////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 2008 - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Alexandre Tenca, June 2008
//
// VERSION:   Verilog Simulation Model for FP Natural Logarithm
//
// DesignWare_version: 38ff7549
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------------
//
// ABSTRACT: Floating-point Natural Logarithm
//           Computes the natural logarithm of a FP number
//
//              parameters      valid values (defined in the DW manual)
//              ==========      ============
//              sig_width       significand size,  2 to 59 bits
//              exp_width       lOO00I0l size,     3 to 31 bits
//              ieee_compliance 0 or 1
//              extra_prec      0 to 59-sig_width bits
//              arch            implementation select
//                              0 - area optimized
//                              1 - speed optimized
//
//              Input ports     Size & Description
//              ===========     ==================
//              a               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Input
//
//              Output ports    Size & Description
//              ===========     ==================
//              z               (sig_width + exp_width + 1) bits
//                              Floating-point Number that represents ln(a)
//              status          byte
//                              Status information about FP operation
//
// MODIFIED:
//
// 02/05/2021   RJK - Removed unused Verilog macro definition such that the
//                    missing undef for that macro is no longer an issue.
//                    (STAR 3323379)
//
// 07/2020 TAWALBEH - STAR 9001576363
//                    1) Tiny bit is not set: for ieee_compliance=0, if the output falls 
//                       between Minorm and Zero, either output is correct (No rounding).
//                       If MinNorm is selected: only the Inexact bit is set and no Tiny bit. 
//                       If Zero is selected: Inexact, Tiny and Zero status bits are set (0x29).	
//                       For ieee_compliance=1: if the output is between MiNorm and MaxDenorm,
//                       either output is correct (No rounding).
//                       If MinNorm is selected: only the Inexact bit is set and no Tiny bit.
//                       If MaxDenorm is selected: Bothe Tiny and Inexact are set. 	
//                    2) Fixed: Inexact bit must be set to 1 when both INF and Huge status
//                       bits are set to 1. 
//                    3) Fixed the mismatch with the SYN model for this case by updating the 
//                       condition for the overflow test. 
//
// 11/2016   KYUNG  - STAR 9001116007
//                    Fixed the status[7] flag for ln(+0) and ln(-0)
//                    Merged into M-SP3 on March 2017. 
// 11/2015   AFT    - STAR 9000854445
//                    The ln(-0) should be the same as ln(+0)=-inf   
// 
// 07/2015   AFT    - STAR 9000927308
//                    The fix of this STAR implied the following actions:
//            	      1) the fixed-point DW_log2 is called with one more bit
//            	         than the sig_width of DW_fp_ln. As a consequence, when 
//                       sig_width=60, DW_log2 input width gets out of range (61).
//                       Had to modify the upper bound of sig_width to 59 and adjust 
//                       the limits for extra_prec. 
//                    2) for extreme cases, e.g. parameter set (59,3,1,0,x), the 
//                       calculation of exponents overflows, caused by small vectors. 
//                       Had to increase the precision of some variable to guarantee
//                       correct computation.
//           
//-------------------------------------------------------------------------------

module DW_fp_ln (a, z, status);
parameter integer sig_width=10;
parameter integer exp_width=5; 
parameter integer ieee_compliance=0;
parameter integer extra_prec=0;
parameter integer arch=0;

// declaration of inputs and outputs
input  [sig_width + exp_width:0] a;
output [sig_width + exp_width:0] z;
output [7:0] status;

// synopsys translate_off
  //-------------------------------------------------------------------------
  // Parameter legality check
  //-------------------------------------------------------------------------
  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
  
    if ( (sig_width < 2) || (sig_width > 59) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter sig_width (legal range: 2 to 59)",
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
  
    if ( (extra_prec < 0) || (extra_prec > 59-sig_width) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter extra_prec (legal range: 0 to 59-sig_width)",
	extra_prec );
    end
  
    if ( (arch < 0) || (arch > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter arch (legal range: 0 to 1)",
	arch );
    end
  
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 



 
// signals
  reg  [(exp_width + sig_width + 1)-1:0] O101l000, lIO1IOO1;
  reg  [8    -1:0] lO0lI00I, O010OO00;
  `define DW_l01O1OIO (sig_width+extra_prec+1)
  `define DW_lOO10O10 (`DW_l01O1OIO+exp_width+5)
  reg  [`DW_l01O1OIO-1:0] OOO10100;
  wire [`DW_l01O1OIO-1:0] IO10000O;
  reg signed [`DW_lOO10O10-1:0] lOO0O0l0;
  reg OOO11lOO;
  reg [`DW_lOO10O10-1:0] l1111OlI;
  reg [sig_width:0] O1I0O100;
  reg [sig_width-1:0] O0OO0OO1;
  reg [sig_width-1:0] O1IOl1I1;
  reg [(exp_width + sig_width + 1)-1:0] OI0O0lO0;
  reg [8    -1:0] O0O01lI1;
  reg lOI10I11, OIO0I1Ol, OO10lI1l, l1I111Il;
  reg [(exp_width + sig_width + 1)-1:0] OIlOllO0;
  reg [(exp_width + sig_width + 1)-1:0] lI00O010;
  reg [(exp_width + sig_width + 1)-1:0] OOOO1I0I;
  reg [sig_width:0] II1l110I;
  reg signed [exp_width+5:0] lOO00I0l;
  reg signed [`DW_lOO10O10-1:0] I100llOO, I010Il1O;
  reg signed [`DW_lOO10O10-1:0] O1001111;
  reg [`DW_lOO10O10-1:0] OI11lI10;
  reg [`DW_lOO10O10-1:0] l100101I;
  reg [`DW_l01O1OIO:0] O101OI0O;
  reg [sig_width+1:0] O1OO1OO1;
  reg [`DW_lOO10O10-1:0] lI01I1ll;
  reg signed [`DW_lOO10O10:0] OOI111O0;
  reg signed [`DW_lOO10O10:0] Ol0Il1O0;
  reg signed [`DW_lOO10O10-1:0] OOIOOlO1;
  reg [8    -1:0] O101OI0I;
  reg Il1O0IOO;
  wire O10IO0I0;
  `define DW_l010Ol0I 93
  wire [(`DW_l010Ol0I - 1):0] lOO1l101;
  assign lOO1l101 = `DW_l010Ol0I'b010110001011100100001011111110111110100011100111101111001101010111100100111100011101100111001;
  wire [`DW_l01O1OIO-1:0] I10IO001;
  assign I10IO001 = lOO1l101[(`DW_l010Ol0I - 1)-1:(`DW_l010Ol0I - 1)-`DW_l01O1OIO]+lOO1l101[(`DW_l010Ol0I - 1)-`DW_l01O1OIO-1];

  always @ (a)
    begin                             
    O1IOl1I1 = 0;
    l1111OlI = {1'b0,a[((exp_width + sig_width) - 1):sig_width]};
    O0OO0OO1 = a[(sig_width - 1):0];
    lOI10I11 = 0;
    OIlOllO0 = {1'b0, {exp_width{1'b1}}, O1IOl1I1};
    OIlOllO0[0] = (ieee_compliance == 1)?1:0;

    lI00O010 = {1'b1, {exp_width{1'b1}},O1IOl1I1};
    OOOO1I0I = {1'b0, {exp_width{1'b1}},O1IOl1I1};
    
    if (ieee_compliance == 1 && l1111OlI == 0)
      begin
        if (O0OO0OO1 == O1IOl1I1)
          begin
            lOI10I11 = 1;
            OIO0I1Ol = 0;
          end
        else
          begin
            lOI10I11 = 0;
            OIO0I1Ol = 1;
            l1111OlI[0] = 1;
          end
        O1I0O100 = {1'b0, a[(sig_width - 1):0]};
      end
    else if (ieee_compliance == 0 && l1111OlI == 0)
      begin
        O1I0O100 = {1'b0,O1IOl1I1};
        lOI10I11 = 1;
        OIO0I1Ol = 0;
      end
    else
      begin
        O1I0O100 = {1'b1, a[(sig_width - 1):0]};
        lOI10I11 = 0;
        OIO0I1Ol = 0;
      end
    
    if ((l1111OlI[exp_width-1:0] == ((((1 << (exp_width-1)) - 1) * 2) + 1)) && 
        ((ieee_compliance == 0) || (O0OO0OO1 == 0)))
      OO10lI1l = 1;
    else
      OO10lI1l = 0;
  
    if ((l1111OlI[exp_width-1:0] == ((((1 << (exp_width-1)) - 1) * 2) + 1)) && 
        (ieee_compliance == 1) && (O0OO0OO1 != 0))
      l1I111Il = 1;
    else
      l1I111Il = 0;
  
    OOO11lOO = a[(exp_width + sig_width)];
      
    O0O01lI1 = 0;
    OI0O0lO0 = 0;
    II1l110I = -1;
  
    if ((l1I111Il == 1) ||	((OOO11lOO == 1'b1) && (lOI10I11 == 1'b0)))
      begin
        OI0O0lO0 = OIlOllO0;
        O0O01lI1[2] = 1;
      end
  
    else if (OO10lI1l == 1) 
      begin
        OI0O0lO0 = OOOO1I0I;
        O0O01lI1[1] = 1;
      end
  
    else if (lOI10I11 == 1)
      begin
        OI0O0lO0 = lI00O010;
        O0O01lI1[1] = 1;
        O0O01lI1[7] = 1;
      end
  
    else if (OIO0I1Ol == 1)
      begin
        II1l110I = O1I0O100;
        while (II1l110I[sig_width] == 0)
          begin
            II1l110I = II1l110I<<1;
            l1111OlI = l1111OlI - 1;
          end
        OI0O0lO0 = 0;
      end
    else if (l1111OlI == ((1 << (exp_width-1)) - 1) &&  O0OO0OO1 == 0 && OOO11lOO == 0)
      begin
        OI0O0lO0 = 0;
        O0O01lI1[0] = 1;
      end
    else
      begin
        II1l110I = O1I0O100;
        OI0O0lO0 = 0;
      end
  
    O101l000 = OI0O0lO0;
    lO0lI00I = O0O01lI1;
    OOO10100 = II1l110I << (`DW_l01O1OIO-(sig_width+1));
    lOO0O0l0 = l1111OlI - ((1 << (exp_width-1)) - 1);
  end

  DW_ln #(`DW_l01O1OIO,arch) U1 (.a(OOO10100), .z(IO10000O));

  always @ (IO10000O or lOO0O0l0 or I10IO001)
  begin
    lOO00I0l = ((1 << (exp_width-1)) - 1);
    OOI111O0 = $signed(lOO0O0l0);
    Ol0Il1O0 = OOI111O0 * $unsigned(I10IO001);
    OOIOOlO1 = Ol0Il1O0[`DW_lOO10O10-1:0];
    I100llOO = OOIOOlO1;
    lI01I1ll = IO10000O;
    I010Il1O = lI01I1ll;
    O1001111 = I100llOO + I010Il1O;
    if (O1001111 < 0)
      begin
        OI11lI10 = -O1001111;
        Il1O0IOO = 1;
      end
    else
      begin
        OI11lI10 = O1001111;
        Il1O0IOO = 0;
      end
    l100101I = $unsigned(OI11lI10);
    while ((l100101I[`DW_lOO10O10-1:`DW_l01O1OIO+1] != 0) && 
           (l100101I != 0))
      begin
        l100101I = l100101I >> 1;
        lOO00I0l = lOO00I0l + 1; 
      end
    O101OI0O = l100101I[`DW_l01O1OIO:0];
    while ((O101OI0O[`DW_l01O1OIO] == 0) && (O101OI0O != 0) && (lOO00I0l > 1))
      begin
        O101OI0O = O101OI0O << 1;
        lOO00I0l = lOO00I0l - 1; 
      end
    
    O1OO1OO1 = {1'b0,O101OI0O[`DW_l01O1OIO:extra_prec+1]}+O101OI0O[extra_prec];
    if (O1OO1OO1[sig_width+1]==1)
      begin
        O1OO1OO1 = O1OO1OO1 >> 1;
        lOO00I0l = lOO00I0l + 1;
      end
    if (O1OO1OO1[sig_width] == 0) 
    begin	
      if (ieee_compliance == 1)
	begin
          lIO1IOO1 = {Il1O0IOO, {exp_width{1'b0}}, O1OO1OO1[sig_width-1:0]};
          O101OI0I[3] = 1;
        end
      else
        begin
          lIO1IOO1 = 0;
          O101OI0I[3] = 1;
          O101OI0I[0] = 1;
        end
    end
    else
     begin
        if (|lOO00I0l[exp_width+5:exp_width] == 1 | (&lOO00I0l[exp_width-1:0] == 1) )   
          begin
            O101OI0I[4] = 1;
            O101OI0I[5] = 1;
            O101OI0I[1] = 1;
            lIO1IOO1 = lI00O010;
          end
        else
          begin
            O101OI0I = 0;
            lIO1IOO1 = {Il1O0IOO, lOO00I0l[exp_width-1:0],O1OO1OO1[sig_width-1:0]};  
          end
      end
     O101OI0I[5] = (~ O101OI0I[1] & ~ O101OI0I[2] &
                                    ~ (O101OI0I[0] & ~ O101OI0I[3]) )
                                    | (O101OI0I[1]  & (O101OI0I[4]) );

    O010OO00 = O101OI0I;
  end

  assign z = ((^(a ^ a) !== 1'b0)) ? {(exp_width + sig_width + 1){1'bx}} : 
             (lO0lI00I != 0) ? O101l000 : lIO1IOO1;
  assign status = ((^(a ^ a) !== 1'b0)) ? {8    {1'bx}} : 
                  (lO0lI00I != 0) ? lO0lI00I : O010OO00;

`undef DW_l01O1OIO
`undef DW_lOO10O10
`undef DW_l010Ol0I

// synopsys translate_on

endmodule


