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
// AUTHOR:    Kyung-Nam Han, Sep. 25, 2006
//
// VERSION:   Verilog Simulation Model for DW_fp_div_seq
//
// DesignWare_version: 57594ed4
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
//
// ABSTRACT: Floating-Point Sequencial Divider
//
//              DW_fp_div_seq calculates the floating-point division
//              while supporting six rounding modes, including four IEEE
//              standard rounding modes.
//
//              parameters      valid values (defined in the DW manual)
//              ==========      ============
//              sig_width       significand size,  2 to 253 bits
//              exp_width       exponent size,     3 to 31 bits
//              ieee_compliance support the IEEE Compliance
//                              0 - IEEE 754 compatible without denormal support
//                                  (NaN becomes Infinity, Denormal becomes Zero)
//                              1 - IEEE 754 standard compatible
//                                  (NaN and denormal numbers are supported)
//              num_cyc         Number of cycles required for the FP sequential
//                              division operation including input and output
//                              register. Actual number of clock cycle is
//                              num_cyc - (1 - input_mode) - (1 - output_mode)
//                               - early_start + internal_reg
//              rst_mode        Synchronous / Asynchronous reset
//                              0 - Asynchronous reset
//                              1 - Synchronous reset
//              input_mode      Input register setup
//                              0 - No input register
//                              1 - Input registers are implemented
//              output_mode     Output register setup
//                              0 - No output register
//                              1 - Output registers are implemented
//              early_start     Computation start (only when input_mode = 1)
//                              0 - start computation in the 2nd cycle
//                              1 - start computation in the 1st cycle (forwarding)
//                              early_start should be 0 when input_mode = 0
//              internal_reg    Insert a register between an integer sequential divider
//                              and a normalization unit
//                              0 - No internal register
//                              1 - Internal register is implemented
//
//              Input ports     Size & Description
//              ===========     ==================
//              a               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Input
//              b               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Input
//              rnd             3 bits
//                              Rounding Mode Input
//              clk             Clock
//              rst_n           Reset. (active low)
//              start           Start operation
//                              A new operation is started by setting start=1
//                              for 1 clock cycle
//              z               (sig_width + exp_width + 1)-bits
//                              Floating-point Number Output
//              status          8 bits
//                              Status Flags Output
//              complete        Operation completed
//
// Modified:
//   6/05/07 KYUNG (0703-SP3)
//           The legal range of num_cyc parameter widened.
//   3/25/08 KYUNG (0712-SP3)
//           Fixed the reset error (STAR 9000234177)
//   1/29/10 KYUNG (D-2010.03)
//           1. Removed synchronous DFF when rst_mode = 0 (STAR 9000367314)
//           2. Fixed complete signal error at the reset  (STAR 9000371212)
//           3. Fixed divide_by_zero flag error           (STAR 9000371212)
//   2/27/12 RJK (F-2011.09-SP4)
//           Added missing message when input changes during calculation
//           while input_mode=0 (STAR 9000523798)
//   9/22/14 KYUNG (J-2014.09-SP1)
//           Modified for the support of VCS NLP feature
//   9/22/15 RJK (K-2015.06-SP3) Further update for NLP compatibility
//   2/26/16 LMSU
//           Updated to use blocking and non-blocking assigments in
//           the correct way
//   10/2/17 AFT (M-2016.12-SP5-2)
//           Fixed the behavior of the complete output signal to match
//           the synthesis model and the VHDL simulation model. 
//           (STAR 9001121224)
//           Also fixed the issue with the impact of rnd input on the
//           components output 'z'. (STAR 9001251699)
//  07/10/18 AFT - Star 9001366623
//           Signal int_complete_advanced had its declaration changed from
//           'reg' to 'wire'.
//  03/03/21 RJK - Star 3580221.  Issues with assertions in protected region
//           of Verilog sim model.  Adopting standard method used
//           in other sequential math models.
//
//-----------------------------------------------------------------------------

module DW_fp_div_seq (a, b, rnd, clk, rst_n, start, z, status, complete);

  parameter integer sig_width = 23;      // RANGE 2 TO 253
  parameter integer exp_width = 8;       // RANGE 3 TO 31
  parameter integer ieee_compliance = 0; // RANGE 0 TO 1
  parameter integer num_cyc = 4;         // RANGE 4 TO (2 * sig_width + 3)
  parameter integer rst_mode = 0;        // RANGE 0 TO 1
  parameter integer input_mode = 1;      // RANGE 0 TO 1
  parameter integer output_mode = 1;     // RANGE 0 TO 1
  parameter integer early_start = 0;     // RANGE 0 TO 1
  parameter integer internal_reg = 1;    // RANGE 0 TO 1


  localparam TOTAL_WIDTH = (sig_width + exp_width + 1);

//-----------------------------------------------------------------------------

  input [(exp_width + sig_width):0] a;
  input [(exp_width + sig_width):0] b;
  input [2:0] rnd;
  input clk;
  input rst_n;
  input start;

  output [(exp_width + sig_width):0] z;
  output [8    -1:0] status;
  output complete;

// synopsys translate_off

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

  
 
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
    
    if ( (num_cyc < 4) || (num_cyc > 2*sig_width+3) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter num_cyc (legal range: 4 to 2*sig_width+3)",
	num_cyc );
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
    
    if ( (internal_reg < 0) || (internal_reg > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter internal_reg (legal range: 0 to 1)",
	internal_reg );
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


//-----------------------------------------------------------------------------

  localparam CYC_CONT = num_cyc - 3;
  integer count;
  integer next_count;
  integer cnt_glitch;

  reg  [(exp_width + sig_width):0] ina;
  reg  [(exp_width + sig_width):0] inb;
  reg  [(exp_width + sig_width):0] next_ina;
  reg  [(exp_width + sig_width):0] next_inb;
  reg  [(exp_width + sig_width):0] next_int_z;
  reg  [(exp_width + sig_width):0] int_z;
  reg  [(exp_width + sig_width):0] int_z_d1;
  reg  [(exp_width + sig_width):0] int_z_d2;
  reg  [7:0] next_int_status;
  reg  [7:0] int_status;
  reg  [7:0] int_status_d1;
  reg  [7:0] int_status_d2;
  reg  [2:0] rnd_reg;
  reg  new_input_pre;
  reg  new_input_reg_d1;
  reg  new_input_reg_d2;
  reg  next_int_complete;
  reg  next_complete;
  reg  int_complete;
  wire int_complete_advanced; 

  reg  int_complete_d1;
  reg  int_complete_d2;
  reg  count_reseted;
  reg  next_count_reseted;

  wire [(exp_width + sig_width):0] ina_div;
  wire [(exp_width + sig_width):0] inb_div;
  wire [(exp_width + sig_width):0] z;
  wire [(exp_width + sig_width):0] temp_z;
  wire [7:0] status;
  wire [7:0] temp_status;
  wire [2:0] rnd_div;
  wire clk, rst_n;
  wire complete;
  wire start_in;

  reg  start_clk;
  wire rst_n_rst;
  reg  reset_st;
  reg  [(exp_width + sig_width):0] a_reg;
  reg  [(exp_width + sig_width):0] b_reg;

  localparam [1:0] output_cont = output_mode + internal_reg;


  wire corrupt_data;

generate
  if (input_mode == 0) begin : GEN_IM_EQ_0

    localparam [0:0] NO_OUT_REG = (output_mode == 0)? 1'b1 : 1'b0;
    reg [TOTAL_WIDTH-1:0] ina_hist;
    reg [TOTAL_WIDTH-1:0] inb_hist;
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
	      ina_hist        <= a;
	      inb_hist        <= b;
	      change_count    <= (start == 1'b1)? 0 :
	                         (next_alert1 == 1'b1)? change_count + 1 : change_count;
	    init_complete   <= init_complete | start;
	    corrupt_data_int<= next_corrupt_data | (corrupt_data_int & ~start);
	  end else begin
	    ina_hist        <= {TOTAL_WIDTH{1'bx}};
	    inb_hist        <= {TOTAL_WIDTH{1'bx}};
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
	      ina_hist        <= a;
	      inb_hist        <= b;
	      change_count    <= (start == 1'b1)? 0 :
	                         (next_alert1 == 1'b1)? change_count + 1 : change_count;
	    init_complete   <= init_complete | start;
	    corrupt_data_int<= next_corrupt_data | (corrupt_data_int & ~start);
	  end else begin
	    ina_hist        <= {TOTAL_WIDTH{1'bx}};
	    inb_hist        <= {TOTAL_WIDTH{1'bx}};
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
					init_complete);

`ifdef UPF_POWER_AWARE
  `protected
NFM9:B_CH#;Z0\PE=:cMU0D=QB<0NHL&?[TY/>E#/4KOSAYK\J,:&)4MF=EH-bMd
fgU8&0HO\JM)EO5#AA&0e1A&0U()Vc:EZ6CZK8[8Q#=I)47V\f6;7BJIX>Gb2aRb
;99_)C=--];NRe]1Z?P2#DHX0L3e:.0]1IX4SNX1UT4^dF9S)7[K@)HC/@;L@7Ng
?/X1eCHDIZFV06\7VE3bb+RbTAJWZ8\.4L_:+@c@@c]:E+_VB)P[_UIUP8R2X=+L
9bMJb/?</Z,]Oc4MXV1^09\VGW(.S[JP76>ZL7?gM1EOA^YF-IT00>:45,#-gO3X
,GGT0(E>Rf4ZO1aA,)AeSfF\94<MQ)G,0E.P9IP:bK]<dDdgTCU3:QZ(eDO:9K?=
X2<Q/IHN];>1?)_@>K;PKL?<KCdVPC#=J_eC]D)C6KKSO4>O5B0@>>E[3ZH.^^dZ
;P+F((KP&,XRN2B,/<N.@+)CA\,5BePF=f1K<9UU07\BaX,W/B)/b(LC-J>OgMcG
]_D\=19[0<9Z?1g8WYR8f@Nef)@?C9)NdQ/c):W[M1X3&@6QH.cXR@E4)B1caJg.
0Nf0LA@Z97V#:gP[#LC]MC6#:SD2)FNP@U^+:;O-Df-ZDK1<-DDZgE2.Ub7OLeN>
CA@>IJ[P<KV)D+#YDLVRgX=RFLg4YX5D3CKVOT\Ve3/B-=PMUULU\F)(:N1aD@E#
,J.J+Lb?fg-\M^#5>E^T:XD0]a&CX7.FF>^=NOMD:2NO>Hc,+cff.0[(2ZgJ<VB\
[.DaW/7e+30K;5TAg3=F]b_&<e576^)1J^:DM_;&CKX&0X9DL>^SH?=3C8O/KOL7
&Bc-JggRN.\cd9-+:(/FWB3f+><EMQXB)PW<e]>Y9V8W&Rgd6gPJ\SbVD/<YOPTQ
(^D9Z6,MC[:a3Z#MKKd=6c9Z9Tc:)c\R=ID7KWJQW,9+F\>\C#H2-L4B4Z0ZK:IK
a@f<KFLe7)[=QLR4-F4aWKR.Ag4Z[A/)8e0Z#Y,gB8PQ]OCVcJ#7FeJ3RC_)/;ZS
5-X)]RL-@\5=dg5ZEA<^ee(-NJ_:Yb;@#=K\4_E2NAJ^6;d4X6gG55ZLBbJB=S;e
aCc@0R,_e)-M\]e.dgN>VTLGg=ZSKYI2Y&KPaM?\UMR.JIJ^BcQDACJO=aCc<&]-
]ETP<.4X7]bW,P;,8-(7_:VSFEG=)F>[)R.:[40NI.:MLTXFd^.X&aeeHb<O#_-B
]Y;e:Y&fZ12&\\(=F]?)IC@+.Ue0]#\,RR>XNU7:E4g/JKPb:@LR4_7=H[-93cO4
]F+H@]@W0CHHS-14WdXOJ8G#D:K_8QZE3EB>)]@U02]-Z2XOOCXSBT(&=HM40+gH
dE8YQ;a(F>+0I9NfN.J-?eWXCM@G3Q(b6GU]]O5aRS+--(d^-La3K/d-D6[C.Q+/
@G/a5g6]_1/D3SPIdT:DPJKLV\\5bE;LCFX<_^:GYG84ZL@Reg>/[6Q_3fC^CTf-
]7e[A]fM[2P.[>Q?()P?)]TaNaB9<4dE#J?X/<@Vf,C2V1H2XSBN34SCc8QGFdZV
)c9,\RCICG812(E?AP@SAM::1_LVGKIR#Z#FMAb<YaD-&bTW.9(^BSJ]<a86S),?
aKJCTc46X-C6:f+]#NCCA,VIDadVUQbe)[WcLR1PEa\RSUY4U10@dWQC]<#.H\=/
F=fGPGB=Z>gQ?9JS+fdA\MB@;FWMJV&5fD8OV5c+?CV-Y[,1[7+SZJ:eZ(6FNTU?
#9a3g9B[4aQ.?);aFdUJXb>3P3=O0A1NW_J]F>A]0M<JU1=W,3)E[H>2=-3ZY^bD
<SYNcf54,\UaIZ\1RLf/P<Wc4GTS#f#)&_N1G-&=Kd\eM&9.fP),)2<+M2[_58]5
\?]O6N_(U3&g?.VD=(IA_:TfSC>K.)7Z84JI7#5BX4K)T)4aSE/e8dYO_+[SQU6=
3.H>6Z.\-0[d[</0GZ#2T=d\V3TOaW5S44HKCaJ:]QZ^3V,=OGPW_21eDZN@,))c
,f[I4PZ_N1>C79eLf;aP37dB[L2>\e:E,_M)?Bg&89Mc#7TN#\0B]N5eb,\9Rg4V
4gGVH>1-O5a3EfN6(VVTBRNB1TaLNP[#O?44Z&S\C4\B^aH=MS?Wd,<d^H3AE5JR
S5bO_P/X,HI@ERTA\<<MKQ([Y<6e<RR-fgdW61W)B);I<F0=W76A[?YIUH8?6F7b
89.S:f-7V:1^)4:/EEIPFT]Z_MA6K7F&bVMb4Y4]==Y:;O1X6_YQ7##QP9fXc0PN
S5+A5ZQ:UeAA[4VC7B+:G8E#JVH.2UZG,HRM)>dgI,=+Wc8P),BPL;T\eE2/BSS/
\N#9^5b#\SL4@aIM57e0=1TU2OL9<@8@.EP0SQ^E/_&&M7<]3S-N3)5ZBQ)FH^eU
?3eD&963fgJLU5E>SY,U>Z>&Ob#Q>G:Y7G^I:/XB@]PL+[GRF&R,g)E(e-K3S74V
)JIR](@NdFP0KTXgdK0U==]RJcX5I0SMT;;FQ2d7O3,IIX>8\bc>2?L-Y]<A@2@)
CFW9JVLQ<0MW_QM<EQ0YM/aP4C[CFBSGZO<4V1CMc;LF_Z?a50H8KU=(;A]:bX);
(_6Y#X).Vb<Z_2(Yd2FHX.8c5))dS#_/<8N&EX0\JT\W1bG:/&QY4M/_bO+M-gY0
6T057Q32G[\/eF[[.V^^(98c4$
`endprotected

`else
    always @ (posedge clk) begin : corrupt_alert_PROC
      integer updated_count;

      updated_count = change_count;

      if (next_alert1 == 1'b1) begin
`ifndef DW_SUPPRESS_WARN
          $display ("WARNING: %m:\n at time = %0t: Operand input change on DW_fp_div_seq during calculation (configured without an input register) will cause corrupted results if operation is allowed to complete.", $time);
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
	$display("##    This instance of DW_fp_div_seq has encountered %0d change(s)", updated_count);
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
:dPC(Y@9_)FFX0OcC(YC9DBbA)I:MeCFZJWbL&QGCfMYaO9+O+<[/)SZRBSKb\.e
Z.Z^e#NJ,:.+C]dPEG,6][MCCR@+I[Z_,M7LZO[G2NVR8YYFH/@bb25Md)RN5F_g
e#a:9a+<,+R;=,f(V:436LGNX6P4L;bPV@5;9b.?0=.]RX;^SXPX8]UNG,Q2FES7
f]Q;#&bI@+/>.AM6PC&X=@a5O\IP[\Lea1WJG,/P\EML-bT3?QJ3NR\aIUe+L]eD
B<^Le5MRCF,@Ub:Y8bB5L3Zg/_2[TR6;Id8J+H_M6F/3]G_RO)_JVC(&88[ZCG8E
ZAHFFD9T6(.HJC4LR;BPVOVM@f^KHN.CN/SS+<-,G(TP#6\9d9<&,WUeI)))]D4L
.?_F2BX/>\F,@B+)B08S[Q_c/++EOdW/XMf3\U[OK.)E4W=UgIG\6(MCWc_>.U5C
DV.fg&B.6R+3U7(Of#3GRX#e8DJ1,B,5T19fBKYPBM[7GcA^M&;;-=;+b2Ba0H;:
:Ud^<]LB-U=&-33FdX^X#FM(_b7]3]>dVQ>UcI/-7cEObb_=5Tdbc.#.-gaC:7M]
)fg_)QNFV;&M:S+)/YgOQ]=FR(Ff3_P2H@eX8DA;AN/1HX_P/L[4:9]eG>(6AZ4\
QMF<(#USNYMJ^1aaB:O1H918/ZaJQ]X3@$
`endprotected

`else
  `ifndef DW_SUPPRESS_WARN
    always @ (posedge clk) begin : corrupt_alert2_PROC
      if (next_alert2 == 1'b1) begin
        $display( "## Warning from %m: DW_fp_div_seq operand input change near %0d causes output to no longer retain result of previous operation.", $time);
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

  assign corrupt_data = (output_cont == 2) ? new_input_reg_d2:
                        (output_cont == 1) ? new_input_reg_d1:
                        new_input_pre;

  assign z = (reset_st) ? 0 :
             (corrupt_data !== 1'b0)? {TOTAL_WIDTH{1'bx}} :
             (output_cont == 2) ? int_z_d2 :
             (output_cont == 1) ? int_z_d1 :
             next_int_z;

  assign status = (reset_st) ? 0 :
                  (corrupt_data !== 1'b0)? {8{1'bx}} :
                  (output_cont == 2) ? int_status_d2 :
                  (output_cont == 1) ? int_status_d1 :
                  next_int_status;

  assign complete = (rst_n == 1'b0 && rst_mode == 0) ? 1'b0:
              (output_cont == 2) ? int_complete_d2:
              (output_cont == 1) ? int_complete_d1:
              int_complete_advanced;

  assign ina_div = (input_mode == 1) ? ina : a;
  assign inb_div = (input_mode == 1) ? inb : b;
  assign rnd_div = (input_mode==1) ? rnd_reg : rnd;

  DW_fp_div #(sig_width, exp_width, ieee_compliance) U1 (
                      .a(ina_div),
                      .b(inb_div),
                      .rnd(rnd_div),
                      .z(temp_z),
                      .status(temp_status)
  );

  generate
  if (rst_mode == 0) begin : GEN_RM_EQ_0_CORRUPT_DATA
  always @(posedge clk or negedge rst_n) begin : a1000_PROC
    if (rst_n == 1'b0) begin
      new_input_reg_d1 <= 1'b0;
      new_input_reg_d2 <=1'b0;
    end else begin
      new_input_reg_d1 <= new_input_pre;
      new_input_reg_d2 <= new_input_reg_d1;
    end
  end
  end else begin : GEN_RM_NEQ_0_CORRUPT_DATA
  always @(posedge clk) begin : a1001_PROC
    if (rst_n == 1'b0) begin
      new_input_reg_d1 <= 1'b0;
      new_input_reg_d2 <=1'b0;
    end else begin
      new_input_reg_d1 <= new_input_pre;
      new_input_reg_d2 <= new_input_reg_d1;
    end
  end 
  end
  endgenerate

  always @(ina_div or inb_div) begin : a1002_PROC
    new_input_pre = (start_in == 1'b0) & (input_mode == 0) & (reset_st == 1'b0);
  end

  generate 
  if (rst_mode == 0) begin : GEN_DATA_DETCT_RM0
  always @(posedge clk or negedge rst_n) begin: DATA_CHANGE_DETECTION_PROC
    if (rst_n == 1'b0) begin
      new_input_pre <= 1'b0;
    end else begin
      if (input_mode == 0 && reset_st == 1'b0 && start_in == 1'b0 && (a_reg != a || b_reg != b)) begin
        new_input_pre <= 1'b1;
      end else begin
        if (start_in == 1'b1) begin
          new_input_pre <= 1'b0;
        end 
      end
    end
  end
  end
  else begin : GEN_DATA_DETCT_RM1
  always @(posedge clk) begin: DATA_CHANGE_DETECTION_PROC
    if (rst_n == 1'b0) begin
      new_input_pre <= 1'b0;
    end else begin
      if (input_mode == 0 && reset_st == 1'b0 && start_in == 1'b0 && (a_reg != a || b_reg != b)) begin
        new_input_pre <= 1'b1;
      end else begin
        if (start_in == 1'b1) begin
          new_input_pre <= 1'b0;
        end 
      end
    end
  end
  end
  endgenerate

  assign start_in = (input_mode & ~early_start) ? start_clk : start;

  always @(start or a or b or ina or inb or count_reseted or next_count) begin : next_comb_PROC
    if (start===1'b1) begin
      next_ina           = a;
      next_inb           = b;
    end
    else if (start===1'b0) begin
      if (next_count >= CYC_CONT) begin
        next_ina           = ina;
        next_inb           = inb;
      end else if (next_count === -1) begin
        next_ina           = {TOTAL_WIDTH{1'bX}};
        next_inb           = {TOTAL_WIDTH{1'bX}};
      end else begin
        next_ina           = ina;
        next_inb           = inb;
      end 
    end
  end

  always @(rst_n or start_in or a or b or ina or inb or count_reseted or next_count or
           temp_z or temp_status or output_cont or count or reset_st) begin : next_state_comb_PROC
    if (start_in===1'b1) begin
      next_count_reseted = 1'b1;
      next_complete      = 1'b0;
      next_int_complete  = 1'b0;
      next_int_z         = {TOTAL_WIDTH{1'bx}};
      next_int_status    = {8{1'bx}};
    end
    else if (start_in===1'b0) begin
      next_count_reseted = 1'b0;
      if (count >= CYC_CONT) begin
        next_int_z         = temp_z & {((exp_width + sig_width) + 1){~(start_in | reset_st)}};
        next_int_status    = temp_status & {8{~(start_in | reset_st)}};
      end
      if (next_count >= CYC_CONT) begin
        next_int_complete  = rst_n;
        next_complete      = 1'b1;
      end else if (next_count === -1) begin
        next_int_complete  = 1'bX;
        next_int_z         = {TOTAL_WIDTH{1'bX}};
        next_int_status    = {8{1'bX}};
        next_complete      = 1'bX;
      end else begin
        next_int_complete  = 0;
        next_int_z         = {TOTAL_WIDTH{1'bX}};
        next_int_status    = {8{1'bX}};
      end 
    end

  end

  always @(start_in or count_reseted or count) begin : a1003_PROC
    if (start_in===1'b1)
      next_count = 0;
    else if(start_in===1'b0) begin
      if (count >= CYC_CONT)
        next_count = count;
      else if (count === -1)
        next_count = -1;
      else
        next_count = count + 1;
    end
  end
 
  assign int_complete_advanced = (internal_reg == 1 || input_mode == 1 || output_mode == 1)?int_complete & (~start_in):int_complete;

  generate
  if (rst_mode == 0) begin : GEN_RM_EQ_0_D
    always @ (posedge clk or negedge rst_n) begin: register_PROC
      if (rst_n === 1'b0) begin
        int_z           <= 0;
        int_status      <= 0;
        int_complete    <= 0;
        count_reseted   <= 0;
        count           <= 0;
        ina             <= 0;
        inb             <= 0;
        int_z_d1        <= 0;
        int_z_d2        <= 0;
        int_status_d1   <= 0;
        int_status_d2   <= 0;
        int_complete_d1 <= 0;
        int_complete_d2 <= 0;
        start_clk       <= 0;
        a_reg           <= 0;
        b_reg           <= 0;
        rnd_reg         <= 3'b000;
      end else if (rst_n === 1'b1) begin
        int_z           <= next_int_z;
        int_status      <= next_int_status;
        int_complete    <= next_int_complete;
        count_reseted   <= next_count_reseted;
        count           <= next_count;
        ina             <= next_ina;
        inb             <= next_inb;
        int_z_d1        <= next_int_z;
        int_z_d2        <= int_z_d1;
        int_status_d1   <= next_int_status;
        int_status_d2   <= int_status_d1;
        int_complete_d1 <= int_complete_advanced;
        int_complete_d2 <= int_complete_d1;
        start_clk       <= start;
        a_reg           <= a;
        b_reg           <= b;
        rnd_reg         <= (start == 1'b1)?rnd:rnd_reg;
      end else begin
        int_z           <= {(exp_width + sig_width){1'bx}};
        int_status      <= {7{1'bx}};
        int_complete    <= 1'bx;
        count_reseted   <= 1'bx;
        count           <= -1;
        ina             <= {TOTAL_WIDTH{1'bx}};
        inb             <= {TOTAL_WIDTH{1'bx}};
        int_z_d1        <= {(exp_width + sig_width){1'bx}};
        int_z_d2        <= {(exp_width + sig_width){1'bx}};
        int_status_d1   <= {8{1'bx}};
        int_status_d2   <= {8{1'bx}};
        int_complete_d1 <= 1'bx;
        int_complete_d2 <= 1'bx;
        start_clk       <= 1'bx;
        a_reg           <= {TOTAL_WIDTH{1'bx}};
        b_reg           <= {TOTAL_WIDTH{1'bx}};
        rnd_reg         <= 3'bxxx;
      end
    end
    always @(posedge clk or negedge rst_n) begin: RST_FSM_PROC
      if (rst_n == 1'b0) begin
        reset_st <= 1'b1;
      end else begin
        if (start == 1'b1) reset_st <= 1'b0;
      end 
    end
  end
  else begin : GEN_RM_NE_0_D
    always @ ( posedge clk) begin: register_PROC
      if (rst_n === 1'b0) begin
        int_z           <= 0;
        int_status      <= 0;
        int_complete    <= 0;
        count_reseted   <= 0;
        count           <= 0;
        ina             <= 0;
        inb             <= 0;
        int_z_d1        <= 0;
        int_z_d2        <= 0;
        int_status_d1   <= 0;
        int_status_d2   <= 0;
        int_complete_d1 <= 0;
        int_complete_d2 <= 0;
        start_clk       <= 0;
        a_reg           <= 0;
        b_reg           <= 0;
        rnd_reg         <= 3'b000;
      end else if (rst_n === 1'b1) begin
        int_z           <= next_int_z;
        int_status      <= next_int_status;
        int_complete    <= next_int_complete;
        count_reseted   <= next_count_reseted;
        count           <= next_count;
        ina             <= next_ina;
        inb             <= next_inb;
        int_z_d1        <= next_int_z;
        int_z_d2        <= int_z_d1;
        int_status_d1   <= next_int_status;
        int_status_d2   <= int_status_d1;
        int_complete_d1 <= int_complete_advanced;
        int_complete_d2 <= int_complete_d1;
        start_clk       <= start;
        a_reg           <= a;
        b_reg           <= b;
        rnd_reg         <= (start==1'b1)?rnd:rnd_reg;
      end else begin
        int_z           <= {(exp_width + sig_width){1'bx}};
        int_status      <= {8{1'bx}};
        int_complete    <= 1'bx;
        count_reseted   <= 1'bx;
        count           <= -1;
        ina             <= {TOTAL_WIDTH{1'bx}};
        inb             <= {TOTAL_WIDTH{1'bx}};
        int_z_d1        <= {(exp_width + sig_width){1'bx}};
        int_z_d2        <= {(exp_width + sig_width){1'bx}};
        int_status_d1   <= {8{1'bx}};
        int_status_d2   <= {8{1'bx}};
        int_complete_d1 <= 1'bx;
        int_complete_d2 <= 1'bx;
        start_clk       <= 1'bx;
        a_reg           <= {TOTAL_WIDTH{1'bx}};
        b_reg           <= {TOTAL_WIDTH{1'bx}};
        rnd_reg         <= 3'bxxx;
      end
    end
    always @(posedge clk) begin: RST_FSM_PROC
      if (rst_n == 1'b0) begin
        reset_st <= 1'b1;
      end else begin
        if (start == 1'b1) reset_st <= 1'b0;
      end 
    end
  end
  endgenerate

  
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
