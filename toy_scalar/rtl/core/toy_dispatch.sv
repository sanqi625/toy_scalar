

module toy_dispatch 
    import toy_pack::*;
(
    input  logic                      clk                         ,
    input  logic                      rst_n                       ,

`ifdef FPGA_SIM 
    input logic                       ila_clk,
`endif
    input  logic                      fetched_instruction_vld     ,
    output logic                      fetched_instruction_rdy     ,
    input  logic [INST_WIDTH-1:0]     fetched_instruction_pld     , 
    input  logic [ADDR_WIDTH-1:0]     fetched_instruction_pc      ,
    input  logic [INST_IDX_WIDTH-1:0] fetched_instruction_idx     ,
    input  logic [32:0]               fetched_instruction_op      ,

    // LSU =========================================================================
    output logic                      lsu_instruction_vld         ,
    input  logic                      lsu_instruction_rdy         ,
    output logic [INST_WIDTH-1:0]     lsu_instruction_pld         ,
    output logic [INST_IDX_WIDTH-1:0] lsu_instruction_idx         ,
    output logic [4:0]                lsu_inst_rd_idx             ,
    output logic                      lsu_inst_rd_en              ,
    output logic [31:0]               lsu_inst_imm                ,      
    output logic [ADDR_WIDTH-1:0]     lsu_pc                      ,
    output logic [REG_WIDTH-1:0]      lsu_rs1_val                 ,
    output logic [REG_WIDTH-1:0]      lsu_rs2_val                 ,

    input  logic [4:0]                lsu_reg_index               ,
    input  logic                      lsu_reg_wr_en               ,
    input  logic [REG_WIDTH-1:0]      lsu_reg_val                 ,
    input  logic [INST_IDX_WIDTH-1:0] lsu_reg_inst_idx_rd         ,
    input  logic [INST_IDX_WIDTH-1:0] lsu_reg_inst_idx_wr         ,
    input                             lsu_inst_commit_en_rd       ,
    input                             lsu_inst_commit_en_wr       ,

    // ALU =========================================================================
    output logic                      alu_instruction_vld         ,
    input  logic                      alu_instruction_rdy         ,
    output logic [INST_WIDTH-1:0]     alu_instruction_pld         ,
    output logic [INST_IDX_WIDTH-1:0] alu_instruction_idx         ,
    output logic [4:0]                alu_inst_rd_idx             ,
    output logic                      alu_inst_rd_en              , 
    output logic [31:0]               alu_inst_imm                ,
    output logic [ADDR_WIDTH-1:0]     alu_pc                      ,
    output logic [REG_WIDTH-1:0]      alu_rs1_val                 ,
    output logic [REG_WIDTH-1:0]      alu_rs2_val                 ,

    input  logic [4:0]                alu_reg_index               ,
    input  logic                      alu_reg_wr_en               ,
    input  logic [REG_WIDTH-1:0]      alu_reg_val                 ,
    input  logic [INST_IDX_WIDTH-1:0] alu_reg_inst_idx            ,
    input                             alu_inst_commit_en          ,

    // MEXT =========================================================================
    output logic                      mext_instruction_vld        ,
    input  logic                      mext_instruction_rdy        ,
    output logic [INST_WIDTH-1:0]     mext_instruction_pld        ,
    output logic [INST_IDX_WIDTH-1:0] mext_instruction_idx        ,
    output logic [4:0]                mext_inst_rd_idx            ,
    output logic                      mext_inst_rd_en             , 
    output logic [31:0]               mext_inst_imm               ,
    output logic [ADDR_WIDTH-1:0]     mext_pc                     ,
    output logic [REG_WIDTH-1:0]      mext_rs1_val                ,
    output logic [REG_WIDTH-1:0]      mext_rs2_val                ,

    input  logic [4:0]                mext_reg_index              ,
    input  logic                      mext_reg_wr_en              ,
    input  logic [REG_WIDTH-1:0]      mext_reg_val                ,
    input  logic [INST_IDX_WIDTH-1:0] mext_reg_inst_idx           ,
    input                             mext_inst_commit_en         ,
    


    // Custom 0 ====================================================================
    output logic                      custom_instruction_vld      ,
    input  logic                      custom_instruction_rdy      ,
    output logic [INST_WIDTH-1:0]     custom_instruction_pld      ,
    output logic [REG_WIDTH-1:0]      custom_rs1_val              ,
    output logic [REG_WIDTH-1:0]      custom_rs2_val              ,
    output logic [ADDR_WIDTH-1:0]     custom_pc                   ,


    // CSR =========================================================================
    output logic                      csr_instruction_vld         ,
    input  logic                      csr_instruction_rdy         ,
    output logic [INST_WIDTH-1:0]     csr_instruction_pld         ,
    output logic [INST_IDX_WIDTH-1:0] csr_instruction_idx         ,
    //output logic                      csr_instruction_is_intr     ,
    output logic [4:0]                csr_inst_rd_idx             ,
    output logic                      csr_inst_rd_en              , 
    output logic [31:0]               csr_inst_imm                ,
    output logic [ADDR_WIDTH-1:0]     csr_pc                      ,
    output logic [REG_WIDTH-1:0]      csr_rs1_val                 ,
    output logic [REG_WIDTH-1:0]      csr_rs2_val                 ,

    input  logic [4:0]                csr_reg_index               ,
    input  logic                      csr_reg_wr_en               ,
    input  logic [REG_WIDTH-1:0]      csr_reg_val                 ,
    input  logic [INST_IDX_WIDTH-1:0] csr_reg_inst_idx            ,
    input                             csr_inst_commit_en          ,

    output logic [63:0]               csr_INSTRET                 ,

    // SPU =========================================================================

    output logic                      spu_instruction_vld         ,
    input  logic                      spu_instruction_rdy         ,
    output logic [INST_WIDTH-1:0]     spu_instruction_pld         ,
    output logic [INST_IDX_WIDTH-1:0] spu_instruction_idx         ,
    output logic                      spu_instruction_op          ,  //1'b0 is normal, 1'b1 is trap
    output logic [31:0]               front_trap_cause            ,
    output logic [ADDR_WIDTH-1:0]     spu_pc                                
);

    logic [31:0] wr_ch0_en_bitmap;
    logic [31:0] wr_ch1_en_bitmap;
    logic [31:0] wr_ch2_en_bitmap;
    logic [31:0] wr_ch3_en_bitmap;


    logic goto_lsu      ;
    logic goto_alu      ;
    logic goto_err      ;
    logic goto_mext     ;
    logic goto_csr      ;
    logic goto_custom   ;
    logic goto_trap     ;

    logic                      dec_inst_vld         ;
    logic                      dec_inst_rdy         ;
    logic [INST_WIDTH-1:0]     dec_inst_pld         ;
    logic [INST_IDX_WIDTH-1:0] dec_inst_id          ;
    logic [4:0]                dec_inst_rd          ;
    logic                      dec_inst_rd_en       ;
    logic [ADDR_WIDTH-1:0]     dec_inst_pc          ;
    logic [4:0]                dec_inst_rs1         ;
    logic [4:0]                dec_inst_rs2         ;
    logic [31:0]               dec_inst_imm         ;
    //logic                      dec_inst_is_intr     ;

    logic [31:0]               register_lock;
    logic [31:0]               register_lock_release;

    logic                      system_exception_en;
    logic [31:0]               system_cause;

    logic                      trap_vld;
    logic                      fetched_real_instruction_vld;

//real instruction is not interrupt 
    assign goto_trap                    = fetched_instruction_op[32]==1 ;

    assign trap_vld                     = fetched_instruction_vld && goto_trap;
    assign fetched_real_instruction_vld = fetched_instruction_vld && ~fetched_instruction_op[32];  

    toy_decoder u_dec (
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),
        .fetched_inst_vld   (fetched_real_instruction_vld    ),
        .fetched_inst_rdy   (fetched_instruction_rdy    ),
        .fetched_inst_pld   (fetched_instruction_pld    ), 
        .fetched_inst_pc    (fetched_instruction_pc     ),
        .fetched_inst_id    (fetched_instruction_idx    ),
        //.csr_intr_instruction_vld  (csr_intr_instruction_vld    ),
        //.csr_intr_instruction_rdy  (csr_intr_instruction_rdy    ),

        .register_lock      (register_lock              ),
        .dec_inst_vld       (dec_inst_vld               ),
        .dec_inst_rdy       (dec_inst_rdy               ),
        .dec_inst_pld       (dec_inst_pld               ),
        .dec_inst_id        (dec_inst_id                ),
        .dec_inst_rd        (dec_inst_rd                ),
        .dec_inst_rd_en     (dec_inst_rd_en             ),
        .dec_inst_pc        (dec_inst_pc                ),
        .dec_inst_rs1       (dec_inst_rs1               ),
        .dec_inst_rs2       (dec_inst_rs2               ),
        .dec_inst_imm       (dec_inst_imm               ),
        //.dec_inst_is_intr   (dec_inst_is_intr           ),
        .goto_lsu           (goto_lsu                   ),
        .goto_alu           (goto_alu                   ),
        .goto_err           (goto_err                   ),
        .goto_mext          (goto_mext                  ),
        .goto_csr           (goto_csr                   ),
        .goto_custom        (goto_custom                ),
        .goto_spu           (goto_spu                   )
        //.system_exception_en(system_exception_en        ),
        //.system_cause       (system_cause               )
        );

////==========================================================================
//  ecall/ebreak and illegal instruction exception. goto spu
//  sret/mret/dret and wfi instruction goto spu
//  fetch trap goto spu
//==========================================================================

//fetched_instruction_op[32] indicate trap, op[31] indicates interrupt

assign spu_instruction_op           = (goto_err || goto_trap)   ? 1'b1 : 1'b0;  // 1 is trap, 0 is normal

assign front_trap_cause[31:0]       = (goto_err && dec_inst_vld) ? MCAUSE_ILLEGAL_INSTR : fetched_instruction_op[31:0];

//==========================================================================
// Dispatch
//==========================================================================

    //assign csr_instruction_is_intr  = dec_inst_is_intr;

    assign alu_inst_imm             = dec_inst_imm;
    assign lsu_inst_imm             = dec_inst_imm;
    //assign custom_inst_imm          = dec_inst_imm;
    assign csr_inst_imm             = dec_inst_imm;
    assign mext_inst_imm            = dec_inst_imm;


    assign alu_pc                   = dec_inst_pc;
    assign lsu_pc                   = dec_inst_pc;
    assign custom_pc                = dec_inst_pc;
    assign csr_pc                   = dec_inst_pc;
    assign mext_pc                  = dec_inst_pc;
    assign spu_pc                   = dec_inst_pc;

    assign alu_instruction_idx      = dec_inst_id;
    assign lsu_instruction_idx      = dec_inst_id;
    assign mext_instruction_idx     = dec_inst_id;
    assign csr_instruction_idx      = dec_inst_id;
    assign spu_instruction_idx      = dec_inst_id;

    assign alu_inst_rd_idx          = dec_inst_rd;
    assign lsu_inst_rd_idx          = dec_inst_rd;
    assign csr_inst_rd_idx          = dec_inst_rd;
    assign mext_inst_rd_idx         = dec_inst_rd;

    assign alu_inst_rd_en           = dec_inst_rd_en;
    assign lsu_inst_rd_en           = dec_inst_rd_en;
    assign csr_inst_rd_en           = dec_inst_rd_en;
    assign mext_inst_rd_en          = dec_inst_rd_en;

    assign lsu_instruction_pld      = dec_inst_pld;
    assign alu_instruction_pld      = dec_inst_pld;
    assign mext_instruction_pld     = dec_inst_pld;
    assign csr_instruction_pld      = dec_inst_pld;
    assign custom_instruction_pld   = dec_inst_pld;
    assign spu_instruction_pld      = dec_inst_pld;

    assign lsu_instruction_vld      =  dec_inst_vld  & goto_lsu    ;
    assign alu_instruction_vld      =  dec_inst_vld  & goto_alu    ;
    assign mext_instruction_vld     =  dec_inst_vld  & goto_mext   ;
    assign csr_instruction_vld      =  dec_inst_vld  & goto_csr    ;
    assign custom_instruction_vld   =  dec_inst_vld  & goto_custom ;
    assign spu_instruction_vld      = (dec_inst_vld  & (goto_spu || goto_err) ) ||  trap_vld ;

    // todo.  lsu rdy has some problems.
    assign dec_inst_rdy = (goto_lsu                  & lsu_instruction_rdy      ) |
                          (goto_alu                  & alu_instruction_rdy      ) |
                          (goto_mext                 & mext_instruction_rdy     ) |
                          (goto_csr                  & csr_instruction_rdy      ) |
                          (goto_custom               & custom_instruction_rdy   ) | 
                          ( (goto_spu || goto_err )  & spu_instruction_rdy      ) ;
                          //( goto_trap                & spu_instruction_rdy      );

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                                  csr_INSTRET <= 64'b0;
        else if(fetched_real_instruction_vld && fetched_instruction_rdy) csr_INSTRET <= csr_INSTRET + 1'b1;
    end


//==========================================================================
// Reg File
//==========================================================================

    generate for(genvar i=0;i<32;i=i+1) begin
        
        assign register_lock_release[i] =   wr_ch0_en_bitmap[i] | 
                                            wr_ch1_en_bitmap[i] |
                                            wr_ch2_en_bitmap[i] |
                                            wr_ch3_en_bitmap[i] ;

        if(i==0) begin
            assign register_lock[i] = 1'b0;
        end
        else begin
            always_ff @(posedge clk or negedge rst_n) begin
                if(~rst_n)                                                                      register_lock[i] <= 1'b0;
                else if(register_lock_release[i] )                                              register_lock[i] <= 1'b0;
                else if(dec_inst_vld && dec_inst_rdy && (dec_inst_rd == i) && dec_inst_rd_en)   register_lock[i] <= 1'b1;
            end
        end
    end endgenerate



    always_comb begin
        wr_ch0_en_bitmap = 32'b0;
        wr_ch0_en_bitmap[lsu_reg_index] = lsu_reg_wr_en;
    end

    always_comb begin
        wr_ch1_en_bitmap = 32'b0;
        wr_ch1_en_bitmap[alu_reg_index] = alu_reg_wr_en;
    end

    always_comb begin
        wr_ch2_en_bitmap = 32'b0;
        wr_ch2_en_bitmap[csr_reg_index] = csr_reg_wr_en;
    end

    always_comb begin
        wr_ch3_en_bitmap = 32'b0;
        wr_ch3_en_bitmap[mext_reg_index] = mext_reg_wr_en;
    end


    toy_regfile u_rf(
        .clk                (clk                ),
        .rst_n              (rst_n              ),
`ifdef FPGA_SIM
        .ila_clk                 (ila_clk),
        .fetched_instruction_vld (fetched_instruction_vld),
        .fetched_instruction_pld (fetched_instruction_pld),
        .fetched_instruction_pc  (fetched_instruction_pc ),
`endif
        // input channel =========================
        .wr_ch0_en_bitmap   (wr_ch0_en_bitmap   ),
        .wr_ch1_en_bitmap   (wr_ch1_en_bitmap   ),
        .wr_ch2_en_bitmap   (wr_ch2_en_bitmap   ),
        .wr_ch3_en_bitmap   (wr_ch3_en_bitmap   ),
        .wr_ch0_data        (lsu_reg_val        ),
        .wr_ch1_data        (alu_reg_val        ),
        .wr_ch2_data        (csr_reg_val        ),
        .wr_ch3_data        (mext_reg_val       ),
        // output channel ========================
        .rd_ch0_index       (dec_inst_rs1       ),
        .rd_ch1_index       (dec_inst_rs2       ),
        .rd_ch2_index       (dec_inst_rs1       ),
        .rd_ch3_index       (dec_inst_rs2       ),
        .rd_ch4_index       (dec_inst_rs1       ),
        .rd_ch5_index       (dec_inst_rs2       ),
        .rd_ch6_index       (dec_inst_rs1       ),
        .rd_ch7_index       (dec_inst_rs2       ),
        .rd_ch0_data        (lsu_rs1_val        ),
        .rd_ch1_data        (lsu_rs2_val        ),
        .rd_ch2_data        (alu_rs1_val        ),
        .rd_ch3_data        (alu_rs2_val        ),
        .rd_ch4_data        (mext_rs1_val       ),
        .rd_ch5_data        (mext_rs2_val       ),
        .rd_ch6_data        (csr_rs1_val        ),
        .rd_ch7_data        (csr_rs2_val        ));

        assign custom_rs1_val = alu_rs1_val;
        assign custom_rs2_val = alu_rs2_val;


    // DEBUG =========================================================================================================

    `ifdef TOY_SIM
    initial begin
        if($test$plusargs("DEBUG")) begin
            forever begin
                @(posedge clk)

                $display("===");
                $display("register_lock         = %b" , register_lock);
                $display("register_lock_release = %b" , register_lock_release);

                if(fetched_real_instruction_vld && fetched_instruction_rdy) begin
                    $display("[dispatch] receive instruction %h, decode goto_alu=%0d, goto_lsu=%0d." , fetched_instruction_pld,goto_alu,goto_lsu);
                end

                if(alu_instruction_vld && alu_instruction_rdy) begin
                    $display("[dispatch] issue instruction %h to alu." , alu_instruction_pld);
                    $display("[dispatch] rs1=%0d, rs2=%0d." , dec_inst_rs1, dec_inst_rs2);
                    $display("[dispatch] rs1_val=0x%h, rs2_val=0x%h." , alu_rs1_val, alu_rs2_val);
                end

                if(lsu_instruction_vld && lsu_instruction_rdy) begin
                    $display("[dispatch] issue instruction %h to lsu." , lsu_instruction_pld);
                end

                // if (reg_wr_en) begin
                //     $display("[dispatch] wb reg[%0d] = %h" , reg_index,reg_val);
                // end

            end
        end
    end

    logic [31:0] reg_stall;
    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) reg_stall <= 32'b0;
        else if(~fetched_instruction_rdy) reg_stall <= reg_stall + 1;
    end


    logic [REG_WIDTH-1:0] registers_shadow         [0:31]  ;
    logic [INST_WIDTH-1:0] fetched_instruction_pld_lut  [0:(1<<INST_IDX_WIDTH)-1];
    logic [ADDR_WIDTH-1:0] fetched_instruction_pc_lut   [0:(1<<INST_IDX_WIDTH)-1];

    function string print_all_reg_shadow();
        string res;
        $sformat(res, "zo:%h ra:%h sp:%h gp:%h tp:%h t0:%h t1:%h t2:%h s0:%h s1:%h a0:%h a1:%h a2:%h a3:%h a4:%h a5:%h a6:%h a7:%h s2:%h s3:%h s4:%h s5:%h s6:%h s7:%h s8:%h s9:%h s10:%h s11:%h t3:%h t4:%h t5:%h t6:%h", 
            registers_shadow[0]  ,
            registers_shadow[1]  ,
            registers_shadow[2]  ,
            registers_shadow[3]  ,
            registers_shadow[4]  ,
            registers_shadow[5]  ,
            registers_shadow[6]  ,
            registers_shadow[7]  ,
        
            registers_shadow[8]  ,
            registers_shadow[9]  ,
            registers_shadow[10] ,
            registers_shadow[11] ,
            registers_shadow[12] ,
            registers_shadow[13] ,
            registers_shadow[14] ,
            registers_shadow[15] ,
        
            registers_shadow[16] ,
            registers_shadow[17] ,
            registers_shadow[18] ,
            registers_shadow[19] ,
            registers_shadow[20] ,
            registers_shadow[21] ,
            registers_shadow[22] ,
            registers_shadow[23] ,

            registers_shadow[24] ,
            registers_shadow[25] ,
            registers_shadow[26] ,
            registers_shadow[27] ,
            registers_shadow[28] ,
            registers_shadow[29] ,
            registers_shadow[30] ,
            registers_shadow[31] );
        return res;
    endfunction

    initial begin
        int file_handle;
        for(int i=0;i<32;i=i+1) begin
            registers_shadow[i] = 0;
        end

        file_handle = $fopen("sim_trace.log", "w");
        forever begin
            @(posedge clk)

            // update reorder buffer ===========================================================
            if(fetched_real_instruction_vld && fetched_instruction_rdy) begin
                fetched_instruction_pld_lut[fetched_instruction_idx] = fetched_instruction_pld;
                fetched_instruction_pc_lut[fetched_instruction_idx]  = fetched_instruction_pc;
            end 

            // update shadowreg file ===========================================================
            for(int i=0;i<32;i=i+1) begin
                registers_shadow[i] = u_toy_scalar.u_core.u_dispatch.u_rf.registers[i];
            end


            if(lsu_inst_commit_en_rd) begin
                $fdisplay(file_handle, "[pc=%h][%s]", fetched_instruction_pc_lut[lsu_reg_inst_idx_rd] ,  print_all_reg_shadow());
                if(lsu_reg_wr_en)
                    registers_shadow[lsu_reg_index] = lsu_reg_val;
            end

            if(alu_inst_commit_en) begin
                $fdisplay(file_handle, "[pc=%h][%s]", fetched_instruction_pc_lut[alu_reg_inst_idx]    ,  print_all_reg_shadow());
            end
            
            if(mext_inst_commit_en) begin
                $fdisplay(file_handle, "[pc=%h][%s]", fetched_instruction_pc_lut[mext_reg_inst_idx]   ,  print_all_reg_shadow());
            end
            
            if(csr_inst_commit_en) begin
                $fdisplay(file_handle, "[pc=%h][%s]", fetched_instruction_pc_lut[csr_reg_inst_idx]    ,  print_all_reg_shadow());        
            end
            
            if(lsu_inst_commit_en_wr)begin
                $fdisplay(file_handle, "[pc=%h][%s]", fetched_instruction_pc_lut[lsu_reg_inst_idx_wr] ,  print_all_reg_shadow());
            end
        end
    end



    `endif


endmodule

            // check reorder buffer
            //if(lsu_inst_commit_en_rd)   $fdisplay(file_handle, "[pc=0x%h][inst=%h][reg idx=%4d][%s]", fetched_instruction_pc_lut[lsu_reg_inst_idx_rd]   , fetched_instruction_pld_lut[lsu_reg_inst_idx_rd]  ,  lsu_reg_inst_idx_rd  ,  print_all_reg());
            //if(alu_inst_commit_en)      $fdisplay(file_handle, "[pc=0x%h][inst=%h][reg idx=%4d][%s]", fetched_instruction_pc_lut[alu_reg_inst_idx]      , fetched_instruction_pld_lut[alu_reg_inst_idx]     ,  alu_reg_inst_idx     ,  print_all_reg());
            //if(mext_inst_commit_en)     $fdisplay(file_handle, "[pc=0x%h][inst=%h][reg idx=%4d][%s]", fetched_instruction_pc_lut[mext_reg_inst_idx]     , fetched_instruction_pld_lut[mext_reg_inst_idx]    ,  mext_reg_inst_idx    ,  print_all_reg());
            //if(csr_inst_commit_en)      $fdisplay(file_handle, "[pc=0x%h][inst=%h][reg idx=%4d][%s]", fetched_instruction_pc_lut[csr_reg_inst_idx]      , fetched_instruction_pld_lut[csr_reg_inst_idx]     ,  csr_reg_inst_idx     ,  print_all_reg());
            //if(lsu_inst_commit_en_wr)   $fdisplay(file_handle, "[pc=0x%h][inst=%h][reg idx=%4d][%s]", fetched_instruction_pc_lut[lsu_reg_inst_idx_wr]   , fetched_instruction_pld_lut[lsu_reg_inst_idx_wr]  ,  lsu_reg_inst_idx_wr  ,  print_all_reg());
            
    //logic use_rs1_en;
    //logic use_rs2_en;




    //assign fetched_instruction_rdy = ( ~register_lock[rs1] || ~use_rs1_en   ) && 
    //                                 ( ~register_lock[rs2] || ~use_rs2_en   ) && 
    //                                 ( ~register_lock[rd]  || ~use_rd_en    );  

    // ecall and ebreak also do not use rs and rd, 
    // but these two instructions cause the pipeline to clear 
    // and pessimistic locking does not cause ipc to drop further.
        
    //always_comb begin
    //    case(opcode)
    //    OPC_BRANCH  :           use_rd_en = 1'b0;
    //    OPC_SYSTEM  : begin
    //        if(funct3==3'b000)  use_rd_en = 1'b0;
    //        else                use_rd_en = 1'b1;
    //    end
    //    OPC_STORE   :           use_rd_en = 1'b0;
    //    default :               use_rd_en = 1'b1;
    //    endcase 
    //end

    // always_comb begin
    //     case(opcode)
    //     OPC_LUI     :   use_rs2_en = 1'b0;
    //     OPC_AUIPC   :   use_rs2_en = 1'b0;
    //     OPC_JAL     :   use_rs2_en = 1'b0;
    //     OPC_JALR    :   use_rs2_en = 1'b0;
    //     OPC_LOAD    :   use_rs2_en = 1'b0;
    //     OPC_OP_IMM  :   use_rs2_en = 1'b0;
    //     OPC_SYSTEM  :   use_rs2_en = 1'b0;
    //     default:        use_rs2_en = 1'b1;    
    //     endcase    
    // end

    // always_comb begin
    //     case(opcode)
    //     OPC_LUI     :   use_rs1_en = 1'b0;
    //     OPC_AUIPC   :   use_rs1_en = 1'b0;
    //     OPC_JAL     :   use_rs1_en = 1'b0;
    //     default:        use_rs1_en = 1'b1;
    //     endcase
    // end

    //always_comb begin
    //    goto_alu    = 1'b0;
    //    goto_lsu    = 1'b0;
    //    goto_mext   = 1'b0;
    //    goto_err    = 1'b0;
    //    goto_csr    = 1'b0;
    //    goto_custom = 1'b0;
    //    case (opcode)
    //        OPC_LUI         :           goto_alu  = 1'b1;
    //        OPC_AUIPC       :           goto_alu  = 1'b1;
    //        OPC_JAL         :           goto_alu  = 1'b1;
    //        OPC_JALR        :           goto_alu  = 1'b1;
    //        OPC_OP_IMM      :           goto_alu  = 1'b1;
    //        OPC_OP          : begin
    //            if(funct7[0]==1'b1)     goto_mext = 1'b1;
    //            else                    goto_alu  = 1'b1;
    //        end
    //        OPC_LOAD        :           goto_lsu  = 1'b1;
    //        OPC_STORE       :           goto_lsu  = 1'b1;

    //        OPC_BRANCH      :           goto_alu  = 1'b1;

    //        OPC_MISC_MEM    :           goto_alu  = 1'b1;
    //        OPC_SYSTEM      :           goto_csr  = 1'b1;
    //        OPC_CUST0       :           goto_custom = 1'b1;
    //        default         :           goto_err  = 1'b1;
    //    endcase
    //end
    //assign opcode   = fetched_instruction_pld`INST_FIELD_OPCODE ;
    //assign funct12  = fetched_instruction_pld`INST_FIELD_FUNCT12;
    //assign funct3   = fetched_instruction_pld`INST_FIELD_FUNCT3 ;
    //assign funct7   = fetched_instruction_pld`INST_FIELD_FUNCT7 ;
    //assign rs1      = fetched_instruction_pld`INST_FIELD_RS1    ;
    //assign rs2      = fetched_instruction_pld`INST_FIELD_RS2    ;
    //assign rd       = fetched_instruction_pld`INST_FIELD_RD     ;

    //logic [4:0]     opcode      ;
    //logic [11:0]    funct12     ;
    //logic [2:0]     funct3      ;
    //logic [6:0]     funct7      ;
    //logic [4:0]     rs1         ;
    //logic [4:0]     rs2         ;
    //logic [4:0]     rd          ;
    //logic           use_rd_en   ;


    //pc_buffer;

    // input  logic                      fetched_instruction_vld     ,
    // output logic                      fetched_instruction_rdy     ,
    // input  logic [INST_WIDTH-1:0]     fetched_instruction_pld     , 
    // input  logic [ADDR_WIDTH-1:0]     fetched_instruction_pc      ,
    // input  logic [INST_IDX_WIDTH-1:0] fetched_instruction_idx     ,
//    function string print_all_reg();
//        string res;
//        $sformat(res, "zo:%h ra:%h sp:%h gp:%h tp:%h t0:%h t1:%h t2:%h s0:%h s1:%h a0:%h a1:%h a2:%h a3:%h a4:%h a5:%h a6:%h a7:%h s2:%h s3:%h s4:%h s5:%h s6:%h s7:%h s8:%h s9:%h s10:%h s11:%h t3:%h t4:%h t5:%h t6:%h", 
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[0]  ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[1]  ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[2]  ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[3]  ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[4]  ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[5]  ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[6]  ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[7]  ,
//            
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[8]  ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[9]  ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[10] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[11] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[12] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[13] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[14] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[15] ,
//            
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[16] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[17] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[18] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[19] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[20] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[21] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[22] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[23] ,

//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[24] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[25] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[26] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[27] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[28] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[29] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[30] ,
//            u_toy_scalar.u_core.u_dispatch.u_rf.registers[31] );
//        return res;
//    endfunction
