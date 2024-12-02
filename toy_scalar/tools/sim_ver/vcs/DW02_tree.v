////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 2000  - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Rick Kelly        07/28/2000
//
// VERSION:   Verilog Simulation Model for DW02_tree
//
// DesignWare_version: da7ee6ba
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////

//-----------------------------------------------------------------------------------
//
// ABSTRACT:  Wallace Tree Summer with Carry Save output
//
// MODIFIED:
//            Aamir Farooqui 7/11/02
//            Corrected parameter checking, simplied sim model, and X_processing
//
//            Alex Tenca  6/20/2011
//            Introduced a new parameter (verif_en) that allows the use of random 
//            CS output values, instead of the fixed CS representation used in 
//            the original model. By "fixed" we mean: the CS output is always the
//            the same for the same input values. By using a randomization process,
//            the CS output for a given input value will change with time. The CS
//            output takes one of the possible CS representations that correspond
//            to the binary output of the DW02_tree. For example: for binary (0110)
//            sometimes the output is (0101,0001), sometimes (0110,0000), sometimes
//            (1100,1010), etc. These are all valid CS representations of 6.
//            Options for the CS output behavior are (based on verif_en parameter):
//              0 - old behavior (fixed CS representation)
//              1 - fully random CS output
//
//            RJK 9/22/2021
//            Corrected coding of conditional suppression of warnings to
//            avoid semantic error when DW_SUPPRESS_WARN Verilog macro
//            is defined.  STAR 3884129
//
//------------------------------------------------------------------------------
//

module DW02_tree( INPUT, OUT0, OUT1 );

// parameters
parameter integer num_inputs = 8;
parameter integer input_width = 8;
parameter integer verif_en = 1;


//-----------------------------------------------------------------------------
// ports
input [num_inputs*input_width-1 : 0]	INPUT;
output [input_width-1:0]		OUT0, OUT1;

//-----------------------------------------------------------------------------
// synopsys translate_off
reg    [input_width-1:0]		OII0OOOI, O001l0I0;
wire   [input_width-1:0]                out0_rnd_cs_full, out1_rnd_cs_full;
wire   [input_width-1:0]                out_fixed_cs,out_rnd_cs_full;

//-----------------------------------------------------------------------------
  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
    
    if (num_inputs < 1) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter num_inputs (lower bound: 1)",
	num_inputs );
    end
    
    if (input_width < 1) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter input_width (lower bound: 1)",
	input_width );
    end
    
    if ( (verif_en < 0) || (verif_en > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter verif_en (legal range: 0 to 1)",
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
  if (verif_en < 1)
    $display("The simulation coverage of CS values is not the best when verif_en=%d !\nThe recommended value is 1.",verif_en);
end // verif_en_warning
`endif

//-----------------------------------------------------------------------------


`protected
SCI;PcO>PAKA\(+7Y];N@g8Q>E[a1TH/EbQ:?<8\L,ZO.e@4eL,H&).0^2bB4X#S
XU=F(8__eN]?V:MD28CZ2#27_[fI0gLf,8KLVf3<S>2;dW9REV:eLWS9XV1<fB83
@F\A:^L_-.STZ-]Dc/NR7Hgae:70;A<RAR3:2Q\VX9R;(:H5=X^gcd1O)08CaBXE
AGJ4&D(;&MEP6Y\6T(9/JX7Q?-6dc,2>^/.cPW<4EZ891-C>]gF,L-P/fPQf2LF0
=:>.4-QAcb>eK<QWSTL\-6Bb7+CcOLS9+M[a.C<-6XDb([6;_Yd\/WHA@.RCKZYT
5SNa?QO6LY^+@^P4M1^YIJ7[Xa?L#[OQ2HF/H?<aEYf.^A]Pg-L];_0#/CE,C5XB
@\Q5gFQM@I0T@]b+cJP/>S(?/\edKfV^]IJ6Fb5Q\]S)B7X@6@YYV)6d<GBcFP@;
Q<OGM0/7fC=LD@6SF;UCCD3-]V#,JU[5_D0CX404IK@c0YNRFD_;cC2+,??bQ<X9
0:Qe.<K8HDGP_aWPKOLNZf_#<d.ZG=NKTe4>d2TS>__Fa3<27)H4YH?9ZF&9>/6=
&?.KaK&P;KC-)[S(,,-JOY9:;1#fNb2SG\(#_))0EcB=#X5R1:(0[/@g<ePYdc4,
>f.e/W]Eb\+UG+UJ^GD[_&BKK5c9J5Rc#)?4)-g-L=YS15XO@\HL7C[;aKe?]LGB
90cXR/F9DOKef[Bd-Fea^-MNKbHMLa]eOIQe0-;)<._e85@OP0JSU,@FH3Ja.3DO
7;a-=O[b^YK/XFMVb=#3f@/G,25MLedaG:NM]RS\KeYZX[NT__?<Qf-16^6TW39M
B191,3#\_)Nf,I=:d3?]ObI>P-Zf8.@VXS2U@#\;?7(/L>XagU&aSaGM4RdV.&Be
O+8c:F#Fec:N39+aWc:2.KYT#;A)C7>Bb))Mf1R8P_XM]d8ZcMNbVbF-3P2c3(f;
+[?CU:S<&2HYM+62XdWgWcgGP:D>U.;R9RQSeJ.1XPAPWRIHU.@N]W>VcRf\2Jb.
><E[c8W#\^9X3/=IRH.U_/eO(65L5^B0gZe4I[7+5([V[bD^/d4O)I@1IIY]-#KD
52>5M[O<e6T.=RSJ#]K>XX1E2X;NQSI1&f6OUYA=4YSBC&:0^0X1]C(NORR9YZ\\
RL\F&b-ZMGDJ>(Q<L;7c-5LdY<NJ+<KVQ:H:L7(U6/O-AF1?^>1eS(C:)1\Pa,aS
E9,13=:g1?gGN5J2Y.NNBP@f?Wc5@aa7MaO+Yd8@8W^Q-32QF5.EP1030.0>AJ>2
b^AEVN.;MA/X9;FP1Sc:3f]8(_g]RYU+;U&YZ<6=QbRYg06IM_g#KYe?T&]Q2MWT
S_eNLLGZ./NM91cI(3O#2O=:SFBb[Ag07c@,]7=011gK4_(Mb48Yg9dUWe=4/_eH
G7P&M.b&XB.MNUebF^0KW60F?cdW>EQJ4+?#,;Yb4f1H28XALF5&7A=/DYY(210a
QcEH:L;-DZ/72_Wf24e/]VX4IDYJ)(RL=G63M2A3J^V.e2f:4#C_OA:8(H6Pg/\\
&52EeX>8I[[DX,=J+;Na#4(F(Q,9,7NB)F\V,eP(QAc8)(3FP0K)J4FGMQDH^^f4
H2G;eJ=gQ64@-7YO.DQ;/g,,,(\F+Q52E--Z5:T.4+S9H26Z6?-aU-27\g@[/=WM
Rb&CHS5V4>X^aZJ1,UXS]8?_Zc3NGVB&GOZXb2P]WDF60]-(),e7]Og<1<ag:WQH
KLGC3d.0f.YOU(F83<M4TO]T20)M-ISCQA0;D;F#YY:[:NF\UT?)E;M@Q=e5O@79
U[5,/4:-@U=Q9N<M@7H+@QP8#X-\E#Age7H7JFEX#YX8UA#NXDM;#PN2If)W=D^T
Ic\PA(c37&>S)2P?>TS<a0-P,-XGKGcKJ4KDL9AXVYI-Z1/WFUS80\<L8UO@;\+a
QXM2POZg5cBc>6/gd2)QBA=/DZ6e&59ZPb4L?&QdC5gS9BQ]Na/(E;1;D&+_+?WD
M/a<2-AWg#a00f7a1.A+/@:DL6U@gHbQ-J-++M^N^V/gW_[/Fa&:QXP0;#F8LG?Z
4+2AfGNa>R83-.X:,;V4&[E8g[B\,<U7b,_1bZX]LXKN(bfKc6^?308aS\SO#,dA
6-[VXGL[1[FRKC/#Q4\I(LS.Rb6,(UbL=,DKUKB;aB^,9g0M&AgPMU3LVaE+Xf?8
B=V).D#M>=.LY(1L_0Ug.8]&YWdC48>(NUPX_c33S>0/=1.CbR22X92>Z8M3UNTf
4&Oga4U/gV0L:LPcTgaBD70;;=?6_AS.BLMLZe[?UYN;/dOB]J?:Q/cTQE-^@B.E
abI@^96^38dEB:UAgNEKdd<@I/2f@gN?[XB\I-LHD]1>?7GW@6KUI^@6FICRdIZQ
AF+I\\O,A44f7\;8KA+e&IXA[ME-W/5G(W3,aTA\^]7I9=[^3O1+>71fZ5L2M)6N
&R>7d_UP@WP0Q^2^_;UF\)RX(VDQR]-c?]f+X2K5JaIF?a_bN#KOO5XbI>\Y9[U2
6D#R4C]cR0^:CCO>>)D(6O@K1[X[KY#\&,EHHUfE9EO=&I9B\c6F>)/\PBaO>S^J
WY;+#\[KT.<d8<e+A)b7HgfB4JU-.J7He>JBaD0VAbK[6>]4a<fTY5EN[&LdH#T7
g\=)dc8>PGOQSHZ\Re<<QS41Oa@FL.OJ)?;7].Se9;##^AL^@[,e7:64+]RTTg-L
[+\L;G=Rd_<G3]]^Y3NF:YOPK2294;A))fGM]]R<:-I)FGJ/_8_H_+g3HEAFCGE5
g1=1JcF:KfZQH3adWNHeYP@VUNUU4YET9B?P]-]3;9A;-N[,YK2^11M,]38BK:TO
0:X;HJNA:#a)Qa5ee(DAf-P=+_RVA;Qf5TKX56egUR/ZcbM[R>Z)JE0R?E-ZBcCf
=YB^9#IBM@O_@T1FT@AQXYfcIa8AX:]UW#2&=Z/2K1#b1B:+@Ad3<JPH#bc=S:fT
e/+a?2&QQ<3ONPF,FH:dYM@QJM1MAOCL&HbV_K1(eV&CFb2KHK?J8-MfE=/dH^HX
aF.Ueb&0?HE@FDDU5]b/Y3RA7YT_SaAfIN67JTI3c4cY:_@WcSfZE;eUA6<UgBd6
dbdODEJO<KJ>E9Mf.Re4ZIRN#GJLOfQ,Y2=J<b8,1J5JOb?NK<H\KZb^e7OKE]B4
+aUZ/+7AMDS^TTD?NE<TS0\]&2<V@)8Wb7/eIASZf=5-HM2S+#W55;Q)Z7AbV_84
N,9^?IW+(#fYPb0J=fUFLOTb.Zd\]eFY<^ZfcFe9P<Rde;?#MQA3X44_^R08L.V@
@-@<&g9gWB]b@_-agH].UV@84C:g#2\&R5fFP,2,>3PY179KI(Y2T3PaB+,EP9c\
SSf>K8bS\->>OI.@UA?0#^_[)\.\7<cM^?b8,<@XA31#T#.&Z3+;?9\T&/#g;BVc
1,CKLAd<H4(FV(aL(HSL+WH_U3D4L_cX.KHgGU2L9<<?))4MPQV<3c=BO)GFdAY:
7+>/RC?W+BV2&Bb).U(,e4egG=PW<79)=2fJJTWdbe<R]D4?)Z7HFF6fFRYL[,6g
FeWT9:U05,Z3a(9F.WHXWCK5ZVY7ObBLZaI,VBJGD#M?BB?MOHITPNaE:Q<[O9G>
S[<0^dgNU[MY&DAeNPKa4W<>3eXZ;G4PZ<IY4.L1PV>HR6._V\CL4U7[A,5\93M2
P4SQ:)9dB7S[ZG^O=^XWe4cP9<KQDd<^QeC98B29PZ:FRO?I1ccPHWS#1OTTOe^,
DZK0T2419AbOSV+a1FF((9O_b:@b\Oc/e][<S)(B\Z:?Y2Q=<IZ.TBBE(ZQKN<cd
-.g,NU;SfdKAOaV<g9e5RR508R:&5SWLVd9.aR@Y^W5<D](UAYJ)-&gbbAfbFXP\
E84Be5c,fJ6MF2&7?Vbd,+QAWK/0T:(7Y(4X_T:2C=NOddR(F)cB/]E17^HTXeX;
B(Xg-EVD_\aWLGf)@4N<3UeP3U.TPUO\EL?JDfgf9RG\[LOX^aL3P,+HOZKcN961
:[Y)V.I-F(WS682,<TDU&)#aN.@<7X/[@S-\N5219ZB14;ZR6I&.?)?bK_458)X&
,ZPR>6,]]<1K)XRcXG7DKQc<d.[?MgP,>[QUaFb@?CeeD&28JA?.L#d=4S=PHg?(
L<.9P81,1E\/6&&ffI)P_8B+5?-H,9+/VcUXR:Y:8Y-6XZc.Zb/b,AY3.D.-0BCQ
SbCGYEPT2:/+I]b^F@/b@-Y7aUE^@N-VMT&85_RfCHS7V9E_bWM+EG6I/dX^,cM9
D44HMZA&?V&?,-;/&L1F2XOUV?eHZJeXF2X[Z^N@7a;H\3Ye?>H<6=R0,;PP0dP]
)X=#(GC\R61G2]BR)+gb4#2.YaC:A5d69_Ldd#V+c7e8D)[WQ,e^<<ZG6@<8\DE]
89POgIbM5W6=EU#>]68W,O0=0]NBD39]:6M][,;d#fOb?A\B^c52XD4WORSJ+GJc
_9gN93-T.[WE?V@cH_Y_AIZA94-^OA#<@9[WEOR[R#;+5:aK;<G<]I]6@_b=+aI^
^?LBMRb.Ag_-eV/Y.b&MMe?G<FM.RO9dIJ&aX1B]VEfD;+9N;6BXU]F/b/,4@G=b
)W7ES\&/-ZBUW,DOR48NM#?G8$
`endprotected


// synopsys translate_on

endmodule
