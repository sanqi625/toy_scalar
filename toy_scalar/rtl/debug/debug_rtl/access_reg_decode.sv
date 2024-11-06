
module access_reg_decode
    import toy_pack::*;
    import debug_pack::*;
(
    input  command_t                abstract_command,

    //output logic                    abstract_command_en,
    output logic [INST_WIDTH-1:0]   access_reg_inst0,
    output logic [INST_WIDTH-1:0]   access_reg_inst1,
    output logic                    command_size_err
    //output logic [INST_WIDTH-1:0]   access_reg_inst2,
);

localparam CSRRW_FUNCT = 3'b001; //CSR write
localparam CSRRS_FUNCT = 3'b010; //CSR read

logic abstract_command_en;
logic access_register_en;
logic access_memory_en;
logic access_csr_en;     
logic access_gpr_en;     
logic access_reserved_en;

logic reg_rd;
logic reg_wr;

logic [11:0] imm12;
logic [4:0]  rs1;
logic [4:0]  rd;
logic [INST_WIDTH-1:0]  gpr_ld_inst;
logic [INST_WIDTH-1:0]  gpr_sw_inst;
logic [INST_WIDTH-1:0]  access_gpr_inst0;
logic [INST_WIDTH-1:0]  access_gpr_inst1;

logic [11:0]    csr_addr;
logic [4:0]     csr_rs1;
logic [4:0]     csr_rs2;
logic [4:0]     csr_rd;
logic [2:0]     csr_funct3;
logic [6:0]     csr_opcode;

logic [INST_WIDTH-1:0]  csrrs_read;
logic [INST_WIDTH-1:0]  csrrw_write;
logic [INST_WIDTH-1:0]  csr_ld_s0;
logic [INST_WIDTH-1:0]  csr_sw_s0;
logic [INST_WIDTH-1:0]  csrr_inst0;
logic [INST_WIDTH-1:0]  csrr_inst1;
logic [INST_WIDTH-1:0]  csrw_inst0;
logic [INST_WIDTH-1:0]  csrw_inst1;
logic [INST_WIDTH-1:0]  access_csr_inst0;
logic [INST_WIDTH-1:0]  access_csr_inst1;

logic [2:0]             support_size;

assign abstract_command_en  = abstract_command.transfer;

assign access_register_en   = abstract_command.cmdtype==ACCESS_REG_COMMAND;
assign access_memory_en     = abstract_command.cmdtype==ACCESS_MEM_COMMAND;

// regno: 0x0000 ~ 0x0FFF, CSR
// regno: 0x1000 ~ 0x101f, GPR
// regno: 0x1020 ~ 0x103f , float point register
assign access_csr_en        = (abstract_command.regno[15:12] == 4'h0) && access_register_en;
assign access_gpr_en        = (abstract_command.regno[15:12] == 4'h1) && access_register_en; //GPR and floating point register
assign access_reserved_en   = (abstract_command.regno[15:12] == 4'hc) && access_register_en;

assign reg_rd = ~abstract_command.write && abstract_command_en;
assign reg_wr =  abstract_command.write && abstract_command_en;
/*=====================================================*/
/*                ACCESS REGISTER - GPR                */
/*=====================================================*/
//load instruction, lw <gpr>, 0x400(zero)

assign imm12[11:0] = 12'h400; //data register
assign rs1[4:0]    = 5'b0;
assign rd[4:0]     = abstract_command.regno[4:0];

assign gpr_ld_inst[INST_WIDTH-1:0]        = {imm12[11:0],rs1[4:0],3'b010,rd[4:0],7'b0000011};

//store instruction, sw <gpr>, 0x400(zero)
assign gpr_sw_inst[INST_WIDTH-1:0]        = {imm12[11:5],rd[4:0],rs1[4:0],3'b010,imm12[4:0],7'b0100011};

assign access_gpr_inst0[INST_WIDTH-1:0]   = reg_wr ? gpr_ld_inst[31:0] : 
                                                reg_rd ? gpr_sw_inst[31:0] : NOP;
assign access_gpr_inst1[INST_WIDTH-1:0]   = NOP;

// jump to progbuf cmd is jal x0,0x7fd0_706f (offset is relative to 0x2000_0004)
//assign cmd_jump_inst[31:0]      = 32'h7fd0_706f;

/*=====================================================*/
/*                ACCESS REGISTER - CSR                */
/*=====================================================*/

assign csr_addr[11:0]   = abstract_command.regno[11:0];
assign csr_rs1[4:0]     = 5'h8; //s0
assign csr_rs2[4:0]     = 5'h8; //s0
assign csr_rd[4:0]      = 5'h8; //s0
assign csr_funct3[2:0]  = reg_rd ? CSRRS_FUNCT : CSRRW_FUNCT;
assign csr_opcode[6:0]  = {OPC_SYSTEM,2'b11};

//CSRRW&CSRRS
//{CSR_ADDR,RS1,FUNCT,RD,OPCPDE}, S0 is temp register
assign csrrs_read[INST_WIDTH-1:0]    = {csr_addr[11:0] , 5'h0        ,   csr_funct3[2:0],    csr_rd[4:0],    csr_opcode[6:0]}; //CSRRS
assign csrrw_write[INST_WIDTH-1:0]   = {csr_addr[11:0] , csr_rs1[4:0],   csr_funct3[2:0],    5'h0       ,    csr_opcode[6:0]}; //CSRRW

//lsw gpr to s0, ld s0 to gpr
assign csr_ld_s0[INST_WIDTH-1:0] = {imm12[11:0],    5'h0,           3'b010      ,   csr_rd[4:0],                7'b0000011};
assign csr_sw_s0[INST_WIDTH-1:0] = {imm12[11:5],    csr_rs2[4:0],   5'h0        ,   3'b010     ,    imm12[4:0], 7'b0100011};

// DM READ
assign csrr_inst0[INST_WIDTH-1:0] = csrrs_read[INST_WIDTH-1:0]; //csr->s0
assign csrr_inst1[INST_WIDTH-1:0] = csr_sw_s0[INST_WIDTH-1:0]; // s0->data

//DM Write
assign csrw_inst0[INST_WIDTH-1:0] = csr_ld_s0[INST_WIDTH-1:0]; //data->s0
assign csrw_inst1[INST_WIDTH-1:0] = csrrw_write[INST_WIDTH-1:0]; //s0->csr

//csr access instruciton
assign access_csr_inst0[INST_WIDTH-1:0] = reg_rd ?  csrr_inst0[31:0] : 
                                          reg_wr ?  csrw_inst0[31:0] : NOP;

assign access_csr_inst1[INST_WIDTH-1:0] = reg_rd ?  csrr_inst1[31:0] :
                                          reg_wr ?  csrw_inst1[31:0] : NOP;

/*=====================================================*/
/*                          SEL                        */
/*=====================================================*/

assign access_reg_inst0[INST_WIDTH-1:0] = access_csr_en ? access_csr_inst0[INST_WIDTH-1:0]   :
                                            access_gpr_en ? access_gpr_inst0[INST_WIDTH-1:0] :
                                            access_reserved_en ? NOP : NOP;
assign access_reg_inst1[INST_WIDTH-1:0] = access_csr_en ? access_csr_inst1[INST_WIDTH-1:0]   :
                                            access_gpr_en ? access_gpr_inst1[INST_WIDTH-1:0] :
                                            access_reserved_en ? NOP : NOP;
//assign access_reg_inst2[INST_WIDTH-1:0] = NOP; 

/*=====================================================*/
/*                   arsize detect                     */
/*=====================================================*/

assign support_size[2:0]    = (RV_XLEN == 8'd32) ? 3'd2 : 
                                (RV_XLEN == 8'd64) ? 3'd3 : 3'd1;

//assign size_32          = abstract_command.arsize == 3'd2;
//assign size_64          = abstract_command.arsize == 3'd3;
//assign size_128         = abstract_command.arsize == 3'd4;

assign command_size_err = (abstract_command.arsize > support_size[2:0]) ? 1'b1 : 1'b0;

endmodule
