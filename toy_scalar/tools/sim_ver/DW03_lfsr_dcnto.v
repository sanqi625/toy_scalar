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
// AUTHOR:    Igor Kurilov       07/07/94 03:06am
//
// VERSION:   Simulation Architecture
//
// DesignWare_version: 848ae855
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//-----------------------------------------------------------------------------------
//
// ABSTRACT:  LFSR Counter with Dynamic Count-to Flag
//           Programmable wordlength (width in integer range 1 to 50)
//           positive edge-triggering clock: clk
//           asynchronous reset(active low): reset
//           count state : count
//           when reset = '0' , count <= "000...000"
//           counter state 0 to 2**width-2, "111...111" illegal state
//
// MODIFIED:
//
//           RJK Jun. 16th, 2015
//           changed for compatibility with VCS Native Low Power
//
//           GN  Feb. 16th, 1996
//           changed dw03 to DW03
//           remove $generic and $end_generic
//           defined parameter width = 8
//------------------------------------------------------------------------------

module DW03_lfsr_dcnto
 (data, count_to, load, cen, clk, reset, count, tercnt);

  parameter integer width = 8 ;
  input [width-1 : 0] data;
  input [width-1 : 0] count_to;
  input load, cen, clk, reset;
  output [width-1 : 0] count;
  output tercnt;

  // synopsys translate_off

  reg right_xor, shift_right, tc;
  reg [width-1 : 0] q, de, d;

`ifdef UPF_POWER_AWARE
`protected
EOPK/9^Eg6+XRDVC93b:fOI#3.@LT/@Za7,&I,_;GE[HfMLGAUGG-)OI&>YBCP?b
R0)/1_VVG5Q3/d](S>//PV&T9EXbT3WYT6]JQe->@W;eae.8N=AC#,7]147\Z8,S
H4\6E8bZQL07.SgeA1?b@5N:/_7+JS;gC>8;NZa6V,.J6-2K[KLEDKI05QTZF@.b
P<K)F[FJS0-D7MaFAKb/5+ecE^:&;K8aQR)CC\DF4]J84#:e=41Q:Y\7;(=1&E#J
?,R_.B#YRUZaCE)D0OYX@AD?.MaP&CWP,R<?XWJK8FR-U@6H5IJ@EUGUE?O6),_T
dF<@R,O?JOJFQ;_P6Y5ZE68/1[.c]#<5W,6VAeXU9>WeY7aY+SK4+DSBXQVF&7V2
C\A_C1dR_EB/Tf4H)=e.UT>BaJ/4UFW-E,_.4GL9=2N/1DgaDQ__KbLDB&PBJ-;D
Te/NQ74UH5+#J8)X5>8L).=EK9T?@V_4J/<g,E)2#T=<:Sba-(0Q67(?SLP+\D/8
?@GAf4Kb,gdK<=:[bDZVP-]895\G/LY5PP(<.]&=-.W:N2_B6N]X21+J_AcOK1;(
4f+fSaAT<Y(KaaCPb9HRJ(1ReM52/53f+BV,9+&U+[7W@]O&79gJ,D:I_eS:X-H,
=Q^#d8c)#VbH6_EBEXR_&cagTBE2\.A^_7OZ[WPaH/gf1]Kb2-F_T0YcL&+532dI
gOD8RbYdgY+Z88>59dJDEaKMSQ9<^GEDTaE<DUK=;<c84?X)&(0@g).[WbN45,EK
(,&UMf:KO3Y9?D:8Bf&MLPTgg7N6O5Z,#W&IA=/ZQ5TNdaD?[DX1U2:2H3@(TU>-
\Z,<JaaENXO?DS)3(RPX0N-3_3A.?f:dQdCJ(?&\dHc=P1\@2c[WTKB\KbQa>XI&
L_DgBKe]\V)/V2LgYC:&Q[\^6REK^-K,a3D(1Q_].7Q?(L-LQfF/Q[fVDZg9TS5Y
+b@S(QB/I\)aIEP^b<,[3&Bd4:FbFRg?d^=+gI6U)VdAaC/)=LYg(0XYO=A7:UPQ
.OE?#EUJ58:<eJ9bJ=8g_>OCRD]W&RS7/82&PV=PI+9/(fHZ]:;[XWK#.BX;e>N.
#<J]]U8&^RH]=N3-+>aCg:QM\?1=CEa<S+:Q&Q.5RM(Q09gM8f&P]aTZ0C2Y7(bg
;@0UCef1gO_O2W(RSbS;E#^&>G_Y_PU9f38f7Q-_=9@H\a[;[@1gQ+(Hg[_]A19S
?DA[Zd3T_51,]E3^PR11PIb&WS[=_CR#72Q677H9[#[4,6ILce+/NOb@FgC[bc9L
2_Qa5VZ/;KOU&K\5V7PZ8QAG67PBBF?H1>6Q81M9eME7e=J,f(_f>38;INWdJ8.-
UaS_)L.?4-(Y=ZSH0VNd9fC\bLIb#R_@Ya5)2)U(Y)F##a8e\=d7O>(;61bHJW2H
_.<II][U0^MTZd,(b^?464<HP2W00<d.IRBU0/2Ec:1.]30WN0&LZH/QWMQ<9dLR
<,EX6=-L+5Ha7PMX^Y>?V?.G=;Wd0<O]3V=eA//de;^K_OcDQd8YO-J<.=#^[ZV<
A+NP.^&1Ub@NM5^_g1Y[,6.B4dVIBVb?\?d9IQf<NdN:WbB^9)EZA38G847&Y;T1
aGAN>Nfb\<-QEX)d?+fcS&[@)]b5X^6/T65[8#a.dDD_A[7NCd>0<e23JV/eMc?C
_/+a[CFYK8.)^5HP;GJf[+a/]),9<#g,75X#H<T=\);]b&0=FXbOZ>CW[^:DdK_M
EO4V;d:G(0.Z3Z-T^?2]#/;8#^d^>49AAIK8DAM5XI@Q1CZ#DF@S.TI[S>aGZ6)?
cVa\GaOQ#;@^RP>+VeegK-82e2V-ZPX#Z#afDW_20YWQD$
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

  always @(count_to or q) tc = count_to == q;

  //---------------------------------------------------------------------------
  // Parameter legality check
  //---------------------------------------------------------------------------
  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
    
    if ( (width < 1) || (width > 50) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter width (legal range: 1 to 50)",
	width );
    end
  
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 


  // synopsys translate_on

endmodule // DW03_lfsr_dcnto
