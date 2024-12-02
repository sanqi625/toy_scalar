////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 2008 - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Alex Tenca  Feb. 05, 2008
//
// VERSION:   Verilog Simulation Model
//
// DesignWare_version: b0813677
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//-----------------------------------------------------------
//
// ABSTRACT: Simulation model of DW_decode_en 
//
// MODIFIED:
//
//  10/2/2019  RJK  Added upper limit to parameter "width"
//                  check as part of addressing  STAR 9001566502
//
//-----------------------------------------------------------

module DW_decode_en (en, a, b);
parameter integer width=3;

// declaration of inputs and outputs
input  en;
input  [width-1:0] a;
output [(1 << width)-1:0] b;

// synopsys translate_off
  //-------------------------------------------------------------------------
  // Parameter legality check
  //-------------------------------------------------------------------------
  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
  
    if ( (width < 1) || (width > 16) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter width (legal range: 1 to 16)",
	width );
    end
  
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 


assign b = ((^(a ^ a) !== 1'b0) || (^(en ^ en) !== 1'b0)) ? {(1 << width){1'bX}} :
	   (en == 1) ? (1 << a) : 0;     


// synopsys translate_on

endmodule
