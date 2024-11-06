
from uhdl.uhdl import *

class ApbBusModule(Component):


    @property
    def module_name(self):
        return type(self).__name__ if self._module_name == "" else self._module_name

    def __init__(self,mapping_list, module_name=""):
        super().__init__()
        self._module_name = module_name

        self.dat_width = 32
        #self.psel = Input(UInt())
        # receive port
        self.s_paddr   = Input(UInt(32))
        self.s_pwdata  = Input(UInt(32))
        self.s_pwrite  = Input(UInt(1))
        self.s_penable = Input(UInt(1))
        self.s_psel    = Input(UInt(1))
        
        self.s_prdata  = Output(UInt(32))
        self.s_pready  = Output(UInt(1))
        self.s_pslverr = Output(UInt(1))

        # Transmit port
        self.m_pwdata  = Output(UInt(32))
        self.m_pwrite  = Output(UInt(1))
        self.m_penable = Output(UInt(1))
        self.m_paddr   = Output(UInt(32))

        self.m_pwdata  += self.s_pwdata
        self.m_pwrite  += self.s_pwrite
        self.m_penable += self.s_penable
        self.m_paddr   += self.s_paddr

        self.psel_lst    = [self.set("m%d_psel"  %i ,Output(UInt(1)))  for i in range(0,len(mapping_list))] 
        #self.paddr_lst   = [self.set("m%d_paddr" %i, Output(UInt(32))) for i in range(0,len(mapping_list))]

        self.m_ready_lst  = [self.set("m%d_pready"%i,Input(UInt(1)))    for i in range(0,len(mapping_list))]
        self.m_rdata_lst  = [self.set("m%d_rdata" %i,Input(UInt(32)))    for i in range(0,len(mapping_list))]
        self.m_slverr_lst = [self.set("m%d_slverr"%i,Input(UInt(1)))    for i in range(0,len(mapping_list))]

        self.pready_mask  = Wire(UInt(len(mapping_list)))
        self.pslverr_mask = Wire(UInt(len(mapping_list)))
        self.rdata_mask   = [self.set("rdata_mask%d" %i,Wire(UInt(32)))    for i in range(0,len(mapping_list))]

        for i in range(0,len(mapping_list)):

            self.psel_lst[i]    +=  When(And(GreaterEqual(self.s_paddr,UInt(mapping_list[i][0])),Less(self.s_paddr,UInt(mapping_list[i][1])))).\
                                        then(UInt(1,1)).\
                                    otherwise(UInt(1,0))
            self.rdata_mask[i]  += when(self.psel_lst[i]).then(self.m_rdata_lst[i]).otherwise(UInt(self.dat_width,0))

        ready_lst  = [ And(self.psel_lst[i], self.m_ready_lst[i]) for i in range(len(mapping_list))]    
        self.pready_mask    += Combine(*ready_lst)
        self.s_pready       += SelfOr(self.pready_mask)

        #rdata_lst            = [BitAnd(self.rdata_mask[i],self.m_rdata_lst[i]) for i in range(len(mapping_list))]
        self.s_prdata       += BitOr(*self.rdata_mask)

        slverr_lst  = [ And(self.psel_lst[i], self.m_slverr_lst[i]) for i in range(len(mapping_list))]  
        self.pslverr_mask   += Combine(*slverr_lst)
        self.s_pslverr      += SelfOr(self.pslverr_mask)
        #self.s_prdata       += rdata_lst[0]

        #ew = EmptyWhen()
        #for self.psel_lst, dat in CondDatPair:
        #    ew = ew.when(cond).then(dat)
        #ew.otherwise(UInt(32,0))
        #O += ew

class ApbBus(object):

    def __init__(self) -> None:
        self.mapping_list = []
    
    def add_port(self,start_addr,end_addr):
        # do some hazard check
        self.mapping_list.append([start_addr,end_addr])

    def generate_verilog(self):
        # check addr hole.
        module = ApbBusModule(self.mapping_list,"apb_bus")
        module.generate_verilog()


# import apb_bus

bus = ApbBus()
bus.add_port("32'hc0001000", "32'hc0001fff")
bus.add_port("32'hc0002000", "32'hc0002fff")
bus.generate_verilog()

# mapping_list = [
#     ["32'h80000000", "32'hA0000000"],
#     ["32'hA0000000", "32'hC0000000"],
#     ["32'h00000000", "32'h10000000"],
#     ["32'hc0001000", "32'hc000ffff"]# 

# bus = ApbBusModule(mapping_list)
# bus.generate_verilog()

        # IO Define
        # self.clk            = Input(UInt(1))
        # self.rst_n          = Input(UInt(1))
        # self.in0_req        = fwd_pld_type().reverse()
        # self.in0_ack        = bwd_pld_type()

        #self.out1_mem_en            = Output(UInt(1))
        #self.out1_mem_addr          = Output(UInt(32))
        #self.out1_mem_rd_data       = Input(UInt(32))
        #self.out1_mem_wr_data       = Output(UInt(32))
        #self.out1_mem_wr_byte_en    = Output(UInt(4))
        #self.out1_mem_wr_en         = Output(UInt(1))


        # self.out0_req_vld    = Output(UInt(1))
        # self.out0_req_rdy    = Input(UInt(1))
        # self.out0_req_addr   = Output(UInt(32))
        # self.out0_req_data   = Output(UInt(32))
        # self.out0_req_strb   = Output(UInt(4))
        # self.out0_req_opcode = Output(UInt(1))

        # self.out0_ack_vld    = Input(UInt(1))
        # self.out0_ack_rdy    = Output(UInt(1))
        # self.out0_ack_data   = Input(UInt(32))

        
        
        # self.in0_req.rdy    += self.out0_req_rdy    #todo

        # self.in0_ack.opcode += UInt(1,0)
        # self.in0_ack.src_id += UInt(4,0)
        #self.in0_ack.tgt_id += UInt(4,0)


        #self.out1_mem_en            += self.in1_req.vld
        #self.out1_mem_addr          += Combine(UInt(5,0),Cut(self.in1_req.addr,28,2))
        #self.in1_ack.data           += self.out1_mem_rd_data
        #self.out1_mem_wr_data       += self.in1_req.data
        #self.out1_mem_wr_byte_en    += self.in1_req.strb
        #self.out1_mem_wr_en         += self.in1_req.opcode

        # self.out0_req_vld    += self.in0_req.vld
        # self.out0_ack_rdy    += self.in0_ack.rdy 
        # self.out0_req_addr   += self.in0_req.addr
        # #self.out0_req_addr   += Combine(UInt(4,0),Cut(self.in0_req.addr,27,16),UInt(2,0),Cut(self.in0_req.addr,15,2))
        # #self.out0_req_addr   += Combine(UInt(6,0),Cut(self.in0_req.addr,27,2))
        # self.out0_req_data   += self.in0_req.data
        # self.out0_req_strb   += self.in0_req.strb
        # self.out0_req_opcode += self.in0_req.opcode

        # self.in0_ack.data    += self.out0_ack_data 
        # #self.in0_ack.vld     += self.out0_ack_vld

        # self.vld_reg = Reg(UInt(1),self.clk,self.rst_n)
        # self.vld_reg += And(self.in0_req.vld,Not(self.in0_req.opcode))
        # self.in0_ack.vld += self.vld_reg

        # self.node_id_reg = Reg(UInt(4,0),self.clk,self.rst_n)
        # self.node_id_reg += self.in0_req.src_id
        # self.in0_ack.tgt_id += self.node_id_reg

