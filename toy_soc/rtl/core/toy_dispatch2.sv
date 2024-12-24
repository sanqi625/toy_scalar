
module toy_dispatch2
    import toy_pack::*;
(

    // Decode =============================================
    input  logic                      dec_inst_vld        ,
    output logic                      dec_inst_rdy        ,
    input  logic [INST_WIDTH-1:0]     dec_inst_pld        ,
    input  logic [INST_IDX_WIDTH-1:0] dec_inst_idx        ,
    input  logic [4:0]                dec_inst_rd         ,
    input  logic                      dec_inst_rd_en      ,
    input  logic [ADDR_WIDTH-1:0]     dec_inst_pc         ,
    input  logic [REG_WIDTH-1:0]      dec_inst_rs1_val    ,
    input  logic [REG_WIDTH-1:0]      dec_inst_rs2_val    ,
    input  logic                      dec_goto_lsu        ,
    input  logic                      dec_goto_alu        ,
    input  logic                      dec_goto_

    // LSU ================================================
    output logic                      lsu_inst_vld        ,
    input  logic                      lsu_inst_rdy        ,
    output logic [INST_WIDTH-1:0]     lsu_inst_pld        ,
    output logic [INST_IDX_WIDTH-1:0] lsu_inst_idx        ,
    output logic [4:0]                lsu_inst_rd         ,
    output logic                      lsu_inst_rd_en      ,
    output logic [ADDR_WIDTH-1:0]     lsu_inst_pc         ,
    output logic [REG_WIDTH-1:0]      lsu_inst_rs1_val    ,
    output logic [REG_WIDTH-1:0]      lsu_inst_rs2_val    ,

    // ALU ================================================
    output logic                      alu_inst_vld        ,
    input  logic                      alu_inst_rdy        ,
    output logic [INST_WIDTH-1:0]     alu_inst_pld        ,
    output logic [INST_IDX_WIDTH-1:0] alu_inst_idx        ,
    output logic [4:0]                alu_inst_rd         ,
    output logic                      alu_inst_rd_en      ,
    output logic [ADDR_WIDTH-1:0]     alu_inst_pc         ,
    output logic [REG_WIDTH-1:0]      alu_inst_rs1_val    ,
    output logic [REG_WIDTH-1:0]      alu_inst_rs2_val    ,

    // MEXT ===============================================
    output logic                      mext_inst_vld       ,
    input  logic                      mext_inst_rdy       ,
    output logic [INST_WIDTH-1:0]     mext_inst_pld       ,
    output logic [INST_IDX_WIDTH-1:0] mext_inst_idx       ,
    output logic [4:0]                mext_inst_rd        ,
    output logic                      mext_inst_rd_en     ,
    output logic [ADDR_WIDTH-1:0]     mext_inst_pc        ,
    output logic [REG_WIDTH-1:0]      mext_inst_rs1_val   ,
    output logic [REG_WIDTH-1:0]      mext_inst_rs2_val   ,

    // CSR ================================================
    output logic                      csr_inst_vld        ,
    input  logic                      csr_inst_rdy        ,
    output logic [INST_WIDTH-1:0]     csr_inst_pld        ,
    output logic [INST_IDX_WIDTH-1:0] csr_inst_idx        ,
    output logic [4:0]                csr_inst_rd         ,
    output logic                      csr_inst_rd_en      ,
    output logic [ADDR_WIDTH-1:0]     csr_inst_pc         ,
    output logic [REG_WIDTH-1:0]      csr_inst_rs1_val    ,
    output logic [REG_WIDTH-1:0]      csr_inst_rs2_val    ,


    // CUST ===============================================
    output logic                      CUST_inst_vld       ,
    input  logic                      CUST_inst_rdy       ,
    output logic [INST_WIDTH-1:0]     CUST_inst_pld       ,
    output logic [INST_IDX_WIDTH-1:0] CUST_inst_idx       ,
    output logic [4:0]                CUST_inst_rd        ,
    output logic                      CUST_inst_rd_en     ,
    output logic [ADDR_WIDTH-1:0]     CUST_inst_pc        ,
    output logic [REG_WIDTH-1:0]      CUST_inst_rs1_val   ,
    output logic [REG_WIDTH-1:0]      CUST_inst_rs2_val   
);

endmodule