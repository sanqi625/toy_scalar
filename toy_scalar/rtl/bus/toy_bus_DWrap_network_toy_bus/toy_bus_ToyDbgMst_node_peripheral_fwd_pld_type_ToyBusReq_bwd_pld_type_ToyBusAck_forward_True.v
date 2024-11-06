//[UHDL]Content Start [md5:685156b4a68b9395dcbf391d6a5279d4]
module toy_bus_ToyDbgMst_node_peripheral_fwd_pld_type_ToyBusReq_bwd_pld_type_ToyBusAck_forward_True (
	input         clk            ,
	input         rst_n          ,
	input         in0_req_vld    ,
	output        in0_req_rdy    ,
	input  [31:0] in0_req_addr   ,
	input  [3:0]  in0_req_strb   ,
	input  [31:0] in0_req_data   ,
	input         in0_req_opcode ,
	input  [3:0]  in0_req_src_id ,
	input  [3:0]  in0_req_tgt_id ,
	output        in0_ack_vld    ,
	input         in0_ack_rdy    ,
	output        in0_ack_opcode ,
	output [31:0] in0_ack_data   ,
	output [3:0]  in0_ack_src_id ,
	output [3:0]  in0_ack_tgt_id ,
	output        out0_req_vld   ,
	input         out0_req_rdy   ,
	output [31:0] out0_req_addr  ,
	output [31:0] out0_req_data  ,
	output [3:0]  out0_req_strb  ,
	output        out0_req_opcode,
	input         out0_ack_vld   ,
	output        out0_ack_rdy   ,
	input  [31:0] out0_ack_data  );

	//Wire define for this module.
	reg [0:0] vld_reg    ;
	reg [3:0] node_id_reg;

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	assign in0_req_rdy = out0_req_rdy;
	
	assign in0_ack_vld = vld_reg;
	
	assign in0_ack_opcode = 1'b0;
	
	assign in0_ack_data = out0_ack_data;
	
	assign in0_ack_src_id = 4'b0;
	
	assign in0_ack_tgt_id = node_id_reg;
	
	assign out0_req_vld = in0_req_vld;
	
	assign out0_req_addr = in0_req_addr;
	
	assign out0_req_data = in0_req_data;
	
	assign out0_req_strb = in0_req_strb;
	
	assign out0_req_opcode = in0_req_opcode;
	
	assign out0_ack_rdy = in0_ack_rdy;
	
	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) vld_reg <= 1'b0;
	    else vld_reg <= (in0_req_vld && (!in0_req_opcode));
	end
	
	always @(posedge clk or negedge rst_n) begin
	    if(~rst_n) node_id_reg <= 4'b0;
	    else node_id_reg <= in0_req_src_id;
	end
	

	//Wire this module connect to sub module.

	//module inst.

endmodule
//[UHDL]Content End [md5:685156b4a68b9395dcbf391d6a5279d4]

