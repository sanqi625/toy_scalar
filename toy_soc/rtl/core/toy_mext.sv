

module toy_mext
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
    
        // reg access
        output logic [4:0]                reg_index           ,
        output logic                      reg_wr_en           ,
        output logic [REG_WIDTH-1:0]      reg_val             ,
        output logic [INST_IDX_WIDTH-1:0] reg_inst_idx        ,
        output logic                      inst_commit_en      
    
    );

    logic        [2             : 0]    funct3          ;
    logic signed [REG_WIDTH     : 0]    rs1_val_sign_ext;
    logic signed [REG_WIDTH     : 0]    rs2_val_sign_ext;
    logic signed [2*REG_WIDTH+1 : 0]    rs_mul_val      ;
    logic signed [REG_WIDTH-1   : 0]    rs_div_val      ;
    logic signed [REG_WIDTH-1   : 0]    rs_rem_val      ;
    logic signed [REG_WIDTH     : 0]    rs_div_temp     ;
    logic signed [REG_WIDTH     : 0]    rs_rem_temp     ;
    logic signed [REG_WIDTH     : 0]    rs2_val_div_sign_ext;

    // for warning todo
    assign rs2_val_div_sign_ext = |rs2_val ? rs2_val_sign_ext : {(REG_WIDTH+1){1'b1}};

    always_comb begin
        case(funct3)
            F3_MUL,F3_MULHU,F3_DIVU,F3_REMU    : begin
                rs1_val_sign_ext = $signed({1'b0,rs1_val})                 ;
                rs2_val_sign_ext = $signed({1'b0,rs2_val})                 ;
            end
            F3_MULH,F3_DIV,F3_REM   : begin
                rs1_val_sign_ext = $signed(rs1_val)                        ;
                rs2_val_sign_ext = $signed(rs2_val)                        ;
            end
            F3_MULHSU : begin
                rs1_val_sign_ext = $signed(rs1_val)                        ;
                rs2_val_sign_ext = $signed({1'b0,rs2_val})                 ;
            end
            default   : begin
                rs1_val_sign_ext = $signed({1'b0,rs1_val})                 ;
                rs2_val_sign_ext = $signed({1'b0,rs2_val})                 ;
            end
        endcase
    end


`ifdef FPGA_SIM

    //DW_mult_fpga #(
    //    .A_width    (REG_WIDTH+1        ),
    //    .B_width    (REG_WIDTH+1        ))
    //metx_dw_mult(
    //    .A          (rs1_val_sign_ext   ),
    //    .B          (rs2_val_sign_ext   ),
    //    .TC         (1'b1               ),
    //    .PRODUCT    (rs_mul_val         ));

    //DW_div_fpga # (
    //    .a_width    (REG_WIDTH+1        ),
    //    .b_width    (REG_WIDTH+1        ),
    //    .tc_mode    (1'b1               ),
    //    .rem_mode   (1'b1               ))
    //metx_dw_div(
    //    .a          (rs1_val_sign_ext   ), 
    //    .b          (rs2_val_div_sign_ext), 
    //    .quotient   (rs_div_temp        ), 
    //    .remainder  (rs_rem_temp        ), 
    //    .divide_by_0(                   ));

    assign rs_mul_val = rs1_val_sign_ext * rs2_val_sign_ext;

    assign rs_div_temp = rs1_val_sign_ext / rs2_val_div_sign_ext;
    assign rs_rem_temp = rs1_val_sign_ext % rs2_val_div_sign_ext;

`else

    DW02_mult #(
        .A_width    (REG_WIDTH+1        ),
        .B_width    (REG_WIDTH+1        ))
    metx_dw_mult(
        .A          (rs1_val_sign_ext   ),
        .B          (rs2_val_sign_ext   ),
        .TC         (1'b1               ),
        .PRODUCT    (rs_mul_val         ));

    DW_div # (
        .a_width    (REG_WIDTH+1        ),
        .b_width    (REG_WIDTH+1        ),
        .tc_mode    (1'b1               ),
        .rem_mode   (1'b1               ))
    metx_dw_div(
        .a          (rs1_val_sign_ext   ), 
        .b          (rs2_val_div_sign_ext), 
        .quotient   (rs_div_temp        ), 
        .remainder  (rs_rem_temp        ), 
        .divide_by_0(                   ));

`endif


    assign funct3       = instruction_pld`INST_FIELD_FUNCT3 ;
    assign reg_index    = instruction_pld`INST_FIELD_RD     ;
    assign rs_div_val   = |rs2_val ? rs_div_temp[REG_WIDTH-1 : 0] : {REG_WIDTH{1'b1}} ; 
    assign rs_rem_val   = |rs2_val ? rs_rem_temp[REG_WIDTH-1 : 0] : rs1_val           ; 

    always_comb begin
        case(funct3)
            F3_MUL    : reg_val = rs_mul_val[REG_WIDTH-1:0]                 ;
            F3_MULH   : reg_val = rs_mul_val[2*REG_WIDTH-1:REG_WIDTH]       ;
            F3_MULHSU : reg_val = rs_mul_val[2*REG_WIDTH-1:REG_WIDTH]       ;
            F3_MULHU  : reg_val = rs_mul_val[2*REG_WIDTH-1:REG_WIDTH]       ;
            F3_DIV    : reg_val = rs_div_val[REG_WIDTH-1:0]                 ;
            F3_DIVU   : reg_val = rs_div_val[REG_WIDTH-1:0]                 ;
            F3_REM    : reg_val = rs_rem_val[REG_WIDTH-1:0]                 ;
            F3_REMU   : reg_val = rs_rem_val[REG_WIDTH-1:0]                 ;
            default   : reg_val = rs_rem_val[REG_WIDTH-1:0]                 ;
        endcase
    end

    assign inst_commit_en   = instruction_vld   ;
    assign reg_inst_idx     = instruction_idx   ;
    assign reg_wr_en        = instruction_vld & inst_rd_en  ;
    assign instruction_rdy  = 1'b1              ;



endmodule