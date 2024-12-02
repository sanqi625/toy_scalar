////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 1999 - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Nitin Mhamunkar  Sept 1999
//
// VERSION:   Simulation Architecture
//
// DesignWare_version: b7619314
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//#include "DW_crc_s.lbls"
//----------------------------------------------------------------------------
// ABSTRACT: Generic CRC 
//
// MODIFIED:
//
//      02/03/2016  Liming SU   Eliminated function calling from sequential
//                              always block in order for NLP tool to correctly
//                              infer FFs
//
//      07/09/2015  Liming SU   Changed for compatibility with VCS Native Low
//                              Power
//
//	09/19/2002  Rick Kelly  Fixed behavior of enable (STAR 147315) as well
//                              as discrepencies in other control logic.  Also
//			        updated to current simulation code guidelines.
//
//----------------------------------------------------------------------------
module DW_crc_s
    (
     clk ,rst_n ,init_n ,enable ,drain ,ld_crc_n ,data_in ,crc_in ,
     draining ,drain_done ,crc_ok ,data_out ,crc_out 
     );

parameter integer data_width = 16;
parameter integer poly_size  = 16;
parameter integer crc_cfg    = 7;
parameter integer bit_order  = 3;
parameter integer poly_coef0 = 4129;
parameter integer poly_coef1 = 0;
parameter integer poly_coef2 = 0;
parameter integer poly_coef3 = 0;
   
input clk, rst_n, init_n, enable, drain, ld_crc_n;
input [data_width-1:0] data_in;
input [poly_size-1:0]  crc_in;
   
output draining, drain_done, crc_ok;
output [data_width-1:0] data_out;
output [poly_size-1:0]  crc_out;
   
//   synopsys translate_off


  wire 			   clk, rst_n, init_n, enable, drain, ld_crc_n;
  wire [data_width-1:0]    data_in;
  wire [poly_size-1:0]     crc_in;
   
  reg			   drain_done_int;
  reg 			   draining_status;
   
  wire [poly_size-1:0]     crc_result;
   
  integer 		   drain_pointer, data_pointer;
  integer 		   drain_pointer_next, data_pointer_next;
  reg 			   draining_status_next;
  reg 			   draining_next;
  reg 			   draining_int;
  reg 			   crc_ok_result;
  wire [data_width-1:0]    insert_data;
  reg [data_width-1:0]     data_out_next;
  reg [data_width-1:0]     data_out_int;
  reg [poly_size-1:0] 	   crc_out_int;
  reg [poly_size-1:0] 	   crc_out_info; 
  reg [poly_size-1:0] 	   crc_out_info_next;
  reg [poly_size-1:0] 	   crc_out_info_temp;
   
  reg [poly_size-1:0] 	   crc_out_next;
  reg [poly_size-1:0] 	   crc_out_temp;
  wire [poly_size-1:0]     insert_crc_info;
  wire [poly_size-1:0]     crc_swaped_info; 
  wire [poly_size-1:0]     crc_out_next_shifted;
  wire [poly_size-1:0]     crc_swaped_shifted;
  reg 			   drain_done_next;
  reg 			   crc_ok_int;
   
`ifdef UPF_POWER_AWARE
  `protected
GM3<FZP0R/NQ5)=?(I5#ZC1(A31fOF0H[:NTgG2,[5IV3<RNO,TC()?SbA^_&9:g
6J:W<c-B[0JcSZV11/gV?P4P+B#T&cZCC.X=KcMBCH&eUE7UQ]BNX+d9dW4D:Ug3
9Rg@MJ/X.L5Z-B-f4HP4C,=:#S_;MC#^[BQGC/V:RaJ<DI>K?7R@A,]g+:T2E0T-
H(f/?Y#3Ya?<GQ0Q?YT&SG]bS@0WIfUBY4H5>_bNeYKB^W#(B\aT-SSFBZbJQ^L4
JBbUNaN6ae]@DaU=IFCI;DWU0QgN[SV;5@5,4B_TUOg3)Y9YcXNRG80A\Z0gBRI6
O.#6#3CeP5]0DCJ;dB\B:G]Nb[R(dB<Mc/.;<O0^JYLBN.f/.CI:K5.1--9ZOPHJ
BRY3H>[EEEB#OR4<R1E;P/LQ6:8Wb\A)?dg_H(cY5/]<5aF865,K4a2Z3SJ6W0AL
@/;I7IK]LPVbMfU^&6789:@XPIVbNK-YJ=<W4P3]5]/F=(1/TD?M-H>Ab(,.dO5+
EX?+RKb4P?:e\[\P/XF0LEEU5fKN5Y?PFTDNE_YPZff0b/ZOM7\2]8_VPR5@]RGE
P4(V@D>20I?cDXY^]_U]I:ZQ1dGXS_CDM/A\(MLR^;B_#Y(?cG5WA^\M@O25(V@7
^VE@DHG+Gg:I&QD39V)F<&I[b:10YG4F1RfU_?OZEf[DD0HB<Ue?XD\F-c_16P^;
?I3aRgGWYFW#>=@5AY5XDcS?-P^.TXTC>;C?L9/S?a[JI5QI92]d:aT(O)bAHK:J
=XMCJW.?^gR10YbbAf3_^HF+@\WX.\4=R=H5DN=GIU?aUIC0,YTNBa63&NAbdKX9
Y[KD92K[,EQ[&0KfS>R+T^F^M4NWbZ(F?J[&ZJgTX_L,d3-:<-F=g]KK#14N;Zd4
)-5.S9@R/3QFY#H/Z9d)8e->D?c?@0c,S,bH,g>XVe@\I#H=-K#H55.Y[5^39bZ8
>DLaA&H&@gdOH[,4D/XO)W?5J=GNb[C6MVQ&\>dgVV?J\5X/BD18&X3GI@,[;>Ka
S(cA+8K7;3@(]DRK;:f7f>a(cN#E2>B0cJQE+GV\B/>S7]=R7GT3]-45/a3;DM>;
QM8;5@AYA>4+0?-I(;34?#Cg4<5<_c#eLK#\8;6W4@=8fbP>JLg94JM>ZL<C5=)3
d=MF^dfB/H2cGR&M.]ZBg+39QbI,J6GE;1g&=S;1Ta7,R0bH?DPDU@^?Q]cV_PAd
6GY@b4F@Q-F>D[>b3b^;<d(K81<.2P9b=49PW&#K\49,<[RS4Z+<XZ&I3@+0D+S\
g@^8LDdK2a<T,KgBLVGdU+=0a269.>)VJ4?[S.<9G9cCBa-aQP^4,=M?H#T/CKF5
4eG;E)5\_AP6T0ZGV8,@AbOUO3PG8/Gc1E.H[QbGNR6MU\TA_J_7#)a-<(O<>H9\
BH.=#2JMV@aDEV_&S84(NP9Z[[BEK2LD&:)B##X]P8-@C\e>=CWAPe0(@9#1<563
0[<b038HX_S>e\4T7T8KW@HX:fe.M;^;4A4QK?E9-PY9f&a@0]S_g[JX=8<P-S5K
(>2[)MZ)(>OSbOQV@+Z>KO.f5W\Xg+O3X9FAB<1Z=ZgdHX2V2W]WB&?M>UNf[WY_
-R:T\.O<+IcW-M<0EAY/YTYZ;&OB)1D6Q(02,;HE6#J4AE(ZdV?McOI+V^\,f8R6
OZK2&?>(W;PSTK@\H_If;D??3GTMY/LME5Y(MG6J4<GUV0=<eX-W);@AbJLOJdB^
XV6]b3d^1[2N\-,O)7JgH(3GAXC(f>^HEW,PRN<O4IL9BY;O>6&6;M3T/AKC4HK@
MV\AZ8KJ?\Y4Sg0TdTb@AYZ,UfLg?1(Td2Q..Z.BfYIO\])MBf_GXD8=agR#9TF<
7U=KWV?WZ)ceT_5MI_0\-g(AHdVcdZ[OQ_Sd8V3(H)4+&8Q^<.0Eed/ZW>6>a?Pf
[H^,c2B>K\Y+6:fJ5Te]WgQCN9>/ZOJ=EQV(3EC00I)a56KPRZ#Y)Ugd91(cH^_d
7ZIaU8f6EE[6AIb^/>=gQW1M?9BYO7Vf(1BV^Q(4]A?,\2ZZ7_J0TfO#.OG6./E1
@GNLUD9(8^Y9cIG<J>Q]Ef=<,YKOI+4AdcR#1c7TdR[282@2B:^CbHb[=X]P,B=P
>bI,b^(4&-2]AWFK=DV:[T=C]LOfR=J_[JTecc>8gQ(>afD/DQXeD<>ScQ2?8X=W
b+>68R=D0GM2=#/d8c9gfZ-AYGe_<\;HB\>E]O6e[D,EJH2Q]KCU?5cGXL?2Va4S
]g\0\(#9Z8?.5d8D111#KKMLOTN(/M]A,f>g_=f0.adUGNbFE1:OKG\0Rg7IeE9F
=V#3gg4XC2<UE]T8@R4RCQ-7:2Sd<^@1<^XTC4IF\:<6<R5,L83/8S;]=XZ:^-LR
M4.d/55/D_D<Ubd#[P^E^6RbF.O-J;Y3X^U^4:&.BH-;]gB^(MSIBS\e]H^FXPO)
.=7#G1ZXD[e<-$
`endprotected

`else
  reg [poly_size-1:0]      reset_crc_reg;
  reg [poly_size-1:0]      crc_polynomial;
  reg [poly_size-1:0] 	   crc_xor_constant;
  reg [poly_size-1:0]      crc_ok_info;
`endif
 

  function [poly_size-1:0] fswap_bytes_bits;
    input [poly_size-1:0] swap_bytes_of_word;
    input [1:0] bit_order;
    begin : FUNC_SWAP_INPUT_DATA 
      reg[data_width-1:0] swaped_word;
      integer 	     no_of_bytes;
      integer 	     byte_boundry1;
      integer 	     byte_boundry2;
      integer 	     i, j;
     
      byte_boundry1 = 0;
      byte_boundry2 = 0;
     
      no_of_bytes = data_width/8;
	if(bit_order == 0)
	  swaped_word = swap_bytes_of_word; 
	else if(bit_order == 1) begin
	  for(i=0;i<=(data_width-1);i=i+1) begin
	    swaped_word[(data_width-1)-i] = swap_bytes_of_word[i];
	  end 
	end  
	else if(bit_order == 3) begin
	  for(i=1;i<=no_of_bytes;i=i+1) begin 
	    byte_boundry1 = (i * 8) - 1;
	    byte_boundry2 = (i - 1)* 8;
	    for (j=0;j<8;j=j+1) begin 
	      swaped_word [(byte_boundry2  + j)] = 
		      swap_bytes_of_word [(byte_boundry1  - j)];
	    end
	  end
	end
	else begin
	  for(i=1;i<=no_of_bytes;i=i+1) begin
	    byte_boundry1 = data_width - (i*8);
	    byte_boundry2 = ((i - 1)* 8);
	    for(j=0;j<8;j=j+1) begin 
	      swaped_word [(byte_boundry2 + j)] = 
      	      	      swap_bytes_of_word [(byte_boundry1  + j)];
	    end
	  end
	end
	 
	fswap_bytes_bits = swaped_word;
      end
  endfunction // FUNC_SWAP_INPUT_DATA





  function [poly_size-1:0] fswap_crc;
    input [poly_size-1:0] swap_crc_data;
    begin : FUNC_SWAP_CRC
      reg[data_width-1:0]   swap_data;
      reg [data_width-1:0] swaped_data;
      reg [poly_size-1:0]  swaped_crc;
      integer 	           no_of_words;
      integer 	           data_boundry1;
      integer 	           data_boundry2;
      integer 	           i, j;
     
      no_of_words = poly_size/data_width;
     
      data_boundry1 = (poly_size-1) + data_width;
      while (no_of_words > 0) begin 
	data_boundry1 = data_boundry1 - data_width;
	data_boundry2 = data_boundry1 - (data_width-1);
	j=0;
	for(i=data_boundry2;i<=data_boundry1;i = i + 1) begin
	  swap_data[j] = swap_crc_data[i];
	  j = j + 1;
	end      
	    
	swaped_data = fswap_bytes_bits (swap_data, bit_order);
	    
	j=0;
	for(i=data_boundry2;i<=data_boundry1;i = i + 1) begin
	  swaped_crc[i] = swaped_data[j];
	  j = j + 1;
	end   
	
	no_of_words = (no_of_words  -  1);
      end
     
      fswap_crc = swaped_crc;
    end
  endfunction // FUNC_SWAP_CRC


  function [poly_size-1:0] fcalc_crc;
    input [data_width-1:0] data_in;
    input [poly_size-1:0] crc_temp_data;
    input [poly_size-1:0] crc_polynomial;
    input [1:0]  bit_order;
    begin : FUNC_CAL_CRC
      reg[data_width-1:0] swaped_data_in;
      reg [poly_size-1:0] crc_data;
      reg 		     xor_or_not;
      integer 	     i;
     
     
     
      swaped_data_in = fswap_bytes_bits (data_in ,bit_order);
      crc_data = crc_temp_data ;
      i = 0 ;
      while (i < data_width ) begin 
	xor_or_not = 
	  swaped_data_in[(data_width-1) - i] ^ crc_data[(poly_size-1)];
	crc_data = {crc_data [((poly_size-1)-1):0],1'b0 };
	if(xor_or_not === 1'b1)
	  crc_data = (crc_data ^ crc_polynomial);
	else if(xor_or_not !== 1'b0)
	  crc_data = {data_width{xor_or_not}} ;
	i = i + 1;
      end
      fcalc_crc = crc_data ;
    end
  endfunction // FUNC_CAL_CRC





  function check_crc;
    input [poly_size-1:0] crc_out_int;
    input [poly_size-1:0] crc_ok_info;
    begin : FUNC_CRC_CHECK
      integer i;
      reg 	 crc_ok_func;
      reg [poly_size-1:0] data1;
      reg [poly_size-1:0] data2;
      data1 = crc_out_int ;
      data2 = crc_ok_info ;
     
      i = 0 ;
      while(i < poly_size) begin 
	if(data1[i] === 1'b0  || data1[i] === 1'b1) begin 
	  if(data1[i] === data2 [i]) begin
	    crc_ok_func = 1'b1;
	  end
	  else begin
	    crc_ok_func = 1'b0;
	    i = poly_size;
	  end 
	end
	else begin
	  crc_ok_func = data1 [i];
	  i = poly_size;
	end 
	i = i + 1;
      end
     
      check_crc = crc_ok_func ;
    end
  endfunction // FUNC_CRC_CHECK



   
  always @(drain or
           draining_status or
           drain_done_int or
           data_pointer or
           drain_pointer or
           insert_data or
           crc_out_next_shifted or
           crc_out_info or
           data_in or
           crc_result or
           ld_crc_n or
           crc_in or
           crc_ok_info)
  begin: PROC_DW_crc_s_sim_com

    if(draining_status === 1'b0) begin
      if((drain & ~drain_done_int) === 1'b1) begin
       draining_status_next = 1'b1;
       draining_next = 1'b1;
       drain_pointer_next = drain_pointer + 1;
       data_pointer_next = data_pointer  - 1;
       data_out_next = insert_data;
       crc_out_next = crc_out_next_shifted;
       crc_out_info_next = crc_out_info; 
       drain_done_next = drain_done_int;
      end  
      else if((drain & ~drain_done_int) === 1'b0) begin
       draining_status_next = 1'b0;
       draining_next = 1'b0;
       drain_pointer_next = 0;
       data_pointer_next = (poly_size/data_width) ; 
       data_out_next = data_in ;
       crc_out_next = crc_result;
       crc_out_info_next = crc_result;
       drain_done_next = drain_done_int;
      end  
      else begin
       draining_status_next = 1'bx ;
       draining_next = 1'bx ;
       drain_pointer_next = 0;
       data_pointer_next = 0 ; 
       data_out_next = {data_width {1'bx}};
       crc_out_next = {poly_size {1'bx}};
       crc_out_info_next = {poly_size {1'bx}}; 
       drain_done_next = 1'bx;
      end  
    end
    else if(draining_status === 1'b1) begin 
      if(data_pointer == 0) begin 
       draining_status_next = 1'b0 ;
       draining_next = 1'b0 ;
       drain_pointer_next = 0 ;
       data_pointer_next = 0 ; 
       data_out_next = data_in ;
       crc_out_next = crc_result;
       crc_out_info_next = crc_result; 
       drain_done_next = 1'b1;
      end
      else begin
       draining_status_next = 1'b1 ;
       draining_next = 1'b1 ;
       drain_pointer_next = drain_pointer + 1;
       data_pointer_next = data_pointer  - 1;
       data_out_next = insert_data ;
       crc_out_next = crc_out_next_shifted;
       crc_out_info_next = crc_out_info;
       drain_done_next = drain_done_int;
      end   
    end   // draining_status === 1'b1
    else begin 
      draining_status_next = 1'bx ;
      draining_next = 1'bx ;
      drain_pointer_next = data_pointer ;
      data_pointer_next = drain_pointer;
      data_out_next = {data_width{1'bx}} ;
      crc_out_next = {poly_size{1'bx}}  ;
      crc_out_info_next = {poly_size{1'bx}}  ; 
      drain_done_next = 1'bx ;
    end   

    if(ld_crc_n === 1'b0) begin
      crc_out_temp = crc_in;
      crc_out_info_temp = crc_in;
    end
    else if(ld_crc_n === 1'b1) begin
      crc_out_temp = crc_out_next;
      crc_out_info_temp = crc_out_info_next;
    end
    else begin
      crc_out_temp = {poly_size{1'bx}};
      crc_out_info_temp = {poly_size{1'bx}}; 
    end 

    crc_ok_result = check_crc(crc_out_temp ,crc_ok_info);

  end // PROC_DW_crc_s_sim_com

  always @ (posedge clk or negedge rst_n) begin : DW_crc_s_sim_seq_PROC
        
    if(rst_n === 1'b0) begin
      draining_status <= 1'b0 ;
      draining_int <= 1'b0 ;
      drain_pointer <= 0 ;
      data_pointer <= (poly_size/data_width) ;
      data_out_int <= {data_width{1'b0}} ;
      crc_out_int <= reset_crc_reg ; 
      crc_out_info <= reset_crc_reg ;  
      drain_done_int <= 1'b0 ;
      crc_ok_int <= 1'b0;   
    end else if(rst_n === 1'b1) begin 
      if(init_n === 1'b0) begin
        draining_status <= 1'b0 ;
        draining_int <= 1'b0 ;
        drain_pointer <= 0 ;
        data_pointer <= (poly_size/data_width) ;
        data_out_int <= {data_width{1'b0}} ;
        crc_out_int <= reset_crc_reg ;
        crc_out_info <= reset_crc_reg ; 
        drain_done_int <= 1'b0 ;
        crc_ok_int <= 1'b0;
      end else if(init_n === 1'b1) begin 
        if(enable === 1'b1) begin
          draining_status <= draining_status_next;
          draining_int <= draining_next ;
          drain_pointer <= drain_pointer_next ;
          data_pointer <= data_pointer_next ;
          data_out_int <= data_out_next ;
          crc_out_int <= crc_out_temp ;
          crc_out_info <= crc_out_info_temp ;
          drain_done_int <= drain_done_next ;
          crc_ok_int <= crc_ok_result;
        end else if(enable === 1'b0) begin
           draining_status <= draining_status ;
           draining_int <= draining_int ;
           drain_pointer <= drain_pointer ;
           data_pointer <= data_pointer ;
           data_out_int <= data_out_int ;
           crc_out_int <= crc_out_int ;
           crc_out_info <= crc_out_info ;
           drain_done_int <= drain_done_int ;
           crc_ok_int <= crc_ok_int ;
        end else begin
           draining_status <= 1'bx ;
           draining_int <= 1'bx ;
           drain_pointer <= 0 ;
           data_pointer <= (poly_size/data_width) ;
           data_out_int <= {data_width{1'bx}} ;
           crc_out_int <= {poly_size{1'bx}} ;
           crc_out_info <= {poly_size{1'bx}} ; 
           drain_done_int <= 1'bx ;
           crc_ok_int <= 1'bx ; 
        end
      end else begin 
        draining_status <= 1'bx ;
        draining_int <= 1'bx ;
        drain_pointer <= 0 ;
        data_pointer <= (poly_size/data_width) ;
        data_out_int <= {data_width{1'bx}} ;
        crc_out_int <= {poly_size{1'bx}} ;
        crc_out_info <= {poly_size{1'bx}} ; 
        drain_done_int <= 1'bx ;
        crc_ok_int <= 1'bx ; 
      end      
    end else begin
      draining_status <= 1'bx ;
      draining_int <= 1'bx ;
      drain_pointer <= 0 ;
      data_pointer <= 0 ;
      data_out_int <= {data_width{1'bx}} ;
      crc_out_int <= {poly_size{1'bx}} ;
      crc_out_info <= {poly_size{1'bx}} ; 
      drain_done_int <= 1'bx ;
      crc_ok_int <= 1'bx ;
    end 
       
  end // PROC_DW_crc_s_sim_seq

   assign crc_out_next_shifted = crc_out_int << data_width; 
   assign crc_result = fcalc_crc (data_in ,crc_out_int ,crc_polynomial ,bit_order);
   assign insert_crc_info = (crc_out_info ^ crc_xor_constant);
   assign crc_swaped_info = fswap_crc (insert_crc_info);
   assign crc_swaped_shifted = crc_swaped_info << (drain_pointer*data_width);
   assign insert_data = crc_swaped_shifted[poly_size-1:poly_size-data_width];

   assign crc_out = crc_out_int;
   assign draining = draining_int;
   assign data_out = data_out_int;
   assign crc_ok = crc_ok_int;
   assign drain_done = drain_done_int;
   
   
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
      
       
    if ( (poly_size < 2) || (poly_size > 64 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter poly_size (legal range: 2 to 64 )",
	poly_size );
    end
       
    if ( (data_width < 1) || (data_width > poly_size ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter data_width (legal range: 1 to poly_size )",
	data_width );
    end
       
    if ( (bit_order < 0) || (bit_order > 3 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter bit_order (legal range: 0 to 3 )",
	bit_order );
    end
       
    if ( (crc_cfg < 0) || (crc_cfg > 7 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter crc_cfg (legal range: 0 to 7 )",
	crc_cfg );
    end
       
    if ( (poly_coef0 < 0) || (poly_coef0 > 65535 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter poly_coef0 (legal range: 0 to 65535 )",
	poly_coef0 );
    end
       
    if ( (poly_coef1 < 0) || (poly_coef1 > 65535 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter poly_coef1 (legal range: 0 to 65535 )",
	poly_coef1 );
    end
       
    if ( (poly_coef2 < 0) || (poly_coef2 > 65535 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter poly_coef2 (legal range: 0 to 65535 )",
	poly_coef2 );
    end
       
    if ( (poly_coef3 < 0) || (poly_coef3 > 65535 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter poly_coef3 (legal range: 0 to 65535 )",
	poly_coef3 );
    end
       
    if ( (poly_coef0 % 2) == 0 ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m : Invalid parameter (poly_coef0 value MUST be an odd number)" );
    end
       
    if ( (poly_size % data_width) > 0 ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m : Invalid parameter combination (poly_size MUST be a multiple of data_width)" );
    end
       
    if ( (data_width % 8) > 0 && (bit_order > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m : Invalid parameter combination (crc_cfg > 1 only allowed when data_width is multiple of 8)" );
    end

   
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 

      

`ifndef UPF_POWER_AWARE
  initial begin : init_vars
	
    reg [63:0]			con_poly_coeff;
    reg [15:0]			v_poly_coef0;
    reg [15:0]			v_poly_coef1;
    reg [15:0]			v_poly_coef2;
    reg [15:0]			v_poly_coef3; 
    reg [poly_size-1:0 ]	int_ok_calc;
    reg[poly_size-1:0]		x;
    reg				xor_or_not_ok;
    integer			i;
	
    v_poly_coef0 = poly_coef0;
    v_poly_coef1 = poly_coef1;
    v_poly_coef2 = poly_coef2;
    v_poly_coef3 = poly_coef3;
	
    con_poly_coeff = {v_poly_coef3, v_poly_coef2,
			v_poly_coef1, v_poly_coef0 };

    crc_polynomial = con_poly_coeff [poly_size-1:0];
	
    if(crc_cfg % 2 == 0)
      reset_crc_reg = {poly_size{1'b0}};
    else
      reset_crc_reg = {poly_size{1'b1}};
	 
    
    if(crc_cfg == 0 || crc_cfg == 1) begin 
      x = {poly_size{1'b0}};
    end
    else if(crc_cfg == 6 || crc_cfg == 7) begin 
      x = {poly_size{1'b1}};
    end
    else begin
      if(crc_cfg == 2 || crc_cfg == 3) begin 
        x[0] = 1'b1;
      end
      else begin 
        x[0] = 1'b0;
      end 
       
      for(i=1;i<poly_size;i=i+1) begin 
        x[i] = ~x[i-1];
      end
    end
    
    crc_xor_constant = x;

    int_ok_calc = crc_xor_constant;
    i = 0;
    while(i < poly_size) begin 
      xor_or_not_ok = int_ok_calc[(poly_size-1)];
      int_ok_calc = { int_ok_calc[((poly_size-1)-1):0], 1'b0};
      if(xor_or_not_ok === 1'b1)
	int_ok_calc = (int_ok_calc ^ crc_polynomial);
      i = i + 1; 
    end
    crc_ok_info = int_ok_calc;
	
   end  // init_vars
`endif
   
   
`ifndef DW_DISABLE_CLK_MONITOR
`ifndef DW_SUPPRESS_WARN
  always @ (clk) begin : clk_monitor 
    if ( (clk !== 1'b0) && (clk !== 1'b1) && ($time > 0) )
      $display ("WARNING: %m:\n at time = %0t: Detected unknown value, %b, on clk input.", $time, clk);
    end // clk_monitor 
`endif
`endif

 // synopsys translate_on
      
endmodule
