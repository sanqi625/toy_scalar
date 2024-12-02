
////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 2007 - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Kyung-Nam Han, Jul. 16, 2007
//
// VERSION:   Verilog Simulation Model for DW_fp_recip
//
// DesignWare_version: b44dcd95
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
//
// ABSTRACT: Floating-Point Reciprocal
//
//              DW_fp_recip calculates the floating-point reciprocal
//              with 1 ulp error.
//
//              parameters      valid values (defined in the DW manual)
//              ==========      ============
//              sig_width       significand size,  3 to 60 bits
//              exp_width       exponent size,     3 to 31 bits
//              ieee_compliance support the IEEE Compliance 
//                              0 - IEEE 754 compatible without denormal support
//                                  (NaN becomes Infinity, Denormal becomes Zero)
//                              1 - IEEE 754 compatible with denormal support
//                                  (NaN and denormal numbers are supported)
//              faithful_round  select the faithful_rounding that admits 1 ulp error
//                              0 - default value. it keeps all rounding modes
//                              1 - z has 1 ulp error. RND input does not affect 
//                                  the output
//
//              Input ports     Size & Description
//              ===========     ==================
//              a               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Input
//              rnd             3 bits
//                              Rounding Mode Input
//              z               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Output
//              status          8 bits
//                              Status Flags Output
//
// Modified:
//
// 3/22/2021  RJK        Addressed STAR 3625874 involving accepting the value
//                       on the 'rnd' input at time 0
//
//
//   06/10/20 Doug Lee 
//            Fixed sizing of x0_rounded to prevent negative index
//            Addresses STAR#3256160
//   01/17/20  AFT - STAR 9001576094
//             Made adjustment to the limit between polynomials of different
//             degrees to solve a 2 ulp error case for a configuration with
//             29 bits in the significand. Limit moved from 30 to 28 bits. 
//
//   06/03/10  Kyung-Nam Han (from D-2010.03-SP3)
//             1) with sig_width=8, it had larger than 1 ulp error. Fixed.
//             2) with faithful_round=1, 1/denormal was not 'Inf' when the
//                true result is at the infinite region. Fixed
//-----------------------------------------------------------------------------

module DW_fp_recip (a, rnd, z, status);

  parameter integer sig_width = 23;      // range 3 to 60
  parameter integer exp_width = 8;       // range 3 to 31
  parameter integer ieee_compliance = 0; // range 0 to 1
  parameter integer faithful_round = 0;  // range 0 to 1

  input  [sig_width + exp_width:0] a;
  input  [2:0] rnd;
  output [sig_width + exp_width:0] z;
  output [7:0] status;

  // synopsys translate_off


  localparam Ill0lOl1 = (sig_width > 8) ? 0 : 8 - sig_width;

  `define DW_O110O00O  (2 * sig_width + 2)
  `define DW_IOI010lO    (sig_width + 2)
  `define DW_OOO101O1 ((sig_width >= 25) ? sig_width - 25 : 0)
  `define DW_IIlI101I ((sig_width >= 24) ? 2 * sig_width - 47 : 0)
  `define DW_l01OI1IO ((sig_width >= 11) ? 2 * sig_width - 21 : 0)
  `define DW_O0OI011O ((sig_width >= 11) ? sig_width - 11 : 0)
  `define DW_OOO111l0 ((sig_width >= 25) ? 2 * sig_width - 47 : 0)
  `define DW_OO00OII1 ((sig_width >= 25) ? sig_width - 22 : 0)
  `define DW_OI11IOIO ((sig_width >= 25) ? sig_width - 11 : 0)
  `define DW_OO1I11OI ((sig_width >= 25) ? 13 : 0)
  `define DW_l10I000l ((sig_width >= 25) ? sig_width + 3 : 0)
  `define DW_O0110OO1 ((sig_width >= 25) ? 27 : 0)
  `define DW_l1l001Ol ((sig_width >= 25) ? 2 * sig_width - 47 : 0)
  `define DW_O0011I0l ((sig_width >= 25) ? sig_width - 23 : 0)
  `define DW_IO011OIO ((sig_width >= 11) ? sig_width + 1 : 0)
  `define DW_OOO01OOO ((sig_width >= 11) ? 12 : 0)
  `define DW_O1IOlO0O ((sig_width >= 11) ? 2 * sig_width - 21 : 0)
  `define DW_l1O11100 ((sig_width >= 11) ? sig_width - 10 : 0)
  `define DW_l111IlIO ((sig_width >= 11) ? sig_width + 3 : 0)
  `define DW_O1l0O0OO ((sig_width >= 11) ? 14 : 0)
  `define DW_lIOl0IO1 ((sig_width >= 9) ? 1 : 9 - sig_width)
  `define DW_O00IO001 ((sig_width >= 9) ? sig_width - 9 : 0)
  `define DW_O1l1lOO1 ((sig_width > 8) ? 0 : 8 - sig_width - 1)
  `define DW_O1I1OlOO ((sig_width < 8) ? `DW_O1l1lOO1 + 1 : 1)
  `define DW_OOlO0O1O ((sig_width >= 8) ? 0 : 8 - sig_width - 1)

  //-------------------------------------------------------------------------
  // parameter legality check
  //-------------------------------------------------------------------------
    
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
      
    if ( (sig_width < 3) || (sig_width > 60) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter sig_width (legal range: 3 to 60)",
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
      
    if ( (faithful_round < 0) || (faithful_round > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter faithful_round (legal range: 0 to 1)",
	faithful_round );
    end
    
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 

  //-------------------------------------------------------------------------


function [4-1:0] RND_eval;

  input [2:0] RND;
  input [0:0] Sign;
  input [0:0] L,R,STK;


  begin
  RND_eval[0] = 0;
  RND_eval[1] = R|STK;
  RND_eval[2] = 0;
  RND_eval[3] = 0;
  case (RND)
    3'b000:
    begin
      RND_eval[0] = R&(L|STK);
      RND_eval[2] = 1;
      RND_eval[3] = 0;
    end
    3'b001:
    begin
      RND_eval[0] = 0;
      RND_eval[2] = 0;
      RND_eval[3] = 0;
    end
    3'b010:
    begin
      RND_eval[0] = ~Sign & (R|STK);
      RND_eval[2] = ~Sign;
      RND_eval[3] = ~Sign;
    end
    3'b011:
    begin
      RND_eval[0] = Sign & (R|STK);
      RND_eval[2] = Sign;
      RND_eval[3] = Sign;
    end
    3'b100:
    begin
      RND_eval[0] = R;
      RND_eval[2] = 1;
      RND_eval[3] = 0;
    end
    3'b101:
    begin
      RND_eval[0] = R|STK;
      RND_eval[2] = 1;
      RND_eval[3] = 1;
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


  reg [(exp_width + sig_width):0] OI0lO110;
  reg [exp_width-1:0] OOOI0O01,O00OO01O;
  reg [exp_width+1:0] IlOl1lOO;
  reg [exp_width+1:0] OO11l0O1;
  reg [exp_width+1:0] OIOI1l00;
  reg signed [exp_width+1:0] l01O10II;
  reg [sig_width:0] ll00I010,Il0I00OO,OI1O10OO,lOO011OI,OlO000O1;
  reg [sig_width:0] IOOI01IO;
  reg [sig_width:0] I0l110I0;
  reg [sig_width:0] lOO00lI0;
  reg l0l0IOlO,O0I11O0l;
  reg [1:0] O00IO10O;
  reg [4-1:0] l011011l;
  reg [8    -1:0] OO01l0I0;
  reg [(exp_width + sig_width):0] O1IlO100;
  reg [(exp_width + sig_width):0] I11l0100;
  reg OIIIOl01;
  reg lI0l111l;
  reg Ill1lII0;
  reg OIllO0O1;
  reg O100OOI0;
  reg OI0llO10;
  reg l0100O0l;
  reg l1O10II1;
  reg OOO0l10l;
  reg [sig_width - 1:0] OIOlO100;
  reg [sig_width - 1:0] O0l10lOO;
  reg [7:0] IOOO0OOO;
  reg [7:0] OO0I1OIl;
  reg [exp_width + 1:0] I00101O1;
  reg [sig_width + exp_width:0] I00I01O1;
  reg [2:0] lOIIOI1l;
  reg [8:0] l00lOI1I;
  reg [8:0] O00001Ol;
  reg [sig_width:0] OO0O1O11;
  reg [sig_width + 3:0] lOOllO11;
  reg [sig_width + 3:0] OI0Ill10;
  reg [sig_width + 3:0] I1I0l10O;
  reg [sig_width + 9:0] O1I11010;
  reg [sig_width + 1:0] lOO00O01;
  reg [sig_width + 18:0] lI1l011I;
  reg [`DW_l01OI1IO:0] O1OI1lI0;
  reg [`DW_O0OI011O:0] l0OO0101;
  reg [`DW_l01OI1IO:0] O000O0Il;
  reg [`DW_OOO101O1:0] lO10010I;
  reg [`DW_IIlI101I:0] IOOO0Ol0;
  reg [`DW_IIlI101I:0] Ol1O10O0;
  reg [`DW_OOO101O1:0] l101lO0O;
  reg [9:0] l0O1Ol0O;
  reg lO1l1OO0;
  reg [8:0] OI0OIlO1;
  reg [sig_width + 3:0] IlOI0OOI;
  reg [sig_width + 3:0] II1ll01l;
  reg [sig_width + 3:0] I11O1I01;
  reg [8:Ill0lOl1] Oll0O1lO;
  reg [sig_width:0] l1O0IlOI;
  reg [sig_width:0] O100lO10;
  reg [sig_width:0] l110lO1l;
  wire [sig_width + exp_width:0] I001ll10;
  wire [7:0] IO0OlO1O;
  wire [sig_width + exp_width:0] O00O101I;

  assign O00O101I = {2'b0, {(exp_width - 1){1'b1}}, {(sig_width){1'b0}}};

  DW_fp_div #(sig_width, exp_width, ieee_compliance, 0) u1 (
    .a(O00O101I),
    .b(a),
    .rnd(rnd),
    .z(I001ll10),
    .status(IO0OlO1O)
  );

  always @(a) begin : a1000_PROC
    lOIIOI1l = 1;
    I00I01O1 = {1'b0, 1'b0, {(exp_width - 1){1'b1}}, {(sig_width){1'b0}}};
    O0I11O0l = a[(exp_width + sig_width)] ^ I00I01O1[(exp_width + sig_width)];
    OOOI0O01 = I00I01O1[((exp_width + sig_width) - 1):sig_width];
    O00OO01O = a[((exp_width + sig_width) - 1):sig_width];
    OIOlO100 = I00I01O1[(sig_width - 1):0];
    O0l10lOO = a[(sig_width - 1):0];
    IOOO0OOO = 0;
    OO0I1OIl = 0;
    IOOI01IO = 0;

    OO01l0I0 = 0;

    if (ieee_compliance)
    begin
      OIIIOl01 = (OOOI0O01 == ((((1 << (exp_width-1)) - 1) * 2) + 1)) & (OIOlO100 == 0);
      lI0l111l = (O00OO01O == ((((1 << (exp_width-1)) - 1) * 2) + 1)) & (O0l10lOO == 0);
      Ill1lII0 = (OOOI0O01 == ((((1 << (exp_width-1)) - 1) * 2) + 1)) & (OIOlO100 != 0);
      OIllO0O1 = (O00OO01O == ((((1 << (exp_width-1)) - 1) * 2) + 1)) & (O0l10lOO != 0);
      O100OOI0 = (OOOI0O01 == 0) & (OIOlO100 == 0);
      OI0llO10 = (O00OO01O == 0) & (O0l10lOO == 0);
      l0100O0l = (OOOI0O01 == 0) & (OIOlO100 != 0);
      l1O10II1 = (O00OO01O == 0) & (O0l10lOO != 0);
      O1IlO100 = {O0I11O0l, {(exp_width){1'b1}}, {(sig_width){1'b0}}}; 
      I11l0100 = {1'b0, {(exp_width){1'b1}}, {(sig_width - 1){1'b0}}, 1'b1};
    end
    else
    begin
      OIIIOl01 = (OOOI0O01 == ((((1 << (exp_width-1)) - 1) * 2) + 1));
      lI0l111l = (O00OO01O == ((((1 << (exp_width-1)) - 1) * 2) + 1));
      Ill1lII0 = 0;
      OIllO0O1 = 0;
      O100OOI0 = (OOOI0O01 == 0);
      OI0llO10 = (O00OO01O == 0);
      l0100O0l = 0;
      l1O10II1 = 0;
      O1IlO100 = {O0I11O0l, {(exp_width){1'b1}}, {(sig_width){1'b0}}};
      I11l0100 = {1'b0, {(exp_width){1'b1}}, {(sig_width){1'b0}}};
    end

    OO01l0I0[7] = OI0llO10; 

    if (Ill1lII0 || OIllO0O1 || (OIIIOl01 && lI0l111l) || (O100OOI0 && OI0llO10))
    begin
      OI0lO110 = I11l0100;
      OO01l0I0[2] = 1;
    end
    else if (OIIIOl01 || OI0llO10)
    begin
      OI0lO110 = O1IlO100;
      OO01l0I0[1] = 1;
    end
    else if (O100OOI0 || lI0l111l)
    begin
      OO01l0I0[0] = 1;
      OI0lO110 = 0;
      OI0lO110[(exp_width + sig_width)] = O0I11O0l;
    end
  
    else
    begin
      if (ieee_compliance) 
      begin

        if (l0100O0l) 
        begin
          ll00I010 = {1'b0, I00I01O1[(sig_width - 1):0]};

          while(ll00I010[sig_width] != 1)
          begin
            ll00I010 = ll00I010 << 1;
            IOOO0OOO = IOOO0OOO + 1;
          end
        end 
        else
        begin
          ll00I010 = {1'b1, I00I01O1[(sig_width - 1):0]};
        end

        if (l1O10II1) 
        begin
          Il0I00OO = {1'b0, a[(sig_width - 1):0]};
          while(Il0I00OO[sig_width] != 1)
          begin
            Il0I00OO = Il0I00OO << 1;
            OO0I1OIl = OO0I1OIl + 1;
          end
        end 
        else
        begin
          Il0I00OO = {1'b1, a[(sig_width - 1):0]};
        end
      end
      else
      begin
        ll00I010 = {1'b1, I00I01O1[(sig_width - 1):0]};
        Il0I00OO = {1'b1, a[(sig_width - 1):0]};
      end

      lO1l1OO0 = (Il0I00OO[sig_width - 1:0] == 0);
      OO0O1O11 = (ieee_compliance) ? 
                 Il0I00OO :
                 {1'b1, O0l10lOO[sig_width - 1:0]};
      l00lOI1I = (sig_width >= 9) ? 
                  OO0O1O11[sig_width - 1:`DW_O00IO001] : 
                  {OO0O1O11[sig_width - 1:0], {(`DW_lIOl0IO1){1'b0}}};
      l0O1Ol0O = {1'b1, l00lOI1I[8:0]};
      O00001Ol = {1'b1, 18'b0} / (l0O1Ol0O + 1);
      O1I11010 = OO0O1O11 * O00001Ol;
      lOO00O01 = ~O1I11010[sig_width + 1:0];
      lI1l011I = O00001Ol * ((1 << (sig_width + 9)) + lOO00O01);
      lOOllO11 = lI1l011I[sig_width  + 17:14];
      O1OI1lI0 = (sig_width >= 11) ? lOO00O01[`DW_IO011OIO:`DW_OOO01OOO] * lOO00O01[`DW_IO011OIO:`DW_OOO01OOO] : 0;
      l0OO0101 = (sig_width >= 11) ? O1OI1lI0[`DW_O1IOlO0O:`DW_l1O11100] : 0;
      O000O0Il = (sig_width >= 11) ? lOOllO11[`DW_l111IlIO:`DW_O1l0O0OO] * l0OO0101 : 0;
      OI0Ill10 = lOOllO11 + O000O0Il[`DW_O1IOlO0O:`DW_l1O11100];
      lO10010I = (sig_width >= 25) ? l0OO0101[`DW_OI11IOIO:`DW_OO1I11OI] : 0;
      IOOO0Ol0 = lO10010I * lO10010I;
      Ol1O10O0 = (sig_width >= 25) ? OI0Ill10[`DW_l10I000l:`DW_O0110OO1] * IOOO0Ol0[`DW_l1l001Ol:`DW_O0011I0l] : 0;
      l101lO0O = (sig_width >= 25) ? Ol1O10O0[`DW_OOO111l0:`DW_OO00OII1] : 0;
      I1I0l10O = OI0Ill10 + l101lO0O;
      OI0OIlO1 = (sig_width == 8) ? O00001Ol + 1 :
               (sig_width < 8) ? O00001Ol + {1'b1, {(`DW_O1I1OlOO){1'b0}}} : 0;
               //(sig_width < 8) ? O00001Ol + {1'b1, {(`DW_O1l1lOO1 + 1){1'b0}}} : 0;
      IlOI0OOI = lOOllO11 + 4'b1000;
      II1ll01l = OI0Ill10 + 4'b1000;
      I11O1I01 = I1I0l10O + 4'b1000;
      Oll0O1lO = (sig_width == 8) ? OI0OIlO1[8:`DW_O1l1lOO1 + 1] :
                   (O00001Ol[`DW_OOlO0O1O]) ? OI0OIlO1[8:`DW_O1l1lOO1 + 1] : O00001Ol[8:`DW_O1l1lOO1 + 1];
      l1O0IlOI = (lOOllO11[2]) ? IlOI0OOI[sig_width + 3:3] : lOOllO11[sig_width + 3:3];
      O100lO10 = (OI0Ill10[2]) ? II1ll01l[sig_width + 3:3] : OI0Ill10[sig_width + 3:3];
      l110lO1l = (I1I0l10O[2]) ? I11O1I01[sig_width + 3:3] : I1I0l10O[sig_width + 3:3];
      I0l110I0 = (lO1l1OO0) ? 0 :
          (sig_width <= 8) ? Oll0O1lO :
          (sig_width <= 14) ? l1O0IlOI :
          (sig_width <= 28) ? O100lO10 : l110lO1l;

      lOO00lI0 = 1;

      IlOl1lOO = (OOOI0O01 - IOOO0OOO + l0100O0l) - (O00OO01O - OO0I1OIl + l1O10II1) + ((1 << (exp_width-1)) - 1);
      OO11l0O1 = (lO1l1OO0) ? IlOl1lOO : IlOl1lOO-1;

      lOO011OI = I0l110I0;
      O00IO10O = 0;
      l01O10II = OO11l0O1;
      l0l0IOlO = 1;

      if (ieee_compliance) begin
        if ((l01O10II <= 0) | (l01O10II[exp_width + 1] == 1)) begin

          OOO0l10l = 1;
          I00101O1 = 1 - l01O10II;
        
          {lOO011OI, IOOI01IO} = {lOO011OI, {(sig_width + 1){1'b0}}} >> I00101O1;

          if (I00101O1 > sig_width + 1) begin
            l0l0IOlO = 1;
          end

          O00IO10O[1] = lOO011OI[0];
          O00IO10O[0] = IOOI01IO[sig_width];

          if (IOOI01IO[sig_width - 1:0] != 0) begin
            l0l0IOlO = 1;
          end
        end
        else begin
          OOO0l10l = 0;
        end
      end

      l011011l = RND_eval(lOIIOI1l, O0I11O0l, O00IO10O[1], O00IO10O[0], l0l0IOlO);
   
      OlO000O1 = (l011011l[0] === 1)? (lOO011OI+1):lOO011OI;

      if ((l01O10II >= ((((1 << (exp_width-1)) - 1) * 2) + 1)) & (l01O10II[exp_width+1] === 1'b0)) begin
        OO01l0I0[4] = 1;
        OO01l0I0[5] = 1;

        if((l011011l[2] === 1) || (faithful_round == 1)) begin
          OI1O10OO = O1IlO100[sig_width:0];
          OIOI1l00 = ((((1 << (exp_width-1)) - 1) * 2) + 1);
          OO01l0I0[1] = 1;
        end
        else begin
          OI1O10OO = -1;
          OIOI1l00 = ((((1 << (exp_width-1)) - 1) * 2) + 1) - 1;
        end
      end
  
      else if ((l01O10II <= 0) | (l01O10II[exp_width+1] === 1'b1)) begin
        OO01l0I0[3] = 1;

        if (ieee_compliance == 0) begin
          OO01l0I0[5] = 1;

          if(l011011l[3] === 1) begin
            OI1O10OO = 0;
            OIOI1l00 = 0 + 1;
          end
          else begin
            OI1O10OO = 0;
            OIOI1l00 = 0;
            OO01l0I0[0] = 1;
          end
        end
        else begin
          OI1O10OO = OlO000O1;
          OIOI1l00 = OlO000O1[sig_width];
        end
      end
      else begin
        OI1O10OO = OlO000O1;
        OIOI1l00 = l01O10II;
      end

      if (ieee_compliance & (l01O10II == 0) & (lOO011OI == 0)) begin
        OI1O10OO[sig_width - 1] = 1;
      end

      if ((OI1O10OO[sig_width - 1:0] == 0) & (OIOI1l00[exp_width - 1:0] == 0)) begin
        OO01l0I0[0] = 1;
      end
  
      OO01l0I0[5] = OO01l0I0[5] | (l011011l[1] & ~lO1l1OO0);
   
      OI0lO110 = {O0I11O0l,OIOI1l00[exp_width-1:0],OI1O10OO[sig_width-1:0]};
    end
  end
   
  assign status = (faithful_round) ? OO01l0I0 : IO0OlO1O;
  assign z = (faithful_round) ? OI0lO110 : I001ll10;
   
  `undef DW_O110O00O
  `undef DW_IOI010lO
  `undef DW_OOO101O1
  `undef DW_IIlI101I
  `undef DW_l01OI1IO
  `undef DW_O0OI011O
  `undef DW_OOO111l0
  `undef DW_OO00OII1
  `undef DW_OI11IOIO
  `undef DW_OO1I11OI
  `undef DW_l10I000l
  `undef DW_O0110OO1
  `undef DW_l1l001Ol
  `undef DW_O0011I0l
  `undef DW_IO011OIO
  `undef DW_OOO01OOO
  `undef DW_O1IOlO0O
  `undef DW_l1O11100
  `undef DW_l111IlIO
  `undef DW_O1l0O0OO
  `undef DW_lIOl0IO1
  `undef DW_O00IO001
  `undef DW_O1l1lOO1
  `undef DW_O1I1OlOO
  `undef DW_OOlO0O1O

  // synopsys translate_on

endmodule
  
  
  
