////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 2000 - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Jay Zhu, March 25, 2000
//
// VERSION:   Verilog Simulation Model
//
// DesignWare_version: 54da00ec
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------------
//
// ABSTRACT : Generic parallel CRC Generator/Checker 
//
// MODIFIED :
//
//      RJK     09/10/2020      Increased max data_width to 2560 (Enh STAR 3372033)
//                              and adjusted parameter checking for consistency
//
//      LMSU    07/09/2015      Changed for compatibility with VCS Native Low Power
//
//	RJK	04/12/2011 	Recoded parts to clean for lint - STAR 9000444285
//
//-------------------------------------------------------------------------------

module	DW_crc_p(
		data_in,
		crc_in,
		crc_ok,
		crc_out
		);

parameter    integer data_width = 16;
parameter    integer poly_size  = 16;
parameter    integer crc_cfg    = 7;
parameter    integer bit_order  = 3;
parameter    integer poly_coef0 = 4129;
parameter    integer poly_coef1 = 0;
parameter    integer poly_coef2 = 0;
parameter    integer poly_coef3 = 0;

input [data_width-1:0]	data_in;
input [poly_size-1:0]	crc_in;
output			crc_ok;
output [poly_size-1:0]	crc_out;


// synopsys translate_off

`define	DW_max_data_crc_l (data_width>poly_size?data_width:poly_size)


wire [poly_size-1:0]		crc_in_inv;
wire [poly_size-1:0]		crc_reg;
wire [poly_size-1:0]		crc_out_inv;
wire [poly_size-1:0]		crc_chk_crc_in;

`ifdef UPF_POWER_AWARE
  `protected
GM3<FZP0R/NQ5)=?(I5#ZC1(A31fOF0H[:NTgG2,[5IV3<RNO,TC()?SbA^_&9:g
>Q_S?WV?&4@_O@#dEG@cA>;/32C14GZ<gb5F5DBSB5Z1@3T?3QbYSM,KB_76&,>g
RRe5RabXB(g_9O?/UG0HA=J)7IG^K6UBJ;MSc\H@88e:420S0]5>2R078OR_?E^O
]?RGMRN>UP<)+PId2ZWI3<]B-G<MgK0)4\RgOO3QWR<88)J9G]3^WDGN8E4BI@3>
]^]J-+<CN<WX:9g/T=KEPSI7AN\54HD,ZN/5,X:WK0E3?gdILEO_EL9-G^,:R=\,
1a&)DOT)FO6]GAcF9ICI/#abfEGR.[Ad\Hg\+:fJ>YB2YAf]7I(/?\JeFQH&d/NJ
)ZXP4<JDIb_2V2:)G<,,].]EKg=NS6#<>U);:gF^X/aHKF^6N9S#Ud(;V0b[S0cI
#;FJf8D/KQZLPgDKD)H6-LWJMggAG^03b8gba;c1NWL-\B10EEGJ\>D0MVQO@=9J
91bL/@M&H(+KGL:Ta.HebW.QD/\6(LB]G2.P#@g&;(RYEXH36V8JTLe5SKGdbc:B
:W<GODcK>gMaDa2-6CA8K\5XHB?K#8?K3]XEUSL+X(.QJ67Tc-03A8N^b/6.GCF.
W7[JDfWE_EfW+T:<fe(Y7A?N6T&LaVPfJ(CV<KZSHV_LA:)N&_?U\^R\].<:RMbZ
QPK66UY?@:O1cR+dF^P4=c=BNNEE&ecF<.@DZ]1<e_7S@/8F84F+[/MLFWGRRfQ]
N,L>ce)40NQE9111a1W+F.QEe#Ac]<TP7A2IJV8LN<3G(8,D;,W#WY]TUfBKc<G-
WSWC6/?cPY:AMe2FJJTgCXVM:O[gT?9(Zdg;^L#?IBSd6EVZBR+A9<(NJD#O&?Q7
H<0-eP4>-BDaNe^#BKTAUCO^GSL3L/.1P<1X@AB#I?gAXg:-[Y&LMU)7CQ<^SY.9
LQcBe>#e4ZL[gg;3<X11KPH/&f:K3Z<gPc2WBB4;_d3H6EF-6EQfe,T+g_ANW&OX
=d1\g-/:Y&#aJ(DPC2]TR>U+S92I+-Y[O--K<Md[C>;#(\9#J_3)(gIA/AUCIa=A
R)<]6754_U[+5e=<?/9Q9]W#85=d1,+PJF;?W#,S?:,LDLA>_&O[DdW\#ZV[J@3S
LP>3Q3?Q5JKT\^=JgK=CQ6=8QdAX:_/;2HA+A>:@02\6(SLLeAKVO-5CR380e^<J
4+PZ,T@94=>FfdJ?M92Gb-5_+7M]:PPQ0KeEM<cU7KeaaI9T]c;e0IJKJVNd^IQ/
0H+LC0I]7B6\P)_<_6fE/45S0Y5bY\BDfE+W\DXV__]=J5Z:d-3f)^>3#Qb>][RN
dE.?40UPN8aS2((D2\OdO.eW;CUP[)8DI6dP?86?_OHaVNB,S_KeA.G?fXRWaC_K
OO;58:3W-cZP#LZA.RRD;DP:bf^,293gLHGA+;=:4RVa<H73(5:YNRW3d0T>B=GR
HP]0C&ga@/fZR#UfQFA4<3D+@CWgOQ8Y[2Rbdd0<3g@BHXg:-M3FAfMd9ZC>UG3Q
7#OU3T_/f/13H]E;]L5cWMG;EYAQ53N0Ff4/\JXLS[X_>K\Z<H((3g9d_N5ggK^B
N@..^5[5.UZC/e)3SM3c6MN-8cY,:FW96,608M^7TO#M&c(,;9McS(9dO$
`endprotected

`else
reg [poly_size-1:0]             crc_inv_alt;
reg [poly_size-1:0]             crc_polynomial;
`endif

function [`DW_max_data_crc_l-1:0]	bit_ordering;
    input [`DW_max_data_crc_l-1:0]	input_data;
    input [31:0]		v_width;

    begin : function_bit_ordering

	integer			width;
	integer			byte_idx;
	integer			bit_idx;

	width = v_width;

	case (bit_order) 
	    0 :
	  	bit_ordering = input_data;
	    1 :
		for(bit_idx=0; bit_idx<width; bit_idx=bit_idx+1)
		  bit_ordering[bit_idx] = input_data[width-bit_idx-1];
	    2 :
	  	for(byte_idx=0; byte_idx<width/8; byte_idx=byte_idx+1)
		  for(bit_idx=0;
		      bit_idx<8;
		      bit_idx=bit_idx+1)
	            bit_ordering[bit_idx+byte_idx*8]
		      = input_data[bit_idx+(width/8-byte_idx-1)*8];
	    3 :
		for(byte_idx=0; byte_idx<width/8; byte_idx=byte_idx+1)
		  for(bit_idx=0; bit_idx<8; bit_idx=bit_idx+1)
		    bit_ordering[byte_idx*8+bit_idx]
		          = input_data[(byte_idx+1)*8-1-bit_idx];
	    default : 
		begin 
		    $display("ERROR: %m : Internal Error.  Please report to Synopsys representative."); 
		    $finish; 
		end
	endcase

    end
endfunction // bit_ordering

function [poly_size-1 : 0] bit_order_crc;

    input [poly_size-1 : 0] crc_in;

    begin : function_bit_order_crc

        reg [`DW_max_data_crc_l-1 : 0] input_value;
        reg [`DW_max_data_crc_l-1 : 0] return_value;
	integer i;

	input_value = {`DW_max_data_crc_l{1'b0}};

	for (i=0 ; i < poly_size ; i=i+1)
	  input_value[i] = crc_in[i];

	return_value = bit_ordering(input_value,poly_size);

	bit_order_crc = return_value[poly_size-1 : 0];
    end
endfunction // bit_order_crc


function [data_width-1 : 0] bit_order_data;

    input [data_width-1 : 0] data_in;

    begin : function_bit_order_data

        reg [`DW_max_data_crc_l-1 : 0] input_value;
        reg [`DW_max_data_crc_l-1 : 0] return_value;
	integer i;

	input_value = {`DW_max_data_crc_l{1'b0}};

	for (i=0 ; i < data_width ; i=i+1)
	  input_value[i] = data_in[i];

	return_value = bit_ordering(input_value,data_width);

	bit_order_data = return_value[data_width-1 : 0];
    end
endfunction // bit_order_data


function [poly_size-1:0]	calculate_crc_w_in;

    input [poly_size-1:0]		crc_in;
    input [`DW_max_data_crc_l-1:0]	input_data;
    input [31:0]			width0;

    begin : function_calculate_crc_w_in

	integer			width;
	reg			feedback_bit;
	reg [poly_size-1:0]	feedback_vector;
	integer			bit_idx;

	width = width0;
	calculate_crc_w_in = crc_in;
	for(bit_idx=width-1; bit_idx>=0; bit_idx=bit_idx-1) begin
	    feedback_bit = calculate_crc_w_in[poly_size-1]
				^ input_data[bit_idx];
	    feedback_vector = {poly_size{feedback_bit}};

	    calculate_crc_w_in = {calculate_crc_w_in[poly_size-2:0],1'b0}
	  		^ (crc_polynomial & feedback_vector);
	end

    end
endfunction // calculate_crc_w_in


function [poly_size-1:0]	calculate_crc;
    input [data_width-1:0]	input_data;

    begin : function_calculate_crc

	reg [`DW_max_data_crc_l-1:0]	input_value;
	reg [poly_size-1:0]		crc_tmp;
	integer i;

	input_value = {`DW_max_data_crc_l{1'b0}};

	for (i=0 ; i < data_width ; i=i+1)
	  input_value[i] = input_data[i];

	crc_tmp = {poly_size{(crc_cfg % 2)?1'b1:1'b0}};
	calculate_crc = calculate_crc_w_in(crc_tmp, input_value,
			data_width);
    end
endfunction // calculate_crc_crc


function [poly_size-1:0]	calculate_crc_crc;
    input [poly_size-1:0]	input_crc;
    input [poly_size-1:0]	input_data;

    begin : function_calculate_crc_crc

	reg [`DW_max_data_crc_l-1:0]	input_value;
	reg [poly_size-1:0]		crc_tmp;
	integer i;

	input_value = {`DW_max_data_crc_l{1'b0}};

	for (i=0 ; i < poly_size ; i=i+1)
	  input_value[i] = input_data[i];

	calculate_crc_crc = calculate_crc_w_in(input_crc, input_value,
			poly_size);
    end
endfunction // calculate_crc_crc


    
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    

	
    if ( (data_width < 1) || (data_width > 2560) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter data_width (legal range: 1 to 2560)",
	data_width );
    end
	
    if ( (poly_size < 2) || (poly_size > 64) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter poly_size (legal range: 2 to 64)",
	poly_size );
    end
	
    if ( (crc_cfg < 0) || (crc_cfg > 7) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter crc_cfg (legal range: 0 to 7)",
	crc_cfg );
    end
	
    if ( (bit_order < 0) || (bit_order > 3) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter bit_order (legal range: 0 to 3)",
	bit_order );
    end
	
    if ( (poly_coef0 < 1) || (poly_coef0 > 65535) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter poly_coef0 (legal range: 1 to 65535)",
	poly_coef0 );
    end
	
    if ( (poly_coef1 < 0) || (poly_coef1 > 65535) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter poly_coef1 (legal range: 0 to 65535)",
	poly_coef1 );
    end
	
    if ( (poly_coef2 < 0) || (poly_coef2 > 65535) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter poly_coef2 (legal range: 0 to 65535)",
	poly_coef2 );
    end
	
    if ( (poly_coef3 < 0) || (poly_coef3 > 65535) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter poly_coef3 (legal range: 0 to 65535)",
	poly_coef3 );
    end
	
    if ( (poly_coef0 % 2)==0 ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m : Invalid parameter (poly_coef0 value MUST be odd)" );
    end
	
    if ( (bit_order>1) && ((data_width % 8) > 0) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m : Invalid parameter combination (bit_order > 1 is only allowed when data_width is a multiple of 8)" );
    end
	
    if ( (bit_order>1) && ((poly_size % 8) > 0) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m : Invalid parameter combination (bit_order > 1 is only allowed when poly_size is a moltiple of 8)" );
    end
    
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 



`ifndef UPF_POWER_AWARE
    initial begin : initialize_vars

	reg [63:0]	crc_polynomial64;
	reg [15:0]	coef0;
	reg [15:0]	coef1;
	reg [15:0]	coef2;
	reg [15:0]	coef3;
	integer		bit_idx;

	coef0 = poly_coef0;
	coef1 = poly_coef1;
	coef2 = poly_coef2;
	coef3 = poly_coef3;

	crc_polynomial64 = {coef3, coef2, coef1, coef0};
	crc_polynomial = crc_polynomial64[poly_size-1:0];

	case(crc_cfg/2)
	    0 : crc_inv_alt = {poly_size{1'b0}};
	    1 : for(bit_idx=0; bit_idx<poly_size; bit_idx=bit_idx+1)
		crc_inv_alt[bit_idx] = (bit_idx % 2)? 1'b0 : 1'b1;
	    2 : for(bit_idx=0; bit_idx<poly_size; bit_idx=bit_idx+1)
		crc_inv_alt[bit_idx] = (bit_idx % 2)? 1'b1 : 1'b0;
	    3 : crc_inv_alt = {poly_size{1'b1}};
	    default : 
		begin 
		    $display("ERROR: %m : Internal Error.  Please report to Synopsys representative."); 
		    $finish; 
		end
	endcase

    end // initialize_vars


`endif
    assign	crc_in_inv = bit_order_crc(crc_in) ^ crc_inv_alt;

    assign	crc_reg = calculate_crc(bit_order_data(data_in));

    assign	crc_out_inv = crc_reg ^ crc_inv_alt;
    assign	crc_out = bit_order_crc(crc_out_inv);
    assign	crc_chk_crc_in = calculate_crc_crc(crc_reg, crc_in_inv);
    assign	crc_ok = ! (| crc_chk_crc_in);


`undef	DW_max_data_crc_l

// synopsys translate_on

endmodule
