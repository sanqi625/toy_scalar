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
// AUTHOR:    Reto Zimmermann         9/15/06
//
// VERSION:   Simulation Architecture
//
// DesignWare_version: a9b932f2
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//-----------------------------------------------------------------------------------
//
// ABSTRACT: Priority coder
//           Returns a one-hot encoded output that indicates the highest
//           non-zero bit position.  An extra bit (LSB) indicates whether all
//           input bits are zero.
//
//           Note: Only for the simulation model, x's will be handled in
//                 the following manner.  If an "x" is the first non-zero
//                 bit value found, then the output cod gets all x's.
//                 If an "x", is in the "a" input, but a "1" is encountered
//                 at a higher bit position, then the output cod gets
//                 the expected non-x values.
//
//           Parameters:     Valid Values
//           ==========      ============
//           a_width         >= 1
//              
//           Input Ports:    Size     Description
//           ===========     ====     ===========
//           a               a_width  Input vector
//
//           Output Ports    Size     Description
//           ============    ====     ===========
//           cod             a_width  One-hot coded version of 'a'
//           zero            1        all-zero flag
//
// MODIFIED: 
//
//-------------------------------------------------------------------------------
//
module DW_pricod (
    a,
    cod,
    zero
  );

  parameter integer a_width = 8;

  input  [a_width-1:0] a;
  output [a_width-1:0] cod;
  output               zero;

  // include modeling functions
  `include "DW_pricod_function.inc"
  // synopsys translate_off

  //-------------------------------------------------------------------------
  // Parameter legality check
  //-------------------------------------------------------------------------
  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
  
    if (a_width < 1) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter a_width (lower bound: 1)",
	a_width );
    end
  
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 


  assign cod  = DWF_pricod (a);
  assign zero = ~ (| a);

  // synopsys translate_on
endmodule
