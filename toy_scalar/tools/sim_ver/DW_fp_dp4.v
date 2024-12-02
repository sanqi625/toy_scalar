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
// AUTHOR:    Alexandre Tenca, November 2006
//
// VERSION:   Verilog Simulation Model for DW_fp_dp4
//
// DesignWare_version: 00d75fda
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------------
//
// ABSTRACT: Floating-point Four-term Dot-product
//           Computes the sum of products of FP numbers. For this component,
//           four products are considered. Given the FP inputs a, b, c, d, e
//           f, g and h, it computes the FP output z = a*b + c*d + e*f + g*h. 
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
//              sig_width       significand,  2 to 253 bits
//              exp_width       exponent,     3 to 31 bits
//              ieee_compliance 0 or 1 (default 1)
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
//              e               (sig_width + exp_width) + 1-bits
//                              Floating-point Number Input
//              f               (sig_width + exp_width) + 1-bits
//                              Floating-point Number Input
//              g               (sig_width + exp_width) + 1-bits
//                              Floating-point Number Input
//              h               (sig_width + exp_width) + 1-bits
//                              Floating-point Number Input
//              rnd             3 bits
//                              rounding mode
//
//              Output ports    Size & Description
//              ===========     ==================
//              z               (sig_width + exp_width + 1) bits
//                              Floating-point Number result that corresponds
//                              to a*b+c*d+e*f+g*h
//              status          byte
//                              info about FP results
//
// MODIFIED:
//
// 3/22/2021  RJK        Addressed STAR 3625874 involving accepting the value
//                       on the 'rnd' input at time 0
//
//         11/09/07: AFT - Includes modifications to deal with the sign of zeros
//                   according to specification regarding the addition of zeros. 
//                   (A-SP1)
//           11/12/07 - AFT - fixed other problems related to the cancellation of
//                    of products and internal detection of infinities
//           04/25/08 - AFT - included a new parameter (arch_type) to control
//                   the use of alternative architecture with IFP blocks
//           01/2009 - AFT - expanded the use of parameters to accept 
//                     ieee_compliance=1 when arch_type=1
//           07/2009 - AFT - fixed the O01l0OI0 bit cancellation procedure to follow 
//                     the same rules defined for the sum4 component (see comments
//                     in the code)
//           09/2010 - AFT - fix corner cases when only 1 bit of the signficant is
//                     kept during alignment.
//           10/2011 - AFT - fixed the cancellation of O01l0OI0 bits when there are 
//                     partially out of range products after alignment.
//           04/2012 - AFT - fixed problem described in star 9000532273 
//                     Sticky bit is being shifted during normalization, and 
//                     causing rounding error. 
//           07/2012 - AFT - slightly changed the description of the rules used
//                     to cancel stk bits when POR or COR products happen. No change
//                     in functionality.
//
//   RJK  02/05/2021 - Added missing `undef statements (STAR 3323379)
//
//-------------------------------------------------------------------------------
module DW_fp_dp4 (a, b, c, d, e, f, g, h, rnd, z, status);
parameter integer sig_width=23;
parameter integer exp_width=8;
parameter integer ieee_compliance=0;                    
parameter integer arch_type=0;

// declaration of inputs and outputs
input  [sig_width+exp_width:0] a,b,c,d,e,f,g,h;
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



function [4-1:0] Ol1l110O;

  input [2:0] ll1IOIlO;
  input [0:0] I000OO0O;
  input [0:0] IO1IO0l1,OO100IO0,O01l0OI0;


  begin
  Ol1l110O[0] = 0;
  Ol1l110O[1] = OO100IO0|O01l0OI0;
  Ol1l110O[2] = 0;
  Ol1l110O[3] = 0;
  case (ll1IOIlO)
    3'b000:
    begin
      Ol1l110O[0] = OO100IO0&(IO1IO0l1|O01l0OI0);
      Ol1l110O[2] = 1;
      Ol1l110O[3] = 0;
    end
    3'b001:
    begin
      Ol1l110O[0] = 0;
      Ol1l110O[2] = 0;
      Ol1l110O[3] = 0;
    end
    3'b010:
    begin
      Ol1l110O[0] = ~I000OO0O & (OO100IO0|O01l0OI0);
      Ol1l110O[2] = ~I000OO0O;
      Ol1l110O[3] = ~I000OO0O;
    end
    3'b011:
    begin
      Ol1l110O[0] = I000OO0O & (OO100IO0|O01l0OI0);
      Ol1l110O[2] = I000OO0O;
      Ol1l110O[3] = I000OO0O;
    end
    3'b100:
    begin
      Ol1l110O[0] = OO100IO0;
      Ol1l110O[2] = 1;
      Ol1l110O[3] = 0;
    end
    3'b101:
    begin
      Ol1l110O[0] = OO100IO0|O01l0OI0;
      Ol1l110O[2] = 1;
      Ol1l110O[3] = 1;
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


// definitions used in the code


`define DW_lIO011OO (sig_width*4+5)
`define DW_l11l1llI (((`DW_lIO011OO>16)?((`DW_lIO011OO>64)?((`DW_lIO011OO>128)?8:7):((`DW_lIO011OO>32)?6:5)):((`DW_lIO011OO>4)?((`DW_lIO011OO>8)?4:3):((`DW_lIO011OO>2)?2:1))))
`define DW_Il1II1Il (6*sig_width+5+3)
`define O11I00O1 0
reg [8    -1:0] OO10OOO1;
reg [(exp_width + sig_width):0] l0Ol0OOI;
reg OIl1001l,lO0OOOIl,l1O100I0,OIO0I111,O01l0OI0,O0l10OOI,OIlOO101,l01010ll,OO1llIO1,IOIO101I,Il110l11;
reg [exp_width-1:0] Il001001,OII0OO00,I0IO1I0I,II11O1l1,O111O1l0,O0I11lO1,I0OllO01,lI10O00l; 
reg [sig_width-1:0] lOOO1O10,I0OOOO0I,O11l1Il0,l1010OI1,Olll0I0I,l110IO01,l0011Ol0,O1I01l1O;
reg [sig_width:0] OOIllOOl,OlI00101,O0O01OO1,IlOl0O1O,I00001l0,l00l0l10,l0l10l0l,l010l000;
reg OO1O01OI,I0O1O10l,lIO0OIO1,O0I1O0OO,I0101O0I,lI0O1O11,lOllOlI1,O0O10OIl;
reg O1101IlO,O01l0I11,OOO1IO01,OOl000IO,O0I0l100,lOIOI11I,OOl0lll1,lll1O1I1;
reg OlO101Ol,II10OOO1,l0l0IIOI,l000O1O1,O111l1ll,I0OIO0II,I00O0l01,l1I11O1O;
reg O00O10O0,IIOO00Ol,IOlI1111,lI01111O,llIO1OO1,O0IOIOOO,l0O0001O,OI0OOO0I;
reg [2*sig_width+1:0] O1I10IO1,l0OOO1l1,I1OlI0Ol,OlOIOIO0;
reg [(`DW_Il1II1Il-2):0] l10IIIO0, I1llOI11;
reg [(`DW_Il1II1Il-2):0] I011O0l1, O0IOlI0O;
reg [exp_width+1:0] OIOl00O1, O11O101I,O0Ol1l1l,II10l0O0;
reg O00I1lOO, I11010I0, O11O0IO1, llII1II1;
reg [exp_width-1:0] l0OIOl1I;
reg [exp_width-1:0] lOII1O0l;
reg [exp_width+1:0] lO11O011;                     // biggest exponent
reg [exp_width+1:0] I0I0110O,O0I0lO1O,OOI1O00O;
reg [exp_width+1:0] O1OlO001,O1O0lOOO,O011O1I0;          // Exponents.
reg [exp_width+1:0] OlI1O0O0,OI0Ol0OO,OI1000I0;
reg [exp_width+1:0] Il10l0OO,O0111O11;
reg O1O00OII,OI01lO00,l10O100O;                 // Signs     
reg O1l100OO,l10OlIl0,O11l0O0O; 
reg OOIIOO0O,OII1I001;
reg [(`DW_Il1II1Il-2):0] II101lI0,llOIOl1I,lO0ll1O1;   // Mantissa vectors
reg [(`DW_Il1II1Il-2):0] O11lO00O,OO1101OO;
reg [(`DW_Il1II1Il-2):0] l0010OO1,I01O1OI1,OO011IO0; 
`define DW_II01l1O1 ((`DW_Il1II1Il-2)+1)
reg [(`DW_Il1II1Il-2):0] llO101OO, I1O11lIO;
reg [(`DW_Il1II1Il-2):0] l0O111OO;
reg [(`DW_Il1II1Il-2)+1:0] O1l0O100,O111111l,OO10Il01, l0IOIO11;
reg [(`DW_Il1II1Il-2)+1:0] IOOO1I01;        // Internal adder output
reg II1lO1lO;
reg IO1110IO;
reg [(`DW_Il1II1Il-2):0] I10OIO1I;                   // Mantissa vector
reg [4-1:0] OIOOl1OI;             // The values returned by Ol1l110O function.
reg [(exp_width + sig_width + 1)-1:0] I10I00I0;                 // NaN FP number
reg [(exp_width + sig_width + 1)-1:0] l1000O1I;               // plus infinity
reg [(exp_width + sig_width + 1)-1:0] IIOO1OI0;                // negative infinity
reg [(exp_width + sig_width + 1)-1:0] OI11lO10;              // plus zero
reg [(exp_width + sig_width + 1)-1:0] OI0110lO;               // negative zero
reg OIl01l1O, IO1O011I, Ol10000O, IOI00O10;
reg OOIO0lO0, I1000OO1, l1OOO0O1, lO01101O;
reg IO0OO10I, OO00O1OO, O1l10l01, l1O100O0;
reg OO1II1I1, O0Ol01I1, OIO11IOO, I1O0lOII; 
reg O00OOl01, O01II1lI, O00I0Ol1, O1l000I0;
reg OO0O1111;
reg lOO000II;
reg IO1O0000, I00l100l;
reg l0IlO0O1, OlOl1OO0;

//---------------------------------------------------------------
// The following portion of the code describes DW_fp_dp2 when
// arch_type = 1
//---------------------------------------------------------------


wire [sig_width+exp_width : 0] O11IOO1I;
wire [7 : 0] OlOII011;

wire [sig_width+2+exp_width+6:0] OO0IOOll;
wire [sig_width+2+exp_width+6:0] O10O0I1O;
wire [sig_width+2+exp_width+6:0] OI0IOI00; 
wire [sig_width+2+exp_width+6:0] OOO1IlI0;
wire [sig_width+2+exp_width+6:0] l10OOO00;
wire [sig_width+2+exp_width+6:0] I0OOII0O;
wire [sig_width+2+exp_width+6:0] ll11O1l0;
wire [sig_width+2+exp_width+6:0] Ol01Ol0I;
wire [2*(sig_width+2+1)+exp_width+1+6:0] IO0OI0ll; // partial products
wire [2*(sig_width+2+1)+exp_width+1+6:0] O101OI11;
wire [2*(sig_width+2+1)+exp_width+1+6:0] O10Ol000; 
wire [2*(sig_width+2+1)+exp_width+1+6:0] l100OO1I;
wire [2*(sig_width+2+1)+1+exp_width+1+1+6:0] l1Ol001l; // result of p1+p2
wire [2*(sig_width+2+1)+1+exp_width+1+1+6:0] IO0111Ol; // result of p3+p4   
wire [2*(sig_width+2+1)+1+1+exp_width+1+1+1+6:0] llOI0000; // result of padd1+padd2



  // Instances of DW_fp_ifp_conv  -- format converters
    DW_fp_ifp_conv #(sig_width, exp_width, sig_width+2, exp_width, ieee_compliance, 0)
          U1 ( .a(a), .z(OO0IOOll) );
    DW_fp_ifp_conv #(sig_width, exp_width, sig_width+2, exp_width, ieee_compliance, 0)
          U2 ( .a(b), .z(O10O0I1O) );
    DW_fp_ifp_conv #(sig_width, exp_width, sig_width+2, exp_width, ieee_compliance, 0)
          U3 ( .a(c), .z(OI0IOI00) );
    DW_fp_ifp_conv #(sig_width, exp_width, sig_width+2, exp_width, ieee_compliance, 0)
          U4 ( .a(d), .z(OOO1IlI0) );
    DW_fp_ifp_conv #(sig_width, exp_width, sig_width+2, exp_width, ieee_compliance, 0)
          U5 ( .a(e), .z(l10OOO00) );
    DW_fp_ifp_conv #(sig_width, exp_width, sig_width+2, exp_width, ieee_compliance, 0)
          U6 ( .a(f), .z(I0OOII0O) );
    DW_fp_ifp_conv #(sig_width, exp_width, sig_width+2, exp_width, ieee_compliance, 0)
          U7 ( .a(g), .z(ll11O1l0) );
    DW_fp_ifp_conv #(sig_width, exp_width, sig_width+2, exp_width, ieee_compliance, 0)
          U8 ( .a(h), .z(Ol01Ol0I) );
  // Instances of DW_ifp_mult
    DW_ifp_mult #(sig_width+2, exp_width, 2*(sig_width+2+1), exp_width+1)
	  U9  ( .a(OO0IOOll), .b(O10O0I1O), .z(IO0OI0ll) );
    DW_ifp_mult #(sig_width+2, exp_width, 2*(sig_width+2+1), exp_width+1)
	  U10 ( .a(OI0IOI00), .b(OOO1IlI0), .z(O101OI11) );
    DW_ifp_mult #(sig_width+2, exp_width, 2*(sig_width+2+1), exp_width+1)
	  U11 ( .a(l10OOO00), .b(I0OOII0O), .z(O10Ol000) );
    DW_ifp_mult #(sig_width+2, exp_width, 2*(sig_width+2+1), exp_width+1)
	  U12 ( .a(ll11O1l0), .b(Ol01Ol0I), .z(l100OO1I) );
   // Instances of DW_ifp_addsub
    DW_ifp_addsub #(2*(sig_width+2+1), exp_width+1, 2*(sig_width+2+1)+1, exp_width+1+1, ieee_compliance)
	  U13 ( .a(IO0OI0ll), .b(O101OI11), .op(1'b0), .rnd(rnd),
               .z(l1Ol001l) );
    DW_ifp_addsub #(2*(sig_width+2+1), exp_width+1, 2*(sig_width+2+1)+1, exp_width+1+1, ieee_compliance)
	  U14 ( .a(O10Ol000), .b(l100OO1I), .op(1'b0), .rnd(rnd),
               .z(IO0111Ol) );
    DW_ifp_addsub #(2*(sig_width+2+1)+1, exp_width+1+1, 2*(sig_width+2+1)+1+1, exp_width+1+1+1, ieee_compliance)
	  U15 ( .a(l1Ol001l), .b(IO0111Ol), .op(1'b0), .rnd(rnd),
               .z(llOI0000) );
  // Instance of DW_ifp_fp_conv  -- format converter
    DW_ifp_fp_conv #(2*(sig_width+2+1)+1+1, exp_width+1+1+1, sig_width, exp_width, ieee_compliance)
          U16 ( .a(llOI0000), .rnd(rnd), .z(O11IOO1I), .status(OlOII011) );

//-------------------------------------------------------------------
// The following code is used to describe the DW_fp_dp2 component
// when arch_type = 0
//-------------------------------------------------------------------
always @(a or b or c or d or e or f or g or h or rnd)
begin
  // setup special values
  lOII1O0l = ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1});
  l0OIOl1I = 1;
  I10I00I0 = {1'b0,{exp_width{1'b1}},{sig_width{1'b0}}};
  // mantissa of NaN is 1 when ieee_compliance = 1
  I10I00I0[0] = ieee_compliance; 
  l1000O1I = {1'b0,lOII1O0l,{sig_width{1'b0}}};
  IIOO1OI0 = {1'b1,lOII1O0l,{sig_width{1'b0}}};
  OI11lO10 = 0;
  OI0110lO = {1'b1,{sig_width+exp_width{1'b0}}};
  OO10OOO1 = 0;

  // extract exponent and significand from inputs
  Il001001 = a[((exp_width + sig_width) - 1):sig_width];
  OII0OO00 = b[((exp_width + sig_width) - 1):sig_width];
  I0IO1I0I = c[((exp_width + sig_width) - 1):sig_width];
  II11O1l1 = d[((exp_width + sig_width) - 1):sig_width];
  O111O1l0 = e[((exp_width + sig_width) - 1):sig_width];
  O0I11lO1 = f[((exp_width + sig_width) - 1):sig_width];
  I0OllO01 = g[((exp_width + sig_width) - 1):sig_width];
  lI10O00l = h[((exp_width + sig_width) - 1):sig_width];
  lOOO1O10 = a[(sig_width - 1):0];
  I0OOOO0I = b[(sig_width - 1):0];
  O11l1Il0 = c[(sig_width - 1):0];
  l1010OI1 = d[(sig_width - 1):0];
  Olll0I0I = e[(sig_width - 1):0];
  l110IO01 = f[(sig_width - 1):0];
  l0011Ol0 = g[(sig_width - 1):0];
  O1I01l1O = h[(sig_width - 1):0];
  OO1O01OI = a[(exp_width + sig_width)];
  I0O1O10l = b[(exp_width + sig_width)];
  lIO0OIO1 = c[(exp_width + sig_width)];
  O0I1O0OO = d[(exp_width + sig_width)];
  I0101O0I = e[(exp_width + sig_width)];
  lI0O1O11 = f[(exp_width + sig_width)];
  lOllOlI1 = g[(exp_width + sig_width)];
  O0O10OIl = h[(exp_width + sig_width)];

  // determine special input values and perform adjustments in internal
  // mantissa values
  O1101IlO = ((Il001001 === 0) && ((lOOO1O10 === 0) || (ieee_compliance === 0)));
  O01l0I11 = ((OII0OO00 === 0) && ((I0OOOO0I === 0) || (ieee_compliance === 0)));
  OOO1IO01 = ((I0IO1I0I === 0) && ((O11l1Il0 === 0) || (ieee_compliance === 0)));
  OOl000IO = ((II11O1l1 === 0) && ((l1010OI1 === 0) || (ieee_compliance === 0)));
  O0I0l100 = ((O111O1l0 === 0) && ((Olll0I0I === 0) || (ieee_compliance === 0)));
  lOIOI11I = ((O0I11lO1 === 0) && ((l110IO01 === 0) || (ieee_compliance === 0)));
  OOl0lll1 = ((I0OllO01 === 0) && ((l0011Ol0 === 0) || (ieee_compliance === 0)));
  lll1O1I1 = ((lI10O00l === 0) && ((O1I01l1O === 0) || (ieee_compliance === 0)));
  lOOO1O10 = (O1101IlO)?0:lOOO1O10;
  I0OOOO0I = (O01l0I11)?0:I0OOOO0I;
  O11l1Il0 = (OOO1IO01)?0:O11l1Il0;
  l1010OI1 = (OOl000IO)?0:l1010OI1;
  Olll0I0I = (O0I0l100)?0:Olll0I0I;
  l110IO01 = (lOIOI11I)?0:l110IO01;
  l0011Ol0 = (OOl0lll1)?0:l0011Ol0;
  O1I01l1O = (lll1O1I1)?0:O1I01l1O;
  // detect infinity inputs
  OlO101Ol = ((Il001001 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&((lOOO1O10 === 0)||(ieee_compliance === 0)));
  II10OOO1 = ((OII0OO00 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&((I0OOOO0I === 0)||(ieee_compliance === 0)));
  l0l0IIOI = ((I0IO1I0I === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&((O11l1Il0 === 0)||(ieee_compliance === 0)));
  l000O1O1 = ((II11O1l1 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&((l1010OI1 === 0)||(ieee_compliance === 0)));
  O111l1ll = ((O111O1l0 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&((Olll0I0I === 0)||(ieee_compliance === 0)));
  I0OIO0II = ((O0I11lO1 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&((l110IO01 === 0)||(ieee_compliance === 0)));
  I00O0l01 = ((I0OllO01 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&((l0011Ol0 === 0)||(ieee_compliance === 0)));
  l1I11O1O = ((lI10O00l === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&((O1I01l1O === 0)||(ieee_compliance === 0)));
  lOOO1O10 = (OlO101Ol)?0:lOOO1O10;
  I0OOOO0I = (II10OOO1)?0:I0OOOO0I;
  O11l1Il0 = (l0l0IIOI)?0:O11l1Il0;
  l1010OI1 = (l000O1O1)?0:l1010OI1;
  Olll0I0I = (O111l1ll)?0:Olll0I0I;
  l110IO01 = (I0OIO0II)?0:l110IO01;
  l0011Ol0 = (I00O0l01)?0:l0011Ol0;
  O1I01l1O = (l1I11O1O)?0:O1I01l1O;
  // detect nan inputs
  O00O10O0 = ((Il001001 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&(lOOO1O10 !== 0)&&(ieee_compliance === 1));
  IIOO00Ol = ((OII0OO00 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&(I0OOOO0I !== 0)&&(ieee_compliance === 1));
  IOlI1111 = ((I0IO1I0I === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&(O11l1Il0 !== 0)&&(ieee_compliance === 1));
  lI01111O = ((II11O1l1 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&(l1010OI1 !== 0)&&(ieee_compliance === 1));
  llIO1OO1 = ((O111O1l0 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&(Olll0I0I !== 0)&&(ieee_compliance === 1));
  O0IOIOOO = ((O0I11lO1 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&(l110IO01 !== 0)&&(ieee_compliance === 1));
  l0O0001O = ((I0OllO01 === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&(l0011Ol0 !== 0)&&(ieee_compliance === 1));
  OI0OOO0I = ((lI10O00l === ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}))&&(O1I01l1O !== 0)&&(ieee_compliance === 1));

  // build mantissas
  // Detect the denormal input case
  if ((Il001001 === 0) && (lOOO1O10 != 0) && (ieee_compliance === 1)) 
    begin
      // Mantissa of denormal value
      OOIllOOl = {1'b0,lOOO1O10};
      OO1II1I1 = 1;
      Il001001[0] = 1;                // set exponent of denormal to minimum
    end
  else
    begin
      // Mantissa for normal number
      if (Il001001 === 0) 
        OOIllOOl = 0;
      else
        OOIllOOl = {1'b1,lOOO1O10};
      OO1II1I1 = 0;      
    end
  if ((OII0OO00 === 0) && (I0OOOO0I != 0) && (ieee_compliance === 1)) 
    begin
      // Mantissa of denormal value
      OlI00101 = {1'b0,I0OOOO0I};
      O0Ol01I1 = 1;
      OII0OO00[0] = 1;
    end
  else
    begin
      // Mantissa for normal number
      if (OII0OO00 === 0) 
        OlI00101 = 0;
      else
        OlI00101 = {1'b1,I0OOOO0I};
      O0Ol01I1 = 0;      
    end
  if ((I0IO1I0I === 0) && (O11l1Il0 != 0) && (ieee_compliance === 1)) 
    begin
      // Mantissa of denormal value
      O0O01OO1 = {1'b0,O11l1Il0};
      OIO11IOO = 1;
      I0IO1I0I[0] = 1;
    end
  else
    begin
      // Mantissa for normal number
      if (I0IO1I0I === 0) 
        O0O01OO1 = 0;
      else
        O0O01OO1 = {1'b1,O11l1Il0};
      OIO11IOO = 0;      
    end
  if ((II11O1l1 === 0) && (l1010OI1 != 0) && (ieee_compliance === 1)) 
    begin
      // Mantissa of denormal value
      IlOl0O1O = {1'b0,l1010OI1};
      I1O0lOII = 1;
      II11O1l1[0] = 1;
    end
  else
    begin
      // Mantissa for normal number
      if (II11O1l1 === 0) 
        IlOl0O1O = 0;
      else
        IlOl0O1O = {1'b1,l1010OI1};
      I1O0lOII = 0;      
    end
  if ((O111O1l0 === 0) && (Olll0I0I != 0) && (ieee_compliance === 1)) 
    begin
      // Mantissa of denormal value
      I00001l0 = {1'b0,Olll0I0I};
      O00OOl01 = 1;
      O111O1l0[0] = 1;
    end
  else
    begin
      // Mantissa for normal number
      if (O111O1l0 === 0) 
        I00001l0 = 0;
      else
        I00001l0 = {1'b1,Olll0I0I};
      O00OOl01 = 0;      
    end
  if ((O0I11lO1 === 0) && (l110IO01 != 0) && (ieee_compliance === 1)) 
    begin
      // Mantissa of denormal value
      l00l0l10 = {1'b0,l110IO01};
      O01II1lI = 1;
      O0I11lO1[0] = 1;
    end
  else
    begin
      // Mantissa for normal number
      if (O0I11lO1 === 0) 
        l00l0l10 = 0;
      else
        l00l0l10 = {1'b1,l110IO01};
      O01II1lI = 0;      
    end
  if ((I0OllO01 === 0) && (l0011Ol0 != 0) && (ieee_compliance === 1)) 
    begin
      // Mantissa of denormal value
      l0l10l0l = {1'b0,l0011Ol0};
      O00I0Ol1 = 1;
      I0OllO01[0] = 1;
    end
  else
    begin
      // Mantissa for normal number
      if (I0OllO01 === 0) 
        l0l10l0l = 0;
      else
        l0l10l0l = {1'b1,l0011Ol0};
      O00I0Ol1 = 0;      
    end
  if ((lI10O00l === 0) && (O1I01l1O != 0) && (ieee_compliance === 1)) 
    begin
      // Mantissa of denormal value
      l010l000 = {1'b0,O1I01l1O};
      O1l000I0 = 1;
      lI10O00l[0] = 1;
    end
  else
    begin
      // Mantissa for normal number
      if (lI10O00l === 0) 
        l010l000 = 0;
      else
        l010l000 = {1'b1,O1I01l1O};
      O1l000I0 = 0;      
    end
  // calculate the internal exponents
  if (Il001001 === 0 || OII0OO00 === 0)
    OIOl00O1 = 0;
  else
    OIOl00O1 = {2'b00,Il001001} + {2'b00,OII0OO00};
  if (I0IO1I0I === 0 || II11O1l1 === 0)
    O11O101I = 0;
  else
    O11O101I = {2'b00,I0IO1I0I} + {2'b00,II11O1l1};
  if (O111O1l0 === 0 || O0I11lO1 === 0)
    O0Ol1l1l = 0;
  else
    O0Ol1l1l = {2'b00,O111O1l0} + {2'b00,O0I11lO1};
  if (I0OllO01 === 0 || lI10O00l === 0)
    II10l0O0 = 0;
  else
    II10l0O0 = {2'b00,I0OllO01} + {2'b00,lI10O00l};

  IO0OO10I = (O1101IlO | O01l0I11);
  OO00O1OO = (OOO1IO01 | OOl000IO);
  O1l10l01 = (O0I0l100 | lOIOI11I);
  l1O100O0 = (OOl0lll1 | lll1O1I1);
  
  // Identify and treat special input values

  // Rule 1.
  if (O00O10O0 || IIOO00Ol || IOlI1111 || lI01111O || llIO1OO1 || O0IOIOOO || l0O0001O || OI0OOO0I)
    begin // gets here only when ieee_compliance = 1
      // one of the inputs is a NAN       --> the output must be an NAN
      l0Ol0OOI = I10I00I0;
      OO10OOO1[2] = 1;
      OO10OOO1[1] = (ieee_compliance == 0);
    end

  //
  // Infinity Inputs
  // Rule 2.1
  //
  else if ((OlO101Ol && O01l0I11) ||  // a=inf and b=0
	   (II10OOO1 && O1101IlO) ||  // b=inf and a=0
	   (l0l0IIOI && OOl000IO) ||  // c=inf and d=0
	   (l000O1O1 && OOO1IO01) ||  // d=inf and c=0
	   (O111l1ll && lOIOI11I) ||  // e=inf and f=0
	   (I0OIO0II && O0I0l100) ||  // f=inf and e=0
	   (I00O0l01 && lll1O1I1) ||  // g=inf and h=0
	   (l1I11O1O && OOl0lll1))    // h=inf and g=0
    begin
      l0Ol0OOI = I10I00I0;
      OO10OOO1[2] = 1;
      OO10OOO1[1] = (ieee_compliance == 0);
    end

  // Leave the decision about 2.2 and 3 for after the multiplication is done

  // Zero inputs 
  else if (IO0OO10I & OO00O1OO & O1l10l01 & l1O100O0 & (ieee_compliance == 1))
    begin
      O00I1lOO = (OO1O01OI ^ I0O1O10l);
      I11010I0 = (lIO0OIO1 ^ O0I1O0OO);
      O11O0IO1 = (I0101O0I ^ lI0O1O11);
      llII1II1 = (lOllOlI1 ^ O0O10OIl);
      if (O00I1lOO == I11010I0 & I11010I0 === O11O0IO1 & O11O0IO1 === llII1II1)
        l0Ol0OOI = {O00I1lOO,{sig_width+exp_width{1'b0}}};
      else
        l0Ol0OOI = (rnd == 3)?OI0110lO:OI11lO10;
      OO10OOO1[0] = 1;
    end
  
  //
  // Normal Inputs
  //
  else                                          
    begin 
    // generate the product terms
    O1I10IO1 = (OOIllOOl * OlI00101);
    l0OOO1l1 = (O0O01OO1 * IlOl0O1O);
    I1OlI0Ol = (I00001l0 * l00l0l10);
    OlOIOIO0 = (l0l10l0l * l010l000);
    l10IIIO0 = {2'b0,O1I10IO1,{(`DW_Il1II1Il-2*sig_width-5){1'b0}}};
    I1llOI11 = {2'b0,l0OOO1l1,{(`DW_Il1II1Il-2*sig_width-5){1'b0}}};
    I011O0l1 = {2'b0,I1OlI0Ol,{(`DW_Il1II1Il-2*sig_width-5){1'b0}}};
    O0IOlI0O = {2'b0,OlOIOIO0,{(`DW_Il1II1Il-2*sig_width-5){1'b0}}};

    O00I1lOO = (OO1O01OI ^ I0O1O10l);
    I11010I0 = (lIO0OIO1 ^ O0I1O0OO);
    O11O0IO1 = (I0101O0I ^ lI0O1O11);
    llII1II1 = (lOllOlI1 ^ O0O10OIl);

    // the following variables are used to keep track of invalid operations
    OOIO0lO0 = ((OlO101Ol & O01l0I11) | (II10OOO1 & O1101IlO)) & (ieee_compliance == 1);
    I1000OO1 = ((l0l0IIOI & OOl000IO) | (l000O1O1 & OOO1IO01)) & (ieee_compliance == 1);
    l1OOO0O1 = ((O111l1ll & lOIOI11I) | (I0OIO0II & O0I0l100)) & (ieee_compliance == 1);
    lO01101O = ((I00O0l01 & lll1O1I1) | (l1I11O1O & OOl0lll1)) & (ieee_compliance == 1);
    OO0O1111 = OOIO0lO0 | I1000OO1 | l1OOO0O1 | lO01101O;

    if (OO0O1111)
      begin
        OO10OOO1[2] = 1;
        l0Ol0OOI = I10I00I0;                  // NaN
        OO10OOO1[1] = (ieee_compliance == 0);
      end
    else

      begin // valid operations 
      // Takes care of Rule 2.2
      // Normalize the intermediate mantissas of partial prods.
      while ( (l10IIIO0[(`DW_Il1II1Il-2)-2] === 0) && (|OIOl00O1 !== 0) )
        begin
          OIOl00O1 = OIOl00O1 - 1;
          l10IIIO0 = l10IIIO0 << 1;
        end
      while ( (I1llOI11[(`DW_Il1II1Il-2)-2] === 0) && (|O11O101I !== 0) )
        begin
          O11O101I = O11O101I - 1;
          I1llOI11 = I1llOI11 << 1;
        end
      while ( (I011O0l1[(`DW_Il1II1Il-2)-2] === 0) && (|O0Ol1l1l !== 0) )
        begin
          O0Ol1l1l = O0Ol1l1l - 1;
          I011O0l1 = I011O0l1 << 1;
        end
      while ( (O0IOlI0O[(`DW_Il1II1Il-2)-2] === 0) && (|II10l0O0 !== 0) )
        begin
          II10l0O0 = II10l0O0 - 1;
          O0IOlI0O = O0IOlI0O << 1;
        end
 

      OIl01l1O = 0;
      IO1O011I = 0;
      Ol10000O = 0;
      IOI00O10 = 0;
      if (OlO101Ol || II10OOO1)
        OIl01l1O = 1;
      if (l0l0IIOI || l000O1O1)
        IO1O011I = 1;
      if (O111l1ll || I0OIO0II)
        Ol10000O = 1;
      if (I00O0l01 || l1I11O1O)
        IOI00O10 = 1;
      lOO000II = OlO101Ol | II10OOO1 | l0l0IIOI | l000O1O1 | 
                       O111l1ll | I0OIO0II | I00O0l01 | l1I11O1O;
      if (OIl01l1O === 1 || IO1O011I === 1 || Ol10000O === 1 || IOI00O10 === 1)
        begin
          OO10OOO1[1] = 1;
          OO10OOO1[4] = ~lOO000II;
          OO10OOO1[5] = OO10OOO1[4];
          l0Ol0OOI = l1000O1I;
          l0Ol0OOI[(exp_width + sig_width)] = (OIl01l1O & O00I1lOO) | (IO1O011I & I11010I0) |
                             (Ol10000O & O11O0IO1) | (IOI00O10 & llII1II1);
          // Watch out for Inf-Inf !
          if ( (OIl01l1O === 1 && IO1O011I === 1 && O00I1lOO !== I11010I0) ||
               (OIl01l1O === 1 && Ol10000O === 1 && O00I1lOO !== O11O0IO1) ||
               (OIl01l1O === 1 && IOI00O10 === 1 && O00I1lOO !== llII1II1) ||
               (IO1O011I === 1 && Ol10000O === 1 && I11010I0 !== O11O0IO1) ||
               (IO1O011I === 1 && IOI00O10 === 1 && I11010I0 !== llII1II1) ||
               (Ol10000O === 1 && IOI00O10 === 1 && O11O0IO1 !== llII1II1) )
            begin
              OO10OOO1[2] = 1;
              OO10OOO1[4] = 0;
              OO10OOO1[5] = 0;
              l0Ol0OOI = I10I00I0;                  // NaN
              OO10OOO1[1] = (ieee_compliance == 0);
            end
        end
      else
        begin
          // continue with addition of products
          if ({O00I1lOO,OIOl00O1,l10IIIO0} == 
              {~I11010I0,O11O101I,I1llOI11})
             begin
               OIOl00O1 = 0;
               l10IIIO0 = 0;
               O11O101I = 0;
               I1llOI11 = 0;
             end
          if ({O00I1lOO,OIOl00O1,l10IIIO0} == 
              {~O11O0IO1,O0Ol1l1l,I011O0l1})
             begin
               OIOl00O1 = 0;
               l10IIIO0 = 0;
               O0Ol1l1l = 0;
               I011O0l1 = 0;
             end
          if ({O00I1lOO,OIOl00O1,l10IIIO0} == 
              {~llII1II1,II10l0O0,O0IOlI0O})
             begin
               OIOl00O1 = 0;
               l10IIIO0 = 0;
               II10l0O0 = 0;
               O0IOlI0O = 0;
             end
          if ({I11010I0,O11O101I,I1llOI11} == 
              {~O11O0IO1,O0Ol1l1l,I011O0l1})
             begin
               O11O101I = 0;
               I1llOI11 = 0;
               O0Ol1l1l = 0;
               I011O0l1 = 0;
             end
          if ({I11010I0,O11O101I,I1llOI11} == 
              {~llII1II1,II10l0O0,O0IOlI0O})
             begin
               O11O101I = 0;
               I1llOI11 = 0;
               II10l0O0 = 0;
               O0IOlI0O = 0;
             end
          if ({O11O0IO1,O0Ol1l1l,I011O0l1} == 
              {~llII1II1,II10l0O0,O0IOlI0O})
             begin
               O0Ol1l1l = 0;
               I011O0l1 = 0;
               II10l0O0 = 0;
               O0IOlI0O = 0;
             end

          // compute the signal that defines the large and small FP values
          OIl1001l = 0;
          if ({OIOl00O1,l10IIIO0} < {O11O101I,I1llOI11})
            OIl1001l = 1;
          if (OIl1001l == 1)
            begin
              O1O0lOOO = O11O101I;
              llOIOl1I = I1llOI11;
              OI01lO00 = I11010I0;
              OI0Ol0OO = OIOl00O1;
              I01O1OI1 = l10IIIO0;
              l10OlIl0 = O00I1lOO;
            end
          else
            begin
              O1O0lOOO = OIOl00O1;
              llOIOl1I = l10IIIO0;
              OI01lO00 = O00I1lOO;
              OI0Ol0OO = O11O101I;
              I01O1OI1 = I1llOI11;
              l10OlIl0 = I11010I0;
            end
          lO0OOOIl = 0;
          if ({O0Ol1l1l,I011O0l1} < {II10l0O0,O0IOlI0O}) 
            lO0OOOIl = 1;
          if (lO0OOOIl == 1) 
            begin
              O011O1I0 = II10l0O0;
              lO0ll1O1 = O0IOlI0O;
              l10O100O = llII1II1;
              OI1000I0 = O0Ol1l1l;
              OO011IO0 = I011O0l1;
              O11l0O0O = O11O0IO1;
            end
          else
            begin
              O011O1I0 = O0Ol1l1l;
              lO0ll1O1 = I011O0l1;
              l10O100O = O11O0IO1;
              OI1000I0 = II10l0O0;
              OO011IO0 = O0IOlI0O;
              O11l0O0O = llII1II1;
            end
          l1O100I0 = 0;
          if ({O1O0lOOO,llOIOl1I} < {O011O1I0,lO0ll1O1}) 
            l1O100I0 = 1;
          if (l1O100I0 == 1) 
            begin
              O1OlO001 = O011O1I0;
              II101lI0 = lO0ll1O1;
              O1O00OII = l10O100O;
              Il10l0OO = O1O0lOOO;
              O11lO00O = llOIOl1I;
              OOIIOO0O = OI01lO00;
            end
          else
            begin
              O1OlO001 = O1O0lOOO;
              II101lI0 = llOIOl1I;
              O1O00OII = OI01lO00;
              Il10l0OO = O011O1I0;
              O11lO00O = lO0ll1O1;
              OOIIOO0O = l10O100O;
            end
          OIO0I111 = 0;
          if ({OI0Ol0OO,I01O1OI1} < {OI1000I0,OO011IO0}) 
            OIO0I111 = 1;
          if (OIO0I111 == 1) 
            begin
              O0111O11 = OI1000I0;
              OO1101OO = OO011IO0;
              OII1I001 = O11l0O0O;
              OlI1O0O0 = OI0Ol0OO;
              l0010OO1 = I01O1OI1;
              O1l100OO = l10OlIl0;
            end
          else
            begin
              O0111O11 = OI0Ol0OO;
              OO1101OO = I01O1OI1;
              OII1I001 = l10OlIl0;
              OlI1O0O0 = OI1000I0;
              l0010OO1 = OO011IO0;
              O1l100OO = O11l0O0O;
            end

          // Shift right by E_Diff the Small number: M_Small.
          llO101OO = O11lO00O;
          if (`O11I00O1 > 0)
            begin
              O0l10OOI = |O11lO00O[`O11I00O1:0];
              llO101OO[`O11I00O1:0] = 0;
            end
          else
            O0l10OOI = 0; 
          I0I0110O = O1OlO001 - Il10l0OO;
          while ( (|llO101OO[`DW_II01l1O1-1:`O11I00O1+1] !== 0) && (|I0I0110O !== 0) && (I0I0110O[exp_width+1] == 1'b0))
            begin
              llO101OO[`DW_II01l1O1-1:`O11I00O1] = llO101OO[`DW_II01l1O1-1:`O11I00O1] >> 1;
              O0l10OOI = llO101OO[`O11I00O1] | O0l10OOI;
              I0I0110O = I0I0110O - 1;
            end
          l0IlO0O1 = ~|llO101OO[`DW_II01l1O1-1:`O11I00O1+1];
          IO1O0000 = |llO101OO[`DW_II01l1O1-1:`O11I00O1+1] & O0l10OOI;
          llO101OO[`O11I00O1] = O0l10OOI;
          I1O11lIO = OO1101OO;
          if (`O11I00O1 > 0)
            begin
              OIlOO101 = |OO1101OO[`O11I00O1:0];
              I1O11lIO[`O11I00O1:0] = 0;
            end
          else
            OIlOO101 = 0;
          O0I0lO1O = O1OlO001 - O0111O11;
          while ( (|I1O11lIO[`DW_II01l1O1-1:`O11I00O1+1] !== 0) && (|O0I0lO1O !== 0) && (O0I0lO1O[exp_width+1] == 1'b0))
            begin
              I1O11lIO[`DW_II01l1O1-1:`O11I00O1] = I1O11lIO[`DW_II01l1O1-1:`O11I00O1] >> 1;
              OIlOO101 = I1O11lIO[`O11I00O1] | OIlOO101;
              O0I0lO1O = O0I0lO1O - 1;
            end
          OlOl1OO0 = ~|I1O11lIO[`DW_II01l1O1-1:`O11I00O1+1];
          I00l100l = |I1O11lIO[`DW_II01l1O1-1:`O11I00O1+1] & OIlOO101;
          I1O11lIO[`O11I00O1] = OIlOO101;
          l0O111OO = l0010OO1;
          if (`O11I00O1 > 0)
            begin
              l01010ll = |l0010OO1[`O11I00O1:0];
              l0O111OO[`O11I00O1:0] = 0;
            end
          else
            l01010ll = 0;
          OOI1O00O = O1OlO001 - OlI1O0O0;
          while ( (|l0O111OO[`DW_II01l1O1-1:`O11I00O1+1] !== 0) && (|OOI1O00O !== 0) && (OOI1O00O[exp_width+1] == 1'b0))
            begin
              l0O111OO[`DW_II01l1O1-1:`O11I00O1] = l0O111OO[`DW_II01l1O1-1:`O11I00O1] >> 1;
              l01010ll = l0O111OO[`O11I00O1] | l01010ll;
              OOI1O00O = OOI1O00O - 1;
            end
          l0O111OO[`O11I00O1] = l01010ll;

          if (IO1O0000 | I00l100l) 
	    begin
              l0O111OO[`O11I00O1] = 0;
              if (IO1O0000 & I00l100l) 
                begin
                  if ({Il10l0OO,O11lO00O} < {O0111O11,OO1101OO})
                    llO101OO[`O11I00O1] = 0;
                  else
                    I1O11lIO[`O11I00O1] = 0;
                end
            end
          else
            begin
              if ((O0l10OOI & l0IlO0O1) | (OIlOO101 & OlOl1OO0)) 
                begin
                  l0O111OO[`O11I00O1] = 0;
                  if ((O0l10OOI & l0IlO0O1) & (OIlOO101 & OlOl1OO0)) 
                    begin  
  	              if ({Il10l0OO,O11lO00O} < {O0111O11,OO1101OO})
                        llO101OO[`O11I00O1] = 0;
                      else
                        I1O11lIO[`O11I00O1] = 0;
                    end
                end
            end         
            
          // Compute internal addition result
          // We are going to change the sign of the smaller products
          // when their sign is different from the large product
          O1l0O100 = {1'b0,II101lI0};
          if (O1O00OII !== OOIIOO0O) 
            O111111l = ~{1'b0,llO101OO} + 1;
          else
            O111111l = {1'b0,llO101OO};
          if (O1O00OII !== OII1I001)
            OO10Il01 = ~{1'b0,I1O11lIO} + 1;
          else
            OO10Il01 = {1'b0,I1O11lIO};
          if (O1O00OII !== O1l100OO)
            l0IOIO11 = ~{1'b0,l0O111OO} + 1;
          else
            l0IOIO11 = {1'b0,l0O111OO};
            
          IOOO1I01 = O1l0O100 + O111111l + 
                         OO10Il01 + l0IOIO11;
  
          // Processing after addition
          II1lO1lO = IOOO1I01[(`DW_Il1II1Il-2)+1];      
          if (II1lO1lO === 1) 
            I10OIO1I = ~IOOO1I01[(`DW_Il1II1Il-2):0] + 1;
          else
            I10OIO1I = IOOO1I01[(`DW_Il1II1Il-2):0];
          I10OIO1I[0] = 1'b0; // eliminates the stick bit from I10OIO1I
          IO1110IO = (IOOO1I01 !== 0)?II1lO1lO ^ O1O00OII:0;
  
          if (I10OIO1I[(`DW_Il1II1Il-2):sig_width+5] === 0 && l01010ll == 1'b1) 
            begin
              I10OIO1I = l0010OO1;
              IO1110IO = (I10OIO1I === 0)?0:O1l100OO;
              lO11O011 = OlI1O0O0;
              l01010ll = 0;
            end
          else
            lO11O011 = O1OlO001;

          // Normalize the Mantissa for computation overflow case.
          OO1llIO1 = 0;
          if (I10OIO1I[(`DW_Il1II1Il-2)] === 1)
            begin
              lO11O011 = lO11O011 + 1;
              OO1llIO1 = I10OIO1I[`O11I00O1];
              I10OIO1I = I10OIO1I >> 1;
              I10OIO1I[`O11I00O1] = I10OIO1I[`O11I00O1] | OO1llIO1;
            end
          if (I10OIO1I[(`DW_Il1II1Il-2)-1] === 1)
            begin
              lO11O011 = lO11O011 + 1;
              OO1llIO1 = I10OIO1I[`O11I00O1];
              I10OIO1I = I10OIO1I >> 1;
              I10OIO1I[`O11I00O1] = I10OIO1I[`O11I00O1] | OO1llIO1;
            end
          if (I10OIO1I[(`DW_Il1II1Il-2)-2] === 1)
            begin
              lO11O011 = lO11O011 + 1;
              OO1llIO1 = I10OIO1I[`O11I00O1];
              I10OIO1I = I10OIO1I >> 1;
              I10OIO1I[`O11I00O1] = I10OIO1I[`O11I00O1] | OO1llIO1;
            end

          // Normalize the Mantissa for leading zero case.
            while ( (I10OIO1I[(`DW_Il1II1Il-2)-3] === 0) && (lO11O011 > (({exp_width{1'b1}}>>1))) )
              begin
                lO11O011 = lO11O011 - 1;
                I10OIO1I = I10OIO1I << 1;
              end
          // This right shift operation is done for denormal values only
            while ( (I10OIO1I !== 0) && (lO11O011 <= (({exp_width{1'b1}}>>1))) && 
                    (ieee_compliance == 1) )
              begin
                lO11O011 = lO11O011 + 1;
                OO1llIO1 = I10OIO1I[`O11I00O1] | OO1llIO1;
                I10OIO1I = I10OIO1I >> 1;
              end
 
          // Round I10OIO1I according to the rounding mode (rnd).
            IOIO101I = I10OIO1I[((`DW_Il1II1Il-2)-3-sig_width)];
            Il110l11 = I10OIO1I[(((`DW_Il1II1Il-2)-3-sig_width) - 1)];
            O01l0OI0 = |I10OIO1I[(((`DW_Il1II1Il-2)-3-sig_width) - 1)-1:0] | O0l10OOI | OIlOO101 | l01010ll | OO1llIO1;
            OIOOl1OI = Ol1l110O(rnd, IO1110IO, IOIO101I, Il110l11, O01l0OI0);
            if (OIOOl1OI[0] === 1) I10OIO1I = I10OIO1I + (1<<((`DW_Il1II1Il-2)-3-sig_width));
            // Normalize the Mantissa for overflow case after rounding.
            if ( (I10OIO1I[(`DW_Il1II1Il-2)-2] === 1) )
              begin
                lO11O011 = lO11O011 + 1;
                I10OIO1I = I10OIO1I >> 1;
              end

          // test if the output of the rounding unit is still not normalized
            if (I10OIO1I[(`DW_Il1II1Il-2):(`DW_Il1II1Il-2)-3] === 0 || lO11O011 <= ({exp_width{1'b1}}>>1))
              if (ieee_compliance == 1) 
                begin
                  l0Ol0OOI = {IO1110IO,{exp_width{1'b0}}, I10OIO1I[((`DW_Il1II1Il-2)-4):((`DW_Il1II1Il-2)-3-sig_width)]};
                  OO10OOO1[5] = OIOOl1OI[1];
                  OO10OOO1[3] = OIOOl1OI[1] | 
                                                (I10OIO1I[(`DW_Il1II1Il-2):((`DW_Il1II1Il-2)-3-sig_width)] != 0);
                  if (I10OIO1I[((`DW_Il1II1Il-2)-4):((`DW_Il1II1Il-2)-3-sig_width)] == 0) 
                    begin
                      OO10OOO1[0] = 1; 
                      if (~OIOOl1OI[1])
                        begin
                          if (rnd == 3)
                            l0Ol0OOI[(exp_width + sig_width)] = 1;
                          else
                            l0Ol0OOI[(exp_width + sig_width)] = 0;
                        end
                    end
                end
              else // when denormal is not used --> becomes zero or minFP
                begin
                  OO10OOO1[5] = OIOOl1OI[1] | 
                                                (I10OIO1I[(`DW_Il1II1Il-2):((`DW_Il1II1Il-2)-3-sig_width)] != 0);
                  OO10OOO1[3] = OO10OOO1[5];
                  if (((rnd == 2 & ~IO1110IO) | 
                       (rnd == 3 & IO1110IO) | 
                       (rnd == 5)) & (I10OIO1I[(`DW_Il1II1Il-2):((`DW_Il1II1Il-2)-3-sig_width)] != 0))
                    begin // minnorm
                      l0Ol0OOI = {IO1110IO,{exp_width-1{1'b0}},{1'b1},{sig_width{1'b0}}};
                      OO10OOO1[0] = 0;
                    end
                  else
                    begin // zero
                      OO10OOO1[0] = 1;
                      if (OO10OOO1[5])
                        l0Ol0OOI = {IO1110IO,{exp_width{1'b0}}, {sig_width{1'b0}}};
                      else
                        // result is an exact zero -- use simple rule
                        begin
                          l0Ol0OOI = 0;
                          if (rnd === 3)
                            l0Ol0OOI[(exp_width + sig_width)] = 1;
                          else
                            l0Ol0OOI[(exp_width + sig_width)] = 0;
                        end
                    end
                end
            else
              begin
                //
                // Huge
                //
                if (lO11O011 >= ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1})+({exp_width{1'b1}}>>1))
                  begin
                    OO10OOO1[4] = 1;
                    OO10OOO1[5] = 1;
                    if(OIOOl1OI[2] === 1)
                      begin
                        // Infinity
                        I10OIO1I[((`DW_Il1II1Il-2)-4):((`DW_Il1II1Il-2)-3-sig_width)] = 0;
                        lO11O011 = ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1});
                        OO10OOO1[1] = 1;
                      end
                    else
                      begin
                        // MaxNorm
                        lO11O011 = ((({exp_width{1'b1}}>>1) << 1) + {{exp_width-1{1'b0}},1'b1}) - 1;
                        I10OIO1I[((`DW_Il1II1Il-2)-4):((`DW_Il1II1Il-2)-3-sig_width)] = -1;
                      end
                  end
                else
                  lO11O011 = lO11O011 - ({exp_width{1'b1}}>>1);
                //
                // Normal  (continued)
                //
                OO10OOO1[5] = OO10OOO1[5] | 
                                              OIOOl1OI[1];
                // Reconstruct the floating point format.
                l0Ol0OOI = {IO1110IO,lO11O011[exp_width-1:0],I10OIO1I[((`DW_Il1II1Il-2)-4):((`DW_Il1II1Il-2)-3-sig_width)]};
              end //  result is normal value 
        end  // addition of products
    end  // valid operations
  end  // normal inputs
end

assign status = ((^(a ^ a) !== 1'b0) || (^(b ^ b) !== 1'b0) || (^(c ^ c) !== 1'b0) || (^(d ^ d) !== 1'b0) || (^(rnd ^ rnd) !== 1'b0)) ? {8'bx} : ((arch_type === 1)?OlOII011:OO10OOO1);
assign z = ((^(a ^ a) !== 1'b0) || (^(b ^ b) !== 1'b0) || (^(c ^ c) !== 1'b0) || (^(d ^ d) !== 1'b0) || (^(rnd ^ rnd) !== 1'b0)) ? {sig_width+exp_width+1{1'bx}} : ((arch_type === 1)?O11IOO1I:l0Ol0OOI);

`undef DW_lIO011OO
`undef DW_l11l1llI
`undef DW_Il1II1Il
`undef O11I00O1
`undef DW_II01l1O1

 // synopsys translate_on

endmodule

