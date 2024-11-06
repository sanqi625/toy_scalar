//[UHDL]Content Start [md5:10f451f8e6d1572947b7a839ccadfdd8]
module toy_bus_DArb_node_dec_dmem_pld_type_ToyBusAck_forward_False (
	input         clk        ,
	input         rst_n      ,
	output        out0_vld   ,
	input         out0_rdy   ,
	output        out0_opcode,
	output [31:0] out0_data  ,
	output [3:0]  out0_src_id,
	output [3:0]  out0_tgt_id,
	input         in0_vld    ,
	output        in0_rdy    ,
	input         in0_opcode ,
	input  [31:0] in0_data   ,
	input  [3:0]  in0_src_id ,
	input  [3:0]  in0_tgt_id ,
	input         in1_vld    ,
	output        in1_rdy    ,
	input         in1_opcode ,
	input  [31:0] in1_data   ,
	input  [3:0]  in1_src_id ,
	input  [3:0]  in1_tgt_id ,
	input         in2_vld    ,
	output        in2_rdy    ,
	input         in2_opcode ,
	input  [31:0] in2_data   ,
	input  [3:0]  in2_src_id ,
	input  [3:0]  in2_tgt_id ,
	input         in3_vld    ,
	output        in3_rdy    ,
	input         in3_opcode ,
	input  [31:0] in3_data   ,
	input  [3:0]  in3_src_id ,
	input  [3:0]  in3_tgt_id );

	//Wire define for this module.
	wire [3:0] msg_update_en      ;
	wire [0:0] msg_update_en_bit_0;
	wire [0:0] msg_update_en_bit_1;
	wire [0:0] msg_update_en_bit_2;
	wire [0:0] msg_update_en_bit_3;
	wire [0:0] arb_lock_reg       ;
	wire [0:0] arb_lock           ;
	wire [0:0] bit_sel_0          ;
	wire [0:0] bit_sel_1          ;
	wire [0:0] bit_sel_2          ;
	wire [0:0] bit_sel_3          ;
	reg  [0:0] bit_set_reg_0      ;
	reg  [0:0] bit_set_reg_1      ;
	reg  [0:0] bit_set_reg_2      ;
	reg  [0:0] bit_set_reg_3      ;
	reg  [0:0] bit_set_locked_0   ;
	reg  [0:0] bit_set_locked_1   ;
	reg  [0:0] bit_set_locked_2   ;
	reg  [0:0] bit_set_locked_3   ;

	//Wire define for sub module.
	wire [3:0] arb_msg_age_bits_row_0;
	wire [3:0] arb_msg_age_bits_row_1;
	wire [3:0] arb_msg_age_bits_row_2;
	wire [3:0] arb_msg_age_bits_row_3;

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	assign out0_vld = ((in0_vld & ({1{bit_set_locked_0}})) | (in1_vld & ({1{bit_set_locked_1}})) | (in2_vld & ({1{bit_set_locked_2}})) | (in3_vld & ({1{bit_set_locked_3}})));
	
	assign out0_opcode = ((in0_opcode & ({1{bit_set_locked_0}})) | (in1_opcode & ({1{bit_set_locked_1}})) | (in2_opcode & ({1{bit_set_locked_2}})) | (in3_opcode & ({1{bit_set_locked_3}})));
	
	assign out0_data = ((in0_data & ({32{bit_set_locked_0}})) | (in1_data & ({32{bit_set_locked_1}})) | (in2_data & ({32{bit_set_locked_2}})) | (in3_data & ({32{bit_set_locked_3}})));
	
	assign out0_src_id = ((in0_src_id & ({4{bit_set_locked_0}})) | (in1_src_id & ({4{bit_set_locked_1}})) | (in2_src_id & ({4{bit_set_locked_2}})) | (in3_src_id & ({4{bit_set_locked_3}})));
	
	assign out0_tgt_id = ((in0_tgt_id & ({4{bit_set_locked_0}})) | (in1_tgt_id & ({4{bit_set_locked_1}})) | (in2_tgt_id & ({4{bit_set_locked_2}})) | (in3_tgt_id & ({4{bit_set_locked_3}})));
	
	assign in0_rdy = (bit_set_locked_0 && out0_rdy);
	
	assign in1_rdy = (bit_set_locked_1 && out0_rdy);
	
	assign in2_rdy = (bit_set_locked_2 && out0_rdy);
	
	assign in3_rdy = (bit_set_locked_3 && out0_rdy);
	
	assign msg_update_en = {msg_update_en_bit_0, msg_update_en_bit_1, msg_update_en_bit_2, msg_update_en_bit_3};
	
	assign msg_update_en_bit_0 = (in0_vld && in0_rdy);
	
	assign msg_update_en_bit_1 = (in1_vld && in1_rdy);
	
	assign msg_update_en_bit_2 = (in2_vld && in2_rdy);
	
	assign msg_update_en_bit_3 = (in3_vld && in3_rdy);
	
	assign arb_lock_reg = 1'b0;
	
	assign arb_lock = 1'b0;
	
	assign bit_sel_0 = ((~((arb_msg_age_bits_row_0[0] && in0_vld) || (arb_msg_age_bits_row_0[1] && in1_vld) || (arb_msg_age_bits_row_0[2] && in2_vld) || (arb_msg_age_bits_row_0[3] && in3_vld))) && in0_vld);
	
	assign bit_sel_1 = ((~((arb_msg_age_bits_row_1[0] && in0_vld) || (arb_msg_age_bits_row_1[1] && in1_vld) || (arb_msg_age_bits_row_1[2] && in2_vld) || (arb_msg_age_bits_row_1[3] && in3_vld))) && in1_vld);
	
	assign bit_sel_2 = ((~((arb_msg_age_bits_row_2[0] && in0_vld) || (arb_msg_age_bits_row_2[1] && in1_vld) || (arb_msg_age_bits_row_2[2] && in2_vld) || (arb_msg_age_bits_row_2[3] && in3_vld))) && in2_vld);
	
	assign bit_sel_3 = ((~((arb_msg_age_bits_row_3[0] && in0_vld) || (arb_msg_age_bits_row_3[1] && in1_vld) || (arb_msg_age_bits_row_3[2] && in2_vld) || (arb_msg_age_bits_row_3[3] && in3_vld))) && in3_vld);
	
	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) bit_set_reg_0 <= 1'b0;
	    else begin
	        if(arb_lock) bit_set_reg_0 <= bit_sel_0;
	    end
	end
	
	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) bit_set_reg_1 <= 1'b0;
	    else begin
	        if(arb_lock) bit_set_reg_1 <= bit_sel_1;
	    end
	end
	
	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) bit_set_reg_2 <= 1'b0;
	    else begin
	        if(arb_lock) bit_set_reg_2 <= bit_sel_2;
	    end
	end
	
	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) bit_set_reg_3 <= 1'b0;
	    else begin
	        if(arb_lock) bit_set_reg_3 <= bit_sel_3;
	    end
	end
	
	always @(*) begin
	    if(arb_lock_reg) bit_set_locked_0 = bit_set_reg_0;
	    else bit_set_locked_0 = bit_sel_0;
	end
	
	always @(*) begin
	    if(arb_lock_reg) bit_set_locked_1 = bit_set_reg_1;
	    else bit_set_locked_1 = bit_sel_1;
	end
	
	always @(*) begin
	    if(arb_lock_reg) bit_set_locked_2 = bit_set_reg_2;
	    else bit_set_locked_2 = bit_sel_2;
	end
	
	always @(*) begin
	    if(arb_lock_reg) bit_set_locked_3 = bit_set_reg_3;
	    else bit_set_locked_3 = bit_sel_3;
	end
	

	//Wire this module connect to sub module.
	assign arb_msg_update_en = msg_update_en;
	

	//module inst.
	toy_bus_CmnAgeMtx_width_4 arb_msg (
		.clk(clk),
		.rst_n(rst_n),
		.update_en(arb_msg_update_en),
		.age_bits_row_0(arb_msg_age_bits_row_0),
		.age_bits_row_1(arb_msg_age_bits_row_1),
		.age_bits_row_2(arb_msg_age_bits_row_2),
		.age_bits_row_3(arb_msg_age_bits_row_3));

endmodule
//[UHDL]Content End [md5:10f451f8e6d1572947b7a839ccadfdd8]

