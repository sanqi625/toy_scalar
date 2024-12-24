//[UHDL]Content Start [md5:e98251bbbaf484a5698ae7a2af75e861]
module ApbBusModule (
	input             s_penable ,
	input      [31:0] s_paddr   ,
	output reg        m0_penable,
	output     [31:0] m0_paddr  ,
	output reg        m1_penable,
	output     [31:0] m1_paddr  ,
	output reg        m2_penable,
	output     [31:0] m2_paddr  ,
	output reg        m3_penable,
	output     [31:0] m3_paddr  );

	//Wire define for this module.

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	always @(*) begin
	    if(((m0_paddr >= 32'b10000000000000000000000000000000) && (m0_paddr < 32'b10100000000000000000000000000000))) m0_penable = 1'b1;
	    else m0_penable = 1'b0;
	end
	
	assign m0_paddr = s_paddr;
	
	always @(*) begin
	    if(((m1_paddr >= 32'b10100000000000000000000000000000) && (m1_paddr < 32'b11000000000000000000000000000000))) m1_penable = 1'b1;
	    else m1_penable = 1'b0;
	end
	
	assign m1_paddr = s_paddr;
	
	always @(*) begin
	    if(((m2_paddr >= 32'b0) && (m2_paddr < 32'b10000000000000000000000000000))) m2_penable = 1'b1;
	    else m2_penable = 1'b0;
	end
	
	assign m2_paddr = s_paddr;
	
	always @(*) begin
	    if(((m3_paddr >= 32'b11000000000000000001000000000000) && (m3_paddr < 32'b11000000000000001111111111111111))) m3_penable = 1'b1;
	    else m3_penable = 1'b0;
	end
	
	assign m3_paddr = s_paddr;
	

	//Wire this module connect to sub module.

	//module inst.

endmodule
//[UHDL]Content End [md5:e98251bbbaf484a5698ae7a2af75e861]

