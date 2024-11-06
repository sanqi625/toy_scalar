//[UHDL]Content Start [md5:6a5e96c1a26e020da48a76a2ddfccc8c]
module toy_bus_ToyCoreSlv_node_lsu_fwd_pld_type_ToyBusReq_bwd_pld_type_ToyBusAck_forward_True (
	input             in0_req_vld    ,
	output            in0_req_rdy    ,
	input      [31:0] in0_req_addr   ,
	input      [31:0] in0_req_data   ,
	input      [3:0]  in0_req_strb   ,
	input             in0_req_opcode ,
	output            in0_ack_vld    ,
	input             in0_ack_rdy    ,
	output     [31:0] in0_ack_data   ,
	output            out0_req_vld   ,
	input             out0_req_rdy   ,
	output     [31:0] out0_req_addr  ,
	output     [3:0]  out0_req_strb  ,
	output     [31:0] out0_req_data  ,
	output            out0_req_opcode,
	output     [3:0]  out0_req_src_id,
	output reg [3:0]  out0_req_tgt_id,
	input             out0_ack_vld   ,
	output            out0_ack_rdy   ,
	input             out0_ack_opcode,
	input      [31:0] out0_ack_data  ,
	input      [3:0]  out0_ack_src_id,
	input      [3:0]  out0_ack_tgt_id);

	//Wire define for this module.

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	assign in0_req_rdy = out0_req_rdy;
	
	assign in0_ack_vld = out0_ack_vld;
	
	assign in0_ack_data = out0_ack_data;
	
	assign out0_req_vld = in0_req_vld;
	
	assign out0_req_addr = in0_req_addr;
	
	assign out0_req_strb = in0_req_strb;
	
	assign out0_req_data = in0_req_data;
	
	assign out0_req_opcode = in0_req_opcode;
	
	assign out0_req_src_id = 4'b1;
	
	always @(*) begin
	    if(((in0_req_addr >= 32'b10000000000000000000000000000000) && (in0_req_addr < 32'b10100000000000000000000000000000))) out0_req_tgt_id = 4'b10;
	    else if(((in0_req_addr >= 32'b10100000000000000000000000000000) && (in0_req_addr < 32'b11000000000000000000000000000000))) out0_req_tgt_id = 4'b11;
	    else if(((in0_req_addr >= 32'b0) && (in0_req_addr < 32'b10000000000000000000000000000))) out0_req_tgt_id = 4'b101;
	    else if(((in0_req_addr >= 32'b11000000000000000001000000000000) && (in0_req_addr < 32'b11000000000000001111111111111111))) out0_req_tgt_id = 4'b111;
	    else out0_req_tgt_id = 4'b100;
	end
	
	assign out0_ack_rdy = in0_ack_rdy;
	

	//Wire this module connect to sub module.

	//module inst.

endmodule
//[UHDL]Content End [md5:6a5e96c1a26e020da48a76a2ddfccc8c]

