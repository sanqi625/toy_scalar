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
// AUTHOR:    Aamir Farooqui                February 12, 2002
//
// VERSION:   Verilog Simulation Model for DW_sqrt_seq
//
// DesignWare_version: 6993deb4
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////

//------------------------------------------------------------------------------
//
//ABSTRACT:  Sequential Square Root 
// Uses modeling functions from DW_Foundation.
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
//             during the first cycle of calculation (related to STAR 9000506330)
// 1/5/12 RJK Change behavior when input changes during calculation with
//          input_mode = 0 to corrupt output (STAR 9000506330)
//
//------------------------------------------------------------------------------

module DW_sqrt_seq ( clk, rst_n, hold, start, a, complete, root);


// parameters 

  parameter  integer width       = 6; 
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
  input [width-1:0] a;

  output complete;
  output [(width+1)/2-1:0] root;

//-----------------------------------------------------------------------------
// synopsys translate_off

//------------------------------------------------------------------------------
localparam signed [31:0] CYC_CONT = (input_mode==1 & output_mode==1 & early_start==0)? 3 :
                                    (input_mode==early_start & output_mode==0)? 1 : 2;

//------------------------------------------------------------------------------
  // include modeling functions
`include "DW_sqrt_function.inc"
 
//-------------------Integers-----------------------
  integer count;
  integer next_count;
 

//-----------------------------------------------------------------------------
// wire and registers 

  wire clk, rst_n;
  wire hold, start;
  wire [width-1:0] a;
  wire complete;
  wire [(width+1)/2-1:0] root;

  wire [(width+1)/2-1:0] temp_root;
  reg [(width+1)/2-1:0] ext_root;
  reg [(width+1)/2-1:0] next_root;
 
  reg [width-1:0]   in1;
  reg [width-1:0]   next_in1;

  wire start_n;
  wire hold_n;
  reg ext_complete;
  reg next_complete;
 


//-----------------------------------------------------------------------------
  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
    
    if (width < 6) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter width (lower bound: 6)",
	width );
    end
    
    if ( (num_cyc < 3) || (num_cyc > (width+1)/2) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter num_cyc (legal range: 3 to (width+1)/2)",
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
  assign complete     = ext_complete & start_n;
  assign temp_root    = (tc_mode)? DWF_sqrt_tc (in1): DWF_sqrt_uns (in1); 

// Begin combinational next state assignments
  always @ (start or hold or a or count or in1 or temp_root or ext_root or ext_complete) begin : a1000_PROC
    if (start === 1'b1) begin                   // Start operation
      next_in1      = a;
      next_count    = 0;
      next_complete = 1'b0;
      next_root     = {(width+1)/2{1'bX}};
    end else if (start === 1'b0) begin          // Normal operation
      if (hold===1'b0) begin
        if (count >= (num_cyc+CYC_CONT-4)) begin
          next_in1      = in1;
          next_count    = count; 
          next_complete = 1'b1;
          next_root     = temp_root;
        end else if (count === -1) begin
          next_in1      = {width{1'bX}};
          next_count    = -1; 
          next_complete = 1'bX;
          next_root     = {(width+1)/2{1'bX}};
        end else begin
          next_in1      = in1;
          next_count    = count+1; 
          next_complete = 1'b0;
          next_root     = {(width+1)/2{1'bX}} ;
        end
      end else if (hold === 1'b1) begin         // Hold operation
        next_in1      = in1;
        next_count    = count; 
        next_complete = ext_complete;
        next_root     = ext_root;
      end else begin                            // hold == X
        next_in1      = {width{1'bX}};
        next_count    = -1;
        next_complete = 1'bX;
        next_root     = {(width+1)/2{1'bX}};
      end
    end else begin                              // start == X
      next_in1      = {width{1'bX}};
      next_count    = -1;
      next_complete = 1'bX;
      next_root     = {(width+1)/2{1'bX}};
    end
  end
// end combinational next state assignments

generate
  if (rst_mode == 0) begin : GEN_RM_EQ_0

  // Begin sequential assignments   
    always @ ( posedge clk or negedge rst_n ) begin: ar_register_PROC
      if (rst_n === 1'b0) begin                 // initialize everything asyn reset
        count        <= 0;
        in1          <= 0;
        ext_root     <= 0;
        ext_complete <= 0;
      end else if (rst_n === 1'b1) begin        // rst_n == 1
        count        <= next_count;
        in1          <= next_in1;
        ext_root     <= next_root;
        ext_complete <= next_complete & start_n;
      end else begin                            // rst_n == X
        count        <= -1;
        in1          <= {width{1'bX}};
        ext_root     <= {(width+1)/2{1'bX}};
        ext_complete <= 1'bX;
      end 
   end // ar_register_PROC

  end else begin : GEN_RM_NE_0

  // Begin sequential assignments   
    always @ ( posedge clk ) begin: sr_register_PROC 
      if (rst_n === 1'b0) begin                 // initialize everything syn reset
        count        <= 0;
        in1          <= 0;
        ext_root     <= 0;
        ext_complete <= 0;
      end else if (rst_n === 1'b1) begin        // rst_n == 1
        count        <= next_count;
        in1          <= next_in1;
        ext_root     <= next_root;
        ext_complete <= next_complete & start_n;
      end else begin                            // rst_n == X
        count        <= -1;
        in1          <= {width{1'bX}};
        ext_root     <= {(width+1)/2{1'bX}};
        ext_complete <= 1'bX;
      end 
    end // sr_register_PROC

  end
endgenerate

  wire corrupt_data;

generate
  if (input_mode == 0) begin : GEN_IM_EQ_0

    localparam [0:0] NO_OUT_REG = (output_mode == 0)? 1'b1 : 1'b0;
    reg [width-1:0] ina_hist;
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
	    change_count    <= 0;

	  init_complete   <= 1'b0;
	  corrupt_data_int <= 1'b0;
	end else begin
	  if ( rst_n === 1'b1) begin
	    if ((hold != 1'b1) || (start == 1'b1)) begin
	      ina_hist        <= a;
	      change_count    <= (start == 1'b1)? 0 :
	                         (next_alert1 == 1'b1)? change_count + 1 : change_count;
	    end

	    init_complete   <= init_complete | start;
	    corrupt_data_int<= next_corrupt_data | (corrupt_data_int & ~start);
	  end else begin
	    ina_hist        <= {width{1'bx}};
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
	    change_count    <= 0;
	  init_complete   <= 1'b0;
	  corrupt_data_int <= 1'b0;
	end else begin
	  if ( rst_n === 1'b1) begin
	    if ((hold != 1'b1) || (start == 1'b1)) begin
	      ina_hist        <= a;
	      change_count    <= (start == 1'b1)? 0 :
	                         (next_alert1 == 1'b1)? change_count + 1 : change_count;
	    end

	    init_complete   <= init_complete | start;
	    corrupt_data_int<= next_corrupt_data | (corrupt_data_int & ~start);
	  end else begin
	    ina_hist        <= {width{1'bx}};
	    init_complete    <= 1'bx;
	    corrupt_data_int <= 1'bX;
	    change_count     <= -1;
	  end
	end
      end
    end // GEN_A_RM_NE_0

    assign data_input_activity =  ((a !== ina_hist)?1'b1:1'b0) & rst_n;

    assign next_corrupt_data = (NO_OUT_REG | ~complete) &
                              (data_input_activity & ~start &
					~hold & init_complete);

`ifdef UPF_POWER_AWARE
  `protected
EOPK/9^Eg6+XRDVC93b:fOI#3.@LT/@Za7,&I,_;GE[HfMLGAUGG-)OI&>YBCP?b
DEGNDD,8f?99U_eUIF;+>#QbeMZOS;SE/PaS_-GNf#HN(FAFV3<J34+>5SV:E4=W
D)cW69(VB)2f8Z>dROP+0MaZN-K>1UUVIKL5/PIT\\Z_336bDZA1MYAL]1^D9;;)
]X596_8&JOa3V]9@?@910AAN:MF;aMT5O2>T^^RPePMR&c)9T[BgLZ[)5UZ&BC>V
gcW;UU7QcD,U/7ZPF1g&C07K_@;#70(SbGP,bR>/<@4[CfNN)E4>57bV^3b>]L.C
:-8HNeE291B,(ZGGGFW74)M/.)&-c@T2Q.[6F4WI=GKWGHIA)Wg6&Z7b]VG#/_FH
0fZJg8+>HAJ:b<_.04[PL^cgB7SMe.(Ua,DSC&9,N#4#T=6:61\=Nb208Maa=egV
,A8]IH+E?F\7SO+W+98QV+PU((Q;0G8,33)+g\=d;QfU@>&M#9[=[HU6?RH\W0;=
VB0=5gDJIHIM.>ZFPQS(<XH)5^I^+?e-8W<M9+^ZQVNC-.-EE2J\gFR#4X&,)Y7/
V<c[&Ff?6+Y#^?I#^4M-?#)NMcSNQeMY26dWL#Q#)\GcH)9RU3:L\J<4=NR:HX]9
>ZcQ6F(_4,5V6.?.0=_Dg:Cf[KR^.g?,-W,,S:>,[H0eXYU+[V6R.B.,[/-)/2DT
G)V6R-+#f:]WZgA9NbcT;X68,D5.<b5C:e/,9WG^URDEH3>,Td@S#36H+?+)eDVN
;J7U6-O[OALF;e]RN^IeHB?\4g^W\g2S\/57=+6dS>,BU_8d^P/4&PbL(85K3E6S
4<,,7?YAFNM=gBD^8LYZ?+1<;5f:-FQ5+gZRV7>JX9>g2Pb,H(^3c5ZL,>)NB\V1
T/;D7Q=[EN^e=M<N3ANG.(>A&H;O2Z&d@15eX=-5RA#_9FK,a_3DPR1IIBgMfIbc
0EMA5,SSR4G2#7ZQS4]^Q>JM1IB&WA8^XdU+O4JFLM,6XN8V\@4UcGJ(8_7^XVc@
^SQb;A.?+eOgH33_702E3;Z#+^b_A=7SYX5M(Z_X;?84eeL5.dd24?DJ\)2LIRIG
&V\Q7BK[M\?.(OZ)bA)RbSBSCg;?gIRVO-0C+EHeU:@\V1-WZ]McbTG4KOBF[NCK
.c)&?YA)Cd4F+f;_1HP)AbVcD06K;;;P@L:P7^=K15?bOJL241<\bQ4\5(J17J(c
8EU^E.fC8O;N?&dP2[af-Xa_+HDEEOFL90W2OL9QQG?A1MXe6_=5#KDdJ<F)K_:F
GMT]d[d,KF8;[W9dfG:9DRd3C-@H81WcaID(0YecYTVO)=O,EN.<:/,?5d.G+Z+A
Q0d4(V0P/8X;8)/Ya;=FVXS5EfK6Ad-NK,6@=IeS2TT\Yf2^=YJ72O;Kf\fD@UE&
0[BbHMXW38@_dQO]I,:&PUB>NXNH@g]+KC4N3[1Z-f7cDPJW^=(\KZH;H]N#RYHF
,XS_];JN#9d3[C/@+<Cd-(<6c?.FRJ5&RBWSfcGP#^J7RC=47JPDFTVK&-2Y(J2e
LW4RgL0.@eAXT3C,GUZ^>&0/L4;OT\F7)dRf,FaQM>c;N(IaO4Za9=Y5@+Oe)a_4
G01)_KSEPMF(P@2^ZZTdO()ecgbII]YfeVSC.<=f221[>Z1.8I_S:-U.6PcZFUOF
>gfa(9TTSAO<OC_aZ>WI3NJEQ0178</81NfF_O@2T_VX+<,JNE/7Cf#NNXD2)TR\
7O5;/9e4V&c2SWXD<;@M_fGTG9I[M8BTYOA^9-;0.Wg4YQ(2)JYD0P=5UN=OIAM\
?R+G1@\?]Ed>#dCgg2gBcP_,FWE\GGOQ#B6]BR:g2GFf-FD&?&bTUbJPE]Y=](GQ
@VR:\ON-JV0H?7Z.eZW<=:7K#.U>8=<Sa6PT25fFX\J_f>3g<=)YKW.V</RJa=PS
M3>_&eDeUcZ[BOGR16fa/&SGJ?dFPPg0G?0#83OL_#_\a>EQ<8J7<]#ee5Egg8_0
4,bG\I-4+B.6ON?NV?K\?XA;]Be@65;98TaGE1d(Nd(>+6K-_4(HKPLXcUggGZ4C
IHP:ZB.2#dQYCNg0bERPWa\UIf=R2S@DH@?#,.+#N<>P_7U)/]F?OHKI_1S?YHJV
abSYN;HMg-APK[\?@2\^0e4UZD]M&/9Y^D+RTgJENG68?\[(:D/MYJC_\(VOKP.4
H1g5YOXB3O?UI4R8dZVGe0R&gG)/QL>9]Z>YJ6W&YS^1N&V6MaeMMF[-:PK<PF<B
S0.74\;T>-0DO\gR]GLb#E_LOZ<FUCQRQ2NRY)(9P_V62Qad3e=C=].8T^Z;9[IS
[9U\4^cSDH1d,d_RR^M=ZACf2@Ed;:N@7XaD4fb2V)9AaaG4SZA4,59f?=J44@PG
VNW8=3QFY<A-?GK\R;OUEA8E,NW^XH,_;.801XY&MU_9?+N7LD4cS0U7eN6S:]e(
F3I5BSJ4L59Q1(fZN^NR7L7C#Rd)91c,,A5Of,gCOKJ0-#RdE8a:R&6fa#,1T23U
.XR+-BfEK?[c-/]ZJB\_KdAJ8:gJZVCJ/L@d8RS,U)FS+1);OE80bc39P?74JZW\
UE-?QIa]K(g^7UNA,)A4MDMGRQ[<YIDIUN?7QVKG@dL6_TA7@\13_;E1:RIUK[bZ
ce9XDB8:+8U^0$
`endprotected

`else
    always @ (posedge clk) begin : corrupt_alert_PROC
      integer updated_count;

      updated_count = change_count;

      if (next_alert1 == 1'b1) begin
`ifndef DW_SUPPRESS_WARN
          $display ("WARNING: %m:\n at time = %0t: Operand input change on DW_sqrt_seq during calculation (configured without an input register) will cause corrupted results if operation is allowed to complete.", $time);
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
	$display("##    This instance of DW_sqrt_seq has encountered %0d change(s)", updated_count);
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
<L9d&A)dUgU,2E\IIBIEI4;UbCJ(_YC9@Z012Ec.S1U/>PHBX1&cI1BZ2TL0cB2e
I;AIAK\]?X;/YZfGZ[F[2B]PXOVT@:15_)9Jb?dH>0N)ab0A)IHRS/A8G6d6A5\R
F:SKK018E1KMT]_2\BbS;>L&LT,U=D\Q]N:2D@JLRc9XS[7daMc6ab/K0FW^_1XH
FHGVOc0RE-.7OQR15^YNHWaWJJ9H;(/TW]a,T&BX76]e,L=gASd&^eLH#H1d-;0g
-/W=cCd5WgV#M4YM#NQ>,P37JIB<]e=FC/8B\3_&c6M/I(_+@20:\LM6L84C&e)X
4A#MDSC7-?)Zc)F9B4^^)\Z,VF>0B/;f@_6TaLE?8@)c8->gaT8Be009.FWV1JA:
ZMeL+J98[M)A&-]@2LZD8^/;:0OI>6Q3@-(,>H+8UZY?789<=MBd5YD30N99_+ba
C2.@LK:cQ?O;+bEBF<GbaIZXg-:,2W[H&Y]YJOGc[9]PIFZRX+cUN:a9VIaHBPFO
AeW99bH8gEf;c/RPS1\-)]5FPE>?FUKVbc?4W<gcc+D84/I#e#GdJg0DJ@#gCZM6
M5^7;B[HU,>E7ddA2>Xc5-&.LA.g^E_O>$
`endprotected

`else
  `ifndef DW_SUPPRESS_WARN
    always @ (posedge clk) begin : corrupt_alert2_PROC
      if (next_alert2 == 1'b1) begin
        $display( "## Warning from %m: DW_sqrt_seq operand input change near %0d causes output to no longer retain result of previous operation.", $time);
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

  assign root         = ((((input_mode==0)&&(output_mode==0))||(early_start==1)) & start == 1'b1) ?
			     {(width+1)/2{1'bX}} :
                             (corrupt_data === 1'b0)? ext_root : {(width+1)/2{1'bX}} ;

 
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




