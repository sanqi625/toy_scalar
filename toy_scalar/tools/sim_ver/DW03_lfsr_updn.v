////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 1994 - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Igor Kurilov       07/09/94 02:08am
//
// VERSION:   Simulation Architecture
//
// DesignWare_version: f4092d46
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------
//
// ABSTRACT:  LFSR Up/Down Counter
//           Programmable wordlength (width in integer range 1 to 50)
//           positive edge-triggering clock: clk
//           asynchronous reset(active low): reset
//           updn = '1' count up, updn = '0' count down
//           count state : count
//           when reset = '0' , count <= "000...000"
//           counter state 0 to 2**width-2, "111...111" illegal state
//
// MODIFIED:
//
//           07/16/2015  Liming Su   Changed for compatibility with VCS Native
//                                   Low Power
//
//           07/14/94 06:26am
//           GN Feb. 16th, 1996
//           changed dw03 to DW03
//           remove $generic
//           define parameter width=8
//-------------------------------------------------------------------------

module DW03_lfsr_updn
 (updn, cen, clk, reset, count, tercnt);


  parameter integer width = 8;
  input updn, cen, clk, reset;
  output [width-1 : 0] count;
  output tercnt;

  // synopsys translate_off

  reg shift_right, shift_left, right_xor, left_xor, tc;
  reg [width-1 : 0] q, de, d;

`ifdef UPF_POWER_AWARE
`protected
NFM9:B_CH#;Z0\PE=:cMU0D=QB<0NHL&?[TY/>E#/4KOSAYK\J,:&)4MF=EH-bMd
3aC,YOSO=aI@d1^BQ25CSaYfG8TMLa>R0L:Y@]3@V_c5&50;D4KVD][a,I^\_VQZ
XU[2<]&J1D@EPVH92eT8.;JgCfM5Z>CN.B^UQ.OVCBU(^S34<JbTV.?J.VR>TJER
7[>7])^]@,cD5J;77E<4c_dMX0@Td>Kg@I:-fYS+@=KGF&(]C1&f=/6>]EJW>eW<
e_N5R;?Q^83;COb5S7d1[.NK3-fNY&2bRa?VD(,W-SPcV6VVG@O4#=6))1WcZd-K
OW0+XSe]@>WXM=Nc-_OHP76G4M.5^g#NNPdL[.,<\GJSZU);M>d9E@V?bU^)0[>O
HFX;1KQU_8#.b]bYKI=Z:JEA_UV#Y0+BI\C1)f3+3fge?+W@:(MU_dfE;f3M5Z:7
=.3d2\X^FI2abb:#Bc_VZ9:1O>A_RP^Z137RN9?S.YeSBYK\d#UA#<0FC5Z2+?XG
2aFCQV1_=^6RcdX^>0EFXH1Q9Ea99:>5WJR]C\0ZEEC;#[^-4B]H+B53T7gF1_\X
:GcRO;bMGW;B<<K:5dL8)gb^@adA8>ELd>&1+Heg7CeNS,[cR^Q:^?.g_JU;KTCY
Y5aJ_IZ.g23J>B204<d<cgJ&G3=6?P11#ALdW.[>:Id>efM4ZdK,W_N>I(c+cU,2
.)S_?dY)>WNXA8fI:Tfe(c^6-/K)VG6<DEbaeR;X^JgE+A+4C,IXGOJ?JeX9Za+>
4FSR+dCKPPg_=Z=4HaL;.1=;Q;-c8#.9;#.D0/<U:52ALH;_8N1d1\76BW=8-]FK
([W8#HZUZ><ZT++,TgKV:=.#I3L4GeCVK7e#RI1<R9IeWI+Yf4,8DO;Z]DQTeR>9
L<.4YD]#E7:WR7B=a@C+>GKRPP5>UC1?(@f-AHY:#\g=a1EQ/?WJM;]PRB6W@RSS
cUZSXLbZTJ_[-D+G#2LQ1^&8&4LQ;(<41IFRA(LI]\/9[E_a:-7QVJdP@@J#dR5f
=e/9/#XgQP:YCAa\WRe]OGWLDB=HRA<Q=PB3PEHU2.8PT(#L6@MP.;>J\1H+[/3H
Y8f38?.B42EW4e8=&(VQ?HHW@/9TT(9#Ifd05\2[A&FNJ5#;@;;F>85;dd#@ecCE
T2C6:Af1VD9W6fLdW>Z/>b9g7PBT:c4<d0GA4=1F=.GX96&+?V/(=QGV=+;[R3/#
+#L-HUI2bSaJ<,<T=^Q<dD(994[4O4Q?5GPC,#b?L;6QGN];+#KQSD&;R977H3;,
HQO7MaT0@?@W:6-FW4c.d3_K#eKa93d9C^^QKDd+6[OV8XTFN^=7RRFQgUB.BVPX
J\+7TV)a<f^]adcM<.W5]-VbWX=,M7X-^U[]TU(X+0=2e\K#H7[4aM[6Z16,fN3O
?Y3e.E]f>[eO&J@^CI\8R_E=7Pa(4/W(BdD7>N)>\>Abe<]HX@bGW.Zeg<972OS.
<cCS3@<(Va5U;-H=-+=cYH,FY?(aZ3c3;)#625f_Z7+c,7=X<]]>P_,F\d7d:X@N
/1P11B&O07.VPR#48J2U7HJ=0eM#F+S#9).7<fdH;\B19-5a&_H[2Md0M]BB<^(R
7KZ5<0Y947efT9E-X[YAXS_Z[NDe9]@H[5P)#bH\JUO1,21=]b(Q+VA>0UT5CDZY
:D7E0N:eF2=a]Y6GF6fEc7<V;7/MEbJ+3)>^^][-I=7+,MdBP\f_K;C8Lc4)QKY1
+O1KI\c[0;Y-@P?JPOB4>Z2(6FB.3A5If&MI5bG6;@[aGOEH)g54]IDa24,8KZ4S
CBA^EYVJFG8.G:A0@bX5CSgRF)@GT0YYc<ZSKHSCbc4EE40+15>H+1A8BGPV>BA#Q$
`endprotected

`else
  reg [width-1 : 0] pr, pl;
`endif

  function [width-1 : 0] shr;
    input [width-1 : 0] a;
    input msb;
    reg [width-1 : 0] b;
    begin
      b = a >> 1;
      b[width-1] = msb;
      shr = b;
    end
  endfunction

  function [width-1 : 0] shl;
    input [width-1 : 0] a;
    input lsb;
    reg [width-1 : 0] b;
    begin
      b = a << 1;
      b[0] = lsb;
      shl = b;
    end
  endfunction

  assign count  = q;
  assign tercnt = tc;

`ifndef UPF_POWER_AWARE
  initial
    begin
    case (width)
      1: pr = 1'b1;
      2,3,4,6,7,15,22: pr = 'b011;
      5,11,21,29,35: pr = 'b0101;
      10,17,20,25,28,31,41: pr = 'b01001;
      9,39: pr = 'b010001;
      23,47: pr = 'b0100001;
      18: pr = 'b010000001;
      49: pr = 'b01000000001;
      36: pr = 'b0100000000001;
      33: pr = 'b010000000000001;
      8,38,43: pr = 'b01100011;
      12: pr = 'b010011001;
      13,45: pr = 'b011011;
      14: pr = 'b01100000000011;
      16: pr = 'b0101101;
      19: pr = 'b01100011;
      24: pr = 'b011011;
      26,27: pr = 'b0110000011;
      30: pr = 'b011000000000000011;
      32,48: pr = 'b011000000000000000000000000011;
      34: pr = 'b01100000000000011;
      37: pr = 'b01010000000101;
      40: pr = 'b01010000000000000000101;
      42: pr = 'b0110000000000000000000011;
      44,50: pr = 'b01100000000000000000000000011;
      46: pr = 'b01100000000000000000011;
      default pr = 'bx;
    endcase
    pl = shr(pr,1'b1);
    end
`endif

  always
    begin: proc_shr
      right_xor = (width == 1) ? ~ q[0] : ^ (q & pr);
      shift_right = ~ right_xor;
      @q;
    end // proc_shr

  always
    begin: proc_shl
      left_xor = (width == 1) ? ~ q[width-1] : ^ (q & pl);
      shift_left = ~ left_xor;
      @q;
    end // proc_shl

  always
    @(updn or cen or q or shift_right or shift_left)
    begin
      de = updn ? shr(q,shift_right) : shl(q,shift_left);
      d = cen ? de : q;
    end


  always @(posedge clk or negedge reset)
    begin
    if (reset === 1'b0)
      q <= {width{1'b0}};

    else
      q <= d;
    end

  always @ (q or updn)
    begin
    if (updn === 1'bx)
      tc = 1'bx;
	  
    else
      begin
      if (updn === 1'b0)
		begin
		if (q === {1'b1, {width-1{1'b0}}})
		  tc = 1'b1;
	     
		else
		  tc = 1'b0;
		end
	     
      else
		begin
		if (q === {{width-1{1'b0}}, 1'b1})
		   tc = 1'b1;
	     
		else
		   tc = 1'b0;
		end
      end
    end

  // synopsys translate_on

endmodule // DW03_lfsr_updn
