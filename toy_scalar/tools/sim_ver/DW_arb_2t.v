////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 2000 - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Reto Zimmermann         Jul 10, 2000
//
// VERSION:   Verilog Simulation Architecture
//
// DesignWare_version: 594757e0
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
//
// ABSTRACT:  Arbiter with two-level priority scheme
//            - first level: dynamic priority scheme
//            - second level: Fair-Among-Equal priority scheme
//   
// MODIFIED:
//          06/14/01  RPH    Fixed the X-processing. STAR 119685
//          12/21/01  RPH    Fixed the init priority bug due to order of 
//                           precedence of the operators and prio_low_int
//                           array not being in the sensitivity list.
//
//         03/26/03  RJK      Fixed problem with with int array triggering
//                            a combinational always block (STAR 160408)
//
//         10/13/10  RJK      Corrected "lock while in park state" issue
//
//          3/04/19  RJK      Eliminated the "#1" delay in the 2 tier arbitration
//                            Verilog simulation model (STAR 9001472840)
//
//-----------------------------------------------------------------------------

module DW_arb_2t (clk, rst_n, init_n, enable, request, prior, lock, mask, 
			   parked, granted, locked, grant, grant_index);

  parameter integer n          = 4; 
  parameter integer p_width    = 2;
  parameter integer park_mode  = 1;
  parameter integer park_index = 0;
  parameter integer output_mode = 1;
   

  `define DW_index_width ((n >16)?((n >64)?((n >128)?8:7):((n >32)?6:5)):((n >4)?((n >8)?4:3):((n >2)?2:1)))

  input  clk, rst_n, init_n, enable;
  input  [n-1 : 0] request, lock, mask;
  input  [p_width*n-1 : 0] prior;
  output parked, granted, locked;
  output [n-1 : 0] grant;
  output [`DW_index_width-1 : 0] grant_index;

  wire clk, rst_n;
  wire [n-1 : 0] request, lock, mask;
  wire [p_width*n-1 : 0] prio;
  wire  parked, locked;
  wire granted;
  wire [n-1 : 0] grant;
  wire [`DW_index_width-1 : 0] grant_index;

  // synopsys translate_off

  integer prio_low_int[n-1 : 0], prio_low_next[n-1 : 0];  
  integer grant_index_int, grant_index_next;
  reg     parked_next, granted_int, granted_next, locked_next; 
  reg 	  parked_int, locked_int; 

  reg [n-1 : 0] request_masked_v;
  reg parked_v, granted_v, locked_v;
  reg request_x, lock_x, mask_x, prio_x;
  reg [p_width*n-1 : 0] prio_tmp;
  assign prio = prior;
  integer prio_high_v[n-1 : 0],  prio_low_v[n-1 : 0];
  integer grant_index_v;
  integer update_priorities_v, i;
  reg   update_arb_reg;
  event update_arbitration;


  //---------------------------------------------------------------------------
  // Behavioral model
  //---------------------------------------------------------------------------
   always @(grant_index_int or granted_int or request or lock or mask or 
		    prio or update_arbitration) begin : PROC_arbitrate
		request_x  = ^request;
		lock_x     = ^lock;
		mask_x     = ^mask;
		prio_x = ^prio;
		
		grant_index_v = -1;
		parked_v      = 1'b0;
		granted_v     = 1'b0;
		locked_v      = 1'b0;
		
		for (i = 0; i < n; i = i+1) prio_low_v[i] = prio_low_int[i];
		update_priorities_v = 0;
		prio_tmp = prio;
		for (i = 0; i < n; i = i+1) begin
           prio_high_v[i] = prio_tmp[p_width-1 : 0];
           prio_tmp  = prio_tmp >> p_width;
		end
		request_masked_v = request & ~mask;

		if ((grant_index_int < -1) && (lock !== {n{1'b0}})) begin
			  grant_index_v = -2;
			  locked_v      = 1'bx;
			  granted_v     = 1'bx;
		end
		else if ((grant_index_int >= 0) &&
			((granted_int & lock[grant_index_int]) !== 1'b0)) begin
		   if ((granted_int & lock[grant_index_int]) === 1'b1) begin
			  grant_index_v = grant_index_int;
			  locked_v      = 1'b1;
			  granted_v     = 1'b1;
			  if (granted_int === 1'b0) update_priorities_v = 1;
		   end
		   else begin
			  grant_index_v = -2;
			  locked_v      = 1'bx;
			  granted_v     = 1'bx;
			  parked_v      = 1'b0;
		   end 
		end 
		else if (request_masked_v !== {n{1'b0}}) begin
		   if (request_x === 1'bx || prio_x === 1'bx ) begin
			  grant_index_v = -2;
			  granted_v = 1'bx;
			  parked_v      = 1'bx;
		   end 
		   else begin
			  for (i = 0; i < n; i = i+1) begin
				 if (request_masked_v[i] === 1'b1) begin
					if ((grant_index_v < 0) || 
						((prio_high_v[i] < prio_high_v[grant_index_v]) ||
						 ((prio_high_v[i] == prio_high_v[grant_index_v]) &&
						  (prio_low_int[i] < prio_low_int[grant_index_v])))) begin
					   grant_index_v = i;
					   granted_v = 1'b1;
					end
				 end
			  end
			  update_priorities_v = 1;
		   end 
		end 
		else if (park_mode == 1) begin	   
		   grant_index_v = park_index;
		   parked_v      = 1'b1;
		end
		else begin
           grant_index_v = -1;
		end

		for (i = 0; i < n; i = i+1) begin
           if (i == grant_index_v) begin
			  prio_low_v[i] = (1<<`DW_index_width)-1;
           end
		   else if (request_masked_v[i] == 1'b1) begin
			  if (update_priorities_v == 1)begin
				if (prio_low_v[i] == 0)
				  prio_low_v[i] = (1<<`DW_index_width)-1;
				else
				  prio_low_v[i] = prio_low_int[i] - 1;
			  end
           end
		   else begin
			  prio_low_v[i] = (1<<`DW_index_width)-1;
           end
		end // for

		grant_index_next = grant_index_v;
		parked_next      = parked_v;
		granted_next     = granted_v;
		locked_next      = locked_v;
		for (i = 0; i < n; i = i+1) prio_low_next[i] = prio_low_v[i];
	 end // arbitrate

  always @(posedge clk or negedge rst_n) begin : register_PROC
    if (rst_n === 1'b0) begin
      update_arb_reg    <= 1'b0;
      grant_index_int   <= -1;
      parked_int        <= 1'b0;
      granted_int       <= 1'b0;
      locked_int        <= 1'b0;
      for (i = 0; i < n; i = i+1) prio_low_int[i] <= (1<<`DW_index_width)-1;
    end else if (rst_n === 1'b1 ) begin
      if (init_n === 1'b0) begin
	update_arb_reg    <= 1'b0;
        grant_index_int   <= -1;
        parked_int        <= 1'b0;
        granted_int       <= 1'b0;
        locked_int        <= 1'b0;
        for (i = 0; i < n; i = i+1) 
	  prio_low_int[i] <= (1<<`DW_index_width)-1;
      end else if (init_n === 1'b1) begin
        if(enable) begin
          grant_index_int   <= grant_index_next;
          parked_int        <= parked_next;
          granted_int       <= granted_next;
          locked_int        <= locked_next;
          for (i = 0; i < n; i = i+1) begin
	    if (prio_low_int[i] !== prio_low_next[i]) begin
	      prio_low_int[i] <= prio_low_next[i];
	      update_arb_reg    <= ~update_arb_reg;
	    end
          end // for
        end // enabled
      end else begin
        grant_index_int <= -2;
        parked_int          <= 1'bx;
        granted_int     <= 1'bx;
        locked_int          <= 1'bx;
        for (i = 0; i < n; i = i+1) begin
          if (prio_low_int[i] !== -1) begin
            prio_low_int[i] <= -1;
	    update_arb_reg    <= ~update_arb_reg;
          end
        end // for
      end
    end else begin
      grant_index_int <= -2;
      parked_int          <= 1'bx;
      granted_int     <= 1'bx;
      locked_int          <= 1'bx;
      for (i = 0; i < n; i = i+1) begin
        if (prio_low_int[i] !== -1) begin
          prio_low_int[i] <= -1;
	  update_arb_reg    <= ~update_arb_reg;
        end
      end // for
    end
  end // register


  always @ (update_arb_reg) begin : trigger_update_PROC
    -> update_arbitration;
  end

  assign grant = (grant_index_int == -2)? {n{1'bx}} :
		 (grant_index_next == -1 && output_mode == 0) ? {n{1'b0}} :
		 (output_mode == 0 ) ? 1'b1 << grant_index_next :
                 1'b1 << grant_index_int;
   assign grant_index = (grant_index_int == -2)? {`DW_index_width{1'bx}} :
                       (grant_index_int == -1 && output_mode == 1) ? {`DW_index_width{1'b1}} :
	               (grant_index_next == -1 && output_mode == 0) ? {`DW_index_width{1'b1}} :
                       (output_mode == 0) ? grant_index_next[`DW_index_width-1:0] :
                       grant_index_int[`DW_index_width-1:0];
  assign granted = output_mode == 0 ? granted_next : 
	           granted_int;
   
  assign parked =  output_mode == 0 ? parked_next : 
	           parked_int;
  assign locked = output_mode == 0 ? locked_next : 
	          locked_int;
   
   


  //---------------------------------------------------------------------------
  // Parameter legality check and initializations
  //---------------------------------------------------------------------------
  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
    
    if ( (n < 2) || (n > 32) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter n (legal range: 2 to 32)",
	n );
    end
    
    if ( (p_width < 1) || (p_width > 5) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter p_width (legal range: 1 to 5)",
	p_width );
    end
    
    if ( (park_mode < 0) || (park_mode > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter park_mode (legal range: 0 to 1)",
	park_mode );
    end
    
    if ( (park_index < 0) || (park_index > n-1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter park_index (legal range: 0 to n-1)",
	park_index );
    end
    
    if ( (output_mode < 0) || (output_mode > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter output_mode (legal range: 0 to 1)",
	output_mode );
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

  `undef DW_index_width 
endmodule

//-----------------------------------------------------------------------------
