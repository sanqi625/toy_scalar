
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
// AUTHOR:    Kyung-Nam Han, Mar. 9, 2007.
//
// VERSION:   Verilog Simulation Model for DW_fp_mac
//
// DesignWare_version: 7527029f
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
//
// ABSTRACT: Floating-Point MAC (Multiply and Add, a * b + c)
//
//              DW_fp_mac calculates the floating-point multiplication and
//              addition (ab + c),
//              while supporting six rounding modes, including four IEEE
//              standard rounding modes.
//
//              parameters      valid values (defined in the DW manual)
//              ==========      ============
//              sig_width       significand size,  2 to 253 bits
//              exp_width       exponent size,     3 to 31 bits
//              ieee_compliance support the IEEE Compliance 
//                              including NaN and denormal expressions.
//                              0 - IEEE 754 compatible without denormal support
//                                  (NaN becomes Infinity, Denormal becomes Zero)
//                              1 - IEEE 754 standard compatible
//                                  (NaN and denormal numbers are supported)
//
//              Input ports     Size & Description
//              ===========     ==================
//              a               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Input
//              b               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Input
//              c               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Input
//              rnd             3 bits
//                              Rounding Mode Input
//              z               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Output
//              status          8 bits
//                              Status Flags Output
//
//  MODIFIED:
//  
//          03/2021 - AFT - STAR 3638672 -
//                    Adjusted the behavior of the TINY flag to match the
//                    IEEE Standard 754 definition. It only affects the
//                    configurations with ieee_compliance=1. Although this
//                    code didn't change, the sub-component DW_fp_dp2 was
//                    modified.
//
//-----------------------------------------------------------------------------

module DW_fp_mac (a, b, c, rnd, z, status);

  parameter integer sig_width = 23;      // RANGE 2 TO 253
  parameter integer exp_width = 8;       // RANGE 3 TO 31
  parameter integer ieee_compliance = 0; // RANGE 0 TO 1

  input  [exp_width + sig_width:0] a;
  input  [exp_width + sig_width:0] b;
  input  [exp_width + sig_width:0] c;
  input  [2:0] rnd;
  output [exp_width + sig_width:0] z;
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
    
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 

  //-------------------------------------------------------------------------

  localparam dp2_arch_type = 0;
  wire [exp_width + sig_width:0] one;
  wire [exp_width - 1:0] one_exp;
  wire [sig_width - 1:0] one_sig;

  // integer number 1 with the FP number format
  assign one_exp = ((1 << (exp_width-1)) - 1);
  assign one_sig = 0;
  assign one = {1'b0, one_exp, one_sig}; // fp(1)

  // Simulation Model with DW_fp_dp2(a, b, c, fp(1))

  DW_fp_dp2 #(sig_width, exp_width, ieee_compliance, dp2_arch_type) U1 (
                      .a(a),
                      .b(b),
                      .c(c),
                      .d(one),
                      .rnd(rnd),
                      .z(z),
                      .status(status) );

  // synopsys translate_on
  
endmodule
