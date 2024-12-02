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
// AUTHOR:    Igor Kurilov       07/09/94 01:44am
//
// VERSION:   Simulation Architecture
//
// DesignWare_version: 83242b32
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//-----------------------------------------------------------------------------------
//
// ABSTRACT:  LFSR Counter with Static Count-to Flag
//           Programmable wordlength (width in integer range 1 to 50)
//           positive edge-triggering clock: clk
//           asynchronous reset(active low): reset
//           count state : count
//           when reset = '0' , count <= "000...000"
//           counter state 0 to 2**width-2, "111...111" illegal state
//
// MODIFIED:
//
//           07/16/2015  Liming Su   Changed for compatibility with VCS Native
//                                   Low Power
//           07/14/94 06:20am
//
//------------------------------------------------------------------------------

module DW03_lfsr_scnto
 (data, load, cen, clk, reset, count, tercnt);
parameter   integer width = 8;
parameter   integer count_to = 5;

  input [width-1 : 0] data;
  input load, cen, clk, reset;
  output [width-1 : 0] count;
  output tercnt;

  // synopsys translate_off

  reg right_xor, shift_right, tc;
  reg [width-1 : 0] q, de, d;

`ifdef UPF_POWER_AWARE
`protected
NFM9:B_CH#;Z0\PE=:cMU0D=QB<0NHL&?[TY/>E#/4KOSAYK\J,:&)4MF=EH-bMd
Ra=R@6Y7K/5?bDF)<3)ZJ&QMNKPcN:B(S7OC5dQ,bDOUa+\.K7T.)K8:\YM=b41\
UVce]<JV,eQ]_)5<Vb_24E31YBYb,-H3+P[0DCVS9>Bb[M-^2c-P-S8/9AFP435-
XLf83PX=F&XD+cgIDC/V5<AF2T#ZV\O^<WP9b]-5I(L0IKZFVY8#724?L_LY[4K>
X@^6AHWO@B(N(P7)?\X3D8eHYXCC.;,IUA8>)7K?K786/_Ze@Y2[I,K=^Fe;;FLW
[ZIZ.K.V\O,K#b944UP;bFb<S.6R/+.aQI\@<VSA,43.<#5JW^1HA<S=KXA);I:?
_M)g?:>a&8bUeS1#9DaQ_f?fKQ=97^_.R<a4TEg&^S.Q/TN?<Q@(PZTG>UdOWeDb
2-R[ZK>H3B4ed=<^OT^(X7@G-ST_FG>,:38E]AVbK+Ra+#5]].W#@U=Peg][FVG@
NTEgSVB^P@NQT95eF0.cM(Y@WScQbVU)1-4=<4#OV.&eEIS?AFC\^ICb4FY6@P./
,]QeU[H#K&AV123Y_Ue+>9V7+N)e/GMbI6=gK\]G02^b.PCD7;V+I.N/@1C+3eBB
5PI9b:.cM+J\)&aXZXZ47fT9[C(;64R6ITAYHI,dG:NCL=-BH-K:D7@PE,2[Yg()
0,^b>GfCFcZ;&)BFb^P3QNf62]]ZPZ-9Y;S=c1JF_>cG=gF5Q&\ZHWe4(a_F\V[N
\VY6_^>4gMP>Bc+VTHXePV44<gL?8>1V^MC^D?&^Ka)N>]D6=BAYQWJ<cS8OB@<Y
D^B;D0DHA?M,(S:7GU5^.K#deNacW;f[F-OC59^daG]:Zf#@BJ<aB-VADQbE5b/c
Vb\<DDA8/X+OXT-(K]3_283&Z[MGH+\b&dLZ<Q;+7L2bg_1QcQ-^1([D9F[Q(BaF
94E+aQe])g7UW;78dGNbb=6d:_1G+0ZFK6(>JI;TY3GVF9dE-0aK&KXH(1XZL(/.
/Ab>RHWWBJI1KVBRg8]MX17a2-BXc[8>#bKMW]NN&#J+e5^T+EM_>C2dO-cU;f-/
DL&KT>e8FY.(VUWQ;RF1VCP+eb:3d8^)SA3117gT(S]P;Ta6#>WV]aGEOc?[[N+c
_0QcSU)<\HbfW+bL+I,934_U(997]81=<=+U3b^6=BKS.8\PH=?e_]#LQ4G87:G+
W09ZPJY7cX&A=Z75N<H^_<.S=g[1U^WA/<\98;,]V<c?0b#Pg.KDg6R]HR(Y_D7V
cQG>fC4KAD@LSV<c[Z8eFYN488.WN4:BNYWFZ.YNfZTR^#Z<dFT_EQd6JCXe]TU3
BDKEKPKMgDaeHeM;>b.fe,7Z&7&YAROg?Q,d&I+#=cTfa6g^ZgTA14BK(CD)FBT4
Vf@V47d2g3U,59,XH7)gO[#S[K1U(f0HC/6/;H;J([>=g>E8IEaAB\K]bCD5<9O+
X^Ld:KS-,Z2E7<>G[:IKPScf40NEY\^f#UZ^dQW5Ze76X+?#VL1U(<+0&D:3,#46
)B?RL>SO=K-50ZU9\1X=d2UXF:YUD[@H<eEedX2G9A85Y+ZS[8Zg29ScFVWZ[81f
E6E<N::[HS1YGA7)O\@J/A7^2gZ/5ZPLeL^?e7CG1fd50MBW]YC]e#F:La^B?UUT
4;UE9dQ.g@KR<#3]A_FIEN(N/.gS/DAcU(FH9E(X#5T_SF\C2;06AJQcL=8/7\.\
ZfIVBABFV,bMMMNb)g^-K.bFVNL+G/Y6P@IW_3Q.FbT3KS0gQ@<dcVK5aa+Q::eRT$
`endprotected

`else
  reg [width-1 : 0] p;
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

  assign count = q;
  assign tercnt = tc;

`ifndef UPF_POWER_AWARE
  initial
    begin
    case (width)
      1: p = 1'b1;
      2,3,4,6,7,15,22: p = 'b011;
      5,11,21,29,35: p = 'b0101;
      10,17,20,25,28,31,41: p = 'b01001;
      9,39: p = 'b010001;
      23,47: p = 'b0100001;
      18: p = 'b010000001;
      49: p = 'b01000000001;
      36: p = 'b0100000000001;
      33: p = 'b010000000000001;
      8,38,43: p = 'b01100011;
      12: p = 'b010011001;
      13,45: p = 'b011011;
      14: p = 'b01100000000011;
      16: p = 'b0101101;
      19: p = 'b01100011;
      24: p = 'b011011;
      26,27: p = 'b0110000011;
      30: p = 'b011000000000000011;
      32,48: p = 'b011000000000000000000000000011;
      34: p = 'b01100000000000011;
      37: p = 'b01010000000101;
      40: p = 'b01010000000000000000101;
      42: p = 'b0110000000000000000000011;
      44,50: p = 'b01100000000000000000000000011;
      46: p = 'b01100000000000000000011;
      default p = 'bx;
    endcase
    end
`endif

  always
    begin: proc_shr
      right_xor = (width == 1) ? ~ q[0] : ^ (q & p);
      shift_right = ~ right_xor;
      @q;
    end // proc_shr

  always
    @(load or cen or shift_right or q or data)
    begin
      de = load ? shr(q,shift_right) : data;
      d = cen ? de : q;
    end

  always @(posedge clk or negedge reset)
    begin
      if (reset === 1'b0)
        begin
          q <= 0;
        end
      else
        begin
          q <= d;
        end
    end

  always @(q) tc = count_to == q;

  // synopsys translate_on

endmodule // dw03_lfsr_scnto
