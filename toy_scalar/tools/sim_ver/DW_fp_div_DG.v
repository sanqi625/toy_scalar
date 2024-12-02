
////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 2010 - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Kyung-Nam Han and Alex Tenca, January 2010
//
// VERSION:   Verilog Simulation Model for DW_fp_div with Datapath Gating
//
// DesignWare_version: 707e6343
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
//
// ABSTRACT: Floating-Point Divider wih Datapath Gating
//
//              DW_fp_div_DG calculates the floating-point division
//              while supporting six rounding modes, including four IEEE
//              standard rounding modes.
//              The DG_ctrl pin controls the isolation of signals. When this pin
//              has a '1' the component behaves exactly as the DW_fp_div.
//
//              parameters      valid values (defined in the DW manual)
//              ==========      ============
//              sig_width       significand size,  2 to 253 bits
//              exp_width       exponent size,     3 to 31 bits
//              ieee_compliance support the IEEE Compliance 
//                              0 - IEEE 754 compatible without denormal support
//                                  (NaN becomes Infinity, Denormal becomes Zero)
//                              1 - IEEE 754 compatible with denormal support
//				2 - Reserved for future use
//                              3 - Use denormals and comply with IEEE 754 standard for NaNs
//                                  (NaN and denormal numbers are supported)
//              faithful_round  select the faithful_rounding that admits 1 ulp error
//                              0 - default value. it keeps all rounding modes
//                              1 - z has 1 ulp error. RND input does not affect
//                                  the output
//              en_ubr_flag     Enable UBR (underflow before rounding) flag
//                              0 or 1
//                              0 - the flag is always zero
//                              1 - the flag indicates underflow before rounding
//
//              Input ports     Size & Description
//              ===========     ==================
//              a               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Input
//              b               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Input
//              rnd             3 bits
//                              Rounding Mode Input
//              DG_ctrl         1 bit
//                              Datapath gating control (1 - normal operation)
//
//              Output ports    Size & Description
//              ============    ==================
//              z               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Output
//              status          8 bits
//                              Status Flags Output
//
//
//
//-----------------------------------------------------------------------------

module DW_fp_div_DG (a, b, rnd, DG_ctrl, z, status);
  parameter integer sig_width = 23;      // range 2 to 253
  parameter integer exp_width = 8;       // range 3 to 31
  parameter integer ieee_compliance = 0; // range 0 to 3
  parameter integer faithful_round = 0;  // range 0 to 1
  parameter integer en_ubr_flag = 0;  // range 0 to 1

  input  [sig_width + exp_width:0] a;
  input  [sig_width + exp_width:0] b;
  input  [2:0] rnd;
  input  DG_ctrl;
  output [sig_width + exp_width:0] z;
  output [7:0] status;

// synopsys translate_off  
  //-------------------------------------------------------------------------
  // parameter legality check
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
      
    if ( (ieee_compliance==2) || (ieee_compliance<0) || (ieee_compliance>3) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m : Illegal value of ieee_compliance. ieee_compliance must be 0, 1, or 3" );
    end   
      
    if ( (faithful_round < 0) || (faithful_round > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter faithful_round (legal range: 0 to 1)",
	faithful_round );
    end
      
    if ( (en_ubr_flag < 0) || (en_ubr_flag > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter en_ubr_flag (legal range: 0 to 1)",
	en_ubr_flag );
    end
    
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 

  //-------------------------------------------------------------------------

  wire [7:0] Il0l00OO;
  wire [sig_width+exp_width:0] ll0IO101;

  // Instance of DW_fp_div
  DW_fp_div #(sig_width, exp_width, ieee_compliance, faithful_round, en_ubr_flag) 
         U1 (.a(a), .b(b), .rnd(rnd), .z(ll0IO101), .status(Il0l00OO));

  // Simulate the isolation of ports when DG_ctrl is zero
  assign z = (DG_ctrl === 1'b1)?ll0IO101:{sig_width+exp_width+1{1'bX}};
  assign status = (DG_ctrl === 1'b1)?Il0l00OO:8'bXXXXXXXX;

// synopsys translate_on  
  
endmodule
