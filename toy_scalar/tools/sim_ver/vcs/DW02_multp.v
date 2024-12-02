////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 1998  - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Rick Kelly               November 3, 1998
//
// VERSION:   Verilog Simulation Model for DW02_multp
//
// DesignWare_version: c5766de3
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------
//
// ABSTRACT:  Multiplier, partial products
//
//    **** >>>>  NOTE:	This model is architecturally different
//			from the 'wall' implementation of DW02_multp
//			but will generate exactly the same result
//			once the two partial product outputs are
//			added together
//
// MODIFIED:
//
//              Aamir Farooqui 7/11/02
//              Corrected parameter simplied sim model, checking, and X_processing 
//              Alex Tenca  6/3/2011
//              Introduced a new parameter (verif_en) that allows the use of random 
//              CS output values, instead of the fixed CS representation used in 
//              the original model. By "fixed" we mean: the CS output is always the
//              the same for the same input values. By using a randomization process, 
//              the CS output for a given input value will change with time. The CS
//              output takes one of the possible CS representations that correspond 
//              to the product of the input values. For example: 3*2=6 may generate
//              sometimes the output (0101,0001), sometimes (0110,0000), sometimes
//              (1100,1010), etc. These are all valid CS representations of 6.
//              Options for the CS output behavior are (based on verif_en parameter):
//              0 - old behavior (fixed CS representation)
//              1 - partially random CS output. MSB of out0 is always '0'
//                  This behavior is similar to the old behavior, in the sense that
//                  the MSB of the old behavior has a constant bit. It differs from
//                  the old behavior because the other bits are random. The patterns
//                  are such that allow simple sign extension.
//              2 - partially random CS output. MSB of either out0 or out1 always
//                  have a '0'. The patterns allow simple sign extension.
//              3 - fully random CS output
//              Alex Tenca  12/08/2016
//              Tones down the warning message for the verif_en parameter
//              by recommending other values only when verif_en is 0 or 1
//------------------------------------------------------------------------------


module DW02_multp( a, b, tc, out0, out1 );


// parameters
parameter integer a_width = 8;
parameter integer b_width = 8;
parameter integer out_width = 18;
parameter integer verif_en = 2;

// ports
input [a_width-1 : 0]	a;
input [b_width-1 : 0]	b;
input			tc;
output [out_width-1:0]	out0, out1;


//-----------------------------------------------------------------------------

  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
    
    if (a_width < 1) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter a_width (lower bound: 1)",
	a_width );
    end
    
    if (b_width < 1) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter b_width (lower bound: 1)",
	b_width );
    end
    
    if (out_width < (a_width+b_width+2)) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter out_width (lower bound: (a_width+b_width+2))",
	out_width );
    end
    
    if ( (verif_en < 0) || (verif_en > 3) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter verif_en (legal range: 0 to 3)",
	verif_en );
    end
  
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 



`ifndef DW_SUPPRESS_WARN
initial begin : verif_en_warning
  if (verif_en < 2) begin
    $display( "" );
    $display("Warning: from DW02_multp at %m");
    $display("    The simulation coverage of Carry-Save values is not the best when verif_en=%d !\nThe recommended value is 2 or 3.",verif_en);
    $display( "" );
  end
end // verif_en_warning   
`endif


//-----------------------------------------------------------------------------
// synopsys translate_off

`protected
R91_T1HP,RSbQ?V=U<..QJ]S[4[G5IK5O1?IV6>;LWM?NeGFEVA8/)P=DHdD)NF9
N>B3Z903e\E&U2WUdYN.0U__2.0cMQ.8/YMg1b]g1BRRe;CZS0MA2>BO@X].P:EF
1B(MP,_&MgZTI1COO#6_[WX#aN<0#;6?g62bT;=b@(;b.a\;P6dgPAC0XXXW/bHC
-6,R^?B8EL)+Q5&E)3,X7eR.+S5DQaHH[L5=-J.ZJS:77F>SY2]8B:>5^CL&+(]:
/0B04;b100TcZYLAYM5Y-0Hee:8S/3O;/,5P6^0G@LTP6_65ZHB]0D-g\P[:eL5P
SZTV1\\2fIQ4G+_NEAg7d5RR+8:#Q-1]c>YN?/_ZB4&#,D8XOU4+EUa,@C<;9_F=
=EaP2T@=Rc?YaJ;;6gJM8-9c>H88=[)E-=-XZY6[\<dJV1Ng.LR+1/?:)7K3KH(2
DZ3(b7fFMRQe/4:5@f3c(X3,R[GLH8^H\XR5UE,-cGSTf2D).0CJ(.M@YF4H\ICS
QLS]E\\TdSAU[)I#W13BCbY^0bc>Q85\O19#JM;,H=E6=Me+51c)df?PG-=QbLd=
Q-.KdY6ZU1TWMgY(/OZTdST/CCV&<N>RQ58<U0\3&U9LdEYJ.BVGc)LcB2b.^Z=]
D-]N>7(24@SCQCBZ)3;/<OB8]^[#gG2Xc(_[M@>IZVf7FcNR&#/,JDb@c69]d1@0
B@;L[/XE=VU.eO9),<CeDgJ&Z=1Kd>47S7_QK:fE2:8-Y&NHd=&LJe7JdSI^DC4K
<Z;257F]e.C1bZ_d4gI\I5f_3Q96_^97fT(X5?2JM900eReE&;OY;gQB+__6KOIH
a/F4P<G?g+5GbQ7J(fb[^E)1?FD&A9>df3RI>Pd430H=2CW[Q#&2/E\DgJd4DEY=
Q1?H&b\N4T]&DKO?V_1e8J53[#3+@Cd<_9DaE6CBN[BM\#aBVObFSUL<^^X__HBb
=gA&8ecS.?(a3;ZTPU+)d.SfJWCM9\/cKQ6#6+N<1b.^>K8&VC1M9OC,GS1S]CKE
?9QdXe8?273\EKE@1Ef&Q2<.c?-LIE/,[\E5@O\SB4gMJC2R5dJa+,6)O4C_bAMP
b0\;D(LHZD0,YNf#/^a>#=V]7.#eBZa&]@8.DN3>De5ZcZ5+UY,fW5=^UA=65FYc
)Df.4I6Y2aV7G5aG7Sd(;1X/dDBJg=X(V.-:XOR^+GBQM;78X-Wb47]dS)/NTaa/
+II+0A]dR5<b(EPY<^UP]R[,8M+1P#0CS4d8f(-26NQe#<fDGG6fXW]6NdSQ8e;d
Z6KMXX^2Q\(9.N)<RcJ)dH2a-8VP4d9@IP?EL-Ye^9/,FPO))+9VgH-VW#32:G6f
XASMg;/^6O<d?.]VfFSLL4]J,Q15gC#V0AgZKTag@N=WNO>AW&eS.(+KH>Z\A4ZH
ZSgaE1+OU5b0YRHG\OP8(PD20+0f40)7ZESbN\Z5U0@2W.J9@+dE>JNL0cJHcRDJ
4+N;0#VQaU[=SNU8FS1GQ(CMQ6(<\,8DW0b0]SAf#JG\gG<.g0WcHZ@9PJ(28XAC
,B37[:^+^3B4FK+^3JJ[J-A@^PV_H_8T(aLE)6]g)0I(5RYD./]d]ccY=AAE_7#<
P^=?H4d6B^b@,<>HfLNPC&7-M-K@UCbW^bQ2_-3TfXK=_\76@R:3b:)2=.J7S0LB
?eTOH==1H4VO<g0E4b+N-e(BfEdK50]Ca1WG_/dU^aL4MHUE&BODd2T(\?TTZ+[5
@(gW-b8d_(<SMQT@;2a2eHM\+,9(;X-KHULV&YLYHe2Yb.eY/1^-&bCYM2eV:PA5
6G,5X&8#76A(W1Q^@2;E5_Z8+^:Fd5a]B.[Q5<BPB;NEGW2875(-U-K-=0I4QS_W
CG4BGM,-V(=d90W<5_BEU([#3GdT]fULB#A/D)BZ5@54<BWf7a,2W:^(d^GaZ0Aa
(e?KDd=7-RSf/H=;A5#bA97[F9FSKE\/C=;J4\1^5KV15/T.5&H1?Pc&<2=IJ.L#
,&6PH&,[=-.S0386+0<V<>:V02g=HgD>BC)I0O=80^Gd9B9LEH&Q(eQ7=B4G-fI1
7caK6(GO]BfAYePDQ&GADE333=5g[9,2G1HLE)-YD<T\+&XL+4NN+=]#UAEYN<0_
3Eg&[>-IWC=25>cQL+Q>U@W+M412NFQ.)UZcY9:?caZ:WVL)3caYUI?<8c-[O4/A
8_M+Z]-]><;a9C-Q4V;IJ&4_Hcc496g>S87B\T8);PP7LI^&)(L)d_,J;1KE:[e4
QO.]Pg4\>d2641GBc6I,QIK&ROY,<E@#g1AP(cZfc?E<<\WT9<S_eENPUMPU7D4f
Q)AVD\U(F4&V=SJZ^bM-9?QN(E@<A-=GZF=C#IVb-UWFFJ^L6]gC<TO2ML)GgHG/
UD/>fH[)?T\8HLF#HY]YE^:.dFUOY=AMAbSgZV;/?G7?KQ[<6FbF=GLe,E.ZNR&^
+ZV1:VTWLH]eDeMfg2]HA(DK@c]I/(fU?]K,M^9+gMTU5OGW?F^f(dKNd11eg:?-
:OPS4Q:8_V#;V]S)2d.)WB]JBP=A[fGceQ:6D_RJ=XQ]+X637IA/1?#1;M0aR)=4
#WTVV<dc\Pg7Y;]-&CQZa-[<2RD)AD<RC;UPMXcaDYQA4Oe^CZ?.cRU2f>+.6PaU
62Yg)>T3R<(#>]0[C9BA+]>T<2B^5(^b&_c8cd8L&cQYJ94(7Lf_d1:g?=U[J,@<
8<V68:eVG3)07GD6(A^cG7QA8RLT5-)GD9W-OX\DDS]@3X-A=U,-Ndg:EK49K,,3
@V7U)UX[4\+NOARfL-27SQ8I.;:?0@U0OJ81-c&GW;C/g30(PbB#O?A&L_cJR,K4
eL?Cf+aCW6LBCaD_/&Y#]dX(^G\?6/OGNK+16.BGIV^(Z@7O1C]8FM_,=-+1<HT:
L7].XQ=)NBcg+;QGG_Q];)LGS64MdQ@4_DG#5]<@7CC[E)gEQV6@L#,71aB_Lecc
OKfH)]a1N-@gVM1=-QE:NFT?59.@gK8;R_C?c0EGb^FYL5\,KEAK(I2d4WM&T5@g
Qb_VfPHS&&+,?O;6@X>_FA^A[3d<JZC2,a57<[.I;?A6M,^PaSFc4TEPL:E\0,f0
JR1EOE1DL+Qf=7N[dN+/OCKD:O\0MI22ICBC_)3NJ:aD@ARQbLf#//(/KDK=>F;T
TKPY0XRe;:HS)P1?0@,K^;e2R#IHGf3]bC#I3I_NS39&UAC5a\MC^C6?K)AQ3caV
HYG<=^b].DUO0HZ\_5DUQN2[.Bd4)A(0b1KD7@24JI8Ag8]d7=eD[()3)2CUA^Me
QL9P^V8HcdWW?+A0G92E[QfS68&PYBaM-+BXecL:\3]Ma>X_[DBKgV-6@A4()^C=
6\A2TCYH?4?9(G01RY/J91;59DN4feE&C</O/ZW;\B]1JZ;_DPYO]Cc+-,</XQa8
GgN?QbZ,N7-5FD]Zf[@XY]S\/I+-d@<SC>J/;TXZeC#9LQ-ReaFcbN&L1d2.V;>X
E.CGDE=1,-[JJZ)e>K3.;YSOJ@,5CfE/>a?G#V9Rb54N;aL+febEfa54eJ(5ME45
,QXM<+5=:d,IO]/bKNIUP5F@d9OLY10D6\5&,ZF&(2A+,)0NSZIfcB]_ZQ3-_@<:
7)^\=FgE2=N:D?:@S=U?a&-f+c_CI8He6(Bcg:(?WXK.@&<-5(:J3aO,R/CLDaI6
C4:agQKX/40<OU8ZAYI-7I<R2/fLMAZD]F_:EdM)3]4B-H&POOG6Ha_-:[e_P<5b
gYV241Mba1I.7<8T/8\CVdS@O>9IQ<58c3b;9aT\c38e==MZ5=4#aP1;dS(#GZ,2
W)Tb^O3I=.-HQER-TH/+0C;Q[)\4ZX>dF@a\2D:eJZNB:-V^4fe(,IJEICfA[<A1
IZ6F,WKEBKXB7fZ8;&+\Z-c[6K0dO=d6_ORXWU?(S0QaBaN:HcVIC[#4TKbJPEg?
9>[L#AA_9Uca/,G7ARO<6LHM0)5^):-T_6b15^X+@R-/09C-45P.>Oe#d5TNDeZ<
-_/8S^WJg,LP&<6R+7)655XYc.GVAR2]V3S8Z)JDC?NEf>@@0aJ[M9Z^ES<<)@2S
I4L^&V_:@NZJKBI9)URQ2S=dJ8Ya;^G=#?M^<3=fC4WFCd@>L@FC&>aXIJ1JN.@)
7K2?(I.]I@d]R.f:&bKdgS._#31VgGV;JNM@AQ8TLB?CMF/AJTS88M5[2b0A^.05
L^WeD\E]WU4CUPNfL4YQLR560ZfBU\7QX5<<T#bNP@2a+?;X4VcPabY&E]S[ZW^K
>Y,>/ZCX#>6N2b,E9H(gb+I-R=3M7LUTHN+/Y\CHQ+Yc1R.YYJ1)_39B,3W3#\RN
#+eLY<^_8HXRb\TEb5KNBQ@>2OeDfGJ_;5eG/N(NGL2(/P\O+Ub(YNb;?6S5P_&D
_cHg?YH^98Ib/L+AY:^T(=;,W\Ld\;Z=(Y2,S76>+JbW).GQ6AFIYB/c:dH/NYeg
E<&aC_Sd.-\RZV-D6=@WV)Y1L?96.dSd-Ja11>KHcK^L8+YFFgOI[^E(_-\>8>+C
WZ3)R0KB?#_A:\KJ[(/,W)N@M\?Y3<Y9(?D<J9LQ@SQdF1Tdc9JA_PCRDHW7Q,#P
H2O&\;af#C17I8OMR74gcFD]08M:?K#,RY2S2>3WRFSR,f/b-4T@]VMB1HFUR]33
KSVUYQGd1?g1X4.SFX84SE#P-:,e^]ZZ9,d53bRag8@3(OJ1O:N(1_VO&K0H82&>
<U3RGd9HFCcF-XeNXZgBc5W^;8H.X9KMIY0090E^IO-;,HaAHIU7Z(#6bRC/8<P1
Q&Z\/.W@]K1H3U56A;==7?U0V9TPZ/e[/PM4,:3ID6RdUG_,;#/<EgcZ:6_RGM,2
\5)a\6cH-1)W6D](OF:E#_NI_&_63&].N_FC57L&4KJQ(CIYHOQN;>])aKO</7JS
;.A7?AaFf:6eI+JW@We2+5EKfP5Y(+b.c=Zcc71Y[A&JMR,#AdD/#7=9U1>GHJ(5
+QE#ZWfb),1VGdB5(70eL\;=)+g4gfJWeAd1;_WR=#VG1[DA/_,a2U#(1DX.+)dO
BOU&D+-,VJ32D9E(E[J-]a_1HMc)Td_@99PN^DA5EN>HdcEDZ?8.F4aETCY3&MN+
?(=J60392=5^GL3=O3M8.7<J_.KZL&&\3[Z^:#?A)P@_F\,M9@PU+9<ST7])e6F5
#5\DQ\.,f?2;.+[Lg4HY\L[^LZ0OC-,>;[3bW+KF])[gZ8Ca(A000cUM5E;H>]YI
BgDXY.B<K#/@W>HQ&/@/A]<8:Yf_5=O,e8&We;OdJ;,D].W8+.\]-QVAFfXDL64W
AL/P#A>LfaG\OZSXS/B,bB_^ZX4J9][-AE8(H(M[?RZ,e4W6P#8cG+,[AX6AR2HL
R1OY=RP9(T[^RTBePAd9.J8\)F^K74f1)f?&COPW5.VJJB#5RBL)S^ZT>T1-gB?_
c19c),IEYJH]?Z?S2S/&Z->bX0)WOZ_X<-./J\S(S3ZJ_&R,C=#R6?,AL2:R7(&Q
KbDIOfH5Y#52:)?FI7IP+ZBG=5gX,WY:YF+_)(TXc;K(HK,aMSP/IS=1].Hd2.1F
,\UT<T>RfUA]ZfM[Z[KP_3)S;0?(?N.][XND1O2==D\B=LOJAQB\\,[I(aO0d[5[
d]U2bc2F;N<[UI>;^Q]Sa7=E_SX@]D-;<B#XC8P<TEXRWd]/#A-B>B<RDHd-D9R_
,c=HL3.<0dP))Hb,>?,Ob8:O^<]#YVBXO4a2[YG=#0C>9@X/MRATTZ-IQc:6c6c9
#^b^@-Lf)4GBabfBfF08Z.^4-SUCL_]0Q/PQ1(J)DJcd>d6E=Ve:<b@8N?\B,?YB
G1/f+f-F-:V^d;I>ADL[?O:AZ(dYZPV^9)7YN#HP6VV:-F)1IGggX,F0fMPEeH3K
28EJ,=0^_2ALRLZXAL6ARB@6WW+.0#K?b6e\UJdS<>@^(7QZ>:.H<.Ue/C(M0?XS
<H3)a9QN,g^8DeM;6>FL&8YG:E;g+/N?(T<HW63H3Y_26NTLECE]N8JZ,QT@W42Q
9,PM1NbD)?V.,?UK,62K#+5J[XU4FJI><OY>RLGQ@Z0.3\UB<<))EOY3e8?^>Qa:
Q&=YX<J^T5)<IWK0B2^-BZf+c89].G.B?Zd/9X</Y^N(UED84a9[fV>W(d1H/NH_
?GS:R0U,LS_QML4<0c6-+]_=LW]>V4];1ZDfT)aC4)QK6)UC&\70:Nc/JYPZ577c
N/fT07.?9JK8^XRV2&[UP2gb>G=3)08N9ZU&]B2(>d.4c4>9TdfE]0QQGP_<W2QS
b3_A+OfJH5D[@\D1dX<NeV/5V0Jg91>9&H+(GC2@;F6JO\0IgW(d:IRE57AZDUPb
f5Q1W\CWG0FTEaLe\+6H_F&EM@0+=P:H.cb[>&;QTWf/&cNLf?-FB8#:,.;]-+A,
92XNII31.WO\_D=23XLZ2Rd+-EALGcB7S2G2]g0Q#1K3/F3-6(]M.<a&f&1,/a8;
H=9#^CQJIHP4/5]>gbdcW080;gIY;<LV/2d_RBK]P8M+L-d^X@M#]-SH-4^4fIVF
VbAffG2JZ.3,ZKaE(RN0WQ+0MTa/D6&1VQLD)LM0&;5g7[QW-Y33HV+X,:ddX>+/
/YU;G46C<O1I/^fT6H.[^<OO4=J2S<?W\4L;77DFYb#3df6R5SEGPWX<O?MK7+?+
B/W>G[.[Y+dMB7X0,S@>KUE]D__B>\G0aJWK)f[A1.TT[<AC13_68f63:EJBRgLF
aFQX?beD3F>I[:[L5GbO1B_R)(,>^debZ/7],IG=90E1T+dYS12FZJ&-K<NbFP/1
d32+X8@6?7BY0DMe#/>bNc;-R<aF0I1&;R?=I7G[:a+9X.5U<MAOHf[;X_b/=M:?
^;4BS:P<BX:&OER-_gC-8U2?S9VJ&HKdG9/^,ZN<-?4C>0A0._GP416V7#\C;T/2
S&RR&X7+1-](KaJ-28[b:9CD]BJ<WBY,0Ae&@LUd/<f:F?&T=0XTDGON,2ME<)V2
BRa5GIAE-L@;B==dU5,<g89TYCS9K/M&.eT(-H^WBAHIW>a#4VY+,3?79C7+2M60
P/_+;;=?MV@Y3FMc3.[aQD39<(ODc&=7D3ZfBI,AU6D(V)D#HJPXXaFCaQ;YGd)8
HFOH?-REP-MZd<Qf5#TCfbK[DG;D?5Bf&+:FM0;2a]gf>&V/(OPL==?ceMCf\0YC
]]7(W;S5NKdMSG)T>I]+#b^NMa4LU=;?5M7)^_4>B\S:ef7T>T<]:6QR[8BSB?^H
^@4=d<6-8G&#aOF\CWVVa+9Hg-:c3\RaZ2_)]GcGQ;(][d-J.7>6X]PB82[f4CO:
8=;):XN4-XgIN8X<K1+5;F._YS-04KC8RX(06\5P>L_cB00+92M[](ZSc)ZMK1I>
)MSc@W]LLg1d63]N#Mg?;:=R2FDV,)WU19Y1(PS3\Q^N+f5H;8T^/V]<WC-RG,Cf
/=-R;:T6aM2I:<e(R6QWUCVEQ2D<R/C3aS/L@)U,?0:#?9d-@M.b[/KJIc589I0b
F4>bQ,^U/QFJ.3XS\5+W;MUNIL6P+43F,NXL.V(S8bTDe7V(:GN6]@\:f:F27T^Q
+U_?AH_\X9cQ\0_19R<aeZWf(_T\bS#+bH0SYK?ebI<c4RG8Y,?#fJF+;]FF1+45
UN@:#(BK08WgJMSMe=VR0ZPVJ((N@L<2T5+?IfM81OPcV@3==KG;U#\K79_98M#?
=d2W=5Eg;NU[7d.U;RdF057DJ&XR&f@>cH8=AfD6Na@B+JNZc/YfbH\T@KIH,(P<
MS)fC->10G4,H_0KfgKW_)T8IP/<U.GXL[KRK1g2KKFWD(I[59a;\L7Y/=R\[5-=
C@cfN,F]]YefNI?]L^,@U><WJ;-;Ag0CNb692^AY&g,@&@(ZFHO1@SCEC00_c4V_
TYH6e,9a.AKLME<K\I^L_M_MbX[HVL49SJCL+K7PVB4?/NGf@M;Z_EF?gI=^LVCd
4ISV0H>d#BMe\bJ\3MMR>GU7C2<Pd?VVaDN#D[HW7II=6KNDMDZGF1E]NBEDf;cW
EOXd9Q-#SI8DN5/G4Vc;S4_)O9]42,)UYJS]O;;<>IbB>O6\EL5VDGM#[9LaLIE5
?EH7X4IQT:Y[NR<bN:fcWBK.XR3_3a5M.bC_2G^9+VPNMDRdd@,(>HB44\8:UZK,
E(b#2XK\Z,(R#2AcTf/^:]#5Jcg>^R6B;1UW04WSOe4ZbdIY?T-:#<R9-<N]_6;a
2aceQLfSSg&RHY>\O3BFdJg9?L]Ca^+>g:\PSBXW;e-30FJV\Ia),<@\+59Nf1e3
/IC/&F+JcBQ=?UQ277Pa2@d/(,D8fgMPE#_W>AW;M\eCL_R>SU)g0PK:(?K;3>.f
\-JB)LYEJRLa=CNIg.SV(_fBPe[C,T=+d>GXGCJYe5TA<cdP&-HDf=2>=A<1.S3B
)+&,2BLWBZ#cGBcR_JQ,LZ52KgT1L5197/C[23E^UUXN_6J\A,Y7Dc-WcR;^KBf]
Z2:_&=KHF#/@2+:=AMLSJ9Sa8AR;H[eNOc)6.UcA;g_J&\U1A+A[c?a5_NB6(6]Z
MZL/e0E0#E?6(I+QD+@=-2>26d)M=BZ)O2??-Ua_H#44<c&^JT=2R-)P>0-H(X)c
^V-J9N=Dc9_S_E2QD]^SY9d).PbM(ZI<]:RULKO73X<eC-.2VS<G,VN^\&D5BL/X
G1Z[Hd6]82/WZ06JA?f_IHd)1$
`endprotected


// synopsys translate_on

endmodule
