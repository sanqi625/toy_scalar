////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 2001 - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Rick Kelly    Aug. 7, 2001
//
// VERSION:   Verilog Simulation Model for DW_ecc
//
// DesignWare_version: f80c4f5e
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//
// ABSTRACT: Error Detection & Correction
//
//      Parameters:
//           width       - data size (4 <= "width" <= 8178)
//           chkbits     - number of checkbits (5 <= "chkbits" <= 14)
//           synd_sel    - controls checkbit correction vs syndrome
//                           emission selection when gen input is not
//                           active (0 => correct check bits
//                           1 => pass syndrome to chkout)
//
//      Ports:
//           gen         - generate versus check mode control input
//                           (1 => generate check bits from datain
//                           0 => check validity of check bits on chkin
//                           with respect to data on datain and indicate
//                           the presence of errors on err_detect & err_multpl)
//           correct_n   - control signal indicating whether or not to correct
//           datain      - input data
//           chkin       - input check bits
//           err_detect  - flag indicating occurance of error
//           err_multpl  - flag indicating multibit (i.e. uncorrectable) error
//           dataout     - output data
//           chkout      - output check bits
//
//-----------------------------------------------------------------------------
// MODIFIED:
//
//  10/7/15 RJK  Updated for compatibility with VCS NLP feature
//  12/21/16 RJK Relaxed lower bound on width (STAR 9001134170)
//  7/14/17 RJK  Updated UPF specific code (STAR 9001217597)
//  7/24/19 RJK  Updated to eliminate lint warnings (STAR 9001489004)
//  5/27/21 RJK  Replaced protected code for NLP w/ original model + inserted
//                "vcs_reinit" attribute to support NLP (STAR 9001219474)
//                (also addressed a couple more lint issues)
//  6/14/21 RJK  Updated to eliminate lint warning (STAR 3734661)
//  11/10/21 RJK Corrected defect in tripple bit error detection from
//                 previous modification. (STAR 3948056)
//
//-----------------------------------------------------------------------------

module DW_ecc(gen, correct_n, datain, chkin,
		err_detect, err_multpl, dataout, chkout);

parameter integer width = 32;
parameter integer chkbits = 7;
parameter integer synd_sel = 0;

input gen;	// checkbit generation control input (active high)
input correct_n;// correct error control input (active low)
input [width-1:0] datain;   // data input bus (generating, checking & correcting)
input [chkbits-1:0] chkin;  // checkbit input bus (checking & correcting)

output err_detect;	// error detection output flag (active high)
output err_multpl;	// multiple bit error detection output (active high)
output [width-1:0] dataout;	// data output bus (generating, checking & correcting)
output [chkbits-1:0] chkout;	// checkbit output bus (generating & scrubbing)

// synopsys translate_off
integer llIIIIO1, lIOII0I1;
integer O1O1Illl, Il011IIl, OO0IIllI;
integer OOIO00II, Il11Il01, O1OOOIll, O11lIO0I;
integer IlI0lOl1, OOOIlOOl, I0O0I100;
integer O11Il0l1,  IlI1lOI1, Ol1IO1l1;
integer IOOlO11O, II1010lI, OlIlOlI0;
integer O01ll0II, lOOOlIl1, OlII0l0O, llI0I0l1, IIIl0lI0;
integer I1OIOlI0 [0:(1<<chkbits)-1];
integer l00II0I1 [0:(1<<(chkbits-1))-1];

reg  [width-1:0]   OIlI11II [0:chkbits-1];
reg  [chkbits-1:0] IlOIl0II;
wire [chkbits-1:0] II111ll0;
reg  [width-1:0]   I1Ol0l01;
reg  [width-1:0] ll101O0O;
reg  [chkbits-1:0] I00ll0II;
reg  Il11O1lO, O1I1OOOO;

  function [30:0] I1Ol11ll;
  
    input [30:0] II1l10lI;
    input [30:0] lIOII0I1;
    integer rtnval;
    begin
      if (II1l10lI) begin
        if (lIOII0I1 < 1) rtnval = 1;
        else if (lIOII0I1 > 5) rtnval = 1;
        else rtnval = 0;
      end else begin
        if (lIOII0I1 < 1) rtnval = 5;
        else if (lIOII0I1 < 3) rtnval = 1;
        else rtnval = 0;
      end

      I1Ol11ll = rtnval[30:0];
    end
  endfunction


  function [30:0] l1I1lI1O;
  
    input [30:0] llI01l01;
    integer lll0Il1O, lI0l1OlO;
    begin
      lI0l1OlO = {1'b0, llI01l01};
      lll0Il1O = 0;
    
      while (lI0l1OlO != 0) begin
        if (lI0l1OlO & 1)
          lll0Il1O = lll0Il1O + 1;
      
        lI0l1OlO = lI0l1OlO >> 1;
      end
      
      l1I1lI1O = lll0Il1O[30:0];
    end
  endfunction
  
`ifdef VCS
`ifdef UPF_POWER_AWARE
(*vcs_reinit*)
`endif
`endif
  initial begin
    II1010lI = 5;
    llIIIIO1 = 1;
    O01ll0II = llIIIIO1 << chkbits;
    O1OOOIll = 2;
    OlII0l0O = O01ll0II >> II1010lI;
    OOOIlOOl = O1OOOIll << 4;
    
    for (OlIlOlI0=0 ; OlIlOlI0 < O01ll0II ; OlIlOlI0=OlIlOlI0+1) begin
      I1OIOlI0[OlIlOlI0]=-1;
    end
    
    llI0I0l1 = OlII0l0O * O1OOOIll;
    OOIO00II = 0;
    lOOOlIl1 = II1010lI + I1OIOlI0[0];
    IlI0lOl1 = OOOIlOOl + I1OIOlI0[1];
    
    for (Ol1IO1l1=0 ; (Ol1IO1l1 < llI0I0l1) && (OOIO00II < width) ; Ol1IO1l1=Ol1IO1l1+1) begin
      O1O1Illl = Ol1IO1l1 / O1OOOIll;
      
      if ((Ol1IO1l1 < 4) || ((Ol1IO1l1 > 8) && (Ol1IO1l1 >= (llI0I0l1-4))))
        O1O1Illl = O1O1Illl ^ 1;
      
      if (^Ol1IO1l1 ^ 1)
        O1O1Illl = OlII0l0O-llIIIIO1-O1O1Illl;
      
      if (OlII0l0O == llIIIIO1)
        O1O1Illl = 0;
      
      Il11Il01 = 0;
      IOOlO11O = O1O1Illl << II1010lI;
      
      if (Ol1IO1l1 < OlII0l0O) begin
        O11Il0l1 = 0;
        if (OlII0l0O > llIIIIO1)
          O11Il0l1 = Ol1IO1l1 % 2;
        
        O11lIO0I = {1'b0, I1Ol11ll(O11Il0l1,0)};
        
        for (OlIlOlI0=IOOlO11O ; (OlIlOlI0 < (IOOlO11O+OOOIlOOl)) && (OOIO00II < width) ; OlIlOlI0=OlIlOlI0+1) begin
          IlI1lOI1 = {1'b0, l1I1lI1O(OlIlOlI0)};
          if (IlI1lOI1 % 2) begin
            if (O11lIO0I <= 0) begin
              if (IlI1lOI1 > 1) begin
                I1OIOlI0[OlIlOlI0] = ((Il11Il01 < 2) && (O11Il0l1 == 0))?
					OOIO00II ^ 1 : OOIO00II;
		l00II0I1[ ((Il11Il01 < 2) && (O11Il0l1 == 0))? OOIO00II ^ 1 : OOIO00II ] =
					OlIlOlI0;
		OOIO00II = OOIO00II + 1;
              end // if
              
              Il11Il01 = Il11Il01 + 1;
              
              if (Il11Il01 < 8) begin
                O11lIO0I = {1'b0, I1Ol11ll(O11Il0l1,Il11Il01)};
              
              end else begin
                OlIlOlI0 = IOOlO11O+OOOIlOOl;
              end
            end else begin
            
              O11lIO0I = O11lIO0I - 1;
            end
          end
        end
        
      end else begin
        for (OlIlOlI0=IOOlO11O+IlI0lOl1 ; (OlIlOlI0 >= IOOlO11O) && (OOIO00II < width) ; OlIlOlI0=OlIlOlI0-1) begin
          IlI1lOI1 = {1'b0, l1I1lI1O(OlIlOlI0)};
          
          if (IlI1lOI1 %2) begin
            if ((IlI1lOI1>1) && (I1OIOlI0[OlIlOlI0] < 0)) begin
              I1OIOlI0[OlIlOlI0] = OOIO00II;
              l00II0I1[OOIO00II] = OlIlOlI0;
              OOIO00II = OOIO00II + 1;
            end
          end
        end
      end
    end
    
    I0O0I100 = llIIIIO1 - 1;
    
    for (OlIlOlI0=0 ; OlIlOlI0<chkbits ; OlIlOlI0=OlIlOlI0+1) begin
      I1Ol0l01 = {width{1'b0}};
      for (OOIO00II=0 ; OOIO00II < width ; OOIO00II=OOIO00II+1) begin
        if (l00II0I1[OOIO00II] & (1 << OlIlOlI0)) begin
          I1Ol0l01[OOIO00II] = 1'b1;
        end
      end
      OIlI11II[OlIlOlI0] = I1Ol0l01;
    end
    
    IIIl0lI0 = I0O0I100 - 1;
    
    for (OlIlOlI0=0 ; OlIlOlI0<chkbits ; OlIlOlI0=OlIlOlI0+1) begin
      I1OIOlI0[llIIIIO1<<OlIlOlI0] = width+OlIlOlI0;
    end
    
  end
  
  
  always @ (datain) begin : PROC1
    for (lIOII0I1=0 ; lIOII0I1 < chkbits ; lIOII0I1=lIOII0I1+1) begin
      IlOIl0II[lIOII0I1] = ^(datain & OIlI11II[lIOII0I1]) ^
				((lIOII0I1<2)||(lIOII0I1>3))? 1'b0 : 1'b1;
    end
  end // PROC1
  
  assign II111ll0 = IlOIl0II ^ chkin;
  
  assign err_detect = (gen == 1'b1)? 1'b0 : Il11O1lO;
  assign err_multpl = (gen == 1'b1)? 1'b0 : O1I1OOOO;
  
  assign chkout = (gen == 1'b1)? IlOIl0II : 
			(synd_sel==1)? II111ll0 :
				(correct_n == 1'b0)? chkin ^ I00ll0II :
					chkin;
  
  assign dataout = ((gen | correct_n) == 1'b0)? datain ^ ll101O0O :
				datain;

  always @ (II111ll0 or gen) begin : PROC2
    if (gen != 1'b1) begin
      if ((^(II111ll0 ^ II111ll0) !== 1'b0)) begin
        I00ll0II = {chkbits{1'bx}};
        ll101O0O = {width{1'bx}};
        Il11O1lO = 1'bx;
        O1I1OOOO = 1'bx;
      end else begin
        I00ll0II = {chkbits{1'b0}};
        ll101O0O = {width{1'b0}};
        if (II111ll0 === {chkbits{1'b0}}) begin
          Il11O1lO = 1'b0;
          O1I1OOOO = 1'b0;
        end else if (I1OIOlI0[II111ll0] == IIIl0lI0) begin
          Il11O1lO = 1'b1;
          O1I1OOOO = 1'b1;
        end else begin
          Il11O1lO = 1'b1;
          O1I1OOOO = 1'b0;
          if (I1OIOlI0[II111ll0] < width)
            ll101O0O[I1OIOlI0[II111ll0]] = 1'b1;
          else
            I00ll0II[I1OIOlI0[II111ll0]-width] = 1'b1;
        end
      end
    end
  end // PROC2
  
  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
    
    if ( (width < 4) || (width > 8178) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter width (legal range: 4 to 8178)",
	width );
    end
    
    if ( (chkbits < 5) || (chkbits > 14) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter chkbits (legal range: 5 to 14)",
	chkbits );
    end
    
    if ( (synd_sel < 0) || (synd_sel > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter synd_sel (legal range: 0 to 1)",
	synd_sel );
    end
    
    if ( width > ((1<<(chkbits-1))-chkbits) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m : Invalid parameter combination (chkbits value too low for specified width)" );
    end
  
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 

  
// synopsys translate_on
endmodule
