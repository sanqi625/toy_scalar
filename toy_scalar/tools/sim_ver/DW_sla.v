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
// AUTHOR:    Alex Tenca, March 2006
//
// VERSION:   Simulation Architecture
//
// DesignWare_version: 2c4de11c
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//----------------------------------------------------------------------------
//
// ABSTRACT: Arithmetic Left Shifter - VHDL style
//           This component performs left and right shifting.
//           When SH_TC = '0', the shift coefficient SH is interpreted as a
//           positive unsigned number and only left shifts are performed.
//           When SH_TC = '1', the shift coefficient SH is a signed two's
//           complement number. A negative coefficient indicates
//           a right shift (division) and a positive coefficient indicates
//           a left shift (multiplication).
//           The input data A is always considered a signed value.
//           The MSB on A is extended when shifted to the right, and the 
//           LSB on A is extended when shifting to the left.
//
// MODIFIED: 
//           3/8/07: Based on the information in STAR 9000124138 (related
//                   to DW_rash, a fix was included in the selecop command
//                   used when SH_TC=1 and SH_width = 1 --> both input 
//                   ops of the selectop operator must be signed.
//
//----------------------------------------------------------------------------

module DW_sla(A, SH, SH_TC, B);
  parameter integer A_width=4;
  parameter integer SH_width=2;

  input [A_width-1:0] A;
  input [SH_width-1:0] SH;
  input SH_TC;
   
  output [A_width-1:0] B;

  // synopsys translate_off
      
  //-------------------------------------------------------------------------
  // Parameter legality check
  //-------------------------------------------------------------------------

  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
  
    if (A_width < 2) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter A_width (lower bound: 2)",
	A_width );
    end
  
    if (SH_width < 1) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter SH_width (lower bound: 1)",
	SH_width );
    end 
  
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 


  reg [A_width-1:0] B_INT;
  reg [A_width-1:0] mask;
 
  always @ (A or SH or SH_TC)
  begin
    mask = {A_width{1'b1}};
    if ((SH_TC === 1'bx) | ((^A) === 1'bx) | ((^SH) === 1'bx) )
      B_INT = {A_width{1'bx}};
    else
      begin
        if ((SH_TC === 1'b0) | (SH[SH_width-1] === 1'b0))
          begin
            B_INT = A << SH;
            B_INT = B_INT | (~(mask << SH) & {A_width{A[0]}});
          end
        else
          if (SH_width === 1) 
            B_INT = (SH === 1)?$signed(A) >>> 1:$signed(A);
          else
            B_INT = ($signed(A) >>> ~SH) >>> 1;
      end
  end

  assign B = B_INT;
  // synopsys translate_on

endmodule
