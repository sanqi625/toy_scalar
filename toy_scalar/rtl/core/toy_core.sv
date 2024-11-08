
module toy_core
    import toy_pack::*;
(
`ifdef FPGA_SIM
    input  logic                        ila_clk    ,
`endif 
    input  logic                      clk                     ,
    input  logic                      rst_n                   ,

    input  logic                      fetch_mem_ack_vld       ,
    output logic                      fetch_mem_ack_rdy       ,
    input  logic [INST_WIDTH-1:0]     fetch_mem_ack_data      ,
    output logic [ADDR_WIDTH-1:0]     fetch_mem_req_addr      ,
    output logic                      fetch_mem_req_vld       ,
    input  logic                      fetch_mem_req_rdy       ,


    output logic                      lsu_mem_req_vld         ,
    input  logic                      lsu_mem_req_rdy         ,
    output logic [ADDR_WIDTH-1:0]     lsu_mem_req_addr        ,
    output logic [DATA_WIDTH-1:0]     lsu_mem_req_data        ,
    output logic [DATA_WIDTH/8-1:0]   lsu_mem_req_strb        ,
    output logic                      lsu_mem_req_opcode      ,
    input  logic                      lsu_mem_ack_vld         ,
    output logic                      lsu_mem_ack_rdy         ,
    input  logic [DATA_WIDTH-1:0]     lsu_mem_ack_data        ,


    output logic                      custom_instruction_vld        ,
    input  logic                      custom_instruction_rdy        ,
    output logic [INST_WIDTH-1:0]     custom_instruction_pld        ,
    output logic [REG_WIDTH-1:0]      custom_rs1_val                ,
    output logic [REG_WIDTH-1:0]      custom_rs2_val                ,
    output logic [ADDR_WIDTH-1:0]     custom_pc                     ,

    input  logic                      intr_meip               ,
    input  logic                      intr_msip               ,
    input  logic                      debug_halt_req          

    //output logic                      debug_halt_ack

);

    logic                      trap_vld            ;
    logic [ADDR_WIDTH-1:0]     trap_pc             ;
    logic [31:0]               trap_cause          ;
    //logic                      trap_type           ;  //exception or interrupt
    logic [ADDR_WIDTH-1:0]     trap_extra_info     ;  //mtval
    logic                      trap_step_rel       ;
    logic                      trap_rdy            ;

    logic                      jb_pc_release_en             ;
    logic                      jb_pc_update_en              ;
    logic [ADDR_WIDTH-1:0]     jb_pc_val                    ;

    logic                      fetched_instruction_vld      ;
    logic                      fetched_instruction_rdy      ;
    logic [INST_WIDTH-1:0]     fetched_instruction_pld      ; 
    logic [ADDR_WIDTH-1:0]     fetched_instruction_pc       ;
    logic [INST_IDX_WIDTH-1:0] fetched_instruction_idx      ;
    logic [32:0]               fetched_instruction_op       ;

    // alu ==================================================
    logic                      alu_instruction_vld          ;
    logic                      alu_instruction_rdy          ;
    logic [INST_WIDTH-1:0]     alu_instruction_pld          ;
    logic [INST_IDX_WIDTH-1:0] alu_instruction_idx          ;
    logic [4:0]                alu_inst_rd_idx              ;
    logic                      alu_inst_rd_en               ;
    logic [31:0]               alu_inst_imm                 ;


    logic [REG_WIDTH-1:0]      alu_rs1_val                  ;
    logic [REG_WIDTH-1:0]      alu_rs2_val                  ;
    logic [ADDR_WIDTH-1:0]     alu_pc                       ;


    logic [4:0]                alu_reg_index                ;  
    logic                      alu_reg_wr_en                ;  
    logic [REG_WIDTH-1:0]      alu_reg_val                  ;  
    logic [INST_IDX_WIDTH-1:0] alu_reg_inst_idx             ;
    logic                      alu_inst_commit_en           ;


    // lsu ==================================================
    logic                      lsu_instruction_vld          ;
    logic                      lsu_instruction_rdy          ;
    logic [INST_WIDTH-1:0]     lsu_instruction_pld          ;
    logic [INST_IDX_WIDTH-1:0] lsu_instruction_idx          ;
    logic [4:0]                lsu_inst_rd_idx              ;
    logic                      lsu_inst_rd_en               ;
    logic [REG_WIDTH-1:0]      lsu_rs1_val                  ;
    logic [REG_WIDTH-1:0]      lsu_rs2_val                  ;
    logic [ADDR_WIDTH-1:0]     lsu_pc                       ;
    logic [31:0]               lsu_inst_imm                 ;

    logic [4:0]                lsu_reg_index                ;
    logic                      lsu_reg_wr_en                ;
    logic [REG_WIDTH-1:0]      lsu_reg_val                  ;
    logic [INST_IDX_WIDTH-1:0] lsu_reg_inst_idx_wr          ;
    logic [INST_IDX_WIDTH-1:0] lsu_reg_inst_idx_rd          ;
    logic                      lsu_inst_commit_en_wr        ;
    logic                      lsu_inst_commit_en_rd        ;
    

    // mext ==================================================
    logic                      mext_instruction_vld          ;
    logic                      mext_instruction_rdy          ;
    logic [INST_WIDTH-1:0]     mext_instruction_pld          ;
    logic [INST_IDX_WIDTH-1:0] mext_instruction_idx          ;
    logic [4:0]                mext_inst_rd_idx              ;
    logic                      mext_inst_rd_en               ;
    logic [ADDR_WIDTH-1:0]     mext_pc                       ;
    logic [REG_WIDTH-1:0]      mext_rs1_val                  ;
    logic [REG_WIDTH-1:0]      mext_rs2_val                  ;
    logic [31:0]               mext_inst_imm                 ;

    logic [4:0]                mext_reg_index                ;
    logic                      mext_reg_wr_en                ;
    logic [REG_WIDTH-1:0]      mext_reg_val                  ;
    logic [INST_IDX_WIDTH-1:0] mext_reg_inst_idx             ;
    logic                      mext_inst_commit_en           ;

    // csr ===================================================
    logic                      csr_instruction_vld           ;
    logic                      csr_instruction_rdy           ;
    logic [INST_WIDTH-1:0]     csr_instruction_pld           ;
    logic [INST_IDX_WIDTH-1:0] csr_instruction_idx           ;
    logic                      csr_instruction_is_intr       ;
    logic [4:0]                csr_inst_rd_idx               ;
    logic                      csr_inst_rd_en                ;
    logic [REG_WIDTH-1:0]      csr_rs1_val                   ;
    logic [REG_WIDTH-1:0]      csr_rs2_val                   ;
    logic [ADDR_WIDTH-1:0]     csr_pc                        ;
    logic [31:0]               csr_inst_imm                  ;

    logic [4:0]                csr_reg_index                 ;
    logic                      csr_reg_wr_en                 ;
    logic [REG_WIDTH-1:0]      csr_reg_val                   ;
    logic [INST_IDX_WIDTH-1:0] csr_reg_inst_idx              ;
    logic                      csr_inst_commit_en            ;

    logic                      dm_halt_req_en;

    logic [63:0]               csr_INSTRET                   ;

    //logic                      csr_intr_instruction_vld      ;
    //logic                      csr_intr_instruction_rdy      ;

    // retire  ===================================================
    logic [4:0]                retire_lsu_reg_index               ;
    logic                      retire_lsu_reg_wr_en               ;
    logic [REG_WIDTH-1:0]      retire_lsu_reg_val                 ;
    logic [INST_IDX_WIDTH-1:0] retire_lsu_reg_inst_idx_rd         ;
    logic [INST_IDX_WIDTH-1:0] retire_lsu_reg_inst_idx_wr         ;
    logic                      retire_lsu_inst_commit_en_rd       ;
    logic                      retire_lsu_inst_commit_en_wr       ;

    //ALU
    logic [4:0]                retire_alu_reg_index               ;
    logic                      retire_alu_reg_wr_en               ;
    logic [REG_WIDTH-1:0]      retire_alu_reg_val                 ;
    logic [INST_IDX_WIDTH-1:0] retire_alu_reg_inst_idx            ;
    logic                      retire_alu_inst_commit_en          ;

    //MEXT
    logic [4:0]                retire_mext_reg_index              ;
    logic                      retire_mext_reg_wr_en              ;
    logic [REG_WIDTH-1:0]      retire_mext_reg_val                ;
    logic [INST_IDX_WIDTH-1:0] retire_mext_reg_inst_idx           ;
    logic                      retire_mext_inst_commit_en         ;

    //CSR
    logic [4:0]                retire_csr_reg_index               ;
    logic                      retire_csr_reg_wr_en               ;
    logic [REG_WIDTH-1:0]      retire_csr_reg_val                 ;
    logic [INST_IDX_WIDTH-1:0] retire_csr_reg_inst_idx            ;
    logic                      retire_csr_inst_commit_en          ;
    logic [ADDR_WIDTH-1:0]     retire_csr_pc                      ;

    // retire pc ===================================================
    logic [ADDR_WIDTH-1:0]     commit_alu_pc                      ;
    //logic [31:0]               alu_exception_cause                ;
    //logic                      alu_exception_en                   ;

    logic [ADDR_WIDTH-1:0]     commit_lsu_pc                      ;
    logic [31:0]               lsu_exception_cause                ;
    logic                      lsu_exception_en                   ;
    logic [INST_WIDTH-1:0]     lsu_exception_inst                 ; 

    logic [ADDR_WIDTH-1:0]     commit_csr_pc                      ;

    //SPU
    logic                      spu_instruction_vld                ;
    logic                      spu_instruction_rdy                ;
    logic [INST_WIDTH-1:0]     spu_instruction_pld                ;
    logic [INST_IDX_WIDTH-1:0] spu_instruction_idx                ;
    logic                      spu_instruction_op                 ; 
    logic [31:0]               front_trap_cause                   ;
    logic [ADDR_WIDTH-1:0]     spu_pc                             ;  

    logic                      spu_jump_vld                       ;
    logic [1:0]                spu_jump_op                        ; 
    logic [31:0]               spu_trap_cause                     ;
    logic [ADDR_WIDTH-1:0]     spu_trap_pc                        ;
    logic [INST_WIDTH-1:0]     spu_trap_inst                      ;
    logic                      spu_wfi_vld                        ;

    logic [REG_WIDTH-1:0]           csr_mtvec                   ;
    logic [REG_WIDTH-1:0]           csr_mepc                    ;
    logic [REG_WIDTH-1:0]           csr_dpc                     ;

    logic                           rtu_pc_release_en       ;
    logic                           rtu_pc_update_en        ;
    logic [ADDR_WIDTH-1:0]          rtu_pc_val              ;
    logic                           rtu_pc_lock             ;

    logic                           trap_indebug;
    logic                           debug_vld           ;
    logic [2:0]                     debug_cause         ;
    logic [ADDR_WIDTH-1:0]          debug_pc            ;
    logic                           debug_mode_en       ; 
    logic                           debug_ebreakm       ;
    logic                           debug_step_en       ;
    logic                           debug_step_release  ;

    //interrupt
    logic                           interrupt_vld       ;
    logic [31:0]                    interrupt_op        ;
    logic                           interrupt_rdy       ;

    logic                           debug_stepie_mask   ;
    logic                           intr_meip_sync      ;
    logic                           intr_msip_sync      ;
    logic                           intr_debug_sync     ;

    //csr bus and pmp module
    logic [1:0]                     csr_bus_op          ;       //csr_op[1]---R, csr_op[0]---W
    logic [2:0]                     csr_bus_funct3      ; 
    logic [4:0]                     csr_bus_imm         ;      
    logic [ADDR_WIDTH-1:0]          csr_bus_addr        ;
    logic                           csr_bus_valid       ;
    logic                           csr_bus_rrsp        ;       //csr module read rsp 
    logic [ADDR_WIDTH-1:0]          csr_bus_rdata       ;       //csr read data
    logic                           csr_bus_rvalid      ;       //csr read valid 
    logic                           csr_bus_reg_rsp     ;       //0---normal  1---exception
    logic [2:0]                     mode_state          ;
    logic [ADDR_WIDTH-1:0]          fetch_req_addr      ;
    logic [1:0]                     fetch_req_mode      ;
    logic                           fetch_addr_pass     ;

    toy_ext_inter u_ext_intr(
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),
        .intr_meip          (intr_meip                  ),
        .intr_msip          (intr_msip                  ),
        .debug_halt_req     (debug_halt_req             ),
        .debug_stepie_mask  (debug_stepie_mask          ),

        .intr_meip_sync     (intr_meip_sync             ),
        .intr_msip_sync     (intr_msip_sync             ),  
        .intr_debug_sync    (intr_debug_sync            )
    );

    toy_fecth3 u_fetch(
`ifdef FPGA_SIM
        .ila_clk                (ila_clk                ),
`endif 
        .clk                (clk                        ),
        .rst_n              (rst_n                      ),
        .mem_ack_vld        (fetch_mem_ack_vld           ),
        .mem_ack_rdy        (fetch_mem_ack_rdy           ),
        .mem_ack_data       (fetch_mem_ack_data          ),
        .mem_req_addr       (fetch_mem_req_addr          ),
        .mem_req_vld        (fetch_mem_req_vld           ),
        .mem_req_rdy        (fetch_mem_req_rdy           ),
        .rtu_pc_release_en  (rtu_pc_release_en          ),
        .rtu_pc_update_en   (rtu_pc_update_en           ),
        .rtu_pc_val         (rtu_pc_val                 ),
        .rtu_lock           (rtu_pc_lock                ),
        .debug_step_en      (debug_step_en               ),
        .debug_step_release (debug_step_release          ),
        .jb_pc_release_en   (1'b0            ),
        .jb_pc_update_en    (1'b0            ),
        .jb_pc_val          (jb_pc_val                  ),
        .instruction_vld    (fetched_instruction_vld    ),
        .instruction_rdy    (fetched_instruction_rdy    ),
        .instruction_pld    (fetched_instruction_pld    ),
        .instruction_pc     (fetched_instruction_pc     ),
        .instruction_idx    (fetched_instruction_idx    ),
        .instruction_op     (fetched_instruction_op     ),
        .interrupt_vld      (interrupt_vld              ),
        .interrupt_rdy      (interrupt_rdy              ),
        .interrupt_op       (interrupt_op               ),
        .fetch_req_addr     (fetch_req_addr             ),
        .fetch_req_mode     (fetch_req_mode             ),
        .fetch_addr_pass    (fetch_addr_pass            )
        );


    toy_dispatch u_dispatch(
`ifdef FPGA_SIM
        .ila_clk                (ila_clk                ),
`endif 
        .clk                        (clk                        ),
        .rst_n                      (rst_n                      ),
        // fetch =================================================
        .fetched_instruction_vld    (fetched_instruction_vld    ),
        .fetched_instruction_rdy    (fetched_instruction_rdy    ),
        .fetched_instruction_pld    (fetched_instruction_pld    ), 
        .fetched_instruction_pc     (fetched_instruction_pc     ),
        .fetched_instruction_idx    (fetched_instruction_idx    ),
        .fetched_instruction_op     (fetched_instruction_op     ),
        // lsu ===================================================
        .lsu_instruction_vld        (lsu_instruction_vld        ),
        .lsu_instruction_rdy        (lsu_instruction_rdy        ),
        .lsu_instruction_pld        (lsu_instruction_pld        ),
        .lsu_instruction_idx        (lsu_instruction_idx        ),
        .lsu_inst_rd_idx            (lsu_inst_rd_idx            ),
        .lsu_inst_rd_en             (lsu_inst_rd_en             ),
        .lsu_inst_imm               (lsu_inst_imm               ),
        .lsu_rs1_val                (lsu_rs1_val                ),
        .lsu_rs2_val                (lsu_rs2_val                ),
        .lsu_pc                     (lsu_pc                     ),
        .lsu_reg_index              (retire_lsu_reg_index              ),
        .lsu_reg_wr_en              (retire_lsu_reg_wr_en              ),
        .lsu_reg_val                (retire_lsu_reg_val                ),
        //.lsu_reg_inst_idx           (lsu_reg_inst_idx           ),
        .lsu_reg_inst_idx_wr        (retire_lsu_reg_inst_idx_wr        ),
        .lsu_reg_inst_idx_rd        (retire_lsu_reg_inst_idx_rd        ),
        .lsu_inst_commit_en_wr      (retire_lsu_inst_commit_en_wr      ),
        .lsu_inst_commit_en_rd      (retire_lsu_inst_commit_en_rd      ),
        // alu ===================================================
        .alu_instruction_vld        (alu_instruction_vld        ),
        .alu_instruction_rdy        (alu_instruction_rdy        ),
        .alu_instruction_pld        (alu_instruction_pld        ),
        .alu_instruction_idx        (alu_instruction_idx        ),
        .alu_inst_rd_idx            (alu_inst_rd_idx            ),
        .alu_inst_rd_en             (alu_inst_rd_en             ),
        .alu_inst_imm               (alu_inst_imm               ),
        .alu_rs1_val                (alu_rs1_val                ),
        .alu_rs2_val                (alu_rs2_val                ),
        .alu_pc                     (alu_pc                     ),
        .alu_reg_index              (retire_alu_reg_index       ),
        .alu_reg_wr_en              (retire_alu_reg_wr_en       ),
        .alu_reg_val                (retire_alu_reg_val         ),
        .alu_reg_inst_idx           (retire_alu_reg_inst_idx    ),
        .alu_inst_commit_en         (retire_alu_inst_commit_en  ),
        // mext ==================================================
        .mext_instruction_vld       (mext_instruction_vld       ),
        .mext_instruction_rdy       (mext_instruction_rdy       ),
        .mext_instruction_pld       (mext_instruction_pld       ),
        .mext_instruction_idx       (mext_instruction_idx       ),
        .mext_inst_rd_idx           (mext_inst_rd_idx           ),
        .mext_inst_rd_en            (mext_inst_rd_en            ),
        .mext_pc                    (mext_pc                    ),
        .mext_inst_imm              (mext_inst_imm              ),
        .mext_rs1_val               (mext_rs1_val               ),
        .mext_rs2_val               (mext_rs2_val               ),
        .mext_reg_index             (retire_mext_reg_index      ),
        .mext_reg_wr_en             (retire_mext_reg_wr_en      ),
        .mext_reg_val               (retire_mext_reg_val        ),
        .mext_reg_inst_idx          (retire_mext_reg_inst_idx   ),
        .mext_inst_commit_en        (retire_mext_inst_commit_en ),
        // csr ===================================================
        .csr_instruction_vld        (csr_instruction_vld        ),
        .csr_instruction_rdy        (csr_instruction_rdy        ),
        .csr_instruction_pld        (csr_instruction_pld        ),
        .csr_instruction_idx        (csr_instruction_idx        ),
        //.csr_instruction_is_intr    (csr_instruction_is_intr    ),
        //.csr_intr_instruction_vld   (1'b0              ), //TODO
        //.csr_intr_instruction_rdy   (              ),

        .csr_inst_rd_idx            (csr_inst_rd_idx            ),
        .csr_inst_rd_en             (csr_inst_rd_en             ),
        .csr_inst_imm               (csr_inst_imm               ),
        .csr_rs1_val                (csr_rs1_val                ),
        .csr_rs2_val                (csr_rs2_val                ),
        .csr_reg_index              (retire_csr_reg_index       ),
        .csr_reg_wr_en              (retire_csr_reg_wr_en       ),
        .csr_reg_val                (retire_csr_reg_val         ),
        .csr_reg_inst_idx           (retire_csr_reg_inst_idx    ),
        .csr_inst_commit_en         (retire_csr_inst_commit_en  ),
        .csr_INSTRET                (csr_INSTRET                ),
        .csr_pc                     (csr_pc                     ),

        // SPU ===================================================
        .spu_instruction_vld        (spu_instruction_vld        ),
        .spu_instruction_rdy        (spu_instruction_rdy        ),
        .spu_instruction_pld        (spu_instruction_pld        ),
        .spu_instruction_idx        (spu_instruction_idx        ),
        .spu_instruction_op         (spu_instruction_op         ), 
        .front_trap_cause           (front_trap_cause           ),   
        .spu_pc                     (spu_pc                     ),             
        
        // custom ================================================
        .custom_instruction_vld     (custom_instruction_vld     ),       
        .custom_instruction_rdy     (custom_instruction_rdy     ),       
        .custom_instruction_pld     (custom_instruction_pld     ),       
        .custom_rs1_val             (custom_rs1_val             ),       
        .custom_rs2_val             (custom_rs2_val             ),       
        .custom_pc                  (custom_pc                  )
        );

    toy_alu u_alu(
        .clk                        (clk                        ),
        .rst_n                      (rst_n                      ),
        .instruction_vld            (alu_instruction_vld        ),
        .instruction_rdy            (alu_instruction_rdy        ),
        .instruction_pld            (alu_instruction_pld        ),
        .instruction_idx            (alu_instruction_idx        ),
        .inst_rd_idx                (alu_inst_rd_idx            ),
        .inst_rd_en                 (alu_inst_rd_en             ),
        .rs1_val                    (alu_rs1_val                ),
        .rs2_val                    (alu_rs2_val                ),
        .pc                         (alu_pc                     ),
        .inst_imm                   (alu_inst_imm               ),
        .reg_inst_idx               (alu_reg_inst_idx           ),
        .reg_index                  (alu_reg_index              ),
        .reg_wr_en                  (alu_reg_wr_en              ),
        .reg_data                   (alu_reg_val                ),
        .inst_commit_en             (alu_inst_commit_en         ),
        .alu_pc                     (commit_alu_pc               ),
        //.alu_exception_en           (alu_exception_en     ),  //exception
        //.alu_exception_cause        (alu_exception_cause  ),
        .pc_release_en              (jb_pc_release_en           ),
        .pc_update_en               (jb_pc_update_en            ),
        .pc_val                     (jb_pc_val                  )
        );

    toy_lsu u_lsu(
        .clk                        (clk                        ),
        .rst_n                      (rst_n                      ),
        .instruction_vld            (lsu_instruction_vld        ),
        .instruction_rdy            (lsu_instruction_rdy        ),
        .instruction_pld            (lsu_instruction_pld        ),
        .instruction_idx            (lsu_instruction_idx        ),
        .inst_rd_idx                (lsu_inst_rd_idx            ),
        .inst_rd_en                 (lsu_inst_rd_en             ),
        .inst_imm                   (lsu_inst_imm               ),
        .pc                         (lsu_pc                     ),
        .rs1_val                    (lsu_rs1_val                ),
        .rs2_val                    (lsu_rs2_val                ),
        .reg_index                  (lsu_reg_index              ),
        .reg_wr_en                  (lsu_reg_wr_en              ),
        .reg_val                    (lsu_reg_val                ),
        .reg_inst_idx_rd            (lsu_reg_inst_idx_rd        ),
        .reg_inst_idx_wr            (lsu_reg_inst_idx_wr        ),
        .inst_commit_en_rd          (lsu_inst_commit_en_rd      ),
        .inst_commit_en_wr          (lsu_inst_commit_en_wr      ),

        .lsu_pc                     (commit_lsu_pc              ),
        .lsu_exception_en           (lsu_exception_en           ),  //exception
        .lsu_exception_cause        (lsu_exception_cause        ),
        .lsu_exception_inst         (lsu_exception_inst         ),

        .csr_op                     (csr_bus_op                 ),       //csr_op[1]---R, csr_op[0]---W
        .csr_funct3                 (csr_bus_funct3             ), 
        .csr_imm                    (csr_bus_imm                ), 
        .csr_rs1_val                (csr_rs1_val                ),     
        .csr_addr                   (csr_bus_addr               ),
        .csr_valid                  (csr_bus_valid              ),
        .csr_rrsp                   (csr_bus_rrsp               ),       //csr module read rsp 
        .csr_rdata                  (csr_bus_rdata              ),       //csr read data
        .csr_rvalid                 (csr_bus_rvalid             ),       //csr read valid 
        .csr_reg_rsp                (csr_bus_reg_rsp            ),       //0---normal  1---exception
        .mode_state                 (mode_state                 ),

        .mem_req_vld                (lsu_mem_req_vld            ),
        .mem_req_rdy                (lsu_mem_req_rdy            ),
        .mem_req_addr               (lsu_mem_req_addr           ),
        .mem_req_data               (lsu_mem_req_data           ),
        .mem_req_strb               (lsu_mem_req_strb           ),
        .mem_req_opcode             (lsu_mem_req_opcode         ),
        .mem_ack_vld                (lsu_mem_ack_vld            ),
        .mem_ack_rdy                (lsu_mem_ack_rdy            ),
        .mem_ack_data               (lsu_mem_ack_data           ),
        
        .fetch_req_addr             (fetch_req_addr             ),
        .fetch_req_mode             (fetch_req_mode             ),
        .fetch_addr_pass            (fetch_addr_pass            )
        );



    toy_mext u_mext(
        .clk                        (clk                        ),
        .rst_n                      (rst_n                      ),
        .instruction_vld            (mext_instruction_vld       ),
        .instruction_rdy            (mext_instruction_rdy       ),
        .instruction_pld            (mext_instruction_pld       ),
        .instruction_idx            (mext_instruction_idx       ),
        .inst_rd_idx                (mext_inst_rd_idx           ),
        .inst_rd_en                 (mext_inst_rd_en            ),
        .rs1_val                    (mext_rs1_val               ),
        .rs2_val                    (mext_rs2_val               ),
        .reg_index                  (mext_reg_index             ),
        .reg_wr_en                  (mext_reg_wr_en             ),
        .reg_val                    (mext_reg_val               ),
        .reg_inst_idx               (mext_reg_inst_idx          ),
        .inst_commit_en             (mext_inst_commit_en        ));



    toy_csr u_csr(
`ifdef FPGA_SIM
        .ila_clk                (ila_clk                ),
`endif 
        .clk                        (clk                        ),
        .rst_n                      (rst_n                      ),

        .instruction_vld            (csr_instruction_vld        ),
        .instruction_rdy            (csr_instruction_rdy        ),
        .instruction_pld            (csr_instruction_pld        ),
        .instruction_idx            (csr_instruction_idx        ),
        .inst_rd_idx                (csr_inst_rd_idx            ),
        .inst_rd_en                 (csr_inst_rd_en             ),
        .rs1_val                    (csr_rs1_val                ),
        .rs2_val                    (csr_rs2_val                ),
        .pc                         (csr_pc                     ),
        .reg_index                  (csr_reg_index              ),
        .reg_wr_en                  (csr_reg_wr_en              ),
        .reg_val                    (csr_reg_val                ),
        .reg_inst_idx               (csr_reg_inst_idx           ),
        .inst_commit_en             (csr_inst_commit_en         ),
        .csr_pc                     (commit_csr_pc              ),
        .csr_INSTRET                (csr_INSTRET                ),

        .trap_vld                   (trap_vld                   ),
        .trap_pc                    (trap_pc                    ),
        .trap_cause                 (trap_cause                 ),
        .trap_extra_info            (trap_extra_info            ), 
        .trap_rdy                   (trap_rdy                   ),
        .trap_indebug               (trap_indebug               ),

        .debug_vld                  (debug_vld                  ),
        .debug_cause                (debug_cause                ),
        .debug_pc_val               (debug_pc                   ),

        .intr_meip_sync             (intr_meip_sync             ),
        .intr_msip_sync             (intr_msip_sync             ),
        .intr_debug_sync            (intr_debug_sync            ),
        .intr_vld                   (interrupt_vld              ),
        .intr_op                    (interrupt_op               ),
        .intr_rdy                   (interrupt_rdy              ),

        .csr_mtvec_val              (csr_mtvec                  ),
        .csr_mepc_val               (csr_mepc                   ),
        .csr_dpc_val                (csr_dpc                    ),
        .dret_en                    (dret_en                    ),
        .mret_en                    (mret_en                    ),
        .sret_en                    (sret_en                    ),

        .csr_bus_op                 (csr_bus_op                 ),       //csr_op[1]---R, csr_op[0]---W
        .csr_bus_funct3             (csr_bus_funct3             ), 
        .csr_bus_imm                (csr_bus_imm                ),      
        .csr_bus_addr               (csr_bus_addr               ),
        .csr_bus_valid              (csr_bus_valid              ),
        .csr_bus_rrsp               (csr_bus_rrsp               ),       //csr module read rsp 
        .csr_bus_rdata              (csr_bus_rdata              ),       //csr read data
        .csr_bus_rvalid             (csr_bus_rvalid             ),       //csr read valid 
        .csr_bus_reg_rsp            (csr_bus_reg_rsp            ),       //0---normal  1---exception
        .mode_state                 (mode_state                 ),

        .debug_mode_en              (debug_mode_en              ),
        .debug_ebreakm              (debug_ebreakm              ),
        .debug_step_en              (debug_step_en              ),
        .debug_step_release         (debug_step_release         ),
        .debug_stepie_mask          (debug_stepie_mask          )
        );

    toy_spu u_toy_spu(
        .clk                        (clk),
        .rst_n                      (rst_n),
        
        .spu_instruction_vld        (spu_instruction_vld        ),
        .spu_instruction_rdy        (spu_instruction_rdy        ),
        .spu_instruction_pld        (spu_instruction_pld        ),
        .spu_instruction_idx        (spu_instruction_idx        ),
        .spu_instruction_op         (spu_instruction_op         ), 
        .front_trap_cause           (front_trap_cause           ),   
        .spu_pc                     (spu_pc                     ),

        .spu_jump_vld               (spu_jump_vld               ),  
        .spu_jump_op                (spu_jump_op                ),   
        .spu_trap_cause             (spu_trap_cause             ),
        .spu_trap_pc                (spu_trap_pc                ),   
        .spu_trap_inst              (spu_trap_inst              ), 
        .spu_wfi_vld                (spu_wfi_vld                )
    );

    toy_rtu u_rtu(
        .clk                          (clk                  ),
        .rst_n                        (rst_n                ),
        
        .csr_mtvec                    (csr_mtvec            ),
        .csr_mepc                     (csr_mepc             ),
        .csr_dpc                      (csr_dpc              ),

        .debug_mode_en                (debug_mode_en        ),
        .debug_ebreakm                (debug_ebreakm        ),
        .debug_step_en                (debug_step_en        ),
        .debug_step_release           (debug_step_release   ),

        .lsu_reg_index                (lsu_reg_index        ),
        .lsu_reg_wr_en                (lsu_reg_wr_en        ),
        .lsu_reg_val                  (lsu_reg_val          ),
        .lsu_reg_inst_idx_rd          (lsu_reg_inst_idx_rd  ),
        .lsu_reg_inst_idx_wr          (lsu_reg_inst_idx_wr  ),
        .lsu_inst_commit_en_rd        (lsu_inst_commit_en_rd),
        .lsu_inst_commit_en_wr        (lsu_inst_commit_en_wr),
        .lsu_pc                       (commit_lsu_pc        ),
        .lsu_exception_inst           (lsu_exception_inst   ),
        .lsu_exception_en             (lsu_exception_en     ),  //exception
        .lsu_exception_cause          (lsu_exception_cause  ),

        .alu_reg_index                (alu_reg_index        ),
        .alu_reg_wr_en                (alu_reg_wr_en        ),
        .alu_reg_val                  (alu_reg_val          ),
        .alu_reg_inst_idx             (alu_reg_inst_idx     ),
        .alu_inst_commit_en           (alu_inst_commit_en   ),
        .alu_pc                       (commit_alu_pc        ),

        .jb_pc_release_en             (jb_pc_release_en     ),
        .jb_pc_update_en              (jb_pc_update_en      ),
        .jb_pc_val                    (jb_pc_val            ),
        //.alu_exception_en             (alu_exception_en     ),  //exception
       // .alu_exception_cause          (alu_exception_cause  ),
        .mext_reg_index               (mext_reg_index       ),
        .mext_reg_wr_en               (mext_reg_wr_en       ),
        .mext_reg_val                 (mext_reg_val         ),
        .mext_reg_inst_idx            (mext_reg_inst_idx    ),
        .mext_inst_commit_en          (mext_inst_commit_en  ),
        .mext_pc                      (mext_pc              ),
        .csr_reg_index                (csr_reg_index        ),
        .csr_reg_wr_en                (csr_reg_wr_en        ),
        .csr_reg_val                  (csr_reg_val          ),
        .csr_reg_inst_idx             (csr_reg_inst_idx     ),
        .csr_inst_commit_en           (csr_inst_commit_en   ),
        .csr_pc                       (commit_csr_pc        ),

        .spu_jump_vld                 (spu_jump_vld         ),
        .spu_jump_op                  (spu_jump_op          ),
        .spu_trap_cause               (spu_trap_cause       ),
        .spu_trap_pc                  (spu_trap_pc          ),
        .spu_trap_inst                (spu_trap_inst        ),
        .spu_wfi_vld                  (spu_wfi_vld          ),

    /*==================== commit rsp ====================*/
        .retire_lsu_reg_index         (retire_lsu_reg_index        ),
        .retire_lsu_reg_wr_en         (retire_lsu_reg_wr_en        ),
        .retire_lsu_reg_val           (retire_lsu_reg_val          ),
        .retire_lsu_reg_inst_idx_rd   (retire_lsu_reg_inst_idx_rd  ),
        .retire_lsu_reg_inst_idx_wr   (retire_lsu_reg_inst_idx_wr  ),
        .retire_lsu_inst_commit_en_rd (retire_lsu_inst_commit_en_rd),
        .retire_lsu_inst_commit_en_wr (retire_lsu_inst_commit_en_wr),
        .retire_alu_reg_index         (retire_alu_reg_index        ),
        .retire_alu_reg_wr_en         (retire_alu_reg_wr_en        ),
        .retire_alu_reg_val           (retire_alu_reg_val          ),
        .retire_alu_reg_inst_idx      (retire_alu_reg_inst_idx     ),
        .retire_alu_inst_commit_en    (retire_alu_inst_commit_en   ),
        .retire_mext_reg_index        (retire_mext_reg_index       ),
        .retire_mext_reg_wr_en        (retire_mext_reg_wr_en       ),
        .retire_mext_reg_val          (retire_mext_reg_val         ),
        .retire_mext_reg_inst_idx     (retire_mext_reg_inst_idx    ),
        .retire_mext_inst_commit_en   (retire_mext_inst_commit_en  ),
        .retire_csr_reg_index         (retire_csr_reg_index        ),
        .retire_csr_reg_wr_en         (retire_csr_reg_wr_en        ),
        .retire_csr_reg_val           (retire_csr_reg_val          ),
        .retire_csr_reg_inst_idx      (retire_csr_reg_inst_idx     ),
        .retire_csr_inst_commit_en    (retire_csr_inst_commit_en   ),
        .retire_csr_pc                (retire_csr_pc               ),

        .trap_vld                     (trap_vld                    ),
        .trap_pc                      (trap_pc                     ),
        .trap_cause                   (trap_cause                  ),
        .trap_extra_info              (trap_extra_info             ),  //mtval
        .trap_rdy                     (trap_rdy                    ),
        .trap_indebug                 (trap_indebug                ),

        .debug_vld                    (debug_vld                   ),
        .debug_cause                  (debug_cause                 ),
        .debug_pc                     (debug_pc                    ),

        .dret_en                      (dret_en                     ),
        .mret_en                      (mret_en                     ),
        .sret_en                      (sret_en                     ),

        .rtu_pc_release_en            (rtu_pc_release_en           ),
        .rtu_pc_update_en             (rtu_pc_update_en            ),
        .rtu_pc_val                   (rtu_pc_val                  ),
        .rtu_pc_lock                  (rtu_pc_lock                 )
        );

endmodule