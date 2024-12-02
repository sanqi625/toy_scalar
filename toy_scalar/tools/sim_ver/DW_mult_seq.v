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
// VERSION:   Verilog Simulation Model for DW_mult_seq
//
// DesignWare_version: e7c3a965
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////

//------------------------------------------------------------------------------
//
//ABSTRACT:  Sequential Multiplier 
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
//             during the first cycle of calculation (related to STAR 9000505348)
// 1/5/12 RJK Change behavior when inputs change during calculation with
//          input_mode = 0 to corrupt output (STAR 9000505348)
//
//------------------------------------------------------------------------------

module DW_mult_seq ( clk, rst_n, hold, start, a,  b, complete, product);


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
  output [a_width+b_width-1:0] product;

//-----------------------------------------------------------------------------
// synopsys translate_off

localparam signed [31:0] CYC_CONT = (input_mode==1 & output_mode==1 & early_start==0)? 3 :
                                    (input_mode==early_start & output_mode==0)? 1 : 2;

//-------------------Integers-----------------------
  integer count;
  integer next_count;
 

//-----------------------------------------------------------------------------
// wire and registers 

  wire clk, rst_n;
  wire hold, start;
  wire [a_width-1:0] a;
  wire [b_width-1:0] b;
  wire complete;
  wire [a_width+b_width-1:0] product;

  wire [a_width+b_width-1:0] temp_product;
  reg [a_width+b_width-1:0] ext_product;
  reg [a_width+b_width-1:0] next_product;
  wire [a_width+b_width-2:0] long_temp1,long_temp2;
  reg [a_width-1:0]   in1;
  reg [b_width-1:0]   in2;
  reg [a_width-1:0]   next_in1;
  reg [b_width-1:0]   next_in2;
 
  wire [a_width-1:0]   temp_a;
  wire [b_width-1:0]   temp_b;

  wire start_n;
  wire hold_n;
  reg ext_complete;
  reg next_complete;
 


//-----------------------------------------------------------------------------
  
  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
    
    if (b_width < 3) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter b_width (lower bound: 3)",
	b_width );
    end
    
    if ( (a_width < 3) || (a_width > b_width) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter a_width (legal range: 3 to b_width)",
	a_width );
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
  assign complete     = ext_complete & start_n;

  assign temp_a       = (in1[a_width-1])? (~in1 + 1'b1) : in1;
  assign temp_b       = (in2[b_width-1])? (~in2 + 1'b1) : in2;
  assign long_temp1   = temp_a*temp_b;
  assign long_temp2   = ~(long_temp1 - 1'b1);
  assign temp_product = (tc_mode)? (((in1[a_width-1] ^ in2[b_width-1]) && (|long_temp1))?
                                {1'b1,long_temp2} : {1'b0,long_temp1}) : in1*in2;

// Begin combinational next state assignments
  always @ (start or hold or a or b or count or in1 or in2 or
            temp_product or ext_product or ext_complete) begin
    if (start === 1'b1) begin                     // Start operation
      next_in1      = a;
      next_in2      = b;
      next_count    = 0;
      next_complete = 1'b0;
      next_product  = {a_width+b_width{1'bX}};
    end else if (start === 1'b0) begin            // Normal operation
      if (hold === 1'b0) begin
        if (count >= (num_cyc+CYC_CONT-4)) begin
          next_in1      = in1;
          next_in2      = in2;
          next_count    = count; 
          next_complete = 1'b1;
          next_product  = temp_product;
        end else if (count === -1) begin
          next_in1      = {a_width{1'bX}};
          next_in2      = {b_width{1'bX}};
          next_count    = -1; 
          next_complete = 1'bX;
          next_product  = {a_width+b_width{1'bX}};
        end else begin
          next_in1      = in1;
          next_in2      = in2;
          next_count    = count+1; 
          next_complete = 1'b0;
          next_product  = {a_width+b_width{1'bX}};
        end
      end else if (hold === 1'b1) begin           // Hold operation
        next_in1      = in1;
        next_in2      = in2;
        next_count    = count; 
        next_complete = ext_complete;
        next_product  = ext_product;
      end else begin                              // hold == x
        next_in1      = {a_width{1'bX}};
        next_in2      = {b_width{1'bX}};
        next_count    = -1;
        next_complete = 1'bX;
        next_product  = {a_width+b_width{1'bX}};
      end
    end else begin                                // start == x
      next_in1      = {a_width{1'bX}};
      next_in2      = {b_width{1'bX}};
      next_count    = -1;
      next_complete = 1'bX;
      next_product  = {a_width+b_width{1'bX}};
    end
  end
// end combinational next state assignments

generate
  if (rst_mode == 0) begin : GEN_RM_EQ_0

  // Begin sequential assignments
    always @ ( posedge clk or negedge rst_n ) begin: ar_register_PROC
      if (rst_n === 1'b0) begin                   // initialize everything asyn reset
        count        <= 0;
        in1          <= 0;
        in2          <= 0;
        ext_product  <= 0;
        ext_complete <= 0;
      end else if (rst_n === 1'b1) begin          // rst_n == 1
        count        <= next_count;
        in1          <= next_in1;
        in2          <= next_in2;
        ext_product  <= next_product;
        ext_complete <= next_complete & start_n;
      end else begin                              // rst_n == X
        in1          <= {a_width{1'bX}};
        in2          <= {b_width{1'bX}};
        count        <= -1;
        ext_product  <= {a_width+b_width{1'bX}};
        ext_complete <= 1'bX;
      end 
   end // ar_register_PROC

  end else  begin : GEN_RM_NE_0

  // Begin sequential assignments
    always @ ( posedge clk ) begin: sr_register_PROC 
      if (rst_n === 1'b0) begin                   // initialize everything asyn reset
        count        <= 0;
        in1          <= 0;
        in2          <= 0;
        ext_product  <= 0;
        ext_complete <= 0;
      end else if (rst_n === 1'b1) begin          // rst_n == 1
        count        <= next_count;
        in1          <= next_in1;
        in2          <= next_in2;
        ext_product  <= next_product;
        ext_complete <= next_complete & start_n;
      end else begin                              // rst_n == X
        in1          <= {a_width{1'bX}};
        in2          <= {b_width{1'bX}};
        count        <= -1;
        ext_product  <= {a_width+b_width{1'bX}};
        ext_complete <= 1'bX;
      end 
   end // ar_register_PROC

  end
endgenerate

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
632,gP3CUK;(1FCe+JIRJ6IM1>-<&(MW>/SM,8/#:M7,/YEBEeNXZFDZW0PR>\>S
#J4g-#-#E)^Y0;Oc4HOL?O<_)#Pg[bX<f-96aEI/YL0:>ASYe(K8.b4Mb,T3XZLT
Z?B[NF:XUe1J6EEPYef>Q:?F<ODZ2]e0NWH&T8N9=74M;ZCY45+7NUKRICR1ab1P
AYCdOHAff5]F67-:ZR#[9FTNTg;)gOAg=@T74S)&000G-/c#@&G,>MHe83+g;>#=
&a1,:^]&CL#[MJM]T72DZcH]C71+]Wg2@LRJ=\aI\UIAf1dO&AG.AKGdgBeZ_H@X
aF,>ZYH8SKD7O6[K9X/c&\&2?,RQYD[OHG+g-6]BT?9TNA:XXA(Of3aKU2S@dG5H
\D:a_40JWgY17L&H@W6;>3_7;^5[9XKP_-VPXP(g=c^P+f(bK=>=0-,/4QQ5)XR^
RB+N-10UPeR>2@BA\cB/dc)9.&/>XN>:ZAYD^8\TQ^b3GLN55#RS,W&^geP6LYXP
gW_9Ub/,>-Rdd#B:C;H0</\<6+,BA&c=FK)+3A(c(^UD(AZUa#:H<7U,C)aU+C.(
ILR#?gV0JKYSK_9F/gLFBKa8T4Y]?(AD]OIIZ:C@+3RZT9[.e^G9\)KQ<B0a_H/+
ZD_(&/b_2_;717[^SJDHGCDCF3bN@FE=BQ@B0e//>_1e2FYa6(X]/GX8[8W7[4/H
H#&OV]EH/#,Y4CF/5S9Fg5\UcJ@R5&>Z7Y\7#3\#\5RNMX&[91,XEfTUfW@-.\L)
71=6?4O72,+2C\^7,_54d)TaG^Y<\F+fU)[LgE0e.&7MFJ,I..3.66A/4E^\NR1E
G3:T7+38PaPQ[aeF^B=;6GbFW0<<2=&#SZUXRBGUg91YJ@FNa<T>Tg(3N:U.ae/8
C:;\XHI/0GKO22R,Z>Nf_[Ka.U#c1J:\^DK->Pb16WQc\)U4Jb&S:a6Ieb?)=Z09
9-QJ_e_.]X:QO3?cAWDJ2Y+L2^aa5g72(>APcRdd@[agH/9OfR0YOPP&Kc(b[I7B
7AH9Fc_0E_GZNML^8CeDYV=F[Y0#>J9.FL_.+R/0]HI<SG:3<G7dHV7_WA[T.RHd
OSC8C;+,9)9C;7+BbCVH:YTLN]HNFY^K9KH11aW7<\4AZ^]RAB/PG17#/K+E:+G3
&QfM;-OP00ML>:cKCI1A?PA.1d+gV2)M^.I89(WTE=66Kc6bMZZQ4.c8Z._E0EG<
2=3fKXO=5&N]./S561c)W4+TWU;))dg6Z(L0?D,9<L+?:DV,)\YF1YGVB+gCb?.[
A(J[Q#G=1]aC-)d.EP8+b\2<9)7A_]g&T;4gdL(5H7W_26.OA<c,LP;4UZe1);Q5
ZBCe.(0]fEN2]:#??SI^:S\fO\]LZMWEBf<Ce&FNG=9]=^S9&5B7cdF-ZIVKN5?Q
bdMS-<He+3da2e=\fg5CI1^OKU^#gBBBW:0M/4ALK,7+JSfg#JI)SWD)#V:e-RON
AI1C;/[1]>^_FCXXFSFK2G[M;Tbec(5fdKC>Q1&e&+[MJXV&d/:ASd&ObN<HVI[0
(B_ba,9JcLKG0BLJ<M-DRFC?P9c:[4]=AMFgAD<.=5&^4@Ld5T8YcU@O0cBIaa1d
LGYN\[X3ZEef/;0Re,82Y\L294I<,@.1GQI_IM=R<5#<DbM4O-d6V5[#A-NUYSaU
8)4^8b9B]eY):A2(NZET>>3FXCRV-NP<)f_?&34XF4BGC8_@D2OgJZHE-\^?07RO
V\9a1,;B)NV7<I?JIEFR]DVQR3D?=@)RA^KNY=O+TQ)5E]\\\G7cK1@@Y[=MB8CD
MgA[U-I\^UBUbH\?a\U6X1M@2#cd6g-LELZ,@[QBJT[ZVC2?DRb@#GfS^-IR6WE+
?8Z\6QS^6dU_&=7C]]bK@2;c#YW#@A/JI_6((PM_@>TR5eD[NB1K8[IcF3e9TCSI
H@ZAHUQaQ[\WPH))0e3?DK6a4L9CB#,X4VVgD\)<]JJC+KN&;aNdAN87Jde,@.2(
^VbN[R2K+@dI8EB1#C1Oa94J;^.Cc=UX?)I2O=4AaSJMXN[_>CDdKZY:1DV_be.0
T1S;KCQFc4W>:HSR[cG2Z.0S2dH.#Ba8W2E@e3QHS/)eBL76>T&aNN,FHHCR)_KP
YJO<0#NbLV[H1-+1Re6XVTVcEB,&#=J>fMXBd<JIUIfKCBX;2/7Sc]84Xc/Ve.^e
1d)WdadMFQ>?U)@E]G&gA=&edP&5X#UBSBUMCL[I-?Cg#VOdXg,J+d1KJC2MT)(e
Ig#,H&cC7N8=WKP;0c4H=>1/BTKX5eBV+[aN]^48VEMHT/<(>H@DRK;R^AKA&-c;
,2A:8XeA&#RPA:/M1WcBWJKRD.=a+&RNY<KR^K-]&?=3=^/QEW>/?\fW(I5.G-TQ
gVMN?Y2P9Pb5L-[)YG8=/PRBUL1CZO2)]^CRXS<5&EOW=7UYT.(a:b+Q;<X9+(8)
?P1X4T#3C]DWB#HF<Z&3N-2.VPIeW?Bccf+I;/FPNB3,PMVE:Q9,Y.+\#X>LVc7B
]SNaZ[WOW>0,2&WJT::2NW#RL:DW?bS;GXe9:19FRIVWJW3)AQYY,Cb]g/>dMN9K
/f)[U9N4CDI,0$
`endprotected

`else
    always @ (posedge clk) begin : corrupt_alert_PROC
      integer updated_count;

      updated_count = change_count;

      if (next_alert1 == 1'b1) begin
`ifndef DW_SUPPRESS_WARN
          $display ("WARNING: %m:\n at time = %0t: Operand input change on DW_mult_seq during calculation (configured without an input register) will cause corrupted results if operation is allowed to complete.", $time);
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
	$display("##    This instance of DW_mult_seq has encountered %0d change(s)", updated_count);
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
9f/,N9XK6@V5L&eZJ4H6E7JR<#+I?<3UZTHYgPdfF..M@#7Gd^1]5=d(1\PccX(\
7I3Z<20EY#0\+Wc)^2H;f9]FJ\]NYLY<N1ee&7&FKa.8YJHd5\MN#?SP]A-\PQ?G
&T@b/L1+,JQ/R^JY\Bb&Pfbg&BV]a#COQ^,4X<L.fDGYOaK3]>,^OX5V)HM5ZG>,
_A-_fd:MSgM]QBQ=S&4c;[ZW4?aB#81^(OG1bH4If&+ZQK0;CC/2Pc&T[4\f(P-[
ZJL/I-3V2E^H04PJ9eaV^cWEaQ944B+5FJX@LV5-1MJU]_LDDO;OU3DMP)LB2g/g
.QD1+Q7)>FWK:UGQKc6ZDG2H^(af9?a5U(&9UF+ZCY_B)9>OH5WJeUM)E&,AcKCW
:H73bDEV/-Vd&ga=Z,e/HKa#GcTMIWXIDFV0eB:IUV\[:N8S/aAB\B>?^>X75QQ6
KP=PRR(0^^UVBDW0Z]#70_/JL6AeW>fUQR:UVK2KL/9G#-19C5b.c/U8EGTO(dT=
Fb>T:U7QJUd8TRe0=gC@K99]&N\Y(I:PZ.dS/;c/XJ>FP)I[Z^dY<0^LKcW@1J]:
+@/3,3ga1^f1G;76A?WIW,G<O+48V5<S>$
`endprotected

`else
  `ifndef DW_SUPPRESS_WARN
    always @ (posedge clk) begin : corrupt_alert2_PROC
      if (next_alert2 == 1'b1) begin
        $display( "## Warning from %m: DW_mult_seq operand input change near %0d causes output to no longer retain result of previous operation.", $time);
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

  assign product      = ((((input_mode==0)&&(output_mode==0)) || (early_start == 1)) && start == 1'b1) ?
			  {a_width+b_width{1'bX}} :
                          (corrupt_data === 1'b0)? ext_product : {a_width+b_width{1'bX}};


 
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




