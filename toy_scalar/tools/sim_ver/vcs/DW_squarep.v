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
// AUTHOR:    Rick Kelly        5/17/99
//
// VERSION:   Verilog Simulation Architecture
//
// DesignWare_version: 549f426c
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//-----------------------------------------------------------------------------------
//
// ABSTRACT:  Integer Squarer, parital products
//
//    **** >>>>  NOTE:	This model is architecturally different
//			from the 'wall' implementation of DW_squarep
//			but will generate exactly the same result
//			once the two partial product outputs are
//			added together
//
// MODIFIED:
//              RPH         10/16/2002
//              Added parameter Chceking and added DC directives
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
//                  are such that allow simple sign extension when tc=1
//              2 - partially random CS output. MSB of either out0 or out1 always
//                  have a '0'. The patterns allow simple sign extension when tc=1.
//              3 - fully random CS output
//              Alex Tenca  12/08/2016
//              Tones down the warning message for the verif_en parameter
//              by recommending other values only when verif_en is 0 or 1
//
//		RJK 9/22/2021
//		Corrected coding of conditional suppression of warnings to
//		avoid semantic error when DW_SUPPRESS_WARN Verilog macro
//		is defined.  STAR 3884129
//------------------------------------------------------------------------------
//
module DW_squarep(a, tc, out0, out1);

   parameter integer width = 8;
   parameter integer verif_en = 2;

   input [width-1 : 0] a;
   input 	       tc;
   output [2*width-1 : 0] out0, out1;
  // synopsys translate_off
   

   wire  signed [width : 0] a_signed;
   wire  signed [(2*width)-1:0] square;
   wire  signed [(2*width)+1:0] square_ext;
   wire  [(2*width)-1:0]   out0_rnd_cs_l1, out1_rnd_cs_l1;
   wire  [(2*width)-1:0]   out0_rnd_cs_l2, out1_rnd_cs_l2;
   wire  [(2*width)-1:0]   out0_rnd_cs_full, out1_rnd_cs_full;
   wire  [(2*width)-1:0]   out_fixed_cs,out_rnd_cs_l1,out_rnd_cs_l2,out_rnd_cs_full;
   wire                    special_msb_pattern;


  //-------------------------------------------------------------------------
  // Parameter legality check
  //-------------------------------------------------------------------------

   
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
     
    if (width < 1) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter width (lower bound: 1)",
	width );
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
     if (verif_en < 2)
       $display("The simulation coverage of CS values is not the best when verif_en=%d !\nThe recommended value is 2 or 3.",verif_en);
   end // verif_en_warning
`endif

  //-----------------------------------------------------------------------------

`protected
R91_T1HP,RSbQ?V=U<..QJ]S[4[G5IK5O1?IV6>;LWM?NeGFEVA8/)P=DHdD)NF9
#0OXNG@<6S-G0XfR))E9Z2J&MZA<(&<.e).<BL#O^b;V?.C=J)0@M:TafWGaM-Mc
:8&\7OIC,Jc24,4a?D^MOBAXaR=<Nf,D&d[X4(,PR:61G=/8?FZBb^fbHcYXLGT3
R@_XU\gE<(L,1g>ITQ105>J_U2JgPQPFYA_R.@@6fOU0daCF&gX&00+\\B+B[5V3
HbF.MW+(LSHKLceZN_?V^];93\:Q/FN5\fGO3:gI4D)@Wb(M((<\[H0I9<XJ@>@g
e/MYRCZ\,5FK3b.fe]3f/0H=N5fAG^dK>8MFaZ_P)X0M5M&WOQYT.]UdZJHGaX37
0QH9NRE)VA39V25,X0_)5gE^6Uc@OTXXAL0&5-.=g4+=eQ(fF1SCPWdgWK(FFNab
.6KgeKQR&1dYOg;e/]##-<,C0KHf,>C;47&>B=,03AE?/,#.f)E&DR0#@U7]Ke/E
\3UQJJ4@/HRS>2TF-^=.bMU5#?X]32(P2f02.99,>U17ZM:-GYU96>a<g:H)F2VF
65g\##83--L)YBb0eXV^+]V68/S;.Y4USU=8MJ2K8He#Q#^0S-RT+Da:6;07CP;Z
UURb3;[W(-LPP--8>g_6Z2&;2<B)16&Pa::b:?3?1K17cZVFF)E.,Y<^;N7aAJ]g
(_fQW]5&5F&/.:]d-dOHWbcZN:g<G_&?/^FB)3L?DN-4d=RY8Q+3DCX&@:A1<KX/
?K]gcQ@Z(?9^.>R0V3fB7D^4,OP-:A05J=N7dE]+)+F]MX/G=\>958_5TBGS04CW
)2=2,caLHEQ8U=()[b9IUM81QdBZg?&6R2a9YP)H#2&+;G?ZV8b]QOM?4;0De724
,8IJcU@K)V81[1JH\KaR^;2cN&,UZ[.DedL,B@e8TdBG8@SBV]4ZVJ=.VA>PVR)7
a+/^fH&^I73Hb_@SKQFPTfE2=0M4=8X@#@8SbW>ea:AY]U5A#?\(EKa9=M;cJ1A?
78g=dW7eK.:&bSb190fc/GC(4DG90Z3,:@)f0Jd(:Ja5PVDCIUZVgSdMB<8Z3=73
S?.)]YLLL3TS217MCC9Pb#,YdSA<B=g9)cV.@DEFR1>Y[0Y/4@WTb_=C>#.DLARb
7a]93S@5UPK;3#_7G]&22A2YG7dA_;8aKZF/./-V,BH0g:1]EcHDeQB&T352B\D5
a+;T.(?LE&Pe+DD4DIgE]IaYEeK&@)TCVAJe]N@HF2:7b^e3S>#FNfLbU2BOYVR<
N>S)Y@9^^FHbed?:,Ic=H/#.;,KM4I#5I985Mf\0K,SD[_+]JFNB3&[]##).,1S?
CYcY&G6YD]5_[1;gec;R196;\6[385VQH&DOX_6GeF1U(835;8:-PU8WN??38W7#
:S9>8OG1TabfG?</KW1b;K^S/#/CQ^L]:=1<EcES,Cd(H6b_-Y&+:;f3c>T4OA;7
a8dVZ/Z#Y3C4Kd9S+#UTD1JO_V[(Y#SI6B\XEa)<50(CG2JWCZb/YMNO21.YTDJA
G5g()V>14<VQ;CN.f5233VGRHUXCZJH&W_QNS7839)@_.FXH\dEc-F&UK2a,Zb2V
VG6??^@V)?C)6I2:>SZ3@7eSS;IDUYPa8M?6+=KGV9\c/8W?2?4/RFY)/1D0NY[4
-O7I104\#H.7D=3Z8?HdJERE,[U7-(HN&6OYTR4=e\?JP,V&TCJA6]^SNNU;W8J:
W5<Q(,LdI753..N]YSQ>X67Z9LX,4Uf9)JM?&IFZ+NF6DcPWX//(HO\cL0&TMOa_
/0\;8EE4-].8+7[W)W[]25b]4HZ/_L=45ed#/]J=PPZ784?=WZHLDP4Rc0dJHT#(
>2KHUbPVEK2@bA:g2aagJ.O<]J14d_[^>\,(@-2P:OAc:B;U1c\/;,SDC_06J?DI
^R?+a>ceRH,/7G7HQ[(f#<15f^)ea^(/8=dFg#Bf1)/=>0C3JA6^Z7?+/S&.I5,[
O_TX]5#[2TFB8/Q;@6gT>QRV:>aJR@=7=bN48^@NF.C3XcX/cQ7U;/.S,P96BH\P
;]HK98LC@,0gUC:TKG+O_NSa(5#FU,8CJA\Q>Da9+@J;eC<0b>8F]V:E]5Z]@fDW
L^0N5C;[].1<_5-?HPC+b,@bP^]33(=L9bg2D1RcAcMbKKQ+LZ97;b3NEfc2#5g=
Ka[TW:4Bggb([_@O-bMc7^-LE;Id[IF\:cBPS_4Z9?RI<;PGF&BHcQfDF#EO.^(g
0(>6=TL4&TG[).6IL#(T;60b?bRTWXX@0YbTbB&GfHdF9:5cL;1b]H>T5dJ>FdII
_##Vb[UWN(H1a<J)bJWNe5HO[/9ECD)P;BaAW&BL\&QR]<I;ZH[[,<I5_d^84)Td
)e0JZbSZG:?_;F@d?3cf21K&J3b_d3P?6+6X0aTPS>018@TTQ\,6<cHgDF#RAACS
?O?eZN/E7Z(C:YKC<)XW0<=S-7O#/@/RfEKf;TXNO.U>PO=L^@1dcG(Lbe0;NXgW
:K]FZV,Eg9:Fa.5WWRR&2+?HIB?7c&4G1AQ#??U459+Wa<2b;#8-4FLGW5aIPa[&
IV.HAa439@TSTYJ[2eKVSHPT3SY2#Re<R_+@5#_W8A_]:ZD7&2=G(:84;Y1^[?X]
<20c996fa]aE4L5SRC;S/bJP;#fT)^P+Y2Q)HQBENOWRe9b97XGGcPB:RMOBF9Tf
eI37N^79ZZBMMX4&2J]KY@B^^.C&<ge.+#UXR+cB&+=DaP(Wf4CWaH&<cRTT(\O)
(P\^fR:ZW^:TALcT(<P3ZW#Qg5:^4,7S/b+.1dfbQ#A2+Saf&:+\V9G,CD?9>gH&
D:+cI:S).#/D/ZX#1FX<E2N(VB,&8HI9?Z42]d2?X69\?HeB_A=KI/aUZ]O.gA^N
C/G7)YVT>/G(?LCCMC)WBNA6KW^c_75+P7Gef-=+WO9)f(;T3\-C>>1G)N8[\?]2
M2&JYR(T]If^NbR6M;2YR;_^2FO/b^Z(G\8XJO6+=562,D&IcgX/HG7:bFI0edL(
EDgUUDUC2P5/6E7EN5\AA,36?HN^W/Qbd.<&-::0C?Z>^Eg-,3IdNNJBPC(<.9f\
9@Cg\<Y6+fVT@a3(X)LNT:MQ/cZS16g&;)_>e1N(fU\Z)[^EFJH4d1H7M<)abD^6
AgT/\36BW@E@:OXba.:C?IU#4?.DI@d.1AbbA2&W2?Ba,gW&JV8^,HP(@OG_#gaB
-a1Rb&X<6&2RW>3Y;,&ZT@1OYgc[+#R6[C&#&:13f/TMFVN)9#IVK=EN@FIIP=Ne
ge3g4P0HTcCfKA7I)OadM\U/<3b\G7)c___/,?G1.1MHXY,aU<JC:^BHOe]Fff<8
[6DW;fg@G6VfMZWC@cGg]Q1S6(8U3.J]GfAH1AVWN_;5KM6<4;65XY;FVg9874IE
1XN2K,c2ZXBR>WZ/>HQ/0b=6/He1GY.4,>+K7LD7/_Bb+c;^R/BA0=[U\7:T6]>^
A1PCAbKBfF&gYV]_-2LDFN\3.3?]4_5L)Ba)82#O]]L]f<U?EQ,OE974.77QVM9[
(c_/CT<fWYRUCYUY.F-/72-;;L8VUF66&QdZLd-ET>g0_VZ]Ud+A##FMfD]cc1=e
@H0RaTN8Dd@)bB>\0C@/)Y_LU,4^)6Q1Q?3UET1bR&KFMUPQ=^S1VUI30-F.H;Ke
^MJ^Kg,2@94NUNI@MCe-4K+K=:g-W[4>P63&MV\;L3_-cN^fP&bL\Tg#AY+(43[3
(X+7.2:@AYC;3KP3e93Z3FX\YdSSDW4PH;Yc3L.O+.>300]\U;]:-8N&BW7^HcVS
+gBK;52^&.9SUcZ1\=M6JNRRK&)bEegM29,05ICa/cdd2X,Ob7M^;?gH+((Y_bSH
f;<f;8Q#_Fee\P92>:AacOTZLf10c-f<;SW)3043g3.@)[=T980YWUN0KG)#E31N
_#-1WXQ]fc73J^,Z:<3Y\;dd/RQ&[&UMJF\G-[dN.2PIf/J]-4EH=M-IW9+8If1F
):NMWg7Z7dISe>/^KS64EYF,aGe)64D_PJ?d)(#a+7ZC?8W[g-BM/6bGLTO(FEQe
5=W4GJ-0-.FQ9MKH.R2K4g+D<K=aTHLG-5#+dN&Je_#](@^>\;0:UcXYL7Y=62EM
W^/7X_925K?O)X-g;b3J11/Bf>U6dDd7/JD@N:8NG7KW:acNJJFJLE/\Vd@\PMUZ
\QT1FS]d]F9L&Q?LYB=F\e^0G50-9>\3DS?CgXe)20ZBHQJ14R<(?WMH9O0f8g3I
FEZ-/G8A@F3G,WT^R^R/4?^982?R5(K=>Y:33+6EENDYFT3/C]75O6+]I@C9BdPa
NIDY8aM-7F?4K3BY##[O9OS\8\5K8_/OXd)CDL(d4<3[Y,G,d3]eHYeG/]W.:QN2
RS5,#JbW(PRE.L27O73UBUA\bBY[0/X<P-E^Vb.J_?2N43?g/Z0VUX1?#EK1c7XB
:A_+C6M/[#a7CG+]([K9([5II,L#_,^67W&L5A4@f=>\KY6^d&_E17\,[@:[:NcT
e&8UY],ZX1/V_;+(6Y2I?NBJJEY\[^M]VC?<>ObL<>D(C8C<<V97T;@6Zb)\bc-4
OdW91ZeRf]=E3(EbA0AIGU+ddC(bHTJ@)CMdF4@)-R]&dG45Mc5OI@aQId_LE3gW
c;+5c_S4;aPK=J;5cgHO[R=9E?2dZP==d)V)]\4/#<V&EC:;6+29;U&2))T5<;=7
\&TfNfdM69L)0SG\O9gC2Ob2X;<53X^DL>JT,7M4V]e\g/eUMQC/B5ad0Zca672=
3+.@_-/)D\=1J1\\EX(6K9]X=]_dEG&dUdEa5N5^<gBUA1^&aKXHP;F>GH,Y?f;W
5&(OY/ae;0-[3MSA_\7a7;Q;IBc#0JQ4M=L)a(bNOYQ>+M472NVY+AGQ];9-9[G+
@X@U&PNM(,5Yg99;9Ge]d3G-C+TePCI?LMF^_G0I+]VF.g83c\UXd4C,-QITPXfX
\d]?4MTV&E?EdFcDGY66(Pe1I,5(_F24FOF/6SL^:MY<gGD(7fDe(?0AfILS3NEU
H&J,#d>KCA@YHd22(3bOWJab5N3I;8bQ6A+W4__SP+_<].M)]b7b3P[-9/&\6CS0
4=L?65Z+)JK5Y2+:7M_VFF\S@=+22V>YP(@eN/C:VIR\MX@N.UeRfVd4,;6L[d4]
_JgJ<g=7dP6Q_YW7J,e=]#c)bV41.PAGT)YZES@>c_8OQS.J9Y^EXWEbgdAeON/L
DHY@R0@,Y#7+dRHF/,;#;&>cc^\?0=9A=\:4(/U@LH<(eZS=7g<d:.Y94e9b]@_Q
?Y=9eb]C2Cf^@J]e:J7cFcW+83=5^:)Q99I3_@IA<?&KOJICT_,9\?.U++4BS6LG
DCSe7&Z/Ac4Y75K9e]3B8>b@N/P;P@QF2U<9YEL/4IGcQddBLC?d18Q1Jg>/gFOc
>QNK)I8ME9Jf+O/b=ZGMOFT.\deV+6I)ZL2Z=)gIbgOf/7A7(+bM)bZ7LBYSeL>-
UYGY6:,@,Wg[ZR32;ggF^2fTK,U9,ZNG6WXLV?Z#H\/RbdU;TFVY9VO4\JP#Q[QN
bHHfUKWH?9(b,C<D#?>fCELF5.V4OL)Mb#DKS5IPXEU?Uec89/&K6&\:G]MB,N;Y
?]Q0XW57>(f]>ZP^C)O11dYI?ZG8X7I).gRbgFg;#.:YZC2M2W(/g?CbYc5UY/Y)
(IR@bMMLAd_Z)09S=ASY9OGI3c-3<.6:?\7be@215-<W64CVaXg,S[<=Y?4b5DR5
?T3PCMA@adPPFB\V9K)G:HM/UO9T9?c>.7;Gc:E@1YP(:d=#3;C=#=Yb-Y0e&a4S
>UXYQ\BUa&.-.3?KW9RFGeIZ5V6_EDd8CH&C->d1[afL56LG?NHe/E=OI\e#bEdJ
3#&c8b8W&=]4D#B.f7(]g\ga7=MC,@^#;)C6(BG/.dbXdd<H799RAV[C=YdZ=+c1
]eVC@>Zg?/PJGWCS+aI1&9/_\>KH)g(fM9)E17S-d&HW3Kb<AP9dINO,=W9g^e0f
aeV5Bb^NSZZ54d0GBWdAI9?d3gMf@WN1/#d#KQ?<H3B7N#OZ?b6Zg+K&[L0SN&:H
,V0gX<O=K)+?[NeY#79ZPE</L>;ZLF?9gO/160_.;Nc[+>;TAAbDQ3\A\E8R_+4T
Y&,L2P]TKaG99#AY_M:9L+=8E?-X=\^aF=9HQGVGR7]D#ZNfQZd4H[4^3_bE7/,3
5=?Q@[=BcbRe&^VLI.gP.F,SKF#NN\[]gb\.g;Je[MBb:T^U]b2S)(KU71B7R;]]
^0@0:ITL?_X1SgXKF:/c)PfNIC,OCII1U,8?33/T\I?/T\=;<6d</e_QXe#0fO])
_<EC=TW?PO>3MNPa.e5[Y(S85U+[K0b8X-Te#]M4M>6J6C/?WId/E-K.4M0-V[KU
d^/D&cB@fG&eGY7?\O[fD^a8XC?N;?.EIDD77F_QZCR5D_F1cLc^0&:Z[](L.E:-
b-2/T2_8a[U@FaRaSDdg>E=Fe1IG?Q]E9NFb>\RGN4,>/-ed5KT:S[/<7cdFUaM4
@a?PX4W;,#XJD=LC.C]Y6a]4>+d4:_8/4C<;ZIK0]UQ(>E/+&Z1(WdGZEFVU)WS:
=2B#d(=XM#X:SFD,<_?PZeTO(O(H-:?#[)G+C@AJ;JdU4F4?K>?R#VMSQ7:WM;3)
DeW8T0?_Z.Z>E?<2@PdBNTGW?LJ1EF(:bbKG,2A\S0L#aR&T?_A\Z>CXJ@QMY&c.
(?=XeS4PXe+8TM\8Z<dW55-@\Qd/V:Q]1cRXLaRE&.+Z:b_T>Y.+S4CW]GI9^f]7
aeTIM77F.Q6]XV5KRQ4ME5W;3814>3F:@UWIIaZSD,XU:>Ka_VOV8JbbH8B4D][e
31#SC1AG0#_<?Hf^8)^FMPe.+Te>DCUcKBOL.KeL_g7Q0A9YN63LF\ECXP.8>DUc
2)QId5d0DN:?YT>a7]8Ra2EC96BSLXe6+-8a((HPEAXPGJff2L9OYQ>+FO8:OEJH
&YWS<UD1XU#TD(ACIG+[?:>G298HTVD&)WdYV8)\7W1bVXb,+L(^@TRReRTa+HQb
UDS<9[gOeJ/[2/O73^6)K56Q?0P(<F]09fM,HXYEfO+4PL5E4cf/N-RYV#=N9LVL
(V=):6_.VXR#7/3U#5TfWOe3K+.cJgU9SP#Xc=c2M6aT\YX8#;UAC-EHQg7eUX#[
OW=V]JK^3YYRS:94e7B1[eB#N(SX9c/d]K>KSB_]aX8/bMEQ_LQ?/?0Fc\cL2===
KEMbH;\d]\<N0AC]NC[[T6QC[U9&[,#)_F(\;.WA4eC1_-;SfRM8872]FL/5IeK4
GB,LZDK?87S\HB5[V9F5gJOLGA5C2Le,#D^6Lg_YU,g;X6J/+X2KU0Hc&TK+,OJL
R<FIUF5TB6QKP6/V66VXS_X^Ac4ed0W-8G)ZT9N?B\C=@B[+L4R\bS=,d/^NAYMS
&-@Z7MbW37d+N\/KNSL9H2Oc>Sd[4^OCD0dFAT<Y]4K#L<V6f/V<BbE5[3@>B+Ug
_\I0N\-E9L^<4IfbHD.X6+He6_bK<X;N)ag>XON?bUH6DZTc;+^+&a]9HM/900D[
EY=T;);g7Y1Ke]2,<ABgE4RIA2LAaZZ-[0<U\Mb=gO70Zg-607S<]AB8AeXVL7dP
\>659ea53YWN-E-EM;.S_?#HdUf?aZ0X.,A3KLD+UF#]SUCb2dP@A-30QLbeB4)U
L6-BO?P2K@6G#IfMO&,19^1W^W-&LRS6c]AeQ/=GJF^B@M7;:S3@MPL#f@I)4FVa
]QF&/WR;&\S92S(6X.\@Ud+c3Jf5^9T>-U#J]d15Rf/9Eb/)ZXaBTcS3\6U@,Og^
/THaH]=0-PFLB2(42C5=B5Nf#>AJLA])REU)e=2J01J]T(FF9@c;37JA7PW;JLD1
QIVPJO?f?EK82J5g5S@8[E9RREL@7M+F.MWAP5:\E8PcXHPEATKN>2SAAK#6,<=5
TNCUZCKc:XFe0L;V[X751fb0YU8C&^++R1LQ4NJZSKC4Y0T#>5B]PRXg\[e:?IPO
O=gT@De.I&I#8KT/F:NUAO,#O=1V^S4353bQWNY40<Ec^],g&<@>;3(&4I.YWX^T
V5b)B3,3^L14_c@0&][P;P.6:@CHOfY=(Q^cLS@>S@DA2&CCT1<d>R1J[90L\d6J
3Q46dWIBgS,8/:+(OCV6?2<S.WGRB6US81.eWY_=<D.45+6]F&\V)bC2f6>0]b,K
NT<7<XM.c_:0J06M+P>/&J2KQ_aeM_g/@3A6:_08D89Y0FVPN7]__YW:TSaQ]KW/
1:c/cN3W\UQfBbE=0gY53fM&BS1P\f-W?(K3]cI4I38fc@Z.?O(-CFFW),</L0b0
?T,PTH+P2)P#PPV5c@8?>,.KSZE&R,cGZ.8T-/3-.G:Y3\R3-IC8H(W2X1U9dR5@
:^86:+)[X/-)/cOfB+Ua\6W2\He6T8QG2+>eAYFX0#2EY:#0XXDWd,J_XUeAa1,R
\<?4\7<#A/ObD@=1G95D_Se//]U57(@#,N;9L2U(,)a?X?^8JR2U1+O8;I8c(DVI
a#F(9?Y>=LO#W9Oc.>8-]@:AHAK6>0^;X8_L+^31@@8;.AE/,U5[<E2KN#;>ITNYQ$
`endprotected


   // synopsys translate_on

endmodule

