////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 2002 - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Aamir Farooqui                February 20, 2002
//
// VERSION:   Verilog Simulation Model for DW_div_seq
//
// DesignWare_version: 39791efe
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////

//------------------------------------------------------------------------------
//ABSTRACT:  Sequential Divider 
//  Uses modeling functions from DW_Foundation.
//
//MODIFIED:
// 2/26/16 LMSU Updated to use blocking and non-blocking assigments in
//              the correct way
// 8/06/15 RJK Update to support VCS-NLP
// 2/06/15 RJK  Updated input change monitor for input_mode=0 configurations to better
//             inform designers of severity of protocol violations (STAR 9000851903)
// 5/20/14 RJK  Extended corruption of output until next start for configurations
//             with input_mode = 0 (STAR 9000741261)
// 9/25/12 RJK  Corrected data corruption detection to catch input changes
//             during the first cycle of calculation (related to STAR 9000506285)
// 1/4/12 RJK Change behavior when inputs change during calculation with
//          input_mode = 0 to corrupt output (STAR 9000506285)
// 3/19/08 KYUNG fixed the reset error of the sim model (STAR 9000233070)
// 5/02/08 KYUNG fixed the divide_by_0 error (STAR 9000241241)
// 1/08/09 KYUNG fixed the divide_by_0 error (STAR 9000286268)
// 8/01/17 AFT fixes to sequential behavior to make the simulation model
//             match the synthesis model. 
// 01/17/18 AFT Star 9001296230 
//              Fixed error in NLP VCS, related to upadtes to next_complete
//              inside always blocks that define registers. NLP forces the
//              code to be synthesizable, forcing the code of this simulation
//              model to be changed.
//------------------------------------------------------------------------------

module DW_div_seq ( clk, rst_n, hold, start, a,  b, complete, divide_by_0, quotient, remainder);


// parameters 

  parameter  integer a_width     = 3; 
  parameter  integer b_width     = 3;
  parameter  integer tc_mode     = 0;
  parameter  integer num_cyc     = 3;
  parameter  integer rst_mode    = 0;
  parameter  integer input_mode  = 1;
  parameter  integer output_mode = 1;
  parameter  integer early_start = 0;
 
//-----------------------------------------------------------------------------

// ports 
  input clk, rst_n;
  input hold, start;
  input [a_width-1:0] a;
  input [b_width-1:0] b;

  output complete;
  output [a_width-1 : 0] quotient;
  output [b_width-1 : 0] remainder;
  output divide_by_0;

//-----------------------------------------------------------------------------
// synopsys translate_off

localparam signed [31:0] CYC_CONT = (input_mode==1 & output_mode==1 & early_start==0)? 3 :
                                    (input_mode==early_start & output_mode==0)? 1 : 2;

//------------------------------------------------------------------------------
  // include modeling functions
`include "DW_div_function.inc"
 

//-------------------Integers-----------------------
  integer count;
  integer next_count;
 

//-----------------------------------------------------------------------------
// wire and registers 

  wire [a_width-1:0] a;
  wire [b_width-1:0] b;
  wire [b_width-1:0] in2_c;
  wire [a_width-1:0] quotient;
  wire [a_width-1:0] temp_quotient;
  wire [b_width-1:0] remainder;
  wire [b_width-1:0] temp_remainder;
  wire clk, rst_n;
  wire hold, start;
  wire divide_by_0;
  wire complete;
  wire temp_div_0;
  wire start_n;
  wire start_rst;
  wire int_complete;
  wire hold_n;

  reg [a_width-1:0] next_in1;
  reg [b_width-1:0] next_in2;
  reg [a_width-1:0] in1;
  reg [b_width-1:0] in2;
  reg [b_width-1:0] ext_remainder;
  reg [b_width-1:0] next_remainder;
  reg [a_width-1:0] ext_quotient;
  reg [a_width-1:0] next_quotient;
  reg run_set;
  reg ext_div_0;
  reg next_div_0;
  reg start_r;
  reg ext_complete;
  reg next_complete;
  reg temp_div_0_ff;

  wire [b_width-1:0] b_mux;
  reg [b_width-1:0] b_reg;
  reg pr_state;
  reg rst_n_clk;
  reg nxt_complete;
  wire reset_st;
  wire nx_state;

//-----------------------------------------------------------------------------
  
  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
    
    if (a_width < 3) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter a_width (lower bound: 3)",
	a_width );
    end
    
    if ( (b_width < 3) || (b_width > a_width) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter b_width (legal range: 3 to a_width)",
	b_width );
    end
    
    if ( (num_cyc < 3) || (num_cyc > a_width) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter num_cyc (legal range: 3 to a_width)",
	num_cyc );
    end
    
    if ( (tc_mode < 0) || (tc_mode > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter tc_mode (legal range: 0 to 1)",
	tc_mode );
    end
    
    if ( (rst_mode < 0) || (rst_mode > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter rst_mode (legal range: 0 to 1)",
	rst_mode );
    end
    
    if ( (input_mode < 0) || (input_mode > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter input_mode (legal range: 0 to 1)",
	input_mode );
    end
    
    if ( (output_mode < 0) || (output_mode > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter output_mode (legal range: 0 to 1)",
	output_mode );
    end
    
    if ( (early_start < 0) || (early_start > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter early_start (legal range: 0 to 1)",
	early_start );
    end
    
    if ( (input_mode===0 && early_start===1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m : Invalid parameter combination: when input_mode=0, early_start=1 is not possible" );
    end

  
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 


//------------------------------------------------------------------------------

  assign start_n      = ~start;
  assign complete     = ext_complete & (~start_r);
  assign in2_c        =  input_mode == 0 ? in2 : ( int_complete == 1 ? in2 : {b_width{1'b1}});
  assign temp_quotient  = (tc_mode)? DWF_div_tc(in1, in2_c) : DWF_div_uns(in1, in2_c);
  assign temp_remainder = (tc_mode)? DWF_rem_tc(in1, in2_c) : DWF_rem_uns(in1, in2_c);
  assign int_complete = (! start && run_set) || start_rst;
  assign start_rst    = ! start && start_r;
  assign reset_st = nx_state;

  assign temp_div_0 = (b_mux == 0) ? 1'b1 : 1'b0;

  assign b_mux = ((input_mode == 1) && (start == 1'b0)) ? b_reg : b;

  always @(posedge clk) begin : a1000_PROC
    if (start == 1) begin
      b_reg <= b;
    end 
  end

// Begin combinational next state assignments
  always @ (start or hold or count or a or b or in1 or in2 or
            temp_div_0 or temp_quotient or temp_remainder or
            ext_div_0 or ext_quotient or ext_remainder or ext_complete) begin
    if (start === 1'b1) begin                       // Start operation
      next_in1       = a;
      next_in2       = b;
      next_count     = 0;
      nxt_complete   = 1'b0;
      next_div_0     = temp_div_0;
      next_quotient  = {a_width{1'bX}};
      next_remainder = {b_width{1'bX}};
    end else if (start === 1'b0) begin              // Normal operation
      if (hold === 1'b0) begin
        if (count >= (num_cyc+CYC_CONT-4)) begin
          next_in1       = in1;
          next_in2       = in2;
          next_count     = count; 
          nxt_complete   = 1'b1;
          if (run_set == 1) begin
            next_div_0     = temp_div_0;
            next_quotient  = temp_quotient;
            next_remainder = temp_remainder;
          end else begin
            next_div_0     = 0;
            next_quotient  = 0;
            next_remainder = 0;
          end
        end else if (count === -1) begin
          next_in1       = {a_width{1'bX}};
          next_in2       = {b_width{1'bX}};
          next_count     = -1; 
          nxt_complete   = 1'bX;
          next_div_0     = 1'bX;
          next_quotient  = {a_width{1'bX}};
          next_remainder = {b_width{1'bX}};
        end else begin
          next_in1       = in1;
          next_in2       = in2;
          next_count     = count+1; 
          nxt_complete   = 1'b0;
          next_div_0     = temp_div_0;
          next_quotient  = {a_width{1'bX}};
          next_remainder = {b_width{1'bX}};
        end
      end else if (hold === 1'b1) begin             // Hold operation
        next_in1       = in1;
        next_in2       = in2;
        next_count     = count; 
        nxt_complete   = ext_complete;
        next_div_0     = ext_div_0;
        next_quotient  = ext_quotient;
        next_remainder = ext_remainder;
      end else begin                                // hold = X
        next_in1       = {a_width{1'bX}};
        next_in2       = {b_width{1'bX}};
        next_count     = -1;
        nxt_complete   = 1'bX;
        next_div_0     = 1'bX;
        next_quotient  = {a_width{1'bX}};
        next_remainder = {b_width{1'bX}};
      end
    end else begin                                  // start = X 
      next_in1       = {a_width{1'bX}};
      next_in2       = {b_width{1'bX}};
      next_count     = -1;
      nxt_complete   = 1'bX;
      next_div_0     = 1'bX;
      next_quotient  = {a_width{1'bX}};
      next_remainder = {b_width{1'bX}};
    end
  end
// end combinational next state assignments
  
generate
  if (rst_mode == 0) begin : GEN_RM_EQ_0

    assign nx_state = ~rst_n | (~start_r & pr_state);

  // Begin sequential assignments   
    always @ ( posedge clk or negedge rst_n ) begin : ar_register_PROC
      if (rst_n === 1'b0) begin
        count           <= 0;
        if(input_mode == 1) begin
          in1           <= 0;
          in2           <= 0;
        end else if (input_mode == 0) begin
          in1           <= a;
          in2           <= b;
        end 
        ext_complete    <= 0;
        ext_div_0       <= 0;
        start_r         <= 0;
        run_set         <= 0;
        pr_state        <= 1;
        ext_quotient    <= 0;
        ext_remainder   <= 0;
        temp_div_0_ff   <= 0;
        rst_n_clk       <= 1'b0;
      end else if (rst_n === 1'b1) begin
        count           <= next_count;
        in1             <= next_in1;
        in2             <= next_in2;
        ext_complete    <= nxt_complete & start_n;
        ext_div_0       <= next_div_0;
        ext_quotient    <= next_quotient;
        ext_remainder   <= next_remainder;
        start_r         <= start;
        pr_state        <= nx_state;
        run_set         <= 1;
        if (start == 1'b1)
          temp_div_0_ff   <= temp_div_0;
        rst_n_clk       <= rst_n;
      end else begin                                // If nothing is activated then put 'X'
        count           <= -1;
        in1             <= {a_width{1'bX}};
        in2             <= {b_width{1'bX}};
        ext_complete    <= 1'bX;
        ext_div_0       <= 1'bX;
        ext_quotient    <= {a_width{1'bX}};
        ext_remainder   <= {b_width{1'bX}};
        temp_div_0_ff   <= 1'bX;
        rst_n_clk       <= 1'bX;
      end 
    end                                             // ar_register_PROC

  end else begin : GEN_RM_NE_0

    assign nx_state = ~rst_n_clk | (~start_r & pr_state);

  // Begin sequential assignments   
    always @ ( posedge clk ) begin : sr_register_PROC
      if (rst_n === 1'b0) begin
        count           <= 0;
        if(input_mode == 1) begin
          in1           <= 0;
          in2           <= 0;
        end else if (input_mode == 0) begin
          in1           <= a;
          in2           <= b;
        end 
        ext_complete    <= 0;
        ext_div_0       <= 0;
        start_r         <= 0;
        run_set         <= 0;
        pr_state        <= 1;
        ext_quotient    <= 0;
        ext_remainder   <= 0;
        temp_div_0_ff   <= 0;
        rst_n_clk       <= 1'b0;
      end else if (rst_n === 1'b1) begin
        count           <= next_count;
        in1             <= next_in1;
        in2             <= next_in2;
        ext_complete    <= nxt_complete & start_n;
        ext_div_0       <= next_div_0;
        ext_quotient    <= next_quotient;
        ext_remainder   <= next_remainder;
        start_r         <= start;
        pr_state        <= nx_state;
        run_set         <= 1;
        if (start == 1'b1)
          temp_div_0_ff   <= temp_div_0;
        rst_n_clk       <= rst_n;
      end else begin                                // If nothing is activated then put 'X'
        count           <= -1;
        in1             <= {a_width{1'bX}};
        in2             <= {b_width{1'bX}};
        ext_complete    <= 1'bX;
        ext_div_0       <= 1'bX;
        ext_quotient    <= {a_width{1'bX}};
        ext_remainder   <= {b_width{1'bX}};
        temp_div_0_ff   <= 1'bX;
        rst_n_clk       <= 1'bX;
      end 
   end // sr_register_PROC

  end
endgenerate

  always @ (posedge clk) begin: nxt_complete_sync_PROC
    next_complete <= nxt_complete;
  end // complete_reg_PROC

  wire corrupt_data;

generate
  if (input_mode == 0) begin : GEN_IM_EQ_0

    localparam [0:0] NO_OUT_REG = (output_mode == 0)? 1'b1 : 1'b0;
    reg [a_width-1:0] ina_hist;
    reg [b_width-1:0] inb_hist;
    wire next_corrupt_data;
    reg  corrupt_data_int;
    wire data_input_activity;
    reg  init_complete;
    wire next_alert1;
    integer change_count;

    assign next_alert1 = next_corrupt_data & rst_n & init_complete &
                                    ~start & ~complete;

    if (rst_mode == 0) begin : GEN_A_RM_EQ_0
      always @ (posedge clk or negedge rst_n) begin : ar_hist_regs_PROC
	if (rst_n === 1'b0) begin
	    ina_hist        <= a;
	    inb_hist        <= b;
	    change_count    <= 0;

	  init_complete   <= 1'b0;
	  corrupt_data_int <= 1'b0;
	end else begin
	  if ( rst_n === 1'b1) begin
	    if ((hold != 1'b1) || (start == 1'b1)) begin
	      ina_hist        <= a;
	      inb_hist        <= b;
	      change_count    <= (start == 1'b1)? 0 :
	                         (next_alert1 == 1'b1)? change_count + 1 : change_count;
	    end

	    init_complete   <= init_complete | start;
	    corrupt_data_int<= next_corrupt_data | (corrupt_data_int & ~start);
	  end else begin
	    ina_hist        <= {a_width{1'bx}};
	    inb_hist        <= {b_width{1'bx}};
	    change_count    <= -1;
	    init_complete   <= 1'bx;
	    corrupt_data_int <= 1'bX;
	  end
	end
      end
    end else begin : GEN_A_RM_NE_0
      always @ (posedge clk) begin : sr_hist_regs_PROC
	if (rst_n === 1'b0) begin
	    ina_hist        <= a;
	    inb_hist        <= b;
	    change_count    <= 0;
	  init_complete   <= 1'b0;
	  corrupt_data_int <= 1'b0;
	end else begin
	  if ( rst_n === 1'b1) begin
	    if ((hold != 1'b1) || (start == 1'b1)) begin
	      ina_hist        <= a;
	      inb_hist        <= b;
	      change_count    <= (start == 1'b1)? 0 :
	                         (next_alert1 == 1'b1)? change_count + 1 : change_count;
	    end

	    init_complete   <= init_complete | start;
	    corrupt_data_int<= next_corrupt_data | (corrupt_data_int & ~start);
	  end else begin
	    ina_hist        <= {a_width{1'bx}};
	    inb_hist        <= {b_width{1'bx}};
	    init_complete    <= 1'bx;
	    corrupt_data_int <= 1'bX;
	    change_count     <= -1;
	  end
	end
      end
    end // GEN_A_RM_NE_0

    assign data_input_activity =  (((a !== ina_hist)?1'b1:1'b0) |
				 ((b !== inb_hist)?1'b1:1'b0)) & rst_n;

    assign next_corrupt_data = (NO_OUT_REG | ~complete) &
                              (data_input_activity & ~start &
					~hold & init_complete);

`ifdef UPF_POWER_AWARE
  `protected
EOPK/9^Eg6+XRDVC93b:fOI#3.@LT/@Za7,&I,_;GE[HfMLGAUGG-)OI&>YBCP?b
:fJ2c9P9EU1;=A:.?4g64:OOc0JLUSYXaCaeg#<2<5:T?a@E.,V&#(#[bdfW@d@J
6_Lg:M=3X2<?\:H_K(&I\IC)G35Gb=9J\-:20/f6XA-b]A7AFNH?(7-APQ.eYEAZ
]TO+KS2RLe(?5],1QG78@,J?17W8+^D/bE8CD->A?Sa,7^(C7EB7)Y>c:-Q6Ea>Y
#Z44H,UW:C9.9>N:01ZE\4gK#X\AeG_A6Q5+V^S^b^48b9V2?bH-3@4d-(.B8f6-
4&>+EHH&Hg:O2PH57L5D1IC]PHAEY1XXS\W(_=+AVG[R\0+[+bYPa4X\T_[4^/J]
\7Z]7d2d0X)B_LF9dZ]K/2#bdI\\TG+PN^_(C9L(bDFd[#5J_7]FcWQ?X?YVGb2f
]-d?B2f9>PMEM&W(PdGaYEPFW@R-E)=+Jf_Vg1]:YY20f2D_))71W4P+F;VWJU2E
[fEX)G+=#4CHB0++NgS<DCY;J\K8QB_B2S-31JGF[#(VLRO]AgKg^ETgHD-UI&#^
,K&#BQP_&_]?H+RPB;)P-5_g6-[BQBH9E;0L.e>_26CPaGc#d?Q;eaI??8RFMH7W
0(SR\06I+MgVR5V8]_g)OG)L3]RE0]<KK6FS)LL5<QY9,X6YZ:E4,.&Z1<M)ZKPa
1T;410XR:VK.g)/)[]J]OHSg+47.<=)XcF3X0fI=5E[(J=T:-582aE,XKa-#13e]
EadX]@DRLPGH1MBG-X;_8(PC1S&Yc5=&O3/:K6:W,_K(.XMD3(PWUIP8bI&-WK?V
^9?)R;bST-IVYWe0ScdW3H5SOJeJXYV^SD>f)\G9Z35U,SNfN2LdQgdMDQ5bS[>8
[O10.R87R7^G\SHDKA(;6V[;[<Z_O;QTE[/5c]Z9=TU&K(P6VMU@dR_EDKb3AC-?
E;6,cB)N8g=1VUH@4<T;6O/]SD>HcT+\[d,&DZSDa]-B;FHN9c?4IA^J32CY50RP
-9,[NBG(U5d]C[R<(\3QQ1IB?cf+g(c38;NbNF1W\&LK>)d,?)0(RAeLc86N7JA:
BXVX,QP[QLc?:4&MS:L_SXCP4+7F=UB632RK6:Z<C7>)6P+<,/8R)XW_-HV<-Ef0
fdS#<...RQQX45+eD:WG04.LU,f2Raf:X\2^R7cO=Mb2dABX(_N6PT(cO8O-)GXN
2Wd<9:5;OG)7H3\TDS&U>&055/H;2CE/;7)EM+,GF(J;=IZ[;3bdaFNY2@cEXWgQ
,3bKA/EA_3FSM3=)_KZ+S<:9[N<M@)e_3;G?/0cIHQIaXW&a.(G[NZO#Ba0A\MY2
0:<X\P74C963aTg?>,@EVb38S&2GHG9[O@:)<@3.0We,LZ=Y7UKdO=/-K^1:g\<8
8,3[f+TNK#Y_ZR[/_]?D14_W=MLLE6N<.G&5S.CBL1Ubc&1#1+7CQf)IR3Ce)IgP
YPO(2_+W@B\RaRY]7LdYG[gP(7\;Q55fWO5@&Y?+)K?2:ZC]gFT8C80\Z9JVg-Pa
X)9EYHFW(V&<FdJO3a&g#/aKI-854:V7+6^(2:&MW741b4<U>.[VUQa)a=:P7(-+
>S&IEZN-Gge<J]G\g\JaR?&eT^V5>fSZT7LJX#;O@cWQ-BJK,0<F].4bGUD?;2RB
H8.Hc@.L<ZBJY2-6O1[fTebUM3^gbXIbFb&?TaB2&M1N2EQN<WK4JAF5g+)&Y8-d
CP&IJ51(4[Z/g^KK];dFXPQ,C-WB]&gdgH)P@TQN:63Y94O94OHS7K2R=8c1U2fU
RV]VLM:XS>V)NdL0NA68@-KL9McZ#b^4B_J@4W7H@&3C=:O5b=]7Ya@-LAcT>fBN
d4Zc^WZFc]cfg1/T^UXXX:86Z[IY<+ALN/5;NUd)>aLg>6cGO>)c<50g)MC;#M]J
CDEYQUf9NXG?;?.fW4N5KGUceb@TV[NDH0T@_WZgU8)SON=1=[:3ZgWNB)fUPB-e
L>SM+DV6?@2eI1OQE_INB39G?4XH#6?&H9JZTIb9E(=OW&ca5dT\FaT-/30YV[a5
)eJ0(]IEg7/>7fAD4_dM>OR->RM]KG>V2T\VMQ^eM2L&B@^GDU6MT\D5F??/dH@:
OOYI:YXAP-L<VAWV#<.URaX(8P6++:H68c]<c8X8.FELJ@HMfJg_?:d6GD)aM5I(
:H@?6)#+YVfbH);4MLEEK7:6D27&Q9cSbSeN?;E=4[5DXA&E1XRF23BRC(CRQL<^
CYS<B-+R14ZP+N1AK6>C:1-9?&EVbf:YE[KNMC1/24/F&2&02@3K,KPRg[52:-ED
bg+5>/,fVB<BO0G5[?9;P^7[XH++.CD_VG(-42T1WYV/L_QM1<:bRQCOCI.4G9a1
H;FHa0V3D3<cISDa;2X?[(L&,B2fJURC]^X(7F7FBg@Ce1KbbGcX9Qad,S>ZQKcQ
dfTfYB9?:&O62d/>WTJQ#,K4b+N.)0:=fS_T>b9\^V87U0Yg/,@a^AL8(^M>>a>>
Y\0I:E2=^W3aLXg3#b4M_1b?>0(Z9JEA97VYK[I=2_27FN35Z]Z(+Rgg/YVLQ^=K
A64^/ZK^S]MOGP8+/VZI@XH4=4R?&@cOf8::0A[7.U7/,^?RGDF]\\SSd&@:SML7
8@8W(KD=gY>O.$
`endprotected

`else
    always @ (posedge clk) begin : corrupt_alert_PROC
      integer updated_count;

      updated_count = change_count;

      if (next_alert1 == 1'b1) begin
`ifndef DW_SUPPRESS_WARN
          $display ("WARNING: %m:\n at time = %0t: Operand input change on DW_div_seq during calculation (configured without an input register) will cause corrupted results if operation is allowed to complete.", $time);
`endif
	updated_count = updated_count + 1;
      end

      if (((rst_n & init_complete & ~start & ~complete & next_complete) == 1'b1) &&
          (updated_count > 0)) begin
	$display(" ");
	$display("############################################################");
	$display("############################################################");
	$display("##");
	$display("## Error!! : from %m");
	$display("##");
	$display("##    This instance of DW_div_seq has encountered %0d change(s)", updated_count);
	$display("##    on operand input(s) after starting the calculation.");
	$display("##    The instance is configured with no input register.");
	$display("##    So, the result of the operation was corrupted.  This");
	$display("##    message is generated at the point of completion of");
	$display("##    the operation (at time %0d), separate warning(s) were", $time );
`ifndef DW_SUPPRESS_WARN
	$display("##    generated earlier during calculation.");
`else
	$display("##    suppressed earlier during calculation.");
`endif
	$display("##");
	$display("############################################################");
	$display("############################################################");
	$display(" ");
      end
    end
`endif

    assign corrupt_data = corrupt_data_int;

  if (output_mode == 0) begin : GEN_OM_EQ_0
    reg  alert2_issued;
    wire next_alert2;

    assign next_alert2 = next_corrupt_data & rst_n & init_complete &
                                     ~start & complete & ~alert2_issued;

`ifdef UPF_POWER_AWARE
  `protected
<5ASC1Y#+OeV>__M<2;VDa=>O8HH?,D/-LY#4fA8.afWWfZdIA_R()Ra\.[3]\SH
Q;#5TcX?JORLUb-e6<(7-SB5G9X#GKJ[@8,08dAYB?D0S+@NJ\HL,fRfJ_W=GA>J
88gS6WLaZb/,G/G+2D/IM\.\6Z0U_FVY4V?V<TGL@6d[<AcEa,GcA:\e))9F(5#R
L^_4W>BAWe(ZTY8eFeK4FV>S>A(fM^-DC[N^U_F>AdW@;7#O50)gOQ-.R0\:d3\E
LGWa)TTY6KO]0U+5abKdU>,8?BH+d0//>c^\BDb4CGcW+NTa27eL\\L+B;7_?R(D
01N1.4[PZMcf<YS-_YM9&#/LL9,Fa#XcMX[)gQe_H^6CPW>O97#8>R-K,&?If9,=
<\AN)F\4,J;NEER>NI>;-eH)M05/:DVPF&^bf-gg8-3A@OTHR)eNWUJ=DRU>?U1A
O<ZY3KK2Z4H2gYV_T6;4?Jf\@,?Zf?O8FXAF_N-YZ7JI2Ae1DcIB)eb59>K(<SN(
]?V:7.R)g;;a5VFY0Ue^HUQ?(&UD_Z&dBRY:TR?a?3)\<CC2eWLa5&:2?AW)A90/
B,QYF/aZ9cM7fKA)AFe1g8:2C7f9.K7EAT(;=51NW+TP7[dggIIE^JS7Y\@T/5f>
;Z2_Ha0Z@SGVYDLMBB]7;)[eD=L+\2FZ=$
`endprotected

`else
  `ifndef DW_SUPPRESS_WARN
    always @ (posedge clk) begin : corrupt_alert2_PROC
      if (next_alert2 == 1'b1) begin
        $display( "## Warning from %m: DW_div_seq operand input change near %0d causes output to no longer retain result of previous operation.", $time);
      end
    end
  `endif
`endif

    if (rst_mode == 0) begin : GEN_AI_REG_AR
      always @ (posedge clk or negedge rst_n) begin : ar_alrt2_reg_PROC
        if (rst_n == 1'b0) alert2_issued <= 1'b0;

	  else alert2_issued <= ~start & (alert2_issued | next_alert2);
      end
    end else begin : GEN_AI_REG_SR
      always @ (posedge clk) begin : sr_alrt2_reg_PROC
        if (rst_n == 1'b0) alert2_issued <= 1'b0;

	  else alert2_issued <= ~start & (alert2_issued | next_alert2);
      end
    end

  end  // GEN_OM_EQ_0

  // GEN_IM_EQ_0
  end else begin : GEN_IM_NE_0
    assign corrupt_data = 1'b0;
  end // GEN_IM_NE_0
endgenerate
    

  assign quotient     = (reset_st == 1) ? {a_width{1'b0}} :
                        ((((input_mode==0)&&(output_mode==0))||(early_start==1)) & start == 1'b1) ? {a_width{1'bX}} :
                        (corrupt_data !== 1'b0)? {a_width{1'bX}} : ext_quotient;
  assign remainder    = (reset_st == 1) ? {b_width{1'b0}} :
                        ((((input_mode==0)&&(output_mode==0))||(early_start==1)) & start == 1'b1) ? {b_width{1'bX}} :
                        (corrupt_data !== 1'b0)? {b_width{1'bX}} : ext_remainder;
  assign divide_by_0  = (reset_st == 1) ? 1'b0 :
                        (input_mode == 1 && output_mode == 0 && early_start == 0) ? ext_div_0 :
                        (output_mode == 1 && early_start == 0) ? temp_div_0_ff :
                        temp_div_0_ff;

 
`ifndef DW_DISABLE_CLK_MONITOR
`ifndef DW_SUPPRESS_WARN
  always @ (clk) begin : P_monitor_clk 
    if ( (clk !== 1'b0) && (clk !== 1'b1) && ($time > 0) )
      $display ("WARNING: %m:\n at time = %0t: Detected unknown value, %b, on clk input.", $time, clk);
    end // P_monitor_clk 
`endif
`endif
// synopsys translate_on

endmodule
