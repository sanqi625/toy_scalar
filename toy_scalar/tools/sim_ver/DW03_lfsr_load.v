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
// AUTHOR:    Igor Kurilov       07/08/94 03:41am
//
// VERSION:   Simulation Architecture
//
// DesignWare_version: b22fcb2d
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//-----------------------------------------------------------------------------------
//
// ABSTRACT:  LFSR Counter with Loadable Data Input
//           Programmable wordlength (width in integer range 1 to 50)
//           positive edge-triggering clock: clk
//           asynchronous reset(active low): reset
//           loadable (active low): load
//           when load = '0' load data and xor previous count
//           when load = '1' regular lfsr up counter
//           count state : count
//           when reset = '0', count <= "000...000"
//           counter state 0 to 2**width-2, "111...111" illegal state
//
// MODIFIED:
//
//           07/15/2015  Liming Su   Changed for compatibility with VCS Native
//                                   Low Power
//           07/14/94 06:14am
//           GN  Feb. 16th, 1996
//           changed DW03 to DW03
//           remove $generic and $end_generic
//           define paramter = 8
//------------------------------------------------------------------------------

module DW03_lfsr_load
  (data, load, cen, clk, reset, count);

  parameter integer width = 8 ;
  input [width-1 : 0] data;
  input load, cen, clk, reset;
  output [width-1 : 0] count;

  // synopsys translate_off

  reg right_xor, shift_right;
  reg [width-1 : 0] q, d, de, datax;

`ifdef UPF_POWER_AWARE
`protected
NFM9:B_CH#;Z0\PE=:cMU0D=QB<0NHL&?[TY/>E#/4KOSAYK\J,:&)4MF=EH-bMd
VV5&e1\OTDY<H2XR66>-Y_=,E:&f7M8L#FR<X]H@-9T9TZ8#9/H0#_J:J)DUL5\a
18E32L_bVNHP@[OW]<E:8/P7+[E,B-F#7_S#f_O8UI>ea4A+O-@MXFg<LG_>>W@;
KcAEe>^X,(dP1QOf5IX3g/VfP,8HcfWZb+5/N117RfX_W6aB3ZKI8#_J5a(5.bBZ
91BgC>>CC4;@2LVd6]K(MFIT7?P_Z3ZTb?^YbB70EPR;GICTUOO=WeL_>+[J&Q]D
N:(9:RT:28H]U2fJ22gRI<@=:Pd334]8gK/e>>XfCbC_7Wab&,W69W8C4PP>b)+;
c)UO:CN,Z#RJXNGKE4M]ecaURM2g5Q??1&3E\ggeZ<d;Z8SW6gX;4fY&1Ye)PAOF
55T5<Q.VRLN311Ib2ea#g?K9fV_P&HV,/BgVPNQW_7.c:42VEQLJGe1dGVC?+3]3
01T=3&&P75AW\X&U0R0JVV?=E9_M4#M6b;DP(Ng.L&g:99_ZDfK-EKdBE5f:P9A6
0DXLL84Wg6UCc5&?-U=(g9TZSKA;>^fBTB#I9R-FgW4531f[?/E)^CLLeH.dD)L-
b+0QA_^IfZ5gHZ#bWDWW/(2AN=YHZL-+Y0IfOZ;_bS@b;F:_^CA),aQS[L<<K(J+
K#;b@JH1O&e9JT74C]YVe&+)c:+JEU6f/#Q3,A/R@ec_;H)#&d_I1)8\50N23DcI
D)4@2&0g.Y_#_466_(PaS+-85@dYEY.0eOb,C3fU/RD=X7#+2Q.B;83IJ^IRg;A9
2\\R&NM@8MQO0/7C:BV.:fGZ48FT5e:4J[Uc_..Y+^@T)#VZ7J:>&5?7)+C:<0<;
]Lda:@Q6W3:0g7VGWKVC,8a\OdJD@]+/MOU^aG<ba/VRF7b:/0^[fB?M<WHdG^WZ
P6_PbE?+Q_5J./a+\S<^>MN;V],3.ZdK.?-3/LW/R#6Z-8d18c\@2K<ERc\R)SB,
;MgHeI(OB?A3\(QRU0_>U@>&_4Nc.AHFNL[3G5RL0:6>/b5<WM\PPaM+0KB[S<@S
?C7N7KebKa@Z?Nb.#36[eMCTX)E1,C@CMCdbF6:VVa310K=_/R-AN<fF=&9aG7eg
_41ZeTDPDQD>R3K-D;:)JSfJ).)(Pb6#8BVSMCBQ3Q:9BdeQfKIBP?#V>NN=>7PI
=QcJ)=#WL(^).C&/3_W.K5(O2OaUSCDfT>N(SFJ-c2K1(0N&^=J6]>U(O>gXa?F>
(V0N<2D?W#)5C\W5b5G[DO_<@:Q@OOVTXCPH-[IT&P6EB^.55QZ[8G_L_.W>C2GK
AEO^31K&DN18]C/c.._S2M+B7TX#3_HSD[MO.A<&,OS8FQUQN:Z\PCbNF5\(cJI,
Y,&VZc7Wcc041;)YKI>[E<F/]MSFD7+B@>Zg<L]PT9F[R9];LCaP4;M6Y:#:1BJ2
IN2d]RBHUS,b?\COH-\7aF=-UCTb@[ED484=VZ]??\G9I>VOS,.-L[6A21bM?eWF
JI(=]NM?F7gb_0/TCdZX=\W7R/_eCZ)=&^NO_+9PLN,.3]:4c)gXK/bEV>O7K1@2
F[:.0.56HBX:g481BAe)4cVeBQP=/0MdI_+4a<Xg)OF<G&,IQg^QVXUWO(,\3AaU
W=c=&_-NW4I5T-5\/I@(418[6;C>FU6\#0NV]9BHc_0F4D0XL9E4P#9AKS\^TcLO
-EOEM#g]@(X+3-XCDeD@YDHg)YUGa\LKX^=0D+U>+)])d)R3FcT.)506e]>LgTX-T$
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
      datax = data ^ shr(q,shift_right);
      de = load ? shr(q,shift_right) : datax;
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

  // synopsys translate_on

endmodule // DW03_lfsr_load
