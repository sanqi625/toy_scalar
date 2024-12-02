////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 2006 - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Alexandre Tenca, September 2006
//
// VERSION:   Verilog Simulation Model for DW_fp_dp2
//
// DesignWare_version: 56940ce1
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------------
//
// ABSTRACT: Floating-point two-term Dot-product
//           Computes the sum of products of FP numbers. For this component,
//           two products are considered. Given the FP inputs a, b, c, and d,
//           it computes the FP output z = a*b + c*d. 
//           The format of the FP numbers is defined by the number of bits 
//           in the significand (sig_width) and the number of bits in the 
//           exponent (exp_width).
//           The total number of bits in the FP number is sig_width+exp_width+1
//           since the sign bit takes the place of the MS bits in the significand
//           which is always 1 (unless the number is a denormal; a condition 
//           that can be detected testing the exponent value).
//           The output is a FP number and status flags with information about
//           special number representations and exceptions. Rounding mode may 
//           also be defined by an input port.
//              parameters      valid values (defined in the DW manual)
//              ==========      ============
//              sig_width       significand size,  2 to 253 bits
//              exp_width       exponent size,     3 to 31 bits
//              ieee_compliance 0 or 1 (default 0)
//              arch_type       0 or 1 (default 0)
//
//              Input ports     Size & Description
//              ===========     ==================
//              a               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Input
//              b               (sig_width + exp_width) + 1-bits
//                              Floating-point Number Input
//              c               (sig_width + exp_width) + 1-bits
//                              Floating-point Number Input
//              d               (sig_width + exp_width) + 1-bits
//                              Floating-point Number Input
//              rnd             3 bits
//                              rounding mode
//
//              Output ports    Size & Description
//              ===========     ==================
//              z               (sig_width + exp_width + 1) bits
//                              Floating-point Number result that corresponds
//                              to a*b+c*d
//              status          byte
//                              info about FP results
//
// MODIFIED:
//
//
//         10/4/06 - includes rounding for denormal values
//          5/1/07 - fixes the manipulation of sign of zero
//         11/9/07 - More fixes of sign of zeros and code cleanup (A-SP1)
//         04/07/08 - AFT : included a new parameter (arch_type) to control
//                   the use of alternative architecture with IFP blocks
//         01/2009 - AFT - fix the cases when tiny=1 and MinNorm=1 for some
//                   combination of the inputs and rounding modes.
//         12/2008 - Fixed tiny bit for the case of sub-norm before rounding
//         12/2008 - Allowed the use of denormals when arch_type=1
//         02/2018 - AFT - Star 9001298598 - in some cases, Huge status bit 
//                   is not being set when the output is forced to +/-MaxNorm
//                   during an exception handling of internal overflow.
//         7/25/19 - RJK - Star 9001538130 - Introduced "generate" structure
//                   coding to eliminate concurrent logic with final
//                   selection, based on "arch_type" parameter.
//       3/22/2021 - RJK
//                   Addressed STAR 3625874 involving accepting the value
//                   on the 'rnd' input at time 0
//         3/29/21 - AFT - STAR 3638672 -
//                   Very special range where the TINY flag should be set. 
//                   This fix extends the range used before.
//                   The 'z' output is properly computed.
//
//-------------------------------------------------------------------------------
module DW_fp_dp2 (a, b, c, d, rnd, z, status);
parameter integer sig_width=23;             // RANGE 2 to 253 bits
parameter integer exp_width=8;              // RANGE 3 to 31 bits     
parameter integer ieee_compliance=0;        // RANGE 0 or 1                  
parameter integer arch_type=0;              // RANGE 0 or 1           

// declaration of inputs and outputs
input  [sig_width+exp_width:0] a,b,c,d;
input  [2:0] rnd;
output [sig_width+exp_width:0] z;
output [7:0] status;

// synopsys translate_off

  //-------------------------------------------------------------------------
  // Parameter legality check
  //-------------------------------------------------------------------------
  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
  
    if ( (sig_width < 2) || (sig_width > 253) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter sig_width (legal range: 2 to 253)",
	sig_width );
    end
  
    if ( (exp_width < 3) || (exp_width > 31) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter exp_width (legal range: 3 to 31)",
	exp_width );
    end
  
    if ( (ieee_compliance < 0) || (ieee_compliance > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter ieee_compliance (legal range: 0 to 1)",
	ieee_compliance );
    end
  
    if ( (arch_type < 0) || (arch_type > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter arch_type (legal range: 0 to 1)",
	arch_type );
    end
  
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 

wire [sig_width+exp_width:0] lOOO0IO1;
wire [7:0] OOOlO11O;

generate
  if (arch_type != 0) begin : DW_I010l1OO

wire [sig_width+2+exp_width+6:0] I0IOlI0I;
wire [sig_width+2+exp_width+6:0] Ol101l00;
wire [sig_width+2+exp_width+6:0] l10OO111; 
wire [sig_width+2+exp_width+6:0] IO1lI10l;
wire [(sig_width+2+6)+exp_width+1+6:0] OO0I1lI1, O0I01000;
wire [(sig_width+2+6)+1+exp_width+1+1+6:0] O101O0IO;

    DW_fp_ifp_conv #(sig_width, exp_width, sig_width+2, exp_width, ieee_compliance, 0)
          U1 ( .a(a), .z(I0IOlI0I) );
    DW_fp_ifp_conv #(sig_width, exp_width, sig_width+2, exp_width, ieee_compliance, 0)
          U2 ( .a(b), .z(Ol101l00) );
    DW_fp_ifp_conv #(sig_width, exp_width, sig_width+2, exp_width, ieee_compliance, 0)
          U3 ( .a(c), .z(l10OO111) );
    DW_fp_ifp_conv #(sig_width, exp_width, sig_width+2, exp_width, ieee_compliance, 0)
          U4 ( .a(d), .z(IO1lI10l) );
    DW_ifp_mult #(sig_width+2, exp_width, (sig_width+2+6), exp_width+1)
	  U5 ( .a(I0IOlI0I), .b(Ol101l00), .z(OO0I1lI1) );
    DW_ifp_mult #(sig_width+2, exp_width, (sig_width+2+6), exp_width+1)
	  U6 ( .a(l10OO111), .b(IO1lI10l), .z(O0I01000) );
    DW_ifp_addsub #((sig_width+2+6), exp_width+1, (sig_width+2+6)+1, exp_width+1+1, ieee_compliance)
	  U7 ( .a(OO0I1lI1), .b(O0I01000), .op(1'b0), .rnd(rnd),
               .z(O101O0IO) );
    DW_ifp_fp_conv #((sig_width+2+6)+1, exp_width+1+1, sig_width, exp_width, ieee_compliance)
          U8 ( .a(O101O0IO), .rnd(rnd), .z(lOOO0IO1), .status(OOOlO11O) );

  end else begin : DW_llOOO1OO


function [4-1:0] OO0Ol01O;

  input [2:0] IlIO100I;
  input [0:0] ll000OIO;
  input [0:0] OI0l1I0O,I11O1O10,ll01l00O;


  begin
  OO0Ol01O[0] = 0;
  OO0Ol01O[1] = I11O1O10|ll01l00O;
  OO0Ol01O[2] = 0;
  OO0Ol01O[3] = 0;
  case (IlIO100I)
    3'b000:
    begin
      OO0Ol01O[0] = I11O1O10&(OI0l1I0O|ll01l00O);
      OO0Ol01O[2] = 1;
      OO0Ol01O[3] = 0;
    end
    3'b001:
    begin
      OO0Ol01O[0] = 0;
      OO0Ol01O[2] = 0;
      OO0Ol01O[3] = 0;
    end
    3'b010:
    begin
      OO0Ol01O[0] = ~ll000OIO & (I11O1O10|ll01l00O);
      OO0Ol01O[2] = ~ll000OIO;
      OO0Ol01O[3] = ~ll000OIO;
    end
    3'b011:
    begin
      OO0Ol01O[0] = ll000OIO & (I11O1O10|ll01l00O);
      OO0Ol01O[2] = ll000OIO;
      OO0Ol01O[3] = ll000OIO;
    end
    3'b100:
    begin
      OO0Ol01O[0] = I11O1O10;
      OO0Ol01O[2] = 1;
      OO0Ol01O[3] = 0;
    end
    3'b101:
    begin
      OO0Ol01O[0] = I11O1O10|ll01l00O;
      OO0Ol01O[2] = 1;
      OO0Ol01O[3] = 1;
    end
    default:
    begin
`ifndef DW_SUPPRESS_WARN
      if ($time > 0) begin
        $display ("WARNING: %m:\\n at time = %0t: Illegal rounding mode.", $time);
      end
`endif
    end
  endcase
  end

endfunction



reg [8    -1:0] OII10I11;
reg [(exp_width + sig_width):0] O0ll10O0;
reg I1OOO001,l000OOOl,ll01l00O,lll00O1O,l11O000O,I1111l1l,l0l0O01l;
reg [exp_width-1:0] O1111I11,lO100lO1,O0100000,OOlI1O01; 
reg [sig_width-1:0] IO001011,OlO11100,lOIO1l0l,O0I1OlI0;
reg [sig_width:0] I0I0O1Ol,O110Ol1O,ll01Ol11,O1OIO01l;
reg ll1lIIl1,lOIO11O0,Ol1OOI0O,OO111IOO;
reg llOl1O11,I0I1O100,OI11lOIl,I1lOOO10;
reg [2*sig_width+1:0] Ol0O1l10, lI111l0O;
reg [(2*sig_width+2+2):0] l101011O, IOl11I1I;
reg [exp_width+1:0] O0I0l01l, l1OllIl0;
reg IIII1OOO, l1OO0O0I;
reg [exp_width-1:0] O00011OI;
reg [exp_width-1:0] IO1Ol100;
reg [exp_width+1:0] I1OOII00;
reg [exp_width+1:0] O0l011lO;
reg [exp_width:0] OlIO1OI0,O1OI0O1I,IlI0OOO1;
reg [(2*sig_width+2+2):0] O1O111OI,II1O1l1I;
reg lO100IlO,O100II10;
reg [(2*sig_width+2+2):0] O1lIO10O;
reg [(2*sig_width+2+2):0] l0l101O0;
reg [(2*sig_width+2+2):0] II10IIO0;
reg [(2*sig_width+2+2):0] IO1lIO11;
reg [4-1:0] l00OO001;
reg [(exp_width + sig_width + 1)-1:0] l0l011O1;
reg [(exp_width + sig_width + 1)-1:0] I1011O01;
reg [(exp_width + sig_width + 1)-1:0] O01llI11;
reg [(exp_width + sig_width + 1)-1:0] IO100O11;
reg [(exp_width + sig_width + 1)-1:0] O1Il1000;
reg O00ll1lO, I0O0OIO1;
reg OIlI1OOI, lIO1I1lO;
reg l1O10O11, l1I0O0OO, IO0OOOIO, I1Ol10O0;
reg O1IO0l11, l00OI00l, lOOIIO0l, O11ll111;
reg O000OI1O;
reg [(2*sig_width+2+2):0] O10OIO0l;
reg [(2*sig_width+2+2):0] OOlI1III;
reg [(2*sig_width+2+2):0] lOO00000;
reg [(2*sig_width+2+2):0] lIIO0I1O;

always @(a or b or c or d or rnd)
begin
  IO1Ol100 = ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1});
  O00011OI = 1;
  l0l011O1 = {1'b0,{exp_width{1'b1}},{sig_width{1'b0}}};
  
  O10OIO0l = 1;
  O10OIO0l = O10OIO0l << 2*sig_width+3;
  OOlI1III = {2'b00, {sig_width+2{1'b1}}, {sig_width+1{1'b0}}};
  lOO00000 = {2'b00, {sig_width+1{1'b1}}, {sig_width+2{1'b0}}};
  lIIO0I1O = {2'b00, {sig_width{1'b1}}, {sig_width+3{1'b0}}};
  O0l011lO = {exp_width+2{1'b0}};
  IO1lIO11 = {(2*sig_width+2+2)+1{1'b0}};

  l0l011O1[0] = ieee_compliance; 
  I1011O01 = {1'b0,IO1Ol100,{sig_width{1'b0}}};
  O01llI11 = {1'b1,IO1Ol100,{sig_width{1'b0}}};
  IO100O11 = 0;
  O1Il1000 = {1'b1,{sig_width+exp_width{1'b0}}};
  OII10I11 = 0;

  O1111I11 = a[((exp_width + sig_width) - 1):sig_width];
  lO100lO1 = b[((exp_width + sig_width) - 1):sig_width];
  O0100000 = c[((exp_width + sig_width) - 1):sig_width];
  OOlI1O01 = d[((exp_width + sig_width) - 1):sig_width];
  IO001011 = a[(sig_width - 1):0];
  OlO11100 = b[(sig_width - 1):0];
  lOIO1l0l = c[(sig_width - 1):0];
  O0I1OlI0 = d[(sig_width - 1):0];
  ll1lIIl1 = a[(exp_width + sig_width)];
  lOIO11O0 = b[(exp_width + sig_width)];
  Ol1OOI0O = c[(exp_width + sig_width)];
  OO111IOO = d[(exp_width + sig_width)];
  l000OOOl = (ll1lIIl1 ^ lOIO11O0) ^ (Ol1OOI0O ^ OO111IOO);

  if ((O1111I11 === 0) && (IO001011 != 0) && (ieee_compliance === 1)) 
    begin
      I0I0O1Ol = {1'b0,IO001011};
      l1O10O11 = 1;
      O1111I11[0] = 1;
    end
  else
    begin
      if (O1111I11 === 0) 
        I0I0O1Ol = 0;
      else
        I0I0O1Ol = {1'b1,IO001011};
      l1O10O11 = 0;      
    end
  if ((lO100lO1 === 0) && (OlO11100 != 0) && (ieee_compliance === 1)) 
    begin
      O110Ol1O = {1'b0,OlO11100};
      l1I0O0OO = 1;
      lO100lO1[0] = 1;
    end
  else
    begin
      if (lO100lO1 === 0) 
        O110Ol1O = 0;
      else
        O110Ol1O = {1'b1,OlO11100};
      l1I0O0OO = 0;      
    end
  if ((O0100000 === 0) && (lOIO1l0l != 0) && (ieee_compliance === 1)) 
    begin
      ll01Ol11 = {1'b0,lOIO1l0l};
      IO0OOOIO = 1;
      O0100000[0] = 1;
    end
  else
    begin
      if (O0100000 === 0) 
        ll01Ol11 = 0;
      else
        ll01Ol11 = {1'b1,lOIO1l0l};
      IO0OOOIO = 0;      
    end
  if ((OOlI1O01 === 0) && (O0I1OlI0 != 0) && (ieee_compliance === 1)) 
    begin
      O1OIO01l = {1'b0,O0I1OlI0};
      I1Ol10O0 = 1;
      OOlI1O01[0] = 1;
    end
  else
    begin
      if (OOlI1O01 === 0) 
        O1OIO01l = 0;
      else
        O1OIO01l = {1'b1,O0I1OlI0};
      I1Ol10O0 = 0;      
    end

  llOl1O11 = ((O1111I11 === 0) && ((IO001011 === 0) || (ieee_compliance === 0)));
  I0I1O100 = ((lO100lO1 === 0) && ((OlO11100 === 0) || (ieee_compliance === 0)));
  OI11lOIl = ((O0100000 === 0) && ((lOIO1l0l === 0) || (ieee_compliance === 0)));
  I1lOOO10 = ((OOlI1O01 === 0) && ((O0I1OlI0 === 0) || (ieee_compliance === 0)));
  O1IO0l11 = ((O1111I11 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1})) && ((IO001011 === 0) || (ieee_compliance === 0)));
  l00OI00l = ((lO100lO1 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1})) && ((OlO11100 === 0) || (ieee_compliance === 0)));
  lOOIIO0l = ((O0100000 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1})) && ((lOIO1l0l === 0) || (ieee_compliance === 0)));
  O11ll111 = ((OOlI1O01 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1})) && ((O0I1OlI0 === 0) || (ieee_compliance === 0)));
  
  if (O1111I11 === 0 || lO100lO1 === 0)
    O0I0l01l = 0;
  else
    O0I0l01l = {2'b0,O1111I11} + {2'b0,lO100lO1};
  if (O0100000 === 0 || OOlI1O01 === 0)
    l1OllIl0 = 0;
  else
    l1OllIl0 = {2'b0,O0100000} + {2'b0,OOlI1O01};

  OIlI1OOI = llOl1O11 | I0I1O100;
  lIO1I1lO = OI11lOIl | I1lOOO10;


  if ((O1111I11 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1})) && (IO001011 != 0) && (ieee_compliance === 1)) 
    begin
      O0ll10O0 = l0l011O1;
      OII10I11[2] = 1;
    end
  else if ((lO100lO1 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1})) && (OlO11100 != 0) && (ieee_compliance === 1))
    begin
      O0ll10O0 = l0l011O1;
      OII10I11[2] = 1;
    end
  else if ((O0100000 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1})) && (lOIO1l0l != 0) && (ieee_compliance === 1)) 
    begin
      O0ll10O0 = l0l011O1;
      OII10I11[2] = 1;
    end
  else if ((OOlI1O01 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1})) && (O0I1OlI0 != 0) && (ieee_compliance === 1)) 
    begin
      O0ll10O0 = l0l011O1;
      OII10I11[2] = 1;
    end

  else if ((O1IO0l11 && I0I1O100) ||
           (l00OI00l && llOl1O11) ||
           (lOOIIO0l && I1lOOO10) ||
           (O11ll111 && OI11lOIl) )
    begin
      O0ll10O0 = l0l011O1;
      OII10I11[2] = 1;
      OII10I11[1] = (ieee_compliance == 0);
    end

  else if (OIlI1OOI & lIO1I1lO)
    begin
      IIII1OOO = (ll1lIIl1 ^ lOIO11O0);
      l1OO0O0I = (Ol1OOI0O ^ OO111IOO);
      if (IIII1OOO == l1OO0O0I)
        O0ll10O0 = {IIII1OOO,{sig_width+exp_width{1'b0}}};
      else
        O0ll10O0 = (rnd == 3)?O1Il1000:IO100O11;
      OII10I11[0] = 1;
    end
  
  else                                          
    begin
    Ol0O1l10 = (I0I0O1Ol * O110Ol1O);
    lI111l0O = (ll01Ol11 * O1OIO01l);
    l101011O = {1'b0,Ol0O1l10,2'b0};
    IOl11I1I = {1'b0,lI111l0O,2'b0};
    IIII1OOO = (ll1lIIl1 ^ lOIO11O0);
    l1OO0O0I = (Ol1OOI0O ^ OO111IOO);

    O00ll1lO = 0;
    I0O0OIO1 = 0;
    if (O1IO0l11||l00OI00l)
      O00ll1lO = 1;
    if (lOOIIO0l||O11ll111) 
      I0O0OIO1 = 1;
    if (O00ll1lO === 1 || I0O0OIO1 === 1)
      begin
        OII10I11[1] = 1;
        OII10I11[4] = ~(O1IO0l11|l00OI00l|lOOIIO0l|O11ll111);
        OII10I11[5] =  ~(O1IO0l11|l00OI00l|lOOIIO0l|O11ll111);
        O0ll10O0 = I1011O01;
        O0ll10O0[(exp_width + sig_width)] = (O00ll1lO === 1)?IIII1OOO:l1OO0O0I;
        if ( (O00ll1lO === 1) && (I0O0OIO1 === 1) && (l000OOOl === 1) )
          begin
            OII10I11[2] = 1;
            OII10I11[4] = 0;
            OII10I11[5] = 0;
            O0ll10O0 = l0l011O1;
            if (ieee_compliance === 1)
              OII10I11[1] = 0;
          end
      end
    else
      begin
        while ( (l101011O[(2*sig_width+2+2)-1] === 0) && (O0I0l01l > 0) )
          begin
            O0I0l01l = O0I0l01l - 1;
            l101011O = l101011O << 1;
          end
        while ( (IOl11I1I[(2*sig_width+2+2)-1] === 0) && (l1OllIl0 > 0) )
          begin
            l1OllIl0 = l1OllIl0 - 1;
            IOl11I1I = IOl11I1I << 1;
          end

        I1OOO001 = 0;
        if ({O0I0l01l,l101011O} < {l1OllIl0,IOl11I1I})
          I1OOO001 = 1;
        if (I1OOO001 === 1)
          begin
            OlIO1OI0 = l1OllIl0;
            O1O111OI = IOl11I1I;
            lO100IlO = l1OO0O0I;
            O1OI0O1I = O0I0l01l;
            II1O1l1I = l101011O;
            O100II10 = IIII1OOO;
          end
        else
          begin
            OlIO1OI0 = O0I0l01l;
            O1O111OI = l101011O;
            lO100IlO = IIII1OOO;
            O1OI0O1I = l1OllIl0;
            II1O1l1I = IOl11I1I;
            O100II10 = l1OO0O0I;
          end

        lll00O1O = 0;
        IlI0OOO1 = OlIO1OI0 - O1OI0O1I;
        O1lIO10O = II1O1l1I;
        while ( (O1lIO10O != 0) && (IlI0OOO1 > 0) )
          begin
            lll00O1O = O1lIO10O[0] | lll00O1O;
            O1lIO10O = O1lIO10O >> 1;
            IlI0OOO1 = IlI0OOO1 - 1;
          end
        O1lIO10O[0] = O1lIO10O[0] | lll00O1O;

        if (l000OOOl === 0) l0l101O0 = O1O111OI + O1lIO10O;
        else l0l101O0 = O1O111OI - O1lIO10O;

        II10IIO0 = l0l101O0;
        I1OOII00 = {1'b0, OlIO1OI0};
            l11O000O = 0;
            if (II10IIO0[(2*sig_width+2+2)] === 1)
              begin
                I1OOII00 = I1OOII00 + 1;
                l11O000O = II10IIO0[0];
                II10IIO0 = II10IIO0 >> 1;
                II10IIO0[0] = II10IIO0[0] | l11O000O;
              end
          if (II10IIO0[(2*sig_width+2+2)-1] === 1)
              begin
                I1OOII00 = I1OOII00 + 1;
                l11O000O = II10IIO0[0];
                II10IIO0 = II10IIO0 >> 1;
                II10IIO0[0] = II10IIO0[0] | l11O000O;
              end

            if ( (I1OOII00 > (({exp_width{1'b1}}>>1))) )
              begin
                while ( (II10IIO0[(2*sig_width+2+2)-2] === 0) && (I1OOII00 > (({exp_width{1'b1}}>>1))) )
                  begin
                    I1OOII00 = I1OOII00 - 1;
                    II10IIO0 = II10IIO0 << 1;
                  end
              end
            O0l011lO = I1OOII00;
            IO1lIO11 = II10IIO0;
            if ( ($unsigned(I1OOII00) <= (({exp_width{1'b1}}>>1))) )
              begin
                while ( (II10IIO0 !== 0) && ($unsigned(I1OOII00) <= (({exp_width{1'b1}}>>1))) )
                  begin
                    I1OOII00 = I1OOII00 + 1;
                    l11O000O = II10IIO0[0] | l11O000O;
                    II10IIO0 = II10IIO0 >> 1;
                  end
              end

            if (ieee_compliance > 0)
              begin
                if ((O0l011lO <= ({exp_width{1'b1}}>>1)) &&
                    (((rnd == 3'd0 || rnd == 3'd4) && IO1lIO11 < OOlI1III) || 
                     (rnd == 3'd1 && IO1lIO11 < O10OIO0l) || 
                     (rnd == 3'd2 && ((lO100IlO == 1'b0 && IO1lIO11 <= lOO00000) || (lO100IlO == 1'b1 && IO1lIO11 < O10OIO0l))) ||
                     (rnd == 3'd3 && ((lO100IlO == 1'b1 && IO1lIO11 <= lOO00000) || (lO100IlO == 1'b0 && IO1lIO11 < O10OIO0l))) ||
                     (rnd == 3'd5 && IO1lIO11 <= lIIO0I1O)))
                  O000OI1O = 1'b1;
                else
                  O000OI1O = 1'b0;
                OII10I11[3] = O000OI1O;
              end

            I1111l1l = II10IIO0[(2*sig_width+2-sig_width-2+2)];
            l0l0O01l = II10IIO0[((2*sig_width+2-sig_width-2+2) - 1)];
            ll01l00O = |II10IIO0[((2*sig_width+2-sig_width-2+2) - 1)-1:0] | lll00O1O | l11O000O;
            l00OO001 = OO0Ol01O(rnd, lO100IlO, I1111l1l, l0l0O01l, ll01l00O);
            if (l00OO001[0] === 1) II10IIO0 = II10IIO0 + (1<<(2*sig_width+2-sig_width-2+2));
            if ( (II10IIO0[(2*sig_width+2+2)-1] === 1) )
              begin
                I1OOII00 = I1OOII00 + 1;
                II10IIO0 = II10IIO0 >> 1;
              end

            if (II10IIO0[(2*sig_width+2+2):(2*sig_width+2+2)-2] === 0 || $unsigned(I1OOII00) <= ({exp_width{1'b1}}>>1))
              if (ieee_compliance == 1) 
                begin
                  O0ll10O0 = {lO100IlO,{exp_width{1'b0}}, II10IIO0[(2*sig_width+2+2)-3:(2*sig_width+2-sig_width-2+2)]};
                  OII10I11[5] = l00OO001[1];
                  OII10I11[3] = OII10I11[3] |
                                              l00OO001[1] | 
                                                (II10IIO0[(2*sig_width+2+2):(2*sig_width+2-sig_width-2+2)] != 0);
                  if (II10IIO0[(2*sig_width+2+2)-3:(2*sig_width+2-sig_width-2+2)] == 0) 
                    begin
                      OII10I11[0] = 1'b1; 
	              if (~l00OO001[1])
                        begin
                          OII10I11[3] = 1'b0;
                          if (rnd === 3)
                            O0ll10O0[(exp_width + sig_width)] = 1;
                          else
                            O0ll10O0[(exp_width + sig_width)] = 0;
                        end
                    end
                end
              else
                begin
                  OII10I11[5] = l00OO001[1] | 
                                                (II10IIO0[(2*sig_width+2+2):(2*sig_width+2-sig_width-2+2)] != 0);
                  if (((rnd == 2 & ~lO100IlO) | 
                       (rnd == 3 & lO100IlO) | 
                       (rnd == 5)) & (II10IIO0[(2*sig_width+2+2):(2*sig_width+2-sig_width-2+2)] != 0))
                    begin
                      O0ll10O0 = {lO100IlO,{exp_width-1{1'b0}},{1'b1},{sig_width{1'b0}}};
                      OII10I11[0] = 1'b0;
                      OII10I11[3] = 1'b0;
                    end
                  else
                    begin
                      OII10I11[0] = 1'b1;
                      OII10I11[3] = OII10I11[5];
                      if (OII10I11[5])
                        O0ll10O0 = {lO100IlO,{exp_width{1'b0}}, {sig_width{1'b0}}};
                      else
                        begin
                          O0ll10O0 = 0;
                          if (rnd === 3)
                            O0ll10O0[(exp_width + sig_width)] = 1;
                          else
                            O0ll10O0[(exp_width + sig_width)] = 0;
                        end
                    end
                end
            else
              begin
                if (I1OOII00 >= ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1})+({exp_width{1'b1}}>>1))
                  begin
                    OII10I11[5] = 1;
                    if(l00OO001[2] === 1)
                      begin
                        II10IIO0[(2*sig_width+2+2)-3:(2*sig_width+2-sig_width-2+2)] = 0;
                        I1OOII00 = ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1});
                        OII10I11[1] = 1;
                        OII10I11[4] = 1;
                     end
                    else
                      begin
                        I1OOII00 = ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}) - 1;
                        II10IIO0[(2*sig_width+2+2)-3:(2*sig_width+2-sig_width-2+2)] = -1;
                        OII10I11[4] = 1;
                     end
                  end
                else
                  I1OOII00 = I1OOII00 - ({exp_width{1'b1}}>>1);
                OII10I11[5] = OII10I11[5] | l00OO001[1];
                O0ll10O0 = {lO100IlO,I1OOII00[exp_width-1:0],II10IIO0[(2*sig_width+2+2)-3:(2*sig_width+2-sig_width-2+2)]};
              end
      end
    end
end

assign lOOO0IO1 = O0ll10O0;
assign OOOlO11O = OII10I11;
  end
endgenerate

assign status = ((^(a ^ a) !== 1'b0) || (^(b ^ b) !== 1'b0) || (^(c ^ c) !== 1'b0) || (^(d ^ d) !== 1'b0) || (^(rnd ^ rnd) !== 1'b0)) ? {8'bx} :
		 OOOlO11O;
assign z = ((^(a ^ a) !== 1'b0) || (^(b ^ b) !== 1'b0) || (^(c ^ c) !== 1'b0) || (^(d ^ d) !== 1'b0) || (^(rnd ^ rnd) !== 1'b0)) ? 
	    {sig_width+exp_width+1{1'bx}} : lOOO0IO1;

 // synopsys translate_on

endmodule

