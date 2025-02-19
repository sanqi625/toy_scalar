# pylint: disable =unused-wildcard-import
from uhdl.uhdl.core import *
# pylint: enable  =unused-wildcard-import

# from .Bundle import LwnocBundle


class ToyDbgMst(Component):

    def __init__(self, node, fwd_pld_type, bwd_pld_type, forward=True):
        super().__init__()
        self.topo_node = node


        # IO Define
        self.clk            = Input(UInt(1))
        self.rst_n          = Input(UInt(1))
        self.in0_req        = fwd_pld_type().reverse()
        self.in0_ack        = bwd_pld_type()

        #self.out1_mem_en            = Output(UInt(1))
        #self.out1_mem_addr          = Output(UInt(32))
        #self.out1_mem_rd_data       = Input(UInt(32))
        #self.out1_mem_wr_data       = Output(UInt(32))
        #self.out1_mem_wr_byte_en    = Output(UInt(4))
        #self.out1_mem_wr_en         = Output(UInt(1))


        self.out0_req_vld    = Output(UInt(1))
        self.out0_req_rdy    = Input(UInt(1))
        self.out0_req_addr   = Output(UInt(32))
        self.out0_req_data   = Output(UInt(32))
        self.out0_req_strb   = Output(UInt(4))
        self.out0_req_opcode = Output(UInt(1))

        self.out0_ack_vld    = Input(UInt(1))
        self.out0_ack_rdy    = Output(UInt(1))
        self.out0_ack_data   = Input(UInt(32))

        
        
        self.in0_req.rdy    += self.out0_req_rdy    #todo

        self.in0_ack.opcode += UInt(1,0)
        self.in0_ack.src_id += UInt(4,0)
        #self.in0_ack.tgt_id += UInt(4,0)


        #self.out1_mem_en            += self.in1_req.vld
        #self.out1_mem_addr          += Combine(UInt(5,0),Cut(self.in1_req.addr,28,2))
        #self.in1_ack.data           += self.out1_mem_rd_data
        #self.out1_mem_wr_data       += self.in1_req.data
        #self.out1_mem_wr_byte_en    += self.in1_req.strb
        #self.out1_mem_wr_en         += self.in1_req.opcode

        self.out0_req_vld    += self.in0_req.vld
        self.out0_ack_rdy    += self.in0_ack.rdy 
        self.out0_req_addr   += self.in0_req.addr
        #self.out0_req_addr   += Combine(UInt(4,0),Cut(self.in0_req.addr,27,16),UInt(2,0),Cut(self.in0_req.addr,15,2))
        #self.out0_req_addr   += Combine(UInt(6,0),Cut(self.in0_req.addr,27,2))
        self.out0_req_data   += self.in0_req.data
        self.out0_req_strb   += self.in0_req.strb
        self.out0_req_opcode += self.in0_req.opcode

        self.in0_ack.data    += self.out0_ack_data 
        #self.in0_ack.vld     += self.out0_ack_vld

        self.vld_reg = Reg(UInt(1),self.clk,self.rst_n)
        self.vld_reg += And(self.in0_req.vld,Not(self.in0_req.opcode))
        self.in0_ack.vld += self.vld_reg

        self.node_id_reg = Reg(UInt(4,0),self.clk,self.rst_n)
        self.node_id_reg += self.in0_req.src_id
        self.in0_ack.tgt_id += self.node_id_reg

