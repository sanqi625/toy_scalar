//[UHDL]Content Start [md5:2a191efbcff389a27a7fef2e38174adc]
module toy_bus_CmnAgeMtx_width_4 (
	input        clk           ,
	input        rst_n         ,
	input  [3:0] update_en     ,
	output [3:0] age_bits_row_0,
	output [3:0] age_bits_row_1,
	output [3:0] age_bits_row_2,
	output [3:0] age_bits_row_3);

	//Wire define for this module.
	wire [0:0] age_bit_0_0;
	reg  [0:0] age_bit_0_1;
	reg  [0:0] age_bit_0_2;
	reg  [0:0] age_bit_0_3;
	wire [0:0] age_bit_1_1;
	reg  [0:0] age_bit_1_2;
	reg  [0:0] age_bit_1_3;
	wire [0:0] age_bit_2_2;
	reg  [0:0] age_bit_2_3;
	wire [0:0] age_bit_3_3;
	wire [0:0] age_bit_1_0;
	wire [0:0] age_bit_2_0;
	wire [0:0] age_bit_2_1;
	wire [0:0] age_bit_3_0;
	wire [0:0] age_bit_3_1;
	wire [0:0] age_bit_3_2;

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	assign age_bits_row_0 = {age_bit_0_3, age_bit_0_2, age_bit_0_1, age_bit_0_0};
	
	assign age_bits_row_1 = {age_bit_1_3, age_bit_1_2, age_bit_1_1, age_bit_1_0};
	
	assign age_bits_row_2 = {age_bit_2_3, age_bit_2_2, age_bit_2_1, age_bit_2_0};
	
	assign age_bits_row_3 = {age_bit_3_3, age_bit_3_2, age_bit_3_1, age_bit_3_0};
	
	assign age_bit_0_0 = 1'b0;
	
	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) age_bit_0_1 <= 1'b0;
	    else age_bit_0_1 <= update_en[1];
	end
	
	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) age_bit_0_2 <= 1'b0;
	    else age_bit_0_2 <= update_en[2];
	end
	
	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) age_bit_0_3 <= 1'b0;
	    else age_bit_0_3 <= update_en[3];
	end
	
	assign age_bit_1_1 = 1'b0;
	
	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) age_bit_1_2 <= 1'b0;
	    else age_bit_1_2 <= update_en[2];
	end
	
	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) age_bit_1_3 <= 1'b0;
	    else age_bit_1_3 <= update_en[3];
	end
	
	assign age_bit_2_2 = 1'b0;
	
	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) age_bit_2_3 <= 1'b0;
	    else age_bit_2_3 <= update_en[3];
	end
	
	assign age_bit_3_3 = 1'b0;
	
	assign age_bit_1_0 = (!age_bit_0_1);
	
	assign age_bit_2_0 = (!age_bit_0_2);
	
	assign age_bit_2_1 = (!age_bit_1_2);
	
	assign age_bit_3_0 = (!age_bit_0_3);
	
	assign age_bit_3_1 = (!age_bit_1_3);
	
	assign age_bit_3_2 = (!age_bit_2_3);
	

	//Wire this module connect to sub module.

	//module inst.

endmodule
//[UHDL]Content End [md5:2a191efbcff389a27a7fef2e38174adc]

