

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
// AUTHOR:    Kyung-Nam Han, Feb. 22, 2006 (Modified by Alex Tenca October 12, 2009)
//
// VERSION:   Verilog Simulation model for DW_fp_mult_DG
//
// DesignWare_version: 72e59a76
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//
//-----------------------------------------------------------------------------
//
// ABSTRACT: Floating-Point Multiplier with Datapath Gating
//
//              DW_fp_mult_DG calculates the floating-point multiplication
//              while supporting six rounding modes, including four IEEE
//              standard rounding modes. This version supports Datapath gating.
//              When the input DG_ctrl=0, the component has a fixed zero output,
//              and when DG_ctrl=1, the component behaves the same way as 
//              DW_fp_mult
//
//              parameters      valid values (defined in the DW manual)
//              ==========      ============
//              sig_width       significand size,  2 to 253 bits
//              exp_width       exponent size,     3 to 31 bits
//              ieee_compliance support the IEEE Compliance 
//                              including NaN and denormal expressions.
//                              0 - MC (module compiler) compatible
//                              1 - IEEE 754 standard compatible
//                              2 - Reserved for future use
//                              3 - Use denormals and comply
//                                  with IEEE 754 standard for NaNs
//              en_ubr_flag     Enable UBR (underflow before rounding) flag
//                              mapped to status[6]
//                              0 or 1 (default 0)
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
//              DG_ctrl         Datapath gating control
//                              1 bit  (default is value 1)
//              z               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Output
//              status          8 bits
//                              Status Flags Output
//
//-----------------------------------------------------------------------------
// Modified:   
//  AFT 03/2022 - STAR 4175244 - - included mechanism
//                to indicate that the internal long-precision calculation 
//                is a denormalized value
//                Introduced a new flag: UBR - underflow before rounding
//                which uses status[6]
//  AFT 04/2021 - STAR 3638672 - - Tiny flag issue
//                the underflow detection (TINY flag) had to
//                be adjusted to take into account the unbounded
//                exponent situation. The flag is set when:
//                 - rnd in {0,4} and |LPR| < MinNormSub1QULP
//                   LPR= long-precision result and MinNormSub1QULP is 
//                   1/4 of the ulp of the MinNorm value
//                 - rnd=1 and |LPR|<MinNorm
//                 - rnd=2 and (LPR>0 and LPR<=MinNormSub2QULP) or 
//                             (LPR<0 and |LPR|<MinNorm)
//                 - rnd=3 and (LPR<0 and |LPR|<=MinNormSub2QULP) or 
//                             (LPR>0 and LPR<MinNorm)
//                 - rnd=5 and |LPR|<=MaxDenorm 
//  DLL 12/2019 - Added ieee_compliance=3 functionality
//  AFT 2009    - generated DG component from original component
//                created in 2006.
//
//-----------------------------------------------------------------------------
//

module DW_fp_mult_DG (a, b, rnd, DG_ctrl, z, status);

  parameter integer sig_width = 23;      // RANGE 2 TO 253
  parameter integer exp_width = 8;       // RANGE 3 TO 31
  parameter integer ieee_compliance = 0; // RANGE 0 TO 3
  parameter integer en_ubr_flag = 0;     // range 0 to 1

  input  [exp_width + sig_width:0] a;
  input  [exp_width + sig_width:0] b;
  input  [2:0] rnd;
  input  DG_ctrl;
  output [exp_width + sig_width:0] z;
  output [7:0] status;

  // synopsys translate_off


  `define Mwidth (2 * sig_width + 3)
  `define Movf   (`Mwidth - 1)
  `define L      (`Movf - 1 - sig_width)
  `define R      (`L - 1)
  `define log_awidth ((sig_width + 1>65536)?((sig_width + 1>16777216)?((sig_width + 1>268435456)?((sig_width + 1>536870912)?30:29):((sig_width + 1>67108864)?((sig_width + 1>134217728)?28:27):((sig_width + 1>33554432)?26:25))):((sig_width + 1>1048576)?((sig_width + 1>4194304)?((sig_width + 1>8388608)?24:23):((sig_width + 1>2097152)?22:21)):((sig_width + 1>262144)?((sig_width + 1>524288)?20:19):((sig_width + 1>131072)?18:17)))):((sig_width + 1>256)?((sig_width + 1>4096)?((sig_width + 1>16384)?((sig_width + 1>32768)?16:15):((sig_width + 1>8192)?14:13)):((sig_width + 1>1024)?((sig_width + 1>2048)?12:11):((sig_width + 1>512)?10:9))):((sig_width + 1>16)?((sig_width + 1>64)?((sig_width + 1>128)?8:7):((sig_width + 1>32)?6:5)):((sig_width + 1>4)?((sig_width + 1>8)?4:3):((sig_width + 1>2)?2:1)))))
  `define ez_msb ((exp_width >= `log_awidth) ? exp_width + 1 : `log_awidth + 1)
  
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
	"ERROR: %m : Illegal value of ieee_compliance.  ieee_compliance must be 0, 1, or 3" );
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




  reg [(exp_width + sig_width):0] z_reg;
  reg [exp_width-1:0] EA;
  reg [exp_width-1:0] EB;
  reg signed [`ez_msb:0] EZ;
  reg signed [`ez_msb:0] EZ_LPR;
  reg signed [`ez_msb:0] EZMinNorm;
  reg signed [`ez_msb:0] EZ_rounded;
  reg signed [`ez_msb:0] Range_Check;
  reg signed [`ez_msb:0] SH_Shift;
  reg signed [`ez_msb:0] EZ_Shift;
  reg [sig_width:0] MA;
  reg [sig_width:0] MB;
  reg [sig_width:0] TMP_MA;
  reg [sig_width:0] TMP_MB;
  reg [`Mwidth-1:0] MZ;
  reg [`Mwidth-1:0] MZ_LPR;
  reg [`Mwidth-1:0] MZ_rounded;
  reg [`Mwidth-1:0] MZMinNormSub1QULP;
  reg [`Mwidth-1:0] MZMinNormSub2QULP;
  reg [`Mwidth-1:0] MZMaxDenorm;
  reg STK;
  reg SIGN;
  reg [4-1:0] RND_val;
  reg [8    -1:0] status_reg;
  reg MaxEXP_A;
  reg MaxEXP_B;
  reg InfSIG_A;
  reg InfSIG_B;
  reg Zero_A;
  reg Zero_B;
  reg Denorm_A;
  reg Denorm_B;
  reg [9:0] LZ_INA;
  reg [9:0] LZ_INB;
  reg [9:0] LZ_IN;
  reg [sig_width - 1:0] SIGA;
  reg [sig_width - 1:0] SIGB;
  reg [(exp_width + sig_width):0] NaN_Reg;
  reg [(exp_width + sig_width):0] Inf_Reg;
  reg MZ_Movf1;
  reg EZ_Zero;
  reg STK_PRE;
  reg [sig_width:0] STK_EXT;
  reg [sig_width - 1:0] NaN_Sig;
  reg [sig_width - 1:0] Inf_Sig;
  reg STK_CHECK;
  reg minnorm_case;

  integer i;
  
  always @(a or b or rnd) begin : a1000_PROC
    SIGN = a[(exp_width + sig_width)] ^ b[(exp_width + sig_width)];
    EA = a[((exp_width + sig_width) - 1):sig_width];
    EB = b[((exp_width + sig_width) - 1):sig_width];
    SIGA = a[(sig_width - 1):0];
    SIGB = b[(sig_width - 1):0];
    status_reg = 0;
    LZ_INA = 0;
    LZ_INB = 0;
    LZ_IN = 0;
    STK_EXT = 0;

    EZ_LPR = 0;
    EZMinNorm = ((1 << (exp_width-1)) - 1);
    EZ_rounded = 0;
    MZ_LPR = 0;
    MZMinNormSub1QULP = ({{`Mwidth-1{1'b0}},1'b1}<<`Movf)-({{`Mwidth-1{1'b0}},1'b1}<<`R);
    MZMinNormSub2QULP = ({{`Mwidth-1{1'b0}},1'b1}<<`Movf)-({{`Mwidth-1{1'b0}},1'b1}<<(`L));
    MZMaxDenorm = ({{`Mwidth-1{1'b0}},1'b1}<<`Movf)-({{`Mwidth-1{1'b0}},1'b1}<<(`L+1));

    MaxEXP_A = (EA == ((((1 << (exp_width-1)) - 1) * 2) + 1));
    MaxEXP_B = (EB == ((((1 << (exp_width-1)) - 1) * 2) + 1));
    InfSIG_A = (SIGA == 0);
    InfSIG_B = (SIGB == 0);

    if ((ieee_compliance == 1) || (ieee_compliance == 3)) begin
      Zero_A = (EA == 0 ) & (SIGA == 0);
      Zero_B = (EB == 0 ) & (SIGB == 0);
      Denorm_A = (EA == 0 ) & (SIGA != 0);
      Denorm_B = (EB == 0 ) & (SIGB != 0);
      if (ieee_compliance == 3) begin
        NaN_Sig = {1'b1, {(sig_width-1){1'b0}}};
      end else begin
        NaN_Sig = 1;
      end
      Inf_Sig = 0;
      NaN_Reg = {1'b0, {(exp_width){1'b1}}, NaN_Sig};
      Inf_Reg = {SIGN, {(exp_width){1'b1}}, Inf_Sig};

      if (Denorm_A) begin
        MA = {1'b0, a[(sig_width - 1):0]};
      end
      else begin
        MA = {1'b1, a[(sig_width - 1):0]};
      end

      if (Denorm_B) begin
        MB = {1'b0, b[(sig_width - 1):0]};
      end
      else begin
        MB = {1'b1, b[(sig_width - 1):0]};
      end

    end
    else begin
      Zero_A = (EA == 0 );
      Zero_B = (EB == 0 );
      Denorm_A = 0;
      Denorm_B = 0;
      MA = {1'b1,a[(sig_width - 1):0]};
      MB = {1'b1,b[(sig_width - 1):0]};
      NaN_Sig = 0;
      Inf_Sig = 0;
      NaN_Reg = {1'b0, {(exp_width){1'b1}}, NaN_Sig};
      Inf_Reg = {SIGN, {(exp_width){1'b1}}, Inf_Sig};
    end
  
    if (((ieee_compliance == 1) || (ieee_compliance == 3)) && ((MaxEXP_A && ~InfSIG_A) || (MaxEXP_B && ~InfSIG_B))) begin
      status_reg[2] = 1;
      z_reg = NaN_Reg;
    end
    else if ( (MaxEXP_A) || (MaxEXP_B) )	begin

      if (ieee_compliance == 0) begin
        status_reg[1] = 1'b0 ^ status_reg[2] ;
      end

      if ( Zero_A || Zero_B ) begin
        status_reg[2] = 1;
        z_reg = NaN_Reg;
      end
      else begin
        status_reg[1] = 1;
        z_reg = Inf_Reg;
      end

    end
    else if (Zero_A || Zero_B) begin
      status_reg[0] = 1;
      z_reg = 0;
      z_reg[(exp_width + sig_width)] = SIGN;
    end
    else begin

      TMP_MA = MA;
      if (Denorm_A) 
      begin
        while(TMP_MA[sig_width] != 1)
        begin
          TMP_MA = TMP_MA << 1;
          LZ_INA = LZ_INA + 1;
        end
      end

      TMP_MB = MB;
      if (Denorm_B) 
      begin
        while(TMP_MB[sig_width] != 1)
        begin
          TMP_MB = TMP_MB << 1;
          LZ_INB = LZ_INB + 1;
        end
      end

      LZ_IN = LZ_INA + LZ_INB;

      EZ = EA + EB - LZ_IN + Denorm_A + Denorm_B;
      MZ = MA * MB;

      if ((ieee_compliance == 1) || (ieee_compliance == 3)) begin
        MZ = MZ << LZ_IN;
      end

      MZ_Movf1 = MZ[`Movf-1];

      if (MZ[`Movf-1] === 1) begin
        EZ = EZ + 1;
        minnorm_case = 0;
      end
      else begin
        MZ = MZ << 1;
        minnorm_case = (EZ - ((1 << (exp_width-1)) - 1) == 0) ? 1 : 0;
      end
      MZ_LPR = MZ;
      EZ_LPR = EZ;

      if ((EZ_LPR < (((1 << (exp_width-1)) - 1) + 1)) && (en_ubr_flag == 1) && (ieee_compliance > 0)) begin
        status_reg[6] = 1'b1;
      end 
      else begin
        status_reg[6] = 1'b0;
      end 

      if ((ieee_compliance == 1) || (ieee_compliance == 3)) begin
        Range_Check = EA + EB + Denorm_A + Denorm_B + MZ_Movf1 - ((1 << (exp_width-1)) - 1) - LZ_IN - 1;
        EZ_Shift = -Range_Check;  
        if (EZ_Shift >= 0) begin
          for (i = 0; i < EZ_Shift; i = i + 1) begin
            {MZ, STK_CHECK} = {MZ, 1'b0} >> 1;
            STK_EXT = STK_EXT | STK_CHECK;
          end
        end
      end

      if ({MZ[`R-1:0], STK_EXT} === 0) STK = 0;
      else STK = 1;

      if (ieee_compliance == 3) begin
        RND_val = RND_eval({1'b0, rnd[1:0]}, SIGN, MZ[`L], MZ[`R], STK);
      end else begin
        RND_val = RND_eval(rnd, SIGN, MZ[`L], MZ[`R], STK);
      end
  
      if (RND_val[0] === 1) MZ_rounded = MZ + (1<<`L);
      else MZ_rounded = MZ;

      EZ_rounded = EZ;
      if ( (MZ_rounded[`Movf] === 1) ) begin
        EZ_rounded = EZ + 1;
        MZ_rounded = MZ_rounded >> 1;
      end

      if (((ieee_compliance == 1) || (ieee_compliance == 3)) & (EZ_rounded <= ((1 << (exp_width-1)) - 1)) & MZ_rounded[`Movf - 1])
        EZ_rounded = EZ_rounded + 1;

      EZ_Zero = (EZ_rounded == ((1 << (exp_width-1)) - 1));
  
      if((EZ_rounded[`ez_msb] == 0) & (EZ_rounded >= ((1 << (exp_width-1)) - 1)))
        EZ_rounded = EZ_rounded - ((1 << (exp_width-1)) - 1);
      else 
        EZ_rounded = 0;

      if (EZ_rounded >= ((((1 << (exp_width-1)) - 1) * 2) + 1)) begin
        status_reg[4] = 1;
        status_reg[5] = 1;

        if(RND_val[2] === 1) begin
          MZ_rounded[`Movf-2:`L] = Inf_Sig;
          EZ_rounded = ((((1 << (exp_width-1)) - 1) * 2) + 1);
          status_reg[1] = 1;
        end
        else begin
          EZ_rounded = ((((1 << (exp_width-1)) - 1) * 2) + 1) - 1;
          MZ_rounded[`Movf-2:`L] = -1;
        end
      end
      else if (EZ_rounded == 0 ) begin
        status_reg[3] = 1;
         
        if (ieee_compliance == 0) begin
          status_reg[5] = 1;

          if(RND_val[3] === 1) begin
            MZ_rounded[`Movf-2:`L] = 0;
            EZ_rounded = 0  + 1;
          end
          else begin
            // 0
            MZ_rounded[`Movf-2:`L] = 0;
            EZ_rounded = 0 ;
            status_reg[0] = 1;
          end
        end

        if ((MZ_rounded[`Movf-2:`L] == 0) & (EZ_rounded[exp_width - 1:0] == 0)) begin
          status_reg[0] = 1;
        end

      end

      if ((ieee_compliance > 0) &&
          (((rnd==0 || rnd==4) && EZ_LPR==EZMinNorm && MZ_LPR<MZMinNormSub1QULP)||
           (rnd==2 && SIGN==1'b0 && EZ_LPR==EZMinNorm && MZ_LPR<=MZMinNormSub2QULP) ||
           (rnd==3 && SIGN==1'b1 && EZ_LPR==EZMinNorm && MZ_LPR<=MZMinNormSub2QULP) 

))
        status_reg[3] = 1;

      status_reg[5] = status_reg[5] | RND_val[1] | (~(Zero_A | Zero_B) & (EZ_rounded[exp_width - 1:0] == 0) & (MZ_rounded[`Movf - 2:`L] == 0));
  
      z_reg = {SIGN,EZ_rounded[exp_width-1:0],MZ_rounded[`Movf-2:`L]};
    end
  end
  
  assign status = ((^(a ^ a) !== 1'b0) || (^(b ^ b) !== 1'b0) || (^(rnd ^ rnd) !== 1'b0) || (DG_ctrl !== 1'b1)) ? {8'bX} : 
	      status_reg;
  assign z = ((^(a ^ a) !== 1'b0) || (^(b ^ b) !== 1'b0) || (^(rnd ^ rnd) !== 1'b0) || (DG_ctrl !== 1'b1)) ? {sig_width+exp_width+1{1'bX}} : 
              z_reg;


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
  
  `undef Mwidth
  `undef Movf
  `undef L
  `undef R
  `undef log_awidth
  `undef ez_msb

  // synopsys translate_on
  
endmodule

