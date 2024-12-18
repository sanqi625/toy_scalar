////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 1995 - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    KB                 May 20, 1995
//
// VERSION:   Verilog Simulation Model for DW_iir_sc
//
// DesignWare_version: b668699d
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//-----------------------------------------------------------------------------------
//
// ABSTRACT: Verilog simulation model for IIR filter with static coefficients
//
// MODIFIED:  
//            Doug Lee    05/23/2008
//              Fix for STAR#9000245949
//                data_out and saturation results were wrong
//                compared to synthetic and VHDL simulation
//                models in a specific negative number
//                boundary case.  Re-wrote rounding/saturation
//                function to resemble VHDL simulation model
//                approach.
//              Added extra legality check to not allow
//                "B0_coef != 0" and all other coefficients "0".
//
//            Zhijun (Jerry) Huang      02/17/2004
//              Changed interface names
//              Added parameter legality check
//              Added asynchronous reset signal rst_n
//              Added optional output register controlled by parameter out_reg
//              Added X-processing
//              Fixed verilog analysis warning about zero multiconcat multiplier
//              Fixed verilog analysis error about negative array index
//              Fixed logic errors with saturation and negative/positive handling
//              Fixed logic errors with feedback_data when feedback_width > data_out_width
//
//-----------------------------------------------------------------------------------

module DW_iir_sc(clk,rst_n,init_n,enable,data_in,data_out,saturation);
parameter	integer data_in_width = 4;
parameter	integer data_out_width = 6;
parameter	integer frac_data_out_width = 0;
parameter	integer feedback_width = 8;
parameter	integer max_coef_width = 4;
parameter	integer frac_coef_width = 0;
parameter	integer saturation_mode = 1;
parameter       integer out_reg = 1;
parameter     	integer A1_coef = -2;
parameter     	integer A2_coef =  3;
parameter     	integer B0_coef =  5;
parameter     	integer B1_coef = -6;
parameter     	integer B2_coef = -2;
input				clk,rst_n,init_n,enable;
input	[data_in_width-1:0]	data_in;
output	[data_out_width-1:0]	data_out;
output				saturation;

parameter	integer psum_width = (feedback_width-frac_data_out_width > data_in_width)?
				  feedback_width+max_coef_width+3
				: data_in_width+frac_data_out_width+max_coef_width+3;

// synopsys translate_off

function [feedback_width+data_out_width:0] rnd_sat;
input	[psum_width-1:0]	psum0;

reg  signed [psum_width:0]        psum0_shiftedby1;
reg  signed [data_out_width-1:0]  data_out_noreg;
reg  signed [feedback_width-1:0]  feedback_data;
reg  signed [frac_coef_width:0]   round_limit;
reg  signed [frac_coef_width-1:0]   psum0_frac_part;
reg  signed [data_out_width-1:0]  max_pos_output;
reg  signed [data_out_width-1:0]  max_neg_output;
reg  signed [feedback_width-1:0]  max_pos_feedback;
reg  signed [feedback_width-1:0]  max_neg_feedback;
reg  signed [data_out_width-1:0]  output_inc_data;
reg  signed [feedback_width-1:0]  feedback_inc_data;
reg                               output_to_big;
reg                               feedback_to_big;
reg                               saturation_internal;

integer i, j, k, l;

begin
    for (i=0; i<data_out_width; i=i+1) begin
      if (i == data_out_width-1)
        max_pos_output[i] = 0;
      else
        max_pos_output[i] = 1;
    end

    for (j=0; j<data_out_width; j=j+1) begin
      if (j == data_out_width-1)
        max_neg_output[j] = 1;
      else if (j == 0)
        if (saturation_mode == 0)
          max_neg_output[j] = 0;
        else
          max_neg_output[j] = 1;
      else
        max_neg_output[j] = 0;
    end

    for (k=0; k<feedback_width; k=k+1) begin
      if (k == feedback_width-1)
        max_pos_feedback[k] = 0;
      else
        max_pos_feedback[k] = 1;
    end

    for (l=0; l<feedback_width; l=l+1) begin
      if (l == feedback_width-1)
        max_neg_feedback[l] = 1;
      else if (l == 0)
        if (saturation_mode == 0)
          max_neg_feedback[l] = 0;
        else
          max_neg_feedback[l] = 1;
      else
        max_neg_feedback[l] = 0;
    end

    // round_limit = -2^(frac_coef_width-1)
    for (i=0; i<=frac_coef_width; i=i+1) begin
      if (i == frac_coef_width)
        round_limit[i] = 1;
      else if (i == frac_coef_width-1)
        round_limit[i] = 1;
      else
        round_limit[i] = 0;
    end


    if (frac_coef_width > 0) begin
        psum0_shiftedby1 = psum0 << 1;

        // Break out the frac_coef portion of psum0
        for (i=0; i<frac_coef_width; i=i+1) begin
          psum0_frac_part[i] = psum0[i];  
        end
   
        if ($signed(psum0_shiftedby1[psum_width:frac_coef_width]) >= $signed({max_pos_output, 1'b1})) begin
                data_out_noreg = max_pos_output;
                output_to_big = 1;
        end else begin 
          if ($signed(psum0_shiftedby1[psum_width:frac_coef_width+1]) < $signed(max_neg_output)) begin
                data_out_noreg = max_neg_output;
                output_to_big = 1;
          end else begin 
            if (psum0_shiftedby1[frac_coef_width] && 
                      (!psum0_shiftedby1[psum_width] || (($signed(psum0_frac_part)) > $signed(round_limit)))) begin
                output_inc_data = psum0[data_out_width+frac_coef_width-1:frac_coef_width] + 1;
                data_out_noreg = output_inc_data;
                output_to_big = 0;
            end else begin
                data_out_noreg = psum0[data_out_width+frac_coef_width-1:frac_coef_width];
                output_to_big = 0;
            end
          end
        end
        if ($signed(psum0_shiftedby1[psum_width:frac_coef_width]) >= $signed({max_pos_feedback, 1'b1})) begin
                feedback_data = max_pos_feedback;
                feedback_to_big = 1;
        end else begin
          if ($signed(psum0_shiftedby1[psum_width:frac_coef_width+1]) < $signed(max_neg_feedback)) begin
                feedback_data = max_neg_feedback;
                feedback_to_big = 1;
          end else begin 
            if (psum0_shiftedby1[frac_coef_width] && 
                      (!psum0_shiftedby1[psum_width] || (($signed(psum0_frac_part)) > $signed(round_limit)))) begin
                feedback_inc_data = psum0[feedback_width+frac_coef_width-1:frac_coef_width] + 1;
                feedback_data = feedback_inc_data;
                feedback_to_big = 0;
            end else begin  
                feedback_data = psum0[feedback_width+frac_coef_width-1:frac_coef_width];
                feedback_to_big = 0;
            end
          end
        end
    end else begin
        if ($signed(psum0) > $signed(max_pos_output)) begin
                data_out_noreg = max_pos_output;
                output_to_big = 1;
        end else begin
          if ($signed(psum0) < $signed(max_neg_output)) begin
                data_out_noreg = max_neg_output;
                output_to_big = 1;
          end else begin
                data_out_noreg = psum0[data_out_width-1:0];
                output_to_big = 0;
          end
        end
        if ($signed(psum0) > $signed(max_pos_feedback)) begin
                feedback_data = max_pos_feedback;
                feedback_to_big = 1;
        end else begin
          if ($signed(psum0) < $signed(max_neg_feedback)) begin
                feedback_data = max_neg_feedback;
                feedback_to_big = 1;
          end else begin 
                feedback_data = psum0[feedback_width-1:0];
                feedback_to_big = 0;
          end
        end
    end
    
    saturation_internal = output_to_big || feedback_to_big;

    rnd_sat = {saturation_internal, feedback_data, data_out_noreg};

end
endfunction


wire    [data_in_width-1:0]	gated_data_in;
wire	[feedback_width-1:0]	feedback_data;
wire	[max_coef_width-1:0]	A1_coef_wire,A2_coef_wire,
				B0_coef_wire,B1_coef_wire,B2_coef_wire;
wire	[data_in_width+max_coef_width-1:0]	B0_product,B1_product,B2_product;
wire	[feedback_width+max_coef_width-1:0]	A1_product,A2_product;
wire	[psum_width-3:0]	psum2;
reg	[psum_width-3:0]	psum2_saved;
wire	[psum_width-1:0]	psum1,psum0;
reg	[psum_width-1:0]	psum1_saved;
wire    [data_out_width-1:0]	data_out_internal;
wire				saturation_internal;
reg	[data_out_width-1:0] 	data_out_reg;
reg				saturation_reg;

assign	A1_coef_wire = A1_coef;
assign	A2_coef_wire = A2_coef;
assign	B0_coef_wire = B0_coef;
assign	B1_coef_wire = B1_coef;
assign	B2_coef_wire = B2_coef;
assign  gated_data_in = (init_n === 1'b0) ? {data_in_width{1'b0}} : data_in;


DW02_mult #(data_in_width,max_coef_width) B0_mult(gated_data_in,B0_coef_wire,1'b1,B0_product);
DW02_mult #(data_in_width,max_coef_width) B1_mult(gated_data_in,B1_coef_wire,1'b1,B1_product);
DW02_mult #(data_in_width,max_coef_width) B2_mult(gated_data_in,B2_coef_wire,1'b1,B2_product);

DW02_mult #(feedback_width,max_coef_width) A1_mult(feedback_data,A1_coef_wire,1'b1,A1_product);
DW02_mult #(feedback_width,max_coef_width) A2_mult(feedback_data,A2_coef_wire,1'b1,A2_product);

assign	psum2 =   ({{psum_width{B2_product[data_in_width+max_coef_width-1]}},
				B2_product[data_in_width+max_coef_width-2:0]} << frac_data_out_width)
		 + {{psum_width{A2_product[feedback_width+max_coef_width-1]}},
				A2_product[feedback_width+max_coef_width-2:0]};

assign	psum1 =   ({{psum_width{B1_product[data_in_width+max_coef_width-1]}},
				B1_product[data_in_width+max_coef_width-2:0]} << frac_data_out_width)
		 + {{psum_width{A1_product[feedback_width+max_coef_width-1]}},
				A1_product[feedback_width+max_coef_width-2:0]}
		 + 	    {{3{psum2_saved[psum_width-3]}},
				psum2_saved[psum_width-4:0]};

assign	psum0 =  ({{psum_width{B0_product[data_in_width+max_coef_width-1]}},
				B0_product[data_in_width+max_coef_width-2:0]} << frac_data_out_width)
		 +		psum1_saved;

assign	{saturation_internal,feedback_data,data_out_internal} = rnd_sat(psum0);

always @ (posedge clk or negedge rst_n)
	if (rst_n === 1'b0) begin
            	psum2_saved <= {psum_width-2{1'b0}};
                psum1_saved <= {psum_width{1'b0}};
                data_out_reg <= {data_out_width{1'b0}};
                saturation_reg <= 1'b0;
        end
        else if (rst_n === 1'b1) begin
                if ((^(init_n ^ init_n) !== 1'b0) || (^(enable ^ enable) !== 1'b0) || 
                    (^(data_in ^ data_in) !== 1'b0) || (^(psum1_saved ^ psum1_saved) !== 1'b0))
                    	psum2_saved <= {psum_width-2{1'bx}};
                else if (init_n === 1'b0)
                    	psum2_saved <= {psum_width-2{1'b0}};
                else if (enable === 1'b1)
                    	psum2_saved <= psum2;
                else
                   	psum2_saved <= psum2_saved;

                if ((^(init_n ^ init_n) !== 1'b0) || (^(enable ^ enable) !== 1'b0) || 
                    (^(data_in ^ data_in) !== 1'b0) || (^(psum2_saved ^ psum2_saved) !== 1'b0))
                    	psum1_saved <= {psum_width{1'bx}};
                else if (init_n === 1'b0)
                    	psum1_saved <= {psum_width{1'b0}};
                else if (enable === 1'b1)
                    	psum1_saved <= psum1;
                else 
                  	psum1_saved <= psum1_saved;

                if ((^(init_n ^ init_n) !== 1'b0) || (^(enable ^ enable) !== 1'b0) ||
                    (^(data_in ^ data_in) !== 1'b0) || (^(psum1_saved ^ psum1_saved) !== 1'b0)) begin
                    	data_out_reg <= {data_out_width{1'bx}};
                    	saturation_reg <= 1'bx;
                end
                else if (init_n === 1'b0) begin
                    	data_out_reg <= {data_out_width{1'b0}};
                    	saturation_reg <= 1'b0;
                end
                else if (enable === 1'b1) begin
                    	data_out_reg <= data_out_internal;
                    	saturation_reg <= saturation_internal;
                end
                else begin
                	data_out_reg <= data_out_reg;
                        saturation_reg <= saturation_reg;
                end
        end
	else begin
                psum2_saved <= {psum_width-2{1'bx}};
                psum1_saved <= {psum_width{1'bx}};
                data_out_reg <= {data_out_width{1'bx}};
                saturation_reg <= 1'bx;
        end

assign data_out = (out_reg == 0) ? data_out_internal : data_out_reg; 
assign saturation = (out_reg == 0) ? saturation_internal : saturation_reg; 


//-------------------------------------------------------------------------
// Parameter legality check
//-------------------------------------------------------------------------


 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
    
    if (data_in_width < 2) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter data_in_width (lower bound: 2)",
	data_in_width );
    end
    
    if ( (data_out_width < 2) || (data_out_width > psum_width-frac_coef_width) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter data_out_width (legal range: 2 to psum_width-frac_coef_width)",
	data_out_width );
    end
    
    if ( (frac_data_out_width < 0) || (frac_data_out_width > data_out_width-1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter frac_data_out_width (legal range: 0 to data_out_width-1)",
	frac_data_out_width );
    end
    
    if (feedback_width < 2) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter feedback_width (lower bound: 2)",
	feedback_width );
    end
    
    if ( (max_coef_width < 2) || (max_coef_width > 31) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter max_coef_width (legal range: 2 to 31)",
	max_coef_width );
    end
    
    if ( (frac_coef_width < 0) || (frac_coef_width > max_coef_width-1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter frac_coef_width (legal range: 0 to max_coef_width-1)",
	frac_coef_width );
    end
    
    if ( (saturation_mode < 0) || (saturation_mode > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter saturation_mode (legal range: 0 to 1)",
	saturation_mode );
    end
    
    if ( (out_reg < 0) || (out_reg > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter out_reg (legal range: 0 to 1)",
	out_reg );
    end
    
    if ( (A1_coef < -(1<<(max_coef_width-1))) || (A1_coef > (1<<(max_coef_width-1))-1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter A1_coef (legal range: -(1<<(max_coef_width-1)) to (1<<(max_coef_width-1))-1)",
	A1_coef );
    end
    
    if ( (A2_coef < -(1<<(max_coef_width-1))) || (A2_coef > (1<<(max_coef_width-1))-1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter A2_coef (legal range: -(1<<(max_coef_width-1)) to (1<<(max_coef_width-1))-1)",
	A2_coef );
    end
    
    if ( (B0_coef < -(1<<(max_coef_width-1))) || (B0_coef > (1<<(max_coef_width-1))-1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter B0_coef (legal range: -(1<<(max_coef_width-1)) to (1<<(max_coef_width-1))-1)",
	B0_coef );
    end
    
    if ( (B1_coef < -(1<<(max_coef_width-1))) || (B1_coef > (1<<(max_coef_width-1))-1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter B1_coef (legal range: -(1<<(max_coef_width-1)) to (1<<(max_coef_width-1))-1)",
	B1_coef );
    end
    
    if ( (B2_coef < -(1<<(max_coef_width-1))) || (B2_coef > (1<<(max_coef_width-1))-1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter B2_coef (legal range: -(1<<(max_coef_width-1)) to (1<<(max_coef_width-1))-1)",
	B2_coef );
    end
    
    if ( ((A1_coef==0) && (A2_coef==0) && (B1_coef==0) && (B2_coef==0)) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m : Illegal to have all coefficients but B0_coef set to 0" );
    end

    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 


//---------------------------------------------------------------------------
// Report unknown clock inputs
//---------------------------------------------------------------------------

`ifndef DW_DISABLE_CLK_MONITOR
`ifndef DW_SUPPRESS_WARN
  always @ (clk) begin : clk_monitor 
    if ( (clk !== 1'b0) && (clk !== 1'b1) && ($time > 0) )
      $display ("WARNING: %m:\n at time = %0t: Detected unknown value, %b, on clk input.", $time, clk);
    end // clk_monitor 
`endif
`endif

// synopsys translate_on
endmodule

