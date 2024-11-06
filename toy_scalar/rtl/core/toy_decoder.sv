

//                      RS1         RS2         RD
// C.ADDI4SPN           X2          -           rd
// C.LW                 rs1         -           rd 
// C.SW                 rs1         rs2         - 


// C.NOP                X0(rs1)     -           X0(rd)
// C.ADDI               rs1         -           rd
// C.JAL                -           -           X1
// C.LI                 X0          -           rd
// C.ADDI16SP           X2(rs1)     -           X2(rd)
// C.LUI                -           -           rd
// C.SRLI               rs1         -           rd
// C.SRAI               rs1         -           rd
// C.ANDI               rs1         -           rd
// C.SUB                rs1         rs2         rd
// C.XOR                rs1         rs2         rd
// C.OR                 rs1         rs2         rd
// C.AND                rs1         rs2         rd
// C.J                  -           -           X0                
// C.BEQZ               rs1         X0          -
// C.BNEZ               rs1         X0          -


// C.SLLI               rs1         -           rd
// C.LWSP               X2          -           rd
// C.JR                 rs1         -           X0
// C.MV                 X0          rs2         rd
// C.EBREAK             -           -           -
// C.JALR               rs1         -           X1
// C.ADD                rs1         rs2         rd
// C.SWSP               X2          rs2         -





module toy_decoder
    import toy_pack::*;
(
    input  logic                      clk                  ,
    input  logic                      rst_n                ,

    input  logic                      fetched_inst_vld     ,
    output logic                      fetched_inst_rdy     ,
    input  logic [INST_WIDTH-1:0]     fetched_inst_pld     , 
    input  logic [ADDR_WIDTH-1:0]     fetched_inst_pc      ,
    input  logic [INST_IDX_WIDTH-1:0] fetched_inst_id      ,

    //input  logic                      csr_intr_instruction_vld  ,
    //output logic                      csr_intr_instruction_rdy  ,


    input  logic [31:0]               register_lock        ,

    output logic                      dec_inst_vld         ,
    input  logic                      dec_inst_rdy         ,
    output logic [INST_WIDTH-1:0]     dec_inst_pld         ,
    output logic [INST_IDX_WIDTH-1:0] dec_inst_id          ,
    output logic [4:0]                dec_inst_rd          ,
    output logic                      dec_inst_rd_en       ,      
    output logic [ADDR_WIDTH-1:0]     dec_inst_pc          ,
    output logic [4:0]                dec_inst_rs1         ,
    output logic [4:0]                dec_inst_rs2         ,
    output logic [31:0]               dec_inst_imm         ,
    //output logic                      dec_inst_is_intr     ,

    output logic                      goto_lsu             ,
    output logic                      goto_alu             ,
    output logic                      goto_err             ,
    output logic                      goto_mext            ,
    output logic                      goto_csr             ,
    output logic                      goto_custom          ,
    output logic                      goto_spu             
);

    logic [4:0]     opcode              ;
    logic [2:0]     funct3              ;
    logic [6:0]     funct7              ;
    logic [11:0]    funct12             ;
    logic           use_rd_en           ;
    logic           use_rs1_en          ;
    logic           use_rs2_en          ;
    logic           reg_lock            ;
    logic [INST_WIDTH-1:0]  p   ;

    logic [31:0]    u_type_imm_32       ;
    logic [31:0]    i_type_imm_32       ;
    logic [31:0]    jar_type_imm_32     ;
    logic [31:0]    branch_type_imm_32  ;

    logic           spu_vld;
    logic           spu_trap_vld;
    logic [31:0]    spu_trap_cause;


    //assign dec_inst_pld = fetched_inst_pld                      ;
    assign dec_inst_id  = fetched_inst_id                       ;
    assign dec_inst_pc  = fetched_inst_pc                       ;
    //assign dec_inst_rd  = fetched_inst_pld`INST_FIELD_RD        ;
    //assign dec_inst_rs1 = fetched_inst_pld`INST_FIELD_RS1       ;
    //assign dec_inst_rs2 = fetched_inst_pld`INST_FIELD_RS2       ;
    
    assign funct3       = fetched_inst_pld`INST_FIELD_FUNCT3    ;
    assign funct7       = fetched_inst_pld`INST_FIELD_FUNCT7    ; 
    assign funct12      = fetched_inst_pld`INST_FIELD_FUNCT12   ;
    assign opcode       = dec_inst_pld`INST_FIELD_OPCODE    ;




    //assign dec_inst_is_intr = 1'b0;

    //assign csr_intr_instruction_vld  = 
    //assign csr_intr_instruction_rdy = 1'b0;


//==========================================================================
// Arbitration
//==========================================================================

    logic dep_checked_vld   ;
    logic dep_checked_rdy   ;
    logic choose_intr       ;

    //assign choose_intr = csr_intr_instruction_vld;

    assign dec_inst_vld             = dep_checked_vld    ;
    assign dep_checked_rdy          = dec_inst_rdy       ; 
    //assign csr_intr_instruction_rdy = choose_intr       ? dec_inst_rdy             : 1'b0               ;

//==========================================================================
// Dependency Check
//==========================================================================

    assign reg_not_lock = ( ~register_lock[dec_inst_rs1] || ~use_rs1_en       ) && 
                          ( ~register_lock[dec_inst_rs2] || ~use_rs2_en       ) && 
                          ( ~register_lock[dec_inst_rd]  || ~dec_inst_rd_en   );

    assign dep_checked_vld  =    fetched_inst_vld   & reg_not_lock;
    assign fetched_inst_rdy =    dep_checked_rdy    & reg_not_lock; 

    always_comb begin
        case(fetched_inst_pld[1:0])
        2'b00:                          dec_inst_rd = {2'b01, fetched_inst_pld[4:2]}    ;
        2'b01: begin
            case(fetched_inst_pld[15:13])
            3'b000:                     dec_inst_rd = fetched_inst_pld[11:7]            ;
            3'b001:                     dec_inst_rd = 5'b00001;
            3'b010:                     dec_inst_rd = fetched_inst_pld[11:7]            ;
            3'b011:                     dec_inst_rd = fetched_inst_pld[11:7]            ;
            3'b100:                     dec_inst_rd = {2'b01, fetched_inst_pld[9:7]}    ;
            3'b101:                     dec_inst_rd = 5'b0;
            3'b110:                     dec_inst_rd = {2'b01, fetched_inst_pld[9:7]}    ;
            3'b111:                     dec_inst_rd = {2'b01, fetched_inst_pld[9:7]}    ;
            default:                    dec_inst_rd = {2'b01, fetched_inst_pld[9:7]}    ;
            endcase
        end
        2'b10: begin
            if((fetched_inst_pld[15:12]==4'b1000) & (fetched_inst_pld[6:2]==5'b0))
                dec_inst_rd = 5'b0;
            else if((fetched_inst_pld[15:12]==4'b1001) & (fetched_inst_pld[6:2]==5'b0))
                dec_inst_rd = 5'b1;
            else
                dec_inst_rd = fetched_inst_pld[11:7];
        end                          
        2'b11:                          dec_inst_rd = fetched_inst_pld`INST_FIELD_RD    ;
        default:                        dec_inst_rd = fetched_inst_pld`INST_FIELD_RD    ;
        endcase
    end




    always_comb begin
        case(fetched_inst_pld[1:0])
        2'b00: begin
            if(fetched_inst_pld[15:13]==3'b000) dec_inst_rs1 = 5'b00010;
            else                                dec_inst_rs1 = {2'b01, fetched_inst_pld[9:7]}   ;
        end
        2'b01: begin
            case(fetched_inst_pld[15:13])
            3'b000:                     dec_inst_rs1 = fetched_inst_pld[11:7]           ;
            3'b001:                     dec_inst_rs1 = 5'b00010;
            3'b010:                     dec_inst_rs1 = fetched_inst_pld[11:7]           ;
            3'b011:                     dec_inst_rs1 = fetched_inst_pld[11:7]           ;
            3'b100:                     dec_inst_rs1 = {2'b01, fetched_inst_pld[9:7]}   ;
            3'b101:                     dec_inst_rs1 = 5'b0;
            3'b110:                     dec_inst_rs1 = {2'b01, fetched_inst_pld[9:7]}   ;
            3'b111:                     dec_inst_rs1 = {2'b01, fetched_inst_pld[9:7]}   ;
            default:                    dec_inst_rs1 = {2'b01, fetched_inst_pld[9:7]}   ;
            endcase
        end
        2'b10: begin
            case(fetched_inst_pc[15:13])
            3'b010:                     dec_inst_rs1 = 5'b00010;
            3'b100:
                if((fetched_inst_pld[12]==1'b0) & (fetched_inst_pld[6:2] !=5'b0))   
                                        dec_inst_rs1 = 5'b0;
                else
                                        dec_inst_rs1 = fetched_inst_pld[11:7];
            3'b110:                     dec_inst_rs1 = 5'b00010;
            default:                    dec_inst_rs1 = fetched_inst_pld[11:7];
            endcase
        end
        2'b11:                          dec_inst_rs1 = fetched_inst_pld`INST_FIELD_RS1  ;
        default:                        dec_inst_rs1 = fetched_inst_pld`INST_FIELD_RS1  ;
        endcase                         
    end

    always_comb begin
        case(fetched_inst_pld[1:0])
        2'b00:                          dec_inst_rs2 = {2'b01, fetched_inst_pld[4:2]}   ;
        2'b01: begin
            if(fetched_inst_pld[15:14]==2'b11)  dec_inst_rs2 = {2'b01, fetched_inst_pld[4:2]}   ;
            else                                dec_inst_rs2 = 5'b0; 
        end                          
        2'b10:                          dec_inst_rs2 = fetched_inst_pld[6:2]            ;
        2'b11:                          dec_inst_rs2 = fetched_inst_pld`INST_FIELD_RS2  ;
        default:                        dec_inst_rs2 = fetched_inst_pld`INST_FIELD_RS2  ;
        endcase
    end

    always_comb begin
        case(fetched_inst_pld[1:0])
        // RV16 Q0 =======================================
        2'b00: begin
            if(fetched_inst_pld[15]) dec_inst_rd_en = 1'b0;
            else                     dec_inst_rd_en = 1'b1;
        end
        // RV16 Q1 =======================================
        2'b01: begin
            case(fetched_inst_pld[15:13])
            3'b110:                  dec_inst_rd_en = 1'b0;
            3'b111:                  dec_inst_rd_en = 1'b0;
            default:                 dec_inst_rd_en = 1'b1;
            endcase
        end
        // RV16 Q2 =======================================
        2'b10: begin
            case(fetched_inst_pld[15:13])
            3'b101:                 dec_inst_rd_en = 1'b0;
            3'b110:                 dec_inst_rd_en = 1'b0;
            3'b111:                 dec_inst_rd_en = 1'b0;
            default:                dec_inst_rd_en = 1'b1; // a little overkill.
            endcase
        end
        // RV32 ==========================================
        2'b11: begin
            case(opcode)
            OPC_BRANCH  :           dec_inst_rd_en = 1'b0;
            OPC_SYSTEM  : begin
                if(funct3==3'b000)  dec_inst_rd_en = 1'b0;
                else                dec_inst_rd_en = 1'b1;
            end
            OPC_STORE   :           dec_inst_rd_en = 1'b0;
            default :               dec_inst_rd_en = 1'b1;
            endcase 
        end
        default: dec_inst_rd_en = 1'b0;
        endcase
    end




    always_comb begin
        case(fetched_inst_pld[1:0])
        // RV16 Q0 =======================================
        2'b00: begin
            if(fetched_inst_pld[15])    use_rs2_en = 1'b1;
            else                        use_rs2_en = 1'b0;
        end
        // RV16 Q1 =======================================
        2'b01: begin
            if((fetched_inst_pld[15:13] == 3'b100) & (fetched_inst_pld[11:10] == 2'b11))    use_rs2_en = 1'b1;
            else                                                                            use_rs2_en = 1'b0;
        end
        // RV16 Q2 =======================================
        2'b10: begin
            if(fetched_inst_pld[15])    use_rs2_en = 1'b1;
            else                        use_rs2_en = 1'b0;
        end
        // RV32 ==========================================
        2'b11: begin
            case(opcode)
            OPC_LUI     :               use_rs2_en = 1'b0;
            OPC_AUIPC   :               use_rs2_en = 1'b0;
            OPC_JAL     :               use_rs2_en = 1'b0;
            OPC_JALR    :               use_rs2_en = 1'b0;
            OPC_LOAD    :               use_rs2_en = 1'b0;
            OPC_OP_IMM  :               use_rs2_en = 1'b0;
            OPC_SYSTEM  :               use_rs2_en = 1'b0;
            default:                    use_rs2_en = 1'b1;    
            endcase   
        end
        default:                        use_rs2_en = 1'b0;
        endcase
    end

    always_comb begin
        case(fetched_inst_pld[1:0])
        // RV16 Q0 =======================================
        2'b00: begin
            use_rs1_en = 1'b1;
            //if(fetched_inst_pld[15:13] == 3'b000)   use_rs1_en = 1'b0;
            //else                                    use_rs1_en = 1'b1;
        end
        // RV16 Q1 =======================================
        2'b01: begin
            case(fetched_inst_pld[15:13])
            3'b001:                                 use_rs1_en = 1'b0;
            3'b101:                                 use_rs1_en = 1'b0;
            default:                                use_rs1_en = 1'b1;
            endcase
        end
        // RV16 Q2 =======================================
        2'b10: begin
            use_rs1_en = 1'b1;
        end
        // RV32 ==========================================
        2'b11: begin
            case(opcode)
            OPC_LUI     :   use_rs1_en = 1'b0;
            OPC_AUIPC   :   use_rs1_en = 1'b0;
            OPC_JAL     :   use_rs1_en = 1'b0;
            default:        use_rs1_en = 1'b1;
            endcase
        end
        default: use_rs1_en = 1'b0;
        endcase
    end


//=====================================================================
// routing
//=====================================================================



    always_comb begin
        goto_alu    = 1'b0;
        goto_lsu    = 1'b0;
        goto_mext   = 1'b0;
        goto_err    = 1'b0;
        goto_csr    = 1'b0;
        goto_custom = 1'b0;
        goto_spu    = 1'b0;
        case (opcode)
            OPC_LUI         :           goto_alu  = 1'b1;
            OPC_AUIPC       :           goto_alu  = 1'b1;
            OPC_JAL         :           goto_alu  = 1'b1;
            OPC_JALR        :           goto_alu  = 1'b1;
            OPC_OP_IMM      :           goto_alu  = 1'b1;
            OPC_OP          : begin
                                if(funct7[0]==1'b1)     
                                    goto_mext = 1'b1;
                                else                    
                                    goto_alu  = 1'b1;
                              end
            OPC_LOAD        :           goto_lsu  = 1'b1;
            OPC_STORE       :           goto_lsu  = 1'b1;
            OPC_AMO         :           goto_lsu  = 1'b1;
            OPC_BRANCH      :           goto_alu  = 1'b1;

            OPC_MISC_MEM    :           goto_alu  = 1'b1;
            OPC_SYSTEM      : begin
                                if( funct3 == F3_PRIV )begin
                                    goto_spu = 1'b1;
                                    goto_csr = 1'b0; 
                                end else begin
                                    goto_spu = 1'b0;
                                    goto_csr = 1'b1;    
                                end
                              end
            OPC_CUST0       :           goto_custom = 1'b1;
            OPC_CUST1       :           goto_custom = 1'b1;
            OPC_CUST2       :           goto_custom = 1'b1;
            OPC_CUST3       :           goto_custom = 1'b1;
            default         :           goto_err  = 1'b1;
        endcase
    end


//=====================================================================
// imm
//=====================================================================

    assign p = fetched_inst_pld;

    assign u_type_imm_32        = {p[31:12], 12'b0};
    assign i_type_imm_32        = {{20{p[31]}}, p[31:20]};
    assign jar_type_imm_32      = {{12{p[31]}}, p[19:12], p[20], p[30:21], 1'b0};
    assign branch_type_imm_32   = {{20{p[31]}}, p[7], p[30:25], p[11:8], 1'b0};

    always_comb begin
        case(p[1:0])
        2'b00: begin
            if(p[15:13] == 3'b000)                  dec_inst_imm = {{22{p[10]}}, p[10:7], p[12:11], p[5], p[6], 2'b00};
            else                                    dec_inst_imm = {{25{p[5]}}, p[5], p[12:10], p[6], 2'b00};
        end
        2'b01: begin
            case(p[15:13])
            3'b000:                                 dec_inst_imm = {{24{p[12]}}, p[12], p[6:2], 2'b00};
            //ignore addiw
            3'b001:                                 dec_inst_imm = {{20{p[12]}}, p[12], p[8], p[10:9], p[6], p[7], p[2], p[11], p[5:3], 1'b0};
            3'b010:                                 dec_inst_imm = {{24{p[12]}}, p[12], p[6:2], 2'b00};
            3'b011: begin
                if(p[11:7] == 5'd2)                 dec_inst_imm = {{22{p[12]}}, p[12], p[4:3], p[5], p[2], p[6], 4'b0};
                else                                dec_inst_imm = {{14{p[12]}}, p[12], p[6:2], 12'b0};   
            end 
            3'b100:                                 dec_inst_imm = {{24{p[12]}}, p[12], p[6:2], 2'b00};
            3'b101:                                 dec_inst_imm = {{20{p[12]}}, p[12], p[8], p[10:9], p[6], p[7], p[2], p[11], p[5:3], 1'b0}; 
            3'b110:                                 dec_inst_imm = {{23{p[12]}}, p[12], p[6:5], p[2], p[11:10], p[4:3], 1'b0};
            3'b111:                                 dec_inst_imm = {{23{p[12]}}, p[12], p[6:5], p[2], p[11:10], p[4:3], 1'b0};
            default:                                dec_inst_imm = {{23{p[12]}}, p[12], p[6:5], p[2], p[11:10], p[4:3], 1'b0};
            endcase
        end
        2'b10: begin
            case(p[15:13])
            3'b000:                                 dec_inst_imm = {{24{p[12]}}, p[12], p[6:2], 2'b00};
            3'b010:                                 dec_inst_imm = {{24{p[3]}}, p[3:2], p[12], p[6:4], 2'b00};
            3'b110:                                 dec_inst_imm = {{24{p[8]}}, p[8:7], p[12:9], 2'b00};
            default:                                dec_inst_imm = {{24{p[8]}}, p[8:7], p[12:9], 2'b00};
            endcase
        end
        2'b11: begin
            case(opcode)
            OPC_LUI     : dec_inst_imm = u_type_imm_32      ;
            OPC_AUIPC   : dec_inst_imm = u_type_imm_32      ;
            OPC_JAL     : dec_inst_imm = jar_type_imm_32    ;
            OPC_JALR    : dec_inst_imm = i_type_imm_32      ;
            OPC_BRANCH  : dec_inst_imm = branch_type_imm_32 ;
            OPC_STORE   : dec_inst_imm = {{20{p[31]}}, p[31:25], p[11:7]}  ;
            OPC_LOAD    : dec_inst_imm = i_type_imm_32      ;
            OPC_AMO     : dec_inst_imm = 32'b0              ;
            default     : dec_inst_imm = i_type_imm_32      ;
            endcase
        end
        default: dec_inst_imm = i_type_imm_32      ;
        endcase
    end


    //============================================================================
    // opcode/funct
    //============================================================================


    always_comb begin
        dec_inst_pld = fetched_inst_pld;
        case(fetched_inst_pld[1:0])
        2'b00: begin
            case(fetched_inst_pld[15:13])
            3'b000: begin //ADDI4SPN
                dec_inst_pld`INST_FIELD_OPCODE = 5'b00100;
                dec_inst_pld`INST_FIELD_FUNCT3 = 3'b000;
            end
            3'b010: begin //LW
                dec_inst_pld`INST_FIELD_OPCODE = 5'b00000;
                dec_inst_pld`INST_FIELD_FUNCT3 = 3'b010;
            end
            3'b110: begin //SW
                dec_inst_pld`INST_FIELD_OPCODE = 5'b01000;
                dec_inst_pld`INST_FIELD_FUNCT3 = 3'b010;
            end
            default:        dec_inst_pld = fetched_inst_pld;
            endcase
        end
        2'b01: begin
            case(fetched_inst_pld[15:13])
            3'b000: begin // ADDI
                dec_inst_pld`INST_FIELD_OPCODE = 5'b00100;
                dec_inst_pld`INST_FIELD_FUNCT3 = 3'b000;
            end
            3'b001: begin // JAL
                dec_inst_pld`INST_FIELD_OPCODE = 5'b11011;
            end
            3'b010: begin // LI
                dec_inst_pld`INST_FIELD_OPCODE = 5'b01101;
            end
            3'b011: begin
                if(fetched_inst_pld[11:7]==5'd2) begin // ADDI16SP
                    dec_inst_pld`INST_FIELD_OPCODE = 5'b00100;
                    dec_inst_pld`INST_FIELD_FUNCT3 = 3'b000;
                end
                else begin //LUI
                    dec_inst_pld`INST_FIELD_OPCODE = 5'b01101;
                end
            end
            3'b100: begin
                case(fetched_inst_pld[11:10])
                2'b00: begin // SRLI
                    dec_inst_pld`INST_FIELD_OPCODE = 5'b00100;
                    dec_inst_pld`INST_FIELD_FUNCT3 = 3'b101;
                    dec_inst_pld[30]               = 1'b0;
                end
                2'b01: begin // SRAI
                    dec_inst_pld`INST_FIELD_OPCODE = 5'b00100;
                    dec_inst_pld`INST_FIELD_FUNCT3 = 3'b101;
                    dec_inst_pld[30]               = 1'b1;
                end
                2'b10: begin // ANDI 
                    dec_inst_pld`INST_FIELD_OPCODE = 5'b00100;
                    dec_inst_pld`INST_FIELD_FUNCT3 = 3'b111;
                end
                2'b11: begin
                    case(fetched_inst_pld[6:5])
                    2'b00: begin // SUB
                        dec_inst_pld`INST_FIELD_OPCODE = 5'b01100;
                        dec_inst_pld`INST_FIELD_FUNCT3 = 3'b000;
                    end
                    2'b01: begin // XOR
                        dec_inst_pld`INST_FIELD_OPCODE = 5'b01100;
                        dec_inst_pld`INST_FIELD_FUNCT3 = 3'b100;
                    end
                    2'b10: begin // OR
                        dec_inst_pld`INST_FIELD_OPCODE = 5'b01100;
                        dec_inst_pld`INST_FIELD_FUNCT3 = 3'b110;
                    end
                    2'b11: begin // AND
                        dec_inst_pld`INST_FIELD_OPCODE = 5'b01100;
                        dec_inst_pld`INST_FIELD_FUNCT3 = 3'b111;
                    end
                    default: dec_inst_pld = fetched_inst_pld;
                    endcase
                end
                default: dec_inst_pld = fetched_inst_pld;
                endcase
            end
            3'b101: begin // J
                dec_inst_pld`INST_FIELD_OPCODE = 5'b11011;
            end
            3'b110: begin // BEQZ
                dec_inst_pld`INST_FIELD_OPCODE = 5'b11000;
                dec_inst_pld`INST_FIELD_FUNCT3 = 3'b000;
            end
            3'b111: begin // BNEZ
                dec_inst_pld`INST_FIELD_OPCODE = 5'b11000;
                dec_inst_pld`INST_FIELD_FUNCT3 = 3'b001;
            end
            default:        dec_inst_pld = fetched_inst_pld;
            endcase
        end
        2'b10: begin
            case(fetched_inst_pld[15:13])
            3'b000: begin // SLLI
                dec_inst_pld`INST_FIELD_OPCODE = 5'b00100;
                dec_inst_pld`INST_FIELD_FUNCT3 = 3'b001;
            end
            3'b010: begin // LWSP
                dec_inst_pld`INST_FIELD_OPCODE = 5'b00000;
                dec_inst_pld`INST_FIELD_FUNCT3 = 3'b010;
            end
            3'b100: begin
                if(fetched_inst_pld[12]==1'b0) begin
                    if(fetched_inst_pld[6:2]==5'b0) begin //JR
                        dec_inst_pld`INST_FIELD_OPCODE = 5'b11001;
                    end
                    else begin // MV
                        dec_inst_pld`INST_FIELD_OPCODE = 5'b01100;
                        dec_inst_pld`INST_FIELD_FUNCT3 = 3'b000;  
                    end
                end
                else begin
                    if((fetched_inst_pld[11:7]==5'b0) & (fetched_inst_pld[6:2]==5'b0)) begin // EBREAK
                        dec_inst_pld`INST_FIELD_OPCODE = 5'b11100;
                        dec_inst_pld[21]               = 1'b1;
                    end
                    else if(fetched_inst_pld[6:2]==5'b0) begin // JALR
                        dec_inst_pld`INST_FIELD_OPCODE = 5'b11001;
                    end
                    else begin // ADD
                        dec_inst_pld`INST_FIELD_OPCODE = 5'b01100;
                        dec_inst_pld`INST_FIELD_FUNCT3 = 3'b000;                        
                    end
                end
            end
            3'b110: begin // SWSP
                dec_inst_pld`INST_FIELD_OPCODE = 5'b01000;
                dec_inst_pld`INST_FIELD_FUNCT3 = 3'b010;
            end
            default:        dec_inst_pld = fetched_inst_pld;
            endcase
        end
        2'b11:              dec_inst_pld = fetched_inst_pld;
        default:            dec_inst_pld = fetched_inst_pld;
        endcase
    end



    // DEBUG =========================================================================================================

    `ifdef TOY_SIM

        logic [31:0] reg_lock_cnt;

        always @(posedge clk or negedge rst_n) begin
            if(~rst_n)                                      reg_lock_cnt <= 0;
            else if(fetched_inst_vld   & (~reg_not_lock))   reg_lock_cnt <= reg_lock_cnt + 1;
        end

        initial begin
            if($test$plusargs("DEBUG")) begin
                forever begin
                    @(posedge clk)
                    if(goto_err) begin
                        $display("[DECODE] system_exception cause is ILLEGAL INSTRUCTION \n" );
                        $display("[DECODE] goto error !!! ");
                        $display("[DECODE] pc_val  = %0h", fetched_inst_pc  );
                        $display("[DECODE] inst_val  = %0h", fetched_inst_pld  );
                    end

                    if(goto_spu ) begin
                        $display("[DECODE] goto spu !!! ");
                        $display("[DECODE] pc_val  = %0h", fetched_inst_pc  );
                        $display("[DECODE] inst_val  = %0h", fetched_inst_pld  );
                    end
                end
            end
        end

    `endif



endmodule




    // always_comb begin
    //     use_rs1_en  = 1'b0;
    //     use_rs2_en  = 1'b0;
    //     use_rd_en   = 1'b0;
    //     case(fetched_instruction_pld[1:0]):
    //     2'b00: begin
    //         case(fetched_instruction_pld[15:13])
    //         3'b000: begin
    //             use_rd_en   = 1'b1;
    //         end
    //         3'b010: begin
    //             use_rs1_en  = 1'b1;
    //             urs_rd_en   = 1'b1;
    //         end
    //         3'b110: begin
    //             use_rs1_en  = 1'b1;
    //             use_rs2_en  = 1'b1;
    //         end
    //         default: begin
    //             use_rs1_en  = 1'b1;
    //             use_rs2_en  = 1'b1;
    //         end
    //         endcase
    //     end
    //     2'b01: begin

    //     end
    //     2'b10: begin

    //     end
    //     2'b11: begin
    //     
    //     end
    //     default: begin

    //     end
    //     endcase
    // end




    // always_comb begin
    //     case(fetched_instruction_pld[1:0]):
    //     2'b00: begin
    //         rs1 = {2'b00,fetched_instruction_pld[9:7]}      ;
    //         rs2 = {2'b00,fetched_instruction_pld[4:2]}      ;
    //         rd  = {2'b00,fetched_instruction_pld[4:2]}      ;
    //     end
    //     2'b01: begin
    //         if(fetched_instruction_pld[15]) begin
    //             rs1 = {2'b00,fetched_instruction_pld[9:7]}  ; 
    //             rs2 = {2'b00,fetched_instruction_pld[4:2]}  ;
    //             rd  = {2'b00,fetched_instruction_pld[9:7]}  ;
    //         end
    //         else begin
    //             rs1 = fetched_instruction_pld[11:7]         ;
    //             rs2 = 5'b00000;
    //             rd  = fetched_instruction_pld[11:7]         ;
    //         end
    //     end
    //     2'b10: begin
    //         rs1 = fetched_instruction_pld[11:7]             ;
    //         rs2 = fetched_instruction_pld[6:2]              ;
    //         rd  = fetched_instruction_pld[11:7]             ;
    //     end
    //     2'b11: begin
    //         rs1 = fetched_instruction_pld`INST_FIELD_RS1    ;
    //         rs2 = fetched_instruction_pld`INST_FIELD_RS2    ;
    //         rd  = fetched_instruction_pld`INST_FIELD_RD     ;
    //     end
    //     default: begin
    //         rs1 = fetched_instruction_pld`INST_FIELD_RS1    ;
    //         rs2 = fetched_instruction_pld`INST_FIELD_RS2    ;
    //         rd  = fetched_instruction_pld`INST_FIELD_RD     ;
    //     end
    //     endcase
    // end