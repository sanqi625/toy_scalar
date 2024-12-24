
module toy_alu
    import toy_pack::*;
(
    input  logic                      clk                 ,
    input  logic                      rst_n               ,

    input  logic                      instruction_vld     ,
    output logic                      instruction_rdy     ,
    input  logic [INST_WIDTH-1:0]     instruction_pld     ,
    input  logic [INST_IDX_WIDTH-1:0] instruction_idx     ,
    input  logic [4:0]                inst_rd_idx         ,
    input  logic                      inst_rd_en          ,
    input  logic [REG_WIDTH-1:0]      rs1_val             ,
    input  logic [REG_WIDTH-1:0]      rs2_val             ,
    input  logic [ADDR_WIDTH-1:0]     pc                  ,
    input  logic [31:0]               inst_imm            ,
    
    // reg access
    output logic [4:0]                reg_index           ,
    output logic                      reg_wr_en           ,
    output logic [REG_WIDTH-1:0]      reg_data            ,
    output logic [INST_IDX_WIDTH-1:0] reg_inst_idx        ,
    output logic                      inst_commit_en      ,

    output logic [ADDR_WIDTH-1:0]     alu_pc              ,//add

    // pc update
    output logic                      pc_release_en       ,
    output logic                      pc_update_en        ,
    output logic [ADDR_WIDTH-1:0]     pc_val          
);


    logic [2:0]     funct3          ;
    logic [4:0]     opcode          ;
    logic [31:0]    opc_op_data;

    assign reg_inst_idx     = instruction_idx;
    assign inst_commit_en   = instruction_vld;

    assign opcode = instruction_pld`INST_FIELD_OPCODE;
    assign funct3 = instruction_pld`INST_FIELD_FUNCT3;


    assign instruction_rdy  = 1'b1;
//=================================================================================================================
// register update
//=================================================================================================================

    //==================================================================
    // for critical path opt in add/sub mux
    //==================================================================
        logic [32:0] opc_op_addsub_rs1;
        logic [32:0] opc_op_addsub_rs2_imm;
        logic [32:0] opc_op_addsub;
        //rs1
        always_comb begin
            if(instruction_pld[5] && instruction_pld[30])begin
                opc_op_addsub_rs1 = {rs1_val,1'b1};
            end
            else begin
                opc_op_addsub_rs1 = {rs1_val,1'b0};
            end
        end
        //rs2/imm
        always_comb begin
            if(instruction_pld[5])begin
                if(instruction_pld[30])begin
                    opc_op_addsub_rs2_imm = {~rs2_val,1'b1};
                end
                else begin
                    opc_op_addsub_rs2_imm = {rs2_val,1'b0};
                end
            end
            else begin
                opc_op_addsub_rs2_imm = {inst_imm,1'b0};
            end
        end

        assign opc_op_addsub = opc_op_addsub_rs1 + opc_op_addsub_rs2_imm;
    //=================================================================
    // for area opt
    //=================================================================


        assign opc_op_data = instruction_pld[5] ? rs2_val : inst_imm;


    always_comb begin
        case(opcode)
        OPC_LUI          : reg_data = inst_imm;
        OPC_AUIPC        : reg_data = inst_imm + pc; // todo adder overflow.
        OPC_JALR         : reg_data = pc + 4;
        OPC_JAL          : reg_data = pc + 4;
        OPC_OP_IMM,OPC_OP: begin
            case(funct3)
            F3_ADDSUB    : reg_data = opc_op_addsub[32:1];
            F3_SLL       : reg_data = rs1_val << opc_op_data[4:0];
            F3_SLT       : reg_data = $signed(rs1_val) < $signed(opc_op_data);
            F3_SLTU      : reg_data = rs1_val < opc_op_data;
            F3_XOR       : reg_data = rs1_val ^ opc_op_data;
            F3_OR        : reg_data = rs1_val | opc_op_data;
            F3_AND       : reg_data = rs1_val & opc_op_data;
            F3_SR        : reg_data = instruction_pld[30] ? ($signed(rs1_val) >>> opc_op_data[4:0])  // sra
                                                         : ($signed(rs1_val) >> opc_op_data[4:0]);           // srl
            default      : reg_data = 32'b0;
            endcase end
        OPC_BRANCH       : reg_data = 32'b0;
        default          : reg_data = 32'b0;
        endcase
    end



    assign reg_wr_en = instruction_vld & inst_rd_en;
    assign reg_index = inst_rd_idx;


//=================================================================================================================
// pc update
//=================================================================================================================
    
    logic pc_release_en_pre ;
    logic pc_update_en_pre  ;

    assign pc_release_en    = pc_release_en_pre  && instruction_vld ;
    assign pc_update_en     = pc_update_en_pre   && instruction_vld ;


    always_comb begin
        case(opcode)
        OPC_JAL             : pc_release_en_pre = 1'b1;
        OPC_JALR            : pc_release_en_pre = 1'b1;
        OPC_BRANCH          : pc_release_en_pre = 1'b1;
        default             : pc_release_en_pre = 1'b0;
        endcase
    end

    always_comb begin
        case(opcode)
        OPC_JAL             : pc_update_en_pre = 1'b1;
        OPC_JALR            : pc_update_en_pre = 1'b1;
        OPC_BRANCH          : begin
            case(funct3)
                F3_BEQ      : pc_update_en_pre = (rs1_val == rs2_val);
                F3_BNE      : pc_update_en_pre = (rs1_val != rs2_val); 
                F3_BLT      : pc_update_en_pre = ($signed(rs1_val) <  $signed(rs2_val));
                F3_BGE      : pc_update_en_pre = ($signed(rs1_val) >= $signed(rs2_val));
                F3_BLTU     : pc_update_en_pre = (rs1_val <  rs2_val);
                F3_BGEU     : pc_update_en_pre = (rs1_val >= rs2_val);
                default     : pc_update_en_pre = 1'b0;
            endcase end
        default             : pc_update_en_pre = 1'b0;
        endcase
    end

    always_comb begin
        case(opcode)
        OPC_JAL             : pc_val = pc + inst_imm;
        OPC_JALR            : pc_val = (rs1_val + inst_imm) & 32'hff_ff_ff_fe; // set LSB to 0
        OPC_BRANCH          : pc_val = pc + inst_imm;
        default             : pc_val = pc + inst_imm;   //32'b0; // todo intr
        endcase
    end

//===================================================================
// Exception
//===================================================================
    //assign csr_addr  = instruction_pld`INST_FIELD_FUNCT12   ;
    //assign funct12   = instruction_pld`INST_FIELD_FUNCT12   ;
//
    //assign instruction_rdy = 1'b1;
//
    //always_comb begin
    //    exception_en = 1'b0;
    //    if(funct3 == F3_PRIV) begin
    //        if ((funct12==F12_ECALL)|(funct12==F12_EBREAK)) begin
    //            exception_en = instruction_vld && instruction_rdy;
    //        end
    //    end
    //end
//
    assign alu_pc               = pc;
    //assign alu_exception_cause  = 'b0;
    //assign alu_exception_en     = 1'b0;


    `ifdef TOY_SIM
    initial begin
        if($test$plusargs("DEBUG")) begin
            forever begin
                @(posedge clk)
                if(instruction_vld && instruction_rdy) begin
                    $display("[alu] receive inst[%h]=%h, opcode=%5b, imm=%0d,%b",pc, instruction_pld, opcode, inst_imm, instruction_pld);
                    $display("[alu] rs1_val= 0x%h ,rs2_val= 0x%h, i_type_imm_32= 0x%h", rs1_val, rs2_val, inst_imm);
                    $display("[alu] reg_update_val = 0x%h ,reg update index %0d ,reg update en %0d", reg_data,reg_index,reg_wr_en);
                    $display("[alu] pc_release_en = %0b", pc_release_en );
                    $display("[alu] pc_update_en  = %0b", pc_update_en  );
                    $display("[alu] pc_val  = %0d", pc_val  );

                    //$display("[alu] reg_data = instruction_pld[30] ? ($signed(rs1_val) >>> rs2_val[4:0]) : (rs1_val >> rs2_val[4:0]);");
                    //$display("[alu] %h = %h ? (%h >>> %h) : (%h >> %h);",reg_data,instruction_pld[30],$signed(rs1_val),i_type_imm_32[4:0],rs1_val,i_type_imm_32[4:0]);
                end
            end
        end
    end
    `endif

endmodule


    //logic [31:0]    u_type_imm_32   ;
    //logic [31:0]    i_type_imm_32   ;
    //logic [31:0]    jar_type_imm_32 ;
    //logic [31:0]    branch_type_imm_32  ;

    //assign u_type_imm_32        = {instruction_pld[31:12], 12'b0};
    //assign i_type_imm_32        = {{20{instruction_pld[31]}}, instruction_pld[31:20]};
    //assign jar_type_imm_32      = {{12{instruction_pld[31]}}, instruction_pld[19:12], instruction_pld[20], instruction_pld[30:21], 1'b0};
    //assign branch_type_imm_32   = {{20{instruction_pld[31]}}, instruction_pld[7], instruction_pld[30:25], instruction_pld[11:8], 1'b0};



    // always_comb begin
    //     case(opcode)
    //     OPC_LUI         : reg_wr_en = instruction_vld;
    //     OPC_AUIPC       : reg_wr_en = instruction_vld;
    //     OPC_JALR        : reg_wr_en = instruction_vld;
    //     OPC_JAL         : reg_wr_en = instruction_vld;
    //     OPC_OP_IMM      : reg_wr_en = instruction_vld;
    //     OPC_OP          : reg_wr_en = instruction_vld;
    //     OPC_BRANCH      : reg_wr_en = 1'b0; 
    //     default         : reg_wr_en = 1'b0;
    //     endcase
    // end