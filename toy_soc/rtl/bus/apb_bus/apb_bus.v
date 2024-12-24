//[UHDL]Content Start [md5:9a738a06f423057d7b17321def3b15c7]
module apb_bus (
	input      [31:0] s_paddr  ,
	input      [31:0] s_pwdata ,
	input             s_pwrite ,
	input             s_penable,
	input             s_psel   ,
	output     [31:0] s_prdata ,
	output            s_pready ,
	output            s_pslverr,
	output     [31:0] m_pwdata ,
	output            m_pwrite ,
	output            m_penable,
	output     [31:0] m_paddr  ,
	output reg        m0_psel  ,
	output reg        m1_psel  ,
	input             m0_pready,
	input             m1_pready,
	input      [31:0] m0_rdata ,
	input      [31:0] m1_rdata ,
	input             m0_slverr,
	input             m1_slverr);

	//Wire define for this module.
	wire [1:0]  pready_mask ;
	wire [1:0]  pslverr_mask;
	reg  [31:0] rdata_mask0 ;
	reg  [31:0] rdata_mask1 ;

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	assign s_prdata = (rdata_mask0 | rdata_mask1);
	
	assign s_pready = (|pready_mask);
	
	assign s_pslverr = (|pslverr_mask);
	
	assign m_pwdata = s_pwdata;
	
	assign m_pwrite = s_pwrite;
	
	assign m_penable = s_penable;
	
	assign m_paddr = s_paddr;
	
	always @(*) begin
	    if(((s_paddr >= 32'b11000000000000000001000000000000) && (s_paddr < 32'b11000000000000000001111111111111))) m0_psel = 1'b1;
	    else m0_psel = 1'b0;
	end
	
	always @(*) begin
	    if(((s_paddr >= 32'b11000000000000000010000000000000) && (s_paddr < 32'b11000000000000000010111111111111))) m1_psel = 1'b1;
	    else m1_psel = 1'b0;
	end
	
	assign pready_mask = {(m0_psel && m0_pready), (m1_psel && m1_pready)};
	
	assign pslverr_mask = {(m0_psel && m0_slverr), (m1_psel && m1_slverr)};
	
	always @(*) begin
	    if(m0_psel) rdata_mask0 = m0_rdata;
	    else rdata_mask0 = 32'b0;
	end
	
	always @(*) begin
	    if(m1_psel) rdata_mask1 = m1_rdata;
	    else rdata_mask1 = 32'b0;
	end
	

	//Wire this module connect to sub module.

	//module inst.

endmodule
//[UHDL]Content End [md5:9a738a06f423057d7b17321def3b15c7]

