//[UHDL]Content Start [md5:d0fcb7475fbc83ca581a77ec2a6df1b3]
module toy_bus_DDec_node_arb_itcm_pld_type_ToyBusAck_forward_False (
	input         in0_vld    ,
	output        in0_rdy    ,
	input         in0_opcode ,
	input  [31:0] in0_data   ,
	input  [3:0]  in0_src_id ,
	input  [3:0]  in0_tgt_id ,
	output        out0_vld   ,
	input         out0_rdy   ,
	output        out0_opcode,
	output [31:0] out0_data  ,
	output [3:0]  out0_src_id,
	output [3:0]  out0_tgt_id,
	output        out1_vld   ,
	input         out1_rdy   ,
	output        out1_opcode,
	output [31:0] out1_data  ,
	output [3:0]  out1_src_id,
	output [3:0]  out1_tgt_id);

	//Wire define for this module.
	wire [0:0] hit_tgtid_0__to_rteid_0;
	wire [0:0] hit_tgtid_1__to_rteid_1;
	wire [0:0] hit_tgtid_6__to_rteid_1;
	wire [0:0] channel_mask_0         ;
	wire [0:0] masked_rdy_0           ;
	wire [0:0] channel_mask_1         ;
	wire [0:0] masked_rdy_1           ;

	//Wire define for sub module.

	//Wire define for Inout.

	//Wire sub module connect to this module and inter module connect.
	assign in0_rdy = (masked_rdy_0 || masked_rdy_1);
	
	assign out0_vld = (in0_vld && channel_mask_0);
	
	assign out0_opcode = in0_opcode;
	
	assign out0_data = in0_data;
	
	assign out0_src_id = in0_src_id;
	
	assign out0_tgt_id = in0_tgt_id;
	
	assign out1_vld = (in0_vld && channel_mask_1);
	
	assign out1_opcode = in0_opcode;
	
	assign out1_data = in0_data;
	
	assign out1_src_id = in0_src_id;
	
	assign out1_tgt_id = in0_tgt_id;
	
	assign hit_tgtid_0__to_rteid_0 = (in0_tgt_id == 4'b0);
	
	assign hit_tgtid_1__to_rteid_1 = (in0_tgt_id == 4'b1);
	
	assign hit_tgtid_6__to_rteid_1 = (in0_tgt_id == 4'b110);
	
	assign channel_mask_0 = (hit_tgtid_0__to_rteid_0);
	
	assign masked_rdy_0 = (out0_rdy && channel_mask_0);
	
	assign channel_mask_1 = (hit_tgtid_1__to_rteid_1 || hit_tgtid_6__to_rteid_1);
	
	assign masked_rdy_1 = (out1_rdy && channel_mask_1);
	

	//Wire this module connect to sub module.

	//module inst.

endmodule
//[UHDL]Content End [md5:d0fcb7475fbc83ca581a77ec2a6df1b3]

