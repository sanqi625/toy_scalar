////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 2009 - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Alexandre Tenca - September 2009
//
// VERSION:   Verilog Simulation Model for FP adder - Datapath Gating
//
// DesignWare_version: 9c27384b
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------------
//
// ABSTRACT: Floating-point two-operand Adder with Datapath Gating
//           Computes the addition of two FP numbers. 
//           For information about FP addition, please, look at the description
//           of DW_fp_add. This component has an extra control port that disables
//           the components functionality in order to save power. The control port
//           is DG_ctrl. Whe DG_ctrl is set to 0, the component will not operate,
//           reducing dynamic power (datapath gating). When DG_ctrl is set to 1, 
//           the component works as DW_fp_add.
//              parameters      valid values (defined in the DW manual)
//              ==========      ============
//              sig_width       significand size,  2 to 253 bits
//              exp_width       exponent size,     3 to 31 bits
//              ieee_compliance 0 or 1
//
//              Input ports     Size & Description
//              ===========     ==================
//              a               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Input
//              b               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Input
//              rnd             3 bits
//                              rounding mode
//              DG_ctrl         1 bit
//                              controls the use of datapath gating
//
//              Output ports    Size & Description
//              ===========     ==================
//              z               (sig_width + exp_width + 1) bits
//                              Floating-point Number result
//              status          byte
//                              info about FP results
//
//-------------------------------------------------------------------------------

//
// MODIFIED:
//
// 3/22/2021  RJK        Addressed STAR 3625874 involving accepting the value
//                       on the 'rnd' input at time 0
//
//
// 08/14/2018 RJK 	Corrected declared width of the 'rnd' input port (from 4 bits
//                	to the correct 3 bits) - STAR 9001386198
//---------------------------------------------------------------------------------

module DW_fp_add_DG (a, b, rnd, DG_ctrl, z, status);
parameter integer sig_width=23;
parameter integer exp_width=8;
parameter integer ieee_compliance=0;

// declaration of inputs and outputs
input  [sig_width + exp_width:0] a,b;
input  [2:0] rnd;
input  DG_ctrl;
output [sig_width + exp_width:0] z;
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
 
    if ( (ieee_compliance==2) || (ieee_compliance<0) || (ieee_compliance>3) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m : Illegal value of ieee_compliance. ieee_compliance must be 0, 1, or 3" );
    end
  
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 



wire [sig_width+exp_width : 0] z_sim;
wire [7 : 0] status_flags_sim;

// instance of DW_fp_addsub
DW_fp_addsub_DG #(sig_width, exp_width, ieee_compliance) U1
     (.a (a),
      .b (b),
      .rnd (rnd),
      .op (1'b0),
      .DG_ctrl (DG_ctrl),
      .z (z_sim),
      .status (status_flags_sim));

assign z = z_sim;
assign status = status_flags_sim;

// synopsys translate_on

endmodule

