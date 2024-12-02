
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
// AUTHOR:    Kyung-Nam Han, Nov. 6, 2006
//
// VERSION:   Verilog Simulation Model for DW_fp_sqrt
//
// DesignWare_version: 06ef1429
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
//
// ABSTRACT: Floating-Point Square Root
//
//              DW_fp_sqrt calculates the floating-point square root
//              while supporting six rounding modes, including four IEEE
//              standard rounding modes.
//
//              parameters      valid values (defined in the DW manual)
//              ==========      ============
//              sig_width       significand f,  2 to 253 bits
//              exp_width       exponent e,     3 to 31 bits
//              ieee_compliance support the IEEE Compliance 
//                              including NaN and denormal expressions.
//                              0 - MC (module compiler) compatible
//                              1 - IEEE 754 standard compatible
//				2 - Reserved for future use
//                              3 - Use denormals and comply with IEEE 754 standard for NaNs
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
// MODIFIED:
//
// 3/22/2021  RJK        Addressed STAR 3625874 involving accepting the value
//                       on the 'rnd' input at time 0
//
// 5/05/2020  Tawalbeh   Modify the NaN handling to match DWFC_fp_sqrt_dr in two cases:
//		 	 1) If the input (a) is negative, then pass the sign to get -qNaN output,
//			 2) If the input (a) is NaN, then pay load is passed to the output 
//
// 1/31/2020  Tawalbeh   -Added ieee_compliance =3 functionality to match the DWFC in: behavior of NaN representation,
// 		         and mapping the rouding modes from six to four (4 and 5 modes will map to 0 and 1 in DWFC). 
//			 Also, added Warning messages when "rnd" value equals '4' or '5'.
//
// 7/19/2010  Kyung-Nam  (STAR 9000404523, D-2010.03-SP4)
//           		 Removed bugs with (23,4,1)-configuration
//
// 4/25/2007  Kyung-Nam  (z0703-SP2), Corrected DW_fp_sqrt(-0) = -0
//
//-----------------------------------------------------------------------------
module DW_fp_sqrt (a, rnd, z, status);

  parameter integer sig_width = 23;      // RANGE 2 TO 253
  parameter integer exp_width = 8;       // RANGE 3 TO 31
  parameter integer ieee_compliance = 0; // Valid Values: 0, 1, and 3.

  input  [sig_width + exp_width:0] a;
  input  [2:0] rnd;
  output [sig_width + exp_width:0] z;
  output [7:0] status;

  // synopsys translate_off


  parameter integer width = 2 * sig_width + 4;

  `define R_width (sig_width + 2)
  
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


  reg SIGN;
  reg [exp_width - 1:0] EA;
  reg [sig_width - 1:0] SIGA;
  reg MAX_EXP_A;
  reg InfSig_A;
  reg Zero_A;
  reg Denorm_A;
  reg [sig_width - 1:0] NaN_Sig;
  reg [sig_width - 1:0] Inf_Sig;
  reg [(exp_width + sig_width):0] NaN_Reg;
  reg [(exp_width + sig_width):0] Inf_Reg;
  reg [sig_width:0] MA;
  reg [2 * sig_width + 3:0] Sqrt_in;
  reg [sig_width:0] TMP_MA;
  reg [9:0] LZ_INA;
  reg [`R_width - 1:0] MZ;
  reg [2 * `R_width - 1:0] Square;
  reg [`R_width:0] REMAINDER;
  reg [(exp_width + sig_width):0] z_reg;
  reg [8     - 1:0] status_reg;
  reg signed [exp_width+2:0] EZ;
  reg signed [exp_width+1:0] EM;
  reg Sticky;
  reg Round_Bit;
  reg Guard_Bit;
  reg [`R_width - 1:1] Mantissa;
  reg [4 - 1:0] RND_val;
  reg [`R_width:1] temp_mantissa;
  reg Movf;
  reg NegInput;

  `include "DW_sqrt_function.inc"

  always @(a or rnd) begin : a1000_PROC
    
    SIGN = 0;
    EA = a[((exp_width + sig_width) - 1):sig_width];
    SIGA = a[(sig_width - 1):0];
    status_reg = 0;
    MAX_EXP_A = (EA == ((((1 << (exp_width-1)) - 1) * 2) + 1));
    InfSig_A = (SIGA == 0);
    LZ_INA = 0;
 
    // Zero and Denormal,  
    if (((ieee_compliance == 1) || (ieee_compliance == 3)) ) begin
      Zero_A = (EA == 0) & (SIGA == 0);
      Denorm_A = (EA == 0) & (SIGA != 0);
      Inf_Sig = 0;
      Inf_Reg = {SIGN, {(exp_width){1'b1}}, Inf_Sig};          
      NaN_Sig = 1;       
      NaN_Reg = {1'b0, {(exp_width){1'b1}}, NaN_Sig};      
       
     if (ieee_compliance == 3)       
       begin    
         NaN_Sig = {1'b1, {(sig_width-1){1'b0}} } ;    
	 NaN_Reg = {a[(exp_width + sig_width)], {(exp_width){1'b1}}, NaN_Sig };
       end           
     if ((ieee_compliance == 3) && MAX_EXP_A && ~InfSig_A)
       begin
         NaN_Reg = {a[(exp_width + sig_width)],{(exp_width){1'b1}}, {1'b1, SIGA[sig_width-2: 0]}  } ;
       end
       

      if (Denorm_A) begin
        MA = {1'b0, a[(sig_width - 1):0]};
      end
      else begin
        MA = {1'b1, a[(sig_width - 1):0]};
      end

    end
    else begin // ieee_compliance =0
      Zero_A = (EA == 0);
      Denorm_A = 0;
      MA = {1'b1, a[(sig_width - 1):0]};
      NaN_Sig = 0;
      Inf_Sig = 0;
      NaN_Reg = {SIGN, {(exp_width){1'b1}}, NaN_Sig};
      Inf_Reg = {SIGN, {(exp_width){1'b1}}, Inf_Sig};
    end

    NegInput = ~Zero_A & a[(exp_width + sig_width)];
    if ( (((ieee_compliance == 1) || (ieee_compliance == 3)) ) && MAX_EXP_A && ~InfSig_A || NegInput) begin
      status_reg[2] = 1;
      z_reg = NaN_Reg;
    end
    else if (MAX_EXP_A) begin
      if (ieee_compliance == 0) begin
        status_reg[1] = 1;
      end

      if (Zero_A) begin
        status_reg[2] = 1;
        z_reg = NaN_Reg;
      end
      else begin
        status_reg[1] = 1;
        z_reg = Inf_Reg;
      end
    end
    else if (Zero_A) begin
      status_reg[0] = 1;
      z_reg = {a[(exp_width + sig_width)], {(sig_width + exp_width){1'b0}}};
    end
    
    // Normal & Denormal Inputs
    else begin

      // Denormal Check
      TMP_MA = MA;
      if (Denorm_A) begin
        while(MA[sig_width] != 1) begin
          MA = MA << 1;
          LZ_INA = LZ_INA + 1;
        end
      end

      // Exponent Calculation
      EM = EA - LZ_INA + Denorm_A - ((1 << (exp_width-1)) - 1);
      EZ = $signed(EM[exp_width + 1:1]);

      // Adjust Exponent Bias
      EZ = EZ + ((1 << (exp_width-1)) - 1);

      // Square Root Operation
      if (EM[0] == 0) begin
        Sqrt_in = {MA, {(sig_width + 2){1'b0}}};
      end
      else begin
        Sqrt_in = {MA, {(sig_width + 3){1'b0}}};
      end
      MZ = DWF_sqrt_uns(Sqrt_in);
      Square = MZ * MZ;
      REMAINDER = Sqrt_in - Square;
   
      Sticky = (REMAINDER == 0) ? 0 : 1;

      if ( (((ieee_compliance == 1) || (ieee_compliance == 3))) && (EZ == 0 || EZ < 0)) begin
        Sticky = Sticky | MZ[0];
        MZ = MZ >> 1;
      end

      Mantissa = MZ[`R_width - 1:1];
      Round_Bit = MZ[0];
      Guard_Bit = MZ[1];

      RND_val = RND_eval(rnd, 1'b0, Guard_Bit, Round_Bit, Sticky); 
 
      if (ieee_compliance == 3)      
        begin
          RND_val = RND_eval( {1'b0, rnd[1:0]}, 1'b0, Guard_Bit, Round_Bit, Sticky); 
        end  
      else
	begin
          RND_val = RND_eval(rnd, 1'b0, Guard_Bit, Round_Bit, Sticky);      
        end
      // Round Addition
      if (RND_val[0] == 1) temp_mantissa = Mantissa + 1;
      else temp_mantissa = Mantissa;

      Movf = temp_mantissa[`R_width];
      if (Movf == 1) begin
        EZ = EZ + 1;
        temp_mantissa = temp_mantissa >> 1;
      end

      Mantissa = temp_mantissa[`R_width - 1:1];

      //
      // Tiny
      //
      if (EZ == 0) begin
        status_reg[3] = 1;

        if (Mantissa[`R_width - 2:1] == 0 & EZ[exp_width - 1:0] == 0)
          status_reg[0] = 1;

      end

      status_reg[5] = RND_val[1];

      if ( ((ieee_compliance == 1) || (ieee_compliance == 3))  && (EZ < 0)) begin
        if (((1 << (exp_width-1)) - 1) < 2 * sig_width + 1) begin
          Mantissa = Mantissa >> -EZ;
        end

        EZ = 0;
      end

      // Reconstruct the FP number
      z_reg = {1'b0, EZ[exp_width - 1:0], Mantissa[`R_width - 2:1]};
    end
  end

  assign status = status_reg;
  assign z = z_reg;

  `undef R_width


reg msg_rnd4_emitted_once;
reg msg_rnd5_emitted_once;
initial begin
  msg_rnd4_emitted_once = 1'b0;
  msg_rnd5_emitted_once = 1'b0;
end

generate
  if (ieee_compliance == 3) begin : GEN_IC_EQ_3
    always @ (rnd) begin : warning_alert_PROC
      if ((rnd == 3'b100) && (msg_rnd4_emitted_once !== 1'b1)) begin
        $display("############################################################");
        $display("############################################################");
        $display("##");
        $display("## At time: %d", $stime);
        $display("## Warning! : from %m");
        $display("##");
        $display("##      The rnd input was set to a value of 4 and with");
        $display("##      ieee_compliance set to 3 internal rounding will");
        $display("##      follow the same behavior as if rnd input is being");
        $display("##      set to 0.  That is, the IEEE standard rounding mode");
        $display("##      of 'round to nearest even' is used when rnd input");
        $display("##      is set to a value of 4.");
        $display("##");
        $display("############################################################");
        $display("############################################################");
        $display(" ");
        msg_rnd4_emitted_once = 1'b1;
      end

      if ((rnd == 3'b101) && (msg_rnd5_emitted_once !== 1'b1)) begin
        $display("############################################################");
        $display("############################################################");
        $display("##");
        $display("## At time: %d", $stime);
        $display("## Warning! : from %m");
        $display("##");
        $display("##      The rnd input was set to a value of 5 and with");
        $display("##      ieee_compliance set to 3 internal rounding will");
        $display("##      follow the same behavior as if rnd input is being");
        $display("##      set to 1.  That is, the IEEE standard rounding mode");
        $display("##      of 'round to zero' is used when rnd input is set");
        $display("##      to a value of 5.");
        $display("##");
        $display("############################################################");
        $display("############################################################");
        $display(" ");
        msg_rnd5_emitted_once = 1'b1;
      end
    end
  end  // GEN_IC_EQ_3
endgenerate

  // synopsys translate_on

endmodule
/* vcs gen_ip dbg_ip off */
 /* */
