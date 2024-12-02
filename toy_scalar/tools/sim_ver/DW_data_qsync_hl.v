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
// AUTHOR:    "Bruce Dean May 25 2006"     
//
// VERSION:   "Simulation verilog"
//
// DesignWare_version: 71b06b2f
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//
//
//  ABSTRACT:  
//
//             Parameters:     Valid Values
//             ==========      ============
//             width           1 to 1024      8
//             clk_ratio       2 to 1024      2
//             reg_data_s      0 to 1         1
//             reg_data_d      0 to 1         1
//             tst_mode        0 to 2         0
//
//
//             Input Ports:    Size    Description
//             ===========     ====    ===========
//             clk_s            1        Source clock
//             rst_s_n          1        Source domain asynch. reset (active low)
//             init_s_n         1        Source domain synch. reset (active low)
//             send_s           1        Source domain send request input
//             data_s           width    Source domain send data input
//             clk_d            1        Destination clock
//             rst_d_n          1        Destination domain asynch. reset (active low)
//             init_d_n         1        Destination domain synch. reset (active low)
//             test             1        Scan test mode select input
//
//
//             Output Ports    Size    Description
//             ============    ====    ===========
//             data_d          width    Destination domain data output
//             data_avail_d    1        Destination domain data update output
//
//
//
//
//
//  MODIFIED:
//
//  10/01/15 RJK  Updated for compatible with VCS NLP flow
//

`ifdef UPF_POWER_AWARE
`protected
GM3<FZP0R/NQ5)=?(I5#ZC1(A31fOF0H[:NTgG2,[5IV3<RNO,TC()?SbA^_&9:g
Oc12Id[f]UKG:EZ&af)U+ZfO@fKLKR4=N?(Kf0VX4KP,T+_gcDBUSJ3#:FL0QE)X
cKG[;eCD^Q./dTTNMbM^B2F(?C[a6[2Ka6Y0NLS@G,Z\cD/=2(+VM:bR1IF;Raef
4)4HVP-ZCDT0dHD=2L3Q^4P45H7RI0/\/>-,5GX/bMWRV(eP2JOLRHOLN+G6cCG3
#ESVPEQeD7(/fH-B&A,f:)_V,L4S-A#7WSOP?L(9J(e>ZZaA]L:3F]2GBJLKM0_X
@gKP4OONFg8bf@66<FK1?KgNMLAQTOJOd;Q.(7>1I.#]Q7-9LB>STFUTJU+XQ\+[
WgK4.KT=M5Af2:@/fg1FJ:bg6-D27:=a</.Fc[<@eE43LI135J6eV:aXZgE]QEYE
OP0K\N?8db&J]Q0D]3aM9.N-KPV&QGOZR4;F(#1cDSQKJaQc_VT,)0L(H]]eK1HU
Z>)0YPUPbV:4&KVK-dJE7I_S;),T/IF4.9f6&-20@V\[c@F8aB)72\7YZdZ75Hb?
b(&U1GRR8DNgS??QSSNW>J1[AR;I?aUK[M=7@2F+5/e?0dA39RY-<cU,H9?+(7WA
bZX8eCQT_If&CcdQ+J7673I-0LYg+>MR__L58fMMT452PFfd]@4,dZ)/7AgfDBf?
b]?&WL7Sf_/,AJfe+a>)-2=P75dKLA?c73d,;EV&6Jbd4g^?J[8D?]P)]H;<ETeN
>C1H=99H9P^KAaQ<1HbMCMN0R[H7BLV[,>He#QXcQ.QX9-L/.&[ZbfGfRU9AgS64
VHLDH^VH5]JO;Q&g>GHJ)dE7X)S/PV66\e#d^g>R_4<9L1659+Od9[Z5dF8IPg/a
Za]2QdHB&RA80HAC0.fY0\(4UUK9&6-4)Y7c;&I@O,;g.b9#/ZSV5Q&L5/(A2]);
8:cfT6-P<0B>-gcJ8[#P2XL?BE)CL)afQ^;W0?6^0J9d:(W6.49&A7N>OU4Y.H0A
3Wg1WKB5HERaFI-Db35QTH]U3MZ&8=STDZ3);3cdaf8B0AAScHQMN1X,ODRC3]XT
Dd[-Y@3JWGeA:G#^NX1FOFJ,<>KQ_c:\7RDWV-S[VHXUA7C2da.:7#HB:]N6U[>8
WAH5-I@MQPEW<Y7DWCAX6aP@AGY]QHI/Bc-&>SY?^)S;f>e51+[K#-@^;eHA/Y=?
AF;P<OCB<[0_@-cRY.2_J]0)^6B4LIN76=Q:/&N&L_+/X:ZY8-N6]g?CZc?GW&_B
<3.(4\D?3b0=YPCUXZCD8c;#>eJIRH9?C^5XX?EY@U?/_[f.+R_#FbH2BR&J-bfa
+N1]14Q@4@FgH_L8-KP8Df8)?>+8R90gI+^.a4^<c(3KGfO6<_,.2Z/BLK_^GaH^
DITcMPEI9XXZ+5O5?gf^Xe7DAc7\JK?]JUX^?e7VD>((bAIH.33L1=06G=V<e9aP
Z47S]N3gEC=K,?XK(O#CF=-U2(7.[ILa1Xf7g0N\H)F\a];((5_<@P[R,dP;VXL^
CWW7:RG@>5TWb1]_[1Hb7?<;>g7gdCK0M#fF>4OeKVSADfKN#KcSa0J^H,O\Wg1S
/#NY^-P#7W\DM8GJ(_D_37bXKOe^bEgD7:9:B8/#(KP#E2.RZ@LbFT0.TM>-WGN5
#7IEGL&<1d605#X6;gXH#8AaXMYID9M@Ma(E6;1e=ddKUUQ]TK92UeDW)J-P&L4C
L)=[_71_X^ISg0ICH<.I6GdZS)28LCK/cFC4C\DOY4=@0=I1#]egP89PN4.\ePe]
FYWGM>2G+.G7-6e>M4,d&3I,4&<8:K49MSA20^(6;=A]DI_TeNYVKQ;EZM>)9.KC
&5g?<>cbBeUPSAO,S26TfT\QJb)dfW9P6Ea[Tga2D__8H?MbaP2GPdX7S,1Vbb2e
7]5.MFVc0@^#G_AIg:fA^;+:_5BR7>KNX+c8(0#4[UP\Tf0QGQDLJ8T1c[ZL#9UQ
D.+FY_-fY1&.(Y4]4#ED9K-W:Z_/OLM\38L=[,ec]@eO99U2:gFF/Q0PQWX1aVUP
H]#VY48Y8M:R)9QT1/2S+-ZN13<G9.]eVIAD8OWZ;H[Y699N4?fOM2Ie9egI8\X1
I2(8==Tc;&GJ0NN&X#9:925U@U-aNL0Y5O+GI7=@B1HNDXe_OGO\K_K+BQWWRL)-
?KZ-=TUR(ULUNfaR/Ja4VO2_a2U#2HR=<9+63b^6LgX,KGUa;L0^R.3M]914BF0b
MOTU7bc^T=5/6d5^.Y6^7Z)]MIVJG,E[7,I.gf-,-(U/I5GeMPaNaK:0.T]C7J\3
RWZ:aP:Ufg>H_W/F5D/J./Qb&>?U7#.KD#Y?_;LP^ONW;JN>QeJ7NARP?EI7+65=
dP8WH8,T;cQMTVQO]f)A\<A#L-e:aGP9^b0XHK:\f,C@)JW#eS-<<([+9e.3IV=\
QCWZ?PM)RZNH-/&M1d:A.\Y&CT:9_dbB9R_XO]8Q1ELK]&-2-4aI.R;?^RQ3K&>1
D>TR<[;fHb:?A/gYDGF)K@ZT:aH5ARaO9,9[@b2XHV0HaAVI]YZIC]<2/;J0dP[7
<-[OeFD91QC,K:R4aF>)DI\P)DS-+Q&cYGV<B?4:3Wb>,M29XeP.Pa.JXP09f(3K
R)5;dg3&5QNCF-#=C\0B:MTTc\#?I7[N;4X@R6JYBFGIZZ7L3H@14W/Zc97#3J^B
9Qb6(0F>)bD&/;UOe(cF2:-6@6<61c0U1E0--bPUE3=49SM[]X<5E4Fd5fZ@]<Z0
fTeR##Y\g[7Y^Qb->.g.<eWPPXDB0]RD-f^K+bgQG>a[gJU/b)@_X-HCBZ1>eL<W
5V#-R;>JA_aC4bN)()eVN62K3_8Uc?&THO/Y86VI_U#_,HN2a+PEI0?BO4GK_A,>
J3,[ZPG)F]=YDa]EgWZD18GH7DHH1VMb87d\^>:U-<=e1C@adN3\W06<@Z.RXIL<
89bNWNYYCE[d?B3[+A8Jg30J9-/P?IQMM14A_JM(4dFPI;/.gUd<U_B(Kf:579f4
=N6a8>1.bEDRYcO.#TcW)V<Cb(a3/B,6\9f&;MLU?4HRLO)X3:,S(?Oc,/g2:?:a
HaEgO-F;Y:gM=4#WZfd6:8DI@-,CRBb0_aPKC_1<E+D/9-08d;Z6eTX3QBVSF>+>
;f>Q6B:KK(ZQ+<8:WP8;:cVA>YDcWHXCXQB[^MT-C)\JKSX8#(J1,6?9-Y#(YdE-
0L/+BEKI;\A[YRM>afMG#K_(gV1#4#]b,,ZY;4S4)9gFWU,LC,8Rc,Z&B-CDZEC8
?;+&Hf-SNWPefP.YJTc041\WWb5;+TI<^]OXR-1AI7KfM=085R./R8PS:[=]8HG5
/(2A/Hc:9WAAe@G+Y@6YO.#70J=^/A1L;L_<Lf,4&:>gC#>cTHG6[TGE_X^C4#YV
HIg[13O>YSG1)/3C92X]fFOQ(K<EX_T##aNMM\2O.BJMJ1#AOf0K^@N^1^a2#PCV
YK3@1G^N(5Qd0(c\@EV=C3QL-KK<KKPXBJ??(H[a;S=SL[OOUf^@AKI]+Lc0c-c=
CTZDQ]61cCJFW-GIC2IDORHJ<0d.Q.[;g.6e_T=E\@IbKBZdS](PH6IB+K=:-6[4
#<SOB\fCKR/:Q/8O1DP90U;4B2O51&]B\S+.7>](6N=PB&R/7N/M.1CG2HV,2;-.
gM.VE&f3^?U;IP-_3^@7Q],^7=;))YQIZGaT3</?/:c_;_D,PEL:A4:VZTU=OLAS
?;XTbGF?&^@&dd>.<a<P#]3IGb.OLIg.6_b;d;cU(QS:W3QC@&,IQARIRKb-EecP
P2G5J2_0EPAW>1)8&>RbU.9=\MMgE0BT</6Y@QdF:6DF>#LNHW&fRge?RGZA.BGT
9LP9;H]K=_QZ830(DD_OCDc:d]0KBS7D,WF)C9Ic?bK?)^EGbN[A64+T;T:6>0&#
@g<FY[Lc_LD6RIY?GUg+-/JZdXL9&IK^J)?bICVP:7@V#5&gf8<D0WJNVI@6SI19
P4,?[TF_C[A9@H/_CS(Fa[(ETLWc\\/+Z\#B;ANZ?bO(D?K.,VK0c(Cg_5U6+@[V
#HcaCYEE&HQ-U206C,8)V^+Xc[9:;f8TA8_;4]XE4,23Zbg;;Z7IeUVf6IG?WW_Q
(&92UegZBFgE7c+^eP.?aM1BVYQa>BX8W4JB^83-\AW/DYYJ>0GHHb>c[0YcP^TN
Xf[LLYK9P7>OM9Z>6Ug)WBeQB9MO/>:5).Z05[aJ68a05S]e[^S,S=/[S<_VeVOL
Q3V/6C0(MR^0E9R<4)@1M=]a/dX]549C-HY?JVO.V-L?QDIDZ.F.G?\D:5M37P:A
PCOe(K8\.QJ_EZ>&^@L1c<\8e](>U/,V)DJEXC.b>#OD57AVW1_YQT7I@&#>c?UC
T,A:?^>#EY&TA6@.-2c7g>eT5<9R9]_A[/FB229d?]0FaY.0&^0XGT2DJG:EQbfB
9S9ea]9-RE1H=(F5&4[]aH-U9OX<F/(@C44LE]48;PX9J/44)MfG1F=0X.>(.)07
XeU9<B.VeL;\5^VBa;;ARRb+U@O;bH5H,/4/V+@gV]AZ+X2+9?-G3Z[fBeTNTG=N
PO8\;Xe8UaIcIVg,\BU&N&?>@?Q2QJG?L4<+[0#)):c8Mcg5GKMR-OC909/3Z-K?
#JO^&.JIFXK_e?fHdbRSL]<BX#ZV29O\+8e#8K\<.TAMg1G05NbMa7<#WVS=NWT@
7/eL8]E.H.GD#CgW-bLJ[R9@T)03H#DOE#AO:@acea]HTH^;Hc^Q@QD:f9;_C[3G
W(Pee/UZI3gLFN/+Mf+APbgD.f(8g)ABebc7BHYL8Q3QFYEd;C]Y-OOXg9904)W;
4g30YEF2R<QT=D)#O;KMGHU]>6cT(\<+?J9a?NNcY^QW#ZVS&Z<g#0L9Y94H:P-C
b<EF23)65QVIa7.Dc[52CWeG_D1dMOV40MM2g4/K:U,<XKF.B27?REJ+B586F0Pf
d9&W>d#=ZTTCWYFVLRM]9M.O=#FQ?6&S?9>52E6,:;B/O3[?ZZ1RB;.78@>g6N,e
BK-=dV)>/?DHEGW-bdS>e\f6Yb(FF^acC#<7/)f77WXLeT^GJT[FL<.:>3/8B4Nc
0AP(/>+@#.^,47YgA(C@ED/K)2/XCFd>8R:=<_<g2MI1N?[:@fX=0^#[eP0([^^^
Zb=POY]>E:-/U/((?+3AC>1)8+MGS7W3<R6;RN3Pg4:BW:0(1^3WH4Y+3\0IS;[#
^UK6<HPb7eec:39I;186TGUJ,;]_)9/aGBAX[LZ=D:J=B;7[:N5K]]Q9fOYa/0?O
bd6MRb@5)#-^>ZP[5c@d-BSMP?O[QS?c#gIJYBDQ.BK2Qa\2PBdRQN#6>6:#KaVR
;U,3DSf&-W)c1=(H1WU]BPO1c_OO_=g5b_9U4@b+V=)&&8H,XT>>ac6aF[7#/5DH
&92f.ULWZ.Y7^Q+K)WX_-=aZC)[3a(gg>=]A2/Y<Y372WJ=D-?4fP0XM6bCcT-:?
Y9591AP-[HVS#A&+a,I[TNHLQHH#Kg@F81JOK#:P06X_\R(-#830)1BVLVM;5^JJ
^)].O4L&Q?7D[I9LI?)9Y9&+BJ5BU;48RO?(<^+6K:V/#eR<QDB,S-SLYV78P.12
ge3559\24b\g+NP3a]_3:=e^aPEH#0W/^RPH8TfF]BdQCT=6/\66F>T+Oe+H2+Z9
/V-ZD=//.Pb8P5DVO\EI+;@3Cc66<C3M1@QWZ[gQ@6)TAITA[OTQO:@@[bNE]\[>
?33FYMK,J;[Q#C1Wf0AY4BXOY&TD#W5YQ(fKR,e^H#N676G;=-74[C4+&Q-M\N3(
7GXb2PFIC@FL^4J^^T2PTDT)\HQUA4K3M&/ZKA9>:eH-UC]1FJ;FNCeN^;A@3FPV
L:?^cWLN-]/&P]@-T+4b?OPJb;MF29b3^JRAe&),;WAAA@ZF4FVQHAF-#b;2gP&]
SaE,LV<b4ea1=Z(+<4IS.7\W;9@9fO#QL[)658dgSS@&2=fF<FT7bR;V=1;DXdA?
B&L,MB7/d\gOB]8(:TM_@;\S6[QOFR5f+Z_<5=9O0?eD+I\_HE[3W/:]0Lg&(RG0
1GT,^]BdIX8O3Z>44R\RFe._Tf[>7)dW9B(7BGK7/Y4\)8M87#<WLeRQ?Yc3B0b^
aI+g:U-I,>BU5GR,#a^U5g<6[A?ISS8E;<P;S:1=>I#G/GGE:g^dg37YWC;g--49
Uf,9e.Jb=9#PI)I<E<Y_64\3M80:Y[GZ(Z1aCCDGVVR\^Y7g3<H>N)R?/+55@XZD
NA6R92>/4W.M((8c,R]eYQ,X>bff_bXJaM)L>)E&S3E>#(eA&)EBaff6_W&JK?RI
0H+CLCM<2OX\G2FREN[UCCX?=[DK^HKHN9aF5:S_WbBbRC0J;K]6Y?<RW=M(TGOT
[RX?F/>:]/N8N<:Y]C3G45\aX<:JQB)5UBO\94XVR.gJQc2YS,bW:^W0=bTg.AG/
1PM:4.<J)8#-36-?7H,3/7^g&?&#ZYgNY6XO>-C]Y\HI=WRJSX@;&#WG)JXP;0F=
Q/&Q?M).64Y[F4OeDf^\X;I;OJ5=)E#c2=H-[#e6Y6779N-Q<9BGI8<&CJ7KgPE9
0#6>Xe/;.PSPFcT=dU\O(=>L\\gQ;c?I=f95\WI0W/IAY5,O/FN=/J-fPbB+/MAJ
\6gF&0fM4=]D0S+_P3#9)?0L(7&[N@X2X&Zea]@/N]?&T296)<K)9gW[7C1FV#L7
a:gA,3])d,?M[<gf(>52LF>U<9N-.UJ:Z8f8NDE2N+QXFE4X9[YLD7@;fH/M)H9f
f6gR.,KbP.-XNSJ8Y;,U.&S;\6PTPW=J;,?LO\O@Z27Y+VH/gED7#EGbVYDKPE).
bJKL.)D1MD.E.IKO>5UTKg1&DAe4gf\NSGCA4^NRf+&M[,TP,g]+C&Y)L_6OF7c=
Q<fZCUMT_X08H28T4(F@D231E88?:,I.&:+d+7S7W),gb(D8^c4L1@-cccZY>-_+
Zf0A9#6Q9AT[g\GLfG9ZO\3EIXNL[/7[bb^5a+3#]a=BfI<dKeSY-eI7X-ILY6(;
/\,Z);R=Yc?#a@=PTcc[]C_-PYK.A#SJ.2EB+E3,bV4;-=c=Dd?\0,cGPM,K>=QG
e\gcWKU#DFB1K&DY@geaZ4P]gd@M3A?a8?fa?FYe8?,JA/?bK/S-aS)G4AM]?Q&S
Q@b(G7<Q<4AQC\BH135,@=\3N)6E,;f[B:[g-d&^(IK0A_1@gB.-IaTK(f:YM,aB
#@H:[d6)g/CUP=dG/HgJ+;PP(NL8f(9H:W&0KUWJdGLY2[@E?T]OAH.;Z,-CRHI,
DAE^Lc[ac3@3cY9aI=<+N>J9[MN?74-9LgO2H61C1NJcZKE[CF@.RD/Nb<b3I8/3
K1J?O<e(HbR\FV-.gc5ON]I1RX8511a7M0Z78KF^J<NZ4TbRJE/MPJ<=dZ+L,98T
5+((-QTHc8a7]>JP;SCCWC+/HLKR]5IAfKO1B^dA>>S>P7=2K.a+Oc6a^??IM.ZS
OGMI0]-^LG]U)58/3M,R:f8fc99\0J5b-)Rd@ffD(/&8J(bd(dg17KC\aZ_#KD=U
QT\#<<7ZODc3L^V;HMePJ?P:^J6:MEGK[BR9D@QH<)>IGP3e:-5[VP;C0]\=\.9;
=c0(L)#\12K0XK-E].MCZPaFDFF58+=>GYM1^2T<@/T.5R&@IY9U_Y]G>R]ad\VM
N2LNS(UWc@-=T-f?8ZW<C4Ee<FI&IR.dKFbZ0&Q93fW3cIB86HVa=^]8U3I+aINS
<.Kg)6_b2QQV-e[E)/8Wg9ABbEZ]cV-ZgCCH4,G^YV\gfLMF^gc>Ba&KCH&G1O]1
@6d,Z87e+B6Ad1ddf#b/9f=cO.BDJd3[E3T0AA\FKY8UM6_dYE=6Q#=-.4^-8Zga
Id71Zd+(WR>COVPCL]D_](g3bG,H4=f]dHLgT34[IQNZF?I508SV(BTOXVW@+GA,
J_NJAgB@/-;#1HeP[-2g,SIa0LddKLA[eLDb)7-_W2>^:A5TU+/<.5/.H,0+C^Ld
3G;OgZ&(WRDU]#Ra3/&b;8EB?ZZ-ZDS7M?DSb[E+;<65g9TcaF-DNQ4cMG8.-_2L
DbC0cWJ=;X+.)d?0EEO\KMecE&C.ZUQ7R<b8DCC\OW>B6?X3Q/ISX-]/5\RdH73E
9IAF9HFFU>=PK28TZ.Ke/U53FP-P.Ne2\ObZ=aD57(=3-\B=^-(.\QY66^fEa>7A
g38M>4T+7<G5\FO&S_>\?G7KY[LL?7DL6#GPZaFZXM8U33+6IYb&3JNX[X=EZ#TK
W/8^(&>+HEcD#gF)D-fe8&]2A?g8M5LDYZOG=3UONW1OgL#I+?bGQcd6[QcBSR7W
26df1[31X/?E.7OgeD-3;5QACR.Aec,]b;X??<65NH,Le&Cg_3JM9DIA>0U)G:/_
W2C.N91VCe<;T99XEE-C.?fNM21Yg1V+,Q)E(/\9V2fA_,TJ1a7AY.eB0<5J:Q6Y
Ig]SVGX\ZdKb<Z-[YR=<b5+XHA.8;eX@8=7/b0ZE?a_QY;YbMIEY6XCSC#S^2<^;
<ON[c=.1AKB;8^^SETN4UZBSQ)?0O1)0BT&1bJ:GZ883X0X;aPTH9]:O&\+:5BOb
1E_&RNU._UK&)U9SRgZ&4Z>g[0J_W?9M,:^UWIHAPVCFe-\#ZQ&SU=aCHH2TE-+W
.WMW3OV\W=@CbKIDL0UMf_2<#N[)9+(;N]]K&8?&N&P(OO]d6\C<Hg8.>AH;a/b<
?/IBNJ4d?2R6DbSH9\^33LVLA>FI\ZK5a-&DaF0?c/&:D9/K.RP)a0<>/EIZ-df6
#:J#(-UWeR,g4/@63;U)/2eUPWY+W;P5P>?GBEYf:bWAK.O4E9&dJHKF+03#c@ZX
N-3&PIHN]#B\H,We+=GM6d]+D<HU6fGO=?QJU^942=CgIRN-a);))#3d?UN25R8+
cF4[dW/)G?JLX2f7a&Z,@^Cb_E9B6@Q@Q?Ic+FHb._gJU[Ga7b,Y3g0SHENEdV/]
O?b3A8G0g1J@H+(P/5&2.DA_&-<A?KUK68.=Z::gTB&8a.4H4K.N/]<3\OC3J8:U
AMOTMBD(O(=8+CdEBUFJ3M:=d1?QC>[e((CRQ_KU8QT7\V4?]?4IKK9&@>7#1K,J
:5<?,L]aC[.MA\GbINe87^e(NU(T=D33U14EgC-&_d1/I91>/SL)(EN2<aLOCaQ2
)/^\Y+:d55&>-K_&_[ZW89AEWLE1.KKb:KYUQ,OgOC]NaJ1(/-1#,AX<7-56/agf
Q;g\Dd(3\JUf5#QXEN&7L-F@MHC&He66=86Ge?KR,:DU7FB/L_6Bc8GG&(OXU@1,
b>+I<B4S+0+H\),Ydacab.TJPO^?9bc42cX0_(<8S1]FNP@Pf-<\S(LHaDL9>bU-
)X/a&T:42&Y>J\H]9(-N=KPG&;R^aR&+^e-bLHSQ=,RA_S)2#@QMa52dM<F1Y[S^
CU/DTXDCZD<bR2ee]Q)J+AAL)-TSQJ4YNS.I.X.4/Ka+TQ3c[D@[>;JTH6\J]OA5
-U0Pe9TPaO>U\M[T/D2@6;8BX?CA:9f=F@#a1;8bA](LX1;;c1VSFJZa[4_?-KJP
0)]7#_H.9c5DBJ^SA@\^^(,R1AIRgMO4@&-#7_eeB4=]I>bEDKB[EDI;<8@L)7_,
_Y_PCg@[aFH;0_RT#X=LJIG-;&@M4_E<b5db0DXOEH,E,N-=d&.;K<P<NfG-2C[8
gS#8E4BIM.ca9>SYd2JL0U_H6?)3g\YD?a<F,F:M0deg[>8TS,/e\b,5B<N/IE.L
8Q35?X@BJMSeNS9BZ@d(bUdHaYY[d3g&9N)d^UI>3KK@7YV2X,GD^f[L0J-gN]+M
V_NN3FXWA9YS4deA@-(AJ^RMHF^Z]HB#+8FER9&/\MS\H3W?9aBJ[Of@(\W/^MK?
9C_QbQ1=)18,24@Yb(QK@Q\IKJ7N&f?_7Dfb-BcFL;^VV7e^_-c4<C8)LWA@XP8R
O+6cPTgC^Z9G,K:#c&=6<3R-Z&e/Bd5bfOMT2(;M_L^VP_R>Z[fe0a&eRYBa\5Z]
U)?NG/KfbTBYY4Gd2]SA(-[G-3]8)Sb2#ZJSVdVEWDJ_eTXEg#.3aKYX?2I/-=WS
>6g^#(OL&N8^^M(M?>37A/bd_?8N=6^aR0F,\W&P5(a1bCC?d?d69@5Bg+I]M]Q(
4?Wcg[^Z&.e,Z<eCE69\/PH+UFBXV\EF4)N&b]@?bdgce_KFgT\g59Me;a;T5/SH
K8aO8]gZV+GPUWV4;3.7I?ZU@>KQ&gB-/PfEd+TdO_(a_8XL5/,J6[I6N?IXNUbA
)7]J+SN[^6X<,&I9MIb[(0Q=fE35=2+gaf>bHU9aM<b=5dA>5O:G2[1GRG][POGG
Z\VL)(/T/D4+8F-T>9Z?6P4CLCRZOETg=SIT^[d(D#5.I0Q<L&\)eDdKb[&ae3B9
W7&95EQ=P??;2dK//eO1O.CU&Z30^();1Wa8BW[#3,_@_RdZBe/=&Q>G5H0Z\JGQ
eA\(;<SW=#F;]Z=&)SKEd<D0/PSE78K6QIf>K:be>++U:7c2C#X)9EcI\?YUX/#+
M5ER22F&_41Y;XPV+=)6CSaZT;V_N<f#M5.>>6[aS5.DS>\^e;3F:]>,aC010<Wf
<3=XQ<=Bf+a2HBFR\0M[J(XJa4/C.^bBRU4>Ta+].,881Ic]J9E16TIY#TGZ/,XU
3?2>aMA6T=Z6Mfa_\X8g/Z:#0cGS:?9CQdD#CWG;Ua/>;JD[6:eN]X(8BA5BR;+1
EdR<<[+\G9B^g4c_ae=GS2JV[4LEV)229YNT.0D\7#6(7(L<[<I6a;aRG&7g&8Tb
:f65^VRSI2c0UC&W6PDRNY\R]#^#P#B(^M37)0QN+Fd+Y99B+.:E62fFK(Vdc7X,
9W@D(<6\:2b,QVe:eXE&RfKWXYdST\g\]9?gYYS)W=1CY<fdJ:2XHRM^4M8L.=:2
F,fD]T]9GP/V:R+R;0D\&0473IMIKGX]_+Wc8]IMT+75feSBe4Ac7c)g<BN?,7/V
LZ=5\ATR#.&PQg6P\V)SD,_QE]NKF31>36d0@I,17>^dQ&33_Ucd.K0;IWc2=P(^
^))59f#VFMZd>VFb]Y(62=>g7?CD@d9,cY@(XOf\5>?,H4I:,Z_=,12D?f\Ya5->
)UG46FK0^HGPQF#ae:cHD0/?bSe;Ba2+.fb.g-D[9eW,H$
`endprotected

`else

module DW_data_qsync_hl(
	clk_s,
	rst_s_n,
	init_s_n,
	send_s,
	data_s,
	clk_d,
	rst_d_n,
	init_d_n,
	data_avail_d,
	data_d,
	test
	);

  parameter integer width = 8;
  parameter integer clk_ratio = 2;
  parameter integer tst_mode = 0;

  input  clk_s;
  input  rst_s_n;
  input  init_s_n;
  input  send_s;
  input  [width-1:0] data_s;

  input  clk_d;
  input  rst_d_n;
  input  init_d_n;
  output data_avail_d ;
  output [width-1:0] data_d;

  input  test;
// synopsys translate_off
integer reset ;//        [4 : 0];// :="00001";
integer idle ;//         [4 : 0];// :="00010";
integer update_a ;//     [4 : 0];// :="00100";
integer update_b ;//     [4 : 0];// :="01000";
integer update_hold;//   [4 : 0];// :="10000";

reg    [width-1 : 0]  data_s_reg ; 
wire   [width-1 : 0]  data_s_mux ; 
reg    [4 : 0]  send_state ; 
reg    [4 : 0]  next_state ; 
reg     tmg_ref_data   ;
reg     tmg_ref_reg    ;
wire    tmg_ref_mux    ;
reg     tmg_ref_neg    ;
reg     tmg_ref_pos    ;
reg     tmg_ref_xi     ;
wire    tmg_ref_xo     ;
wire    tmg_ref_fb     ;
wire    tmg_ref_cc;
wire    tmg_ref_ccm;
reg     tmg_ref_l;
reg     data_s_l;
wire    data_avl_out   ;
reg     data_avail_r   ;
reg     data_avail_s   ;
wire    data_s_snd_en  ;
wire    data_s_reg_en  ;
reg    [width-1 : 0]  data_s_snd;
reg     send_s_en      ;
wire    data_m_sel     ;
wire    tmg_ref_fben   ;
reg     data_a_reg;
 
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
  
    if ( (width < 1) || (width > 1024) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter width (legal range: 1 to 1024)",
	width );
    end
  
    if ( (clk_ratio < 2) || (clk_ratio > 1024) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter clk_ratio (legal range: 2 to 1024)",
	clk_ratio );
    end
  
    if ( (tst_mode < 0) || (tst_mode > 2) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter tst_mode (legal range: 0 to 2)",
	tst_mode );
    end

    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 

  initial begin
    reset       <= 5'b00000;
    idle        <= 5'b00001;
    update_a    <= 5'b00010;
    update_b    <= 5'b00100;
    update_hold <= 5'b01000;
  end
  always @ ( clk_s or rst_s_n) begin : SRC_DM_SEQ_PROC
    if  (rst_s_n === 0) begin  
      data_s_reg   <= 0;
      data_s_snd   <= 0;
      send_state   <= 0;
      data_avail_r <= 0;
      tmg_ref_xi   <= 0;
      tmg_ref_reg  <= 0;
      tmg_ref_pos  <= 0;
      tmg_ref_neg  <= 0;
      data_a_reg   <= 0;
    end else if  (rst_s_n === 1) begin   
      if(clk_s === 1)  begin
        if ( init_s_n === 0) begin  
          data_s_reg   <= 0;
          data_s_snd   <= 0;
          send_state   <= 0;
          data_avail_r <= 0;
          tmg_ref_xi   <= 0;
          tmg_ref_reg  <= 0;
          tmg_ref_pos  <= 0;
          tmg_ref_neg  <= 0;
          data_a_reg   <= 0;
        end else if ( init_s_n === 1)   begin 
	  if(data_s_reg_en === 1)
            data_s_reg   <= data_s;
          if(data_s_snd_en === 1)
            data_s_snd   <= data_s_mux;
          send_state   <= next_state;
	  data_avail_r <= data_avl_out;
          tmg_ref_xi   <= tmg_ref_xo;
          tmg_ref_reg  <= tmg_ref_mux;
          tmg_ref_pos  <= tmg_ref_ccm;
          data_a_reg   <= data_avl_out;
        end else begin
          send_state   <= {width{1'bx}};
          data_s_reg   <= {width{1'bx}};
          data_s_snd   <= {width{1'bx}};
          data_avail_r <= 1'bx;
          tmg_ref_xi   <= 1'bx;
          tmg_ref_reg  <= 1'bx;
          tmg_ref_pos  <= 1'bx;
          tmg_ref_neg  <= 1'bx;
          data_a_reg   <= 1'bx;
	end
      end else if(clk_s === 0)  begin
        if ( init_s_n === 0)  
          tmg_ref_neg  <= 0;
        else if ( init_s_n === 1)   
          tmg_ref_neg  <= tmg_ref_ccm;
        else
          tmg_ref_neg  <= 1'bx;
      end else begin
        send_state   <= {width{1'bx}};
        data_s_reg   <= {width{1'bx}};
        data_s_snd   <= {width{1'bx}};
	data_avail_r <= 1'bx;
        tmg_ref_xi   <= 1'bx;
        tmg_ref_reg  <= 1'bx;
        tmg_ref_pos  <= 1'bx;
        tmg_ref_neg  <= 1'bx;
        data_a_reg   <= 1'bx;
      end
    end else begin
      send_state   <= {width{1'bx}};
      data_s_reg   <= {width{1'bx}};
      data_s_snd   <= {width{1'bx}};
      data_avail_r <= 1'bx;
      tmg_ref_xi   <= 1'bx;
      tmg_ref_reg  <= 1'bx;
      tmg_ref_pos  <= 1'bx;
      tmg_ref_neg  <= 1'bx;
      data_a_reg   <= 1'bx;
    end 
  end  

  always @ ( clk_d or rst_d_n) begin : DST_DM_POS_SEQ_PROC
    if (rst_d_n === 0 ) 
      tmg_ref_data <= 0;
    else if (rst_d_n === 1 ) begin  
      if(clk_d === 0)  begin
	tmg_ref_data <= tmg_ref_data;
      end else if(clk_d === 1) 
        if (init_d_n === 0 ) 
          tmg_ref_data <= 0;
        else if (init_d_n === 1 )
	  if(data_avail_r)  
            tmg_ref_data <= !  tmg_ref_data ;
	  else
	    tmg_ref_data <= tmg_ref_data;
	else
          tmg_ref_data <= 1'bx;
      else
        tmg_ref_data <= 1'bx;
    end else
      tmg_ref_data <= 1'bx;
  end
  
// latch is intentionally infered
// leda S_4C_R off
// leda DFT_021 off
  always @ (clk_s or tmg_ref_cc) begin : frwd_hold_latch_PROC
    if (clk_s == 1'b1) 
      tmg_ref_l <= tmg_ref_cc;
  end // frwd_hold_latch_PROC;
// leda DFT_021 on
// leda S_4C_R on

   always @ (send_state or send_s or tmg_ref_fb or clk_s ) begin : SRC_DM_COMB_PROC
    case (send_state) 
      reset : 
	next_state =  idle;
      idle : 
        if (send_s === 1) 
	  next_state =  update_a;
        else
	  next_state =  idle;
      update_a : 
        if(send_s === 1) 
	  next_state =  update_b;
        else
	  next_state =  update_hold;
      update_b : 
        if(tmg_ref_fb === 1 & send_s === 0) 
	  next_state =  update_hold;
        else
	  next_state =  update_b;
      update_hold : 
        if(send_s === 1 & tmg_ref_fb === 0) 
	  next_state =  update_b;
        else if(send_s === 1 & tmg_ref_fb === 1) 
	  next_state =  update_hold;
        else if(send_s === 0 & tmg_ref_fb ===1) 
	  next_state =  idle;
        else
	  next_state =  update_hold;
      default : next_state = reset;
    endcase
  end 
  assign data_avl_out   = next_state[1] | next_state[2] | next_state[3];
  assign tmg_ref_xo     = tmg_ref_reg ^  tmg_ref_mux;
  assign tmg_ref_fb     = tmg_ref_xo;//not (tmg_ref_xi | tmg_ref_xo) when clk_ratio = 3 else tmg_ref_xo;
  assign tmg_ref_mux    = clk_ratio === 2 ? tmg_ref_neg  : tmg_ref_pos ;
  assign tmg_ref_fben   = next_state[1] | next_state[2] | next_state[3];
  assign data_s_mux     = (data_m_sel === 1) ? data_s : data_s_reg;
  assign data_m_sel     = (send_state[0]  | (send_state[3] & data_s_snd_en)) ;
  assign data_s_reg_en  = (send_state[2] | (send_state[3] & !  tmg_ref_fb)) & send_s;
  assign data_s_snd_en  = (send_state[0] & send_s) | (send_state[2] & tmg_ref_fb) |
                          (send_state[3] & tmg_ref_fb & send_s);
  assign data_d         = data_s_snd;
  assign data_avail_d   = data_a_reg;
  assign tmg_ref_cc     = tmg_ref_data;
  assign tmg_ref_ccm    = ((clk_ratio > 2) & (test == 1'b1)) ?  tmg_ref_l: tmg_ref_cc;
  // synopsys translate_on
endmodule
`endif
