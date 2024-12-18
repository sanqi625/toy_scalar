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
// AUTHOR:    Rick Kelly      May 26, 2000
//
// VERSION:   Verilog Simulation Model for DW_dpll_sd
//
// DesignWare_version: 506d3424
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
// DW_dpll_sd - Digital Phase Lock Loop with Static Divisor
//
//
//	Parameters:
//
//		width      1 to 16
//		divisor    4 to 256
//		gain	   1 to 2
//		filter     0 to 8
//		windows    1 to (divisor+1)/2
//
//
//	Ports:
//
//		clk	   local reference clock input
//		rst_n	   Active low asynch reset input
//		stall	   Active high stall control input **
//		squelch	   Active high lock disable input
//		window	   Sampling window control input bus
//		data_in	   Data input stream bus (PLL locks on bit 0)
//
//		clk_out	   Recovered baud clock output
//		bit_ready  Data bit capture status output (use to enable deserializer)
//		data_out   Data output stream bus
//
//	** NOTE:  The stall control does NOT disable the three-stage input
//		  synchronization registers.
// MODIFICATION:
//
// 08/07/15 RJK Eliminated use of initialized 'reg' variable for NLP compatibility.


module DW_dpll_sd(
		    clk,
		    rst_n,
		    stall,
		    squelch,
		    window,
		    data_in,
		    
		    clk_out,
		    bit_ready,
		    data_out
		    );

parameter integer width = 1;
parameter integer divisor = 4;
parameter integer gain = 1;
parameter integer filter = 2;	// 0 => no correction at +/- 1, 1 => always correct at +/- 1
			// 2-8 => correct at +/- 1 only when N consecutive detect samples
			// are +/- 1 in the SAME direction
parameter integer windows = 1;

localparam O1OOO0O0 = divisor;
localparam ll00OOIO =  ((O1OOO0O0>15)? ((O1OOO0O0>63)? ((O1OOO0O0>127)? 8 : 7) : ((O1OOO0O0>31)? 6 : 5)) : ((O1OOO0O0>4)? ((O1OOO0O0>8)? 4 : 3) : ((O1OOO0O0 > 2)? 2 : 1)));
localparam l1IO10O0 = windows;
localparam O11OO010 =  ((l1IO10O0>15)? ((l1IO10O0>63)? ((l1IO10O0>127)? 8 : 7) : ((l1IO10O0>31)? 6 : 5)) : ((l1IO10O0>4)? ((l1IO10O0>8)? 4 : 3) : ((l1IO10O0 > 2)? 2 : 1)));
localparam I1I11000 = (ll00OOIO - 1);
localparam O1O1l1O1 = ((windows/2)+1);
localparam O0111IOl = ((windows+1)/2);

localparam Ol0O1010 = 0;
localparam lIOOlOOO = ( divisor-1 );
localparam IOl10000 = ((divisor-1)/2);
localparam I01I0l1l = -99999999;
localparam l011IlOO = 2;

input			clk, rst_n, stall, squelch;
input [width-1 : 0]	data_in;
input [O11OO010-1:0] window;

output			clk_out, bit_ready;
output [width-1 : 0]	data_out;

// synopsys translate_off


reg 			l0OI10O1;
reg    [width-1 : 0]	O10IOO10;

reg [width-1 : 0] Ol0011O1, Ol10l011, II00lO0O;
reg O101OOO1, lI0100I0, l101l0O0, OIllOO00;
reg [O1O1l1O1*width-1:0] l11I0OOO;
reg [O1O1l1O1*width-1:0] O0OOOOIO;
reg [O0111IOl*width-1:0] OOIOOIO0;
reg [O0111IOl*width-1:0] O011IO1l;
reg  [width-1:0] l1010110;

wire l0I10OI0, IOl1llII, O10l0I01;
wire IOO1Ol01, OlO1000I, l00IOO01;
integer OOIlI1OO, IO010l10;
integer OlllO001, O01000OO;


    // connect registered outputs to their ports
    assign clk_out = OIllOO00;
    assign bit_ready = l0OI10O1;
    assign data_out = O10IOO10;
    
    
    //
    assign l0I10OI0 = ~squelch & (O0OOOOIO[0] ^ O011IO1l[0]);
    

    // sequential block
    always @ (posedge clk or negedge rst_n) begin : P_clk_registers_PROC
	
	if (rst_n == 0) begin
	    Ol0011O1 <= {width{1'b0}};
	    Ol10l011 <= {width{1'b0}};
	    II00lO0O <= {width{1'b0}};
	    O101OOO1 <= 1'b0;
	    l0OI10O1 <= 1'b0;
	    O10IOO10 <= {width{1'b0}};
	    lI0100I0 <= 1'b0;
	    l101l0O0 <= 0;
	    l11I0OOO <= {width*O1O1l1O1{1'b0}};
	    OOIOOIO0 <= {width*O0111IOl{1'b0}};
	    OlllO001 <= IOl10000;
	    OOIlI1OO <= filter-1;
	    OIllOO00 <= 1'b0;
	end else begin

	    if (rst_n === 1) begin
		
		Ol0011O1 <= data_in;
		Ol10l011 <= Ol0011O1;
		II00lO0O <= Ol10l011;

		if (stall === 0) begin
		    O101OOO1 <= l0I10OI0;
		    l0OI10O1 <= IOl1llII;
		    O10IOO10 <= l1010110;
		    lI0100I0 <= O10l0I01;
		    l101l0O0 <= IOO1Ol01;
		    OOIOOIO0 <= O011IO1l;
		    l11I0OOO <= O0OOOOIO;
		    OlllO001 <= O01000OO;
		    OOIlI1OO <= IO010l10;
		    OIllOO00 <= OlO1000I;
		
		end else begin
		
		    if (stall === 1) begin
			O101OOO1 <= O101OOO1;
			l0OI10O1 <= l0OI10O1;
			O10IOO10 <= data_out;
			lI0100I0 <= lI0100I0;
			l101l0O0 <= l101l0O0;
			OOIOOIO0 <= OOIOOIO0;
			l11I0OOO <= l11I0OOO;
			OlllO001 <= OlllO001;
			OOIlI1OO <= OOIlI1OO;
			OIllOO00 <= OIllOO00;
			
		    end else begin
			O101OOO1 <= 1'bx;
			l0OI10O1 <= 1'bx;
			O10IOO10 <= {width{1'bx}};
			lI0100I0 <= 1'bx;
			l101l0O0 <= 1'bx;
			l11I0OOO <= {width*O1O1l1O1{1'bx}};
			OOIOOIO0 <= {width*O0111IOl{1'bx}};
			OlllO001 <= I01I0l1l;
			OOIlI1OO <= I01I0l1l;
			OIllOO00 <= 1'bx;
			
		    end // if-else
		
		end // if-else

	    end else begin
		Ol0011O1 <= {width{1'bx}};
		Ol10l011 <= {width{1'bx}};
		II00lO0O <= {width{1'bx}};
		O101OOO1 <= 1'bx;
		l0OI10O1 <= 1'bx;
		O10IOO10 <= {width{1'bx}};
		lI0100I0 <= 1'bx;
		l101l0O0 <= 1'bx;
		l11I0OOO <= {width*O1O1l1O1{1'bx}};
		OOIOOIO0 <= {width*O0111IOl{1'bx}};
		OlllO001 <= I01I0l1l;
		OOIlI1OO <= I01I0l1l;
		OIllOO00 <= 1'bx;

	    end
	end

    end // IIO11Il1_PROC
    
    
    // 

    assign IOO1Ol01 = 
		
		(O101OOO1==1'b1)? (
		    
		    ((OlllO001==(IOl10000+1)) || (OlllO001==(IOl10000-1)))? 1 : 0
		
		) : (
		
		    l101l0O0
		
		);

    
    // 

    always @ (l11I0OOO or II00lO0O) begin : P_mk_nxt_e_samples_PROC
	integer llOIO0I1;
	
	O0OOOOIO[O1O1l1O1*width-1:(O1O1l1O1-1)*width] = II00lO0O;
	
	for (llOIO0I1=0 ; llOIO0I1 < (O1O1l1O1-1)*width ; llOIO0I1=llOIO0I1+1) begin
	    O0OOOOIO[llOIO0I1] = l11I0OOO[llOIO0I1+width];
	end // for
    end // O00l1l1I_PROC
    
    
    // 

    always @ (l11I0OOO or OOIOOIO0) begin : P_mk_nxt_l_samples_PROC
	integer llOIO0I1;
	
	for (llOIO0I1=0 ; llOIO0I1 < width ; llOIO0I1=llOIO0I1+1) begin
	    O011IO1l[llOIO0I1] = l11I0OOO[llOIO0I1];
	end // for
	
	if (O0111IOl > 1) begin
	    
	    for (llOIO0I1=0 ; llOIO0I1 < (O0111IOl-1)*width ; llOIO0I1=llOIO0I1+1) begin
		O011IO1l[llOIO0I1+width] = OOIOOIO0[llOIO0I1];
	    end // for
	end // if
    end // lIIlI11I_PROC
    
    
    // 

    assign IOl1llII =  (OlllO001 < Ol0O1010)? (

			    1'bx
			
			) : (

			    ((OlllO001 == lIOOlOOO) && (O101OOO1==1'b0))?
				1'b1
			    :
				1'b0
			);
    
    
    // 

    assign OlO1000I = (O01000OO > IOl10000)? 1 : 0;
    
    
    // 

    always @ (IOl1llII or window or l11I0OOO or OOIOOIO0) begin : P_mk_next_data_out_PROC
	integer llOIO0I1, O10l100I;
	O10l100I = (windows > 1)? (
			(window < windows)?
			    window
			:
			    windows-1
		    ) :
			0;
	
	if (IOl1llII == 1'b1) begin
	    for (llOIO0I1=0 ; llOIO0I1 < width ; llOIO0I1=llOIO0I1+1) begin
		if (O10l100I % 2) begin
		    l1010110[llOIO0I1] = OOIOOIO0[(O10l100I/2)*width+llOIO0I1];
		end else begin
		    l1010110[llOIO0I1] = l11I0OOO[(O10l100I/2)*width+llOIO0I1];
		end // if-else
	    end // for
	
	end else begin
	    l1010110 = O10IOO10;
	
	end // if-else
    
    end // OO010001_PROC
    
    
    // 

    assign O10l0I01 = (O101OOO1 == 1'b1)? OIllOO00 : lI0100I0;
    
    
    // 

    assign l00IOO01 = ~((OIllOO00 ^ lI0100I0) & l101l0O0);


    // 

    always @ (OlllO001 or O101OOO1 or OOIlI1OO or l00IOO01) begin : P_mk_next_count_PROC
    
	O01000OO =
	
	    (O101OOO1 == 1'b0)? (
		
		(OlllO001 == lIOOlOOO)?
		    Ol0O1010
		:
		    OlllO001 + 1
	    
	    ) : (
	    
		((OlllO001!==(IOl10000+1)) && (OlllO001!==(IOl10000-1)))? (
		    
		    ((gain==1) && (OlllO001!==IOl10000))? (
		    
			(OlllO001 > IOl10000)?
			    OlllO001 - ((OlllO001-IOl10000+1)/l011IlOO) + 1
			:
			    OlllO001 + ((IOl10000-OlllO001)/l011IlOO) + 1
		    ) :
		    
			IOl10000 + 1
		
		) : (
		
		    (filter > 1)? (
		    
			((OOIlI1OO===0) && l00IOO01)?
			    IOl10000 + 1
			:
			    OlllO001 + 1
		    
		    ) : (
		
			(filter == 1)?
			    IOl10000 + 1
			:
			    OlllO001 + 1
		    )
		)
	    );
    end // I1lO1O00_PROC


    // 

    always @ (O101OOO1 or OOIlI1OO or OlllO001 or l00IOO01) begin : P_mk_next_filt_count_PROC

	if (filter>1) begin
	
	    if (((OlllO001==(IOl10000+1))||(OlllO001==(IOl10000-1))) && (O101OOO1==1'b1)) begin
	
		if ((l00IOO01==1'b1) && (OOIlI1OO>0)) begin
		    IO010l10 = OOIlI1OO - 1;
		end else begin
		
		    if ((l00IOO01==1'b1) && (OOIlI1OO==0)) begin
			IO010l10 = filter-1;
		    end else begin
			IO010l10 = filter - 2;
		    end // if-else
			
		end // if-else
	
	    end else begin
	
		IO010l10 = (O101OOO1==1'b1)? filter-1 : OOIlI1OO;
	    
	    end // if-else
	end else begin
	
	    IO010l10 = 0;
	
	end // if-else
    end // lO1OOOO0_PROC
    
    
    
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
	
    if ( (width < 1) || (width > 16 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%O1OOO0O0) for parameter width (legal range: 1 to 16 )",
	width );
    end
	
    if ( (divisor < 4) || (divisor > 256 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%O1OOO0O0) for parameter divisor (legal range: 4 to 256 )",
	divisor );
    end
	
    if ( (gain < 1) || (gain > 2 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%O1OOO0O0) for parameter gain (legal range: 1 to 2 )",
	gain );
    end
	
    if ( (filter < 0) || (filter > 8 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%O1OOO0O0) for parameter filter (legal range: 0 to 8 )",
	filter );
    end
	
    if ( (windows < 1) || (windows > (divisor+1)/2 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%O1OOO0O0) for parameter windows (legal range: 1 to (divisor+1)/2 )",
	windows );
    end
    
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 

    
    
    
`ifndef DW_DISABLE_CLK_MONITOR
`ifndef DW_SUPPRESS_WARN
  always @ (clk) begin : P_monitor_clk 
    if ( (clk !== 1'b0) && (clk !== 1'b1) && ($time > 0) )
      $display ("WARNING: %m:\n at time = %0t: Detected unknown value, %b, on clk input.", $time, clk);
    end // P_monitor_clk 
`endif
`endif


// synopsys translate_on

endmodule
