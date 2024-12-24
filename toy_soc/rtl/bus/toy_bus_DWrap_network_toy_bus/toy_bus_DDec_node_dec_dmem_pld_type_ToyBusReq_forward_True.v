//[UHDL]Content Start [md5:df3ae9af8a9d830e510f53eb06326414]
module toy_bus_DDec_node_dec_dmem_pld_type_ToyBusReq_forward_True (
	input         in0_vld    ,
	output        in0_rdy    ,
	input  [31:0] in0_addr   ,
	input  [3:0]  in0_strb   ,
	input  [31:0] in0_data   ,
	input         in0_opcode ,
	input  [3:0]  in0_src_id ,
	input  [3:0]  in0_tgt_id ,
	output        out0_vld   ,
	input         out0_rdy   ,
	output [31:0] out0_addr  ,
	output [3:0]  out0_strb  ,
	output [31:0] out0_data  ,
	output        out0_opcode,
	output [3:0]  out0_src_id,
	output [3:0]  out0_tgt_id,
	output        out1_vld   ,
	input         out1_rdy   ,
	output [31:0] out1_addr  ,
	output [3:0]  out1_strb  ,
	output [31:0] out1_data  ,
	output        out1_opcode,
	output [3:0]  out1_src_id,
	output [3:0]  out1_tgt_id,
	output        out2_vld   ,
	input         out2_rdy   ,
	output [31:0] out2_addr  ,
	output [3:0]  out2_strb  ,
	output [31:0] out2_data  ,
	output        out2_opcode,
	output [3:0]  out2_src_id,
	output [3:0]  out2_tgt_id,
	output        out3_vld   ,
	input         out3_rdy   ,
	output [31:0] out3_addr  ,
	output [3:0]  out3_strb  ,
	output [31:0] out3_data  ,
	output        out3_opcode,
	output [3:0]  out3_src_id,
	output [3:0]  out3_tgt_id);

	//Wire define for this module.
	wire [0:0] hit_tgtid_3__to_rteid_0;
	wire [0:0] hit_tgtid_4__to_rteid_1;
	wire [0:0] hit_tgtid_5__to_rteid_2;
	wire [0:0] hit_tgtid_7__to_rteid_3;
	wire [0:0] channel_mask_0         ;
	wire [0:0] masked_rdy_0           ;
	wire [0:0] channel_mask_1         ;
	wire [0:0] masked_rdy_1           ;
	wire [0:0] channel_mask_2         ;
	wire [0:0] masked_rdy_2           ;
	wire [0:0] channel_mask_3         ;
	wire [0:0] masked_rdy_3           ;

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	assign in0_rdy = (masked_rdy_0 || masked_rdy_1 || masked_rdy_2 || masked_rdy_3);
	
	assign out0_vld = (in0_vld && channel_mask_0);
	
	assign out0_addr = in0_addr;
	
	assign out0_strb = in0_strb;
	
	assign out0_data = in0_data;
	
	assign out0_opcode = in0_opcode;
	
	assign out0_src_id = in0_src_id;
	
	assign out0_tgt_id = in0_tgt_id;
	
	assign out1_vld = (in0_vld && channel_mask_1);
	
	assign out1_addr = in0_addr;
	
	assign out1_strb = in0_strb;
	
	assign out1_data = in0_data;
	
	assign out1_opcode = in0_opcode;
	
	assign out1_src_id = in0_src_id;
	
	assign out1_tgt_id = in0_tgt_id;
	
	assign out2_vld = (in0_vld && channel_mask_2);
	
	assign out2_addr = in0_addr;
	
	assign out2_strb = in0_strb;
	
	assign out2_data = in0_data;
	
	assign out2_opcode = in0_opcode;
	
	assign out2_src_id = in0_src_id;
	
	assign out2_tgt_id = in0_tgt_id;
	
	assign out3_vld = (in0_vld && channel_mask_3);
	
	assign out3_addr = in0_addr;
	
	assign out3_strb = in0_strb;
	
	assign out3_data = in0_data;
	
	assign out3_opcode = in0_opcode;
	
	assign out3_src_id = in0_src_id;
	
	assign out3_tgt_id = in0_tgt_id;
	
	assign hit_tgtid_3__to_rteid_0 = (in0_tgt_id == 4'b11);
	
	assign hit_tgtid_4__to_rteid_1 = (in0_tgt_id == 4'b100);
	
	assign hit_tgtid_5__to_rteid_2 = (in0_tgt_id == 4'b101);
	
	assign hit_tgtid_7__to_rteid_3 = (in0_tgt_id == 4'b111);
	
	assign channel_mask_0 = (hit_tgtid_3__to_rteid_0);
	
	assign masked_rdy_0 = (out0_rdy && channel_mask_0);
	
	assign channel_mask_1 = (hit_tgtid_4__to_rteid_1);
	
	assign masked_rdy_1 = (out1_rdy && channel_mask_1);
	
	assign channel_mask_2 = (hit_tgtid_5__to_rteid_2);
	
	assign masked_rdy_2 = (out2_rdy && channel_mask_2);
	
	assign channel_mask_3 = (hit_tgtid_7__to_rteid_3);
	
	assign masked_rdy_3 = (out3_rdy && channel_mask_3);
	

	//Wire this module connect to sub module.

	//module inst.

endmodule
//[UHDL]Content End [md5:df3ae9af8a9d830e510f53eb06326414]

