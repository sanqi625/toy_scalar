
module toy_rtu
    import toy_pack::*; 
(
    input  logic                        clk                     ,
    input  logic                        rst_n                   ,
    // csr value
    input  logic [REG_WIDTH-1:0]        csr_mtvec               , //trap handler address
    input  logic [REG_WIDTH-1:0]        csr_mepc                , //trap return address
    input  logic [REG_WIDTH-1:0]        csr_stvec               ,
    input  logic [REG_WIDTH-1:0]        csr_sepc                ,
    input  logic [REG_WIDTH-1:0]        csr_dpc                 , //debug return address
    input  logic                        trap_enter_smode        ,

    //debug state
    input  logic                        debug_mode_en           , 
    input  logic                        debug_ebreakm           ,
    input  logic                        debug_step_en           ,  
    input  logic                        debug_step_release      ,

    // csr state
    /*==================== commit req ====================*/
    //LSU
    input  logic [4:0]                  lsu_reg_index               ,
    input  logic                        lsu_reg_wr_en               ,
    input  logic [REG_WIDTH-1:0]        lsu_reg_val                 ,
    input  logic [INST_IDX_WIDTH-1:0]   lsu_reg_inst_idx_rd         ,
    input  logic [INST_IDX_WIDTH-1:0]   lsu_reg_inst_idx_wr         ,
    input                               lsu_inst_commit_en_rd       ,
    input                               lsu_inst_commit_en_wr       ,

    input logic [ADDR_WIDTH-1:0]        lsu_pc                      ,
    input logic [INST_WIDTH-1:0]        lsu_exception_inst          ,
    input logic                         lsu_exception_en            ,  //exception
    input logic [5:0]                   lsu_exception_cause         ,

    //ALU
    input  logic [4:0]                  alu_reg_index               ,
    input  logic                        alu_reg_wr_en               ,
    input  logic [REG_WIDTH-1:0]        alu_reg_val                 ,
    input  logic [INST_IDX_WIDTH-1:0]   alu_reg_inst_idx            ,
    input                               alu_inst_commit_en          ,

    input logic [ADDR_WIDTH-1:0]        alu_pc                      ,

    input logic                         jb_pc_release_en       ,
    input logic                         jb_pc_update_en        ,
    input logic [ADDR_WIDTH-1:0]        jb_pc_val              ,
    //input logic                       alu_exception_en            ,  //exception
    //input logic [3:0]                 alu_exception_cause         ,

    //MEXT
    input  logic [4:0]                  mext_reg_index              ,
    input  logic                        mext_reg_wr_en              ,
    input  logic [REG_WIDTH-1:0]        mext_reg_val                ,
    input  logic [INST_IDX_WIDTH-1:0]   mext_reg_inst_idx           ,
    input                               mext_inst_commit_en         ,

    input  logic [ADDR_WIDTH-1:0]       mext_pc                     ,

    //CSR
    input  logic [4:0]                  csr_reg_index               ,
    input  logic                        csr_reg_wr_en               ,
    input  logic [REG_WIDTH-1:0]        csr_reg_val                 ,
    input  logic [INST_IDX_WIDTH-1:0]   csr_reg_inst_idx            ,
    input                               csr_inst_commit_en          ,
    input logic [ADDR_WIDTH-1:0]        csr_pc                      ,

    //SPU 
    input  logic                        spu_jump_vld                ,
    input  logic [1:0]                  spu_jump_op                 ,
    input  logic [5:0]                  spu_trap_cause              ,
    input  logic [ADDR_WIDTH-1:0]       spu_trap_pc                 ,
    input  logic [INST_WIDTH-1:0]       spu_trap_inst               ,
    input  logic                        spu_wfi_vld                 ,

    /*==================== commit rsp ====================*/
    //LSU
    output  logic [4:0]                retire_lsu_reg_index               ,
    output  logic                      retire_lsu_reg_wr_en               ,
    output  logic [REG_WIDTH-1:0]      retire_lsu_reg_val                 ,
    output  logic [INST_IDX_WIDTH-1:0] retire_lsu_reg_inst_idx_rd         ,
    output  logic [INST_IDX_WIDTH-1:0] retire_lsu_reg_inst_idx_wr         ,
    output                             retire_lsu_inst_commit_en_rd       ,
    output                             retire_lsu_inst_commit_en_wr       ,

    //ALU
    output  logic [4:0]                retire_alu_reg_index               ,
    output  logic                      retire_alu_reg_wr_en               ,
    output  logic [REG_WIDTH-1:0]      retire_alu_reg_val                 ,
    output  logic [INST_IDX_WIDTH-1:0] retire_alu_reg_inst_idx            ,
    output                             retire_alu_inst_commit_en          ,

    //MEXT
    output  logic [4:0]                retire_mext_reg_index              ,
    output  logic                      retire_mext_reg_wr_en              ,
    output  logic [REG_WIDTH-1:0]      retire_mext_reg_val                ,
    output  logic [INST_IDX_WIDTH-1:0] retire_mext_reg_inst_idx           ,
    output                             retire_mext_inst_commit_en         ,

    //CSR
    output  logic [4:0]                retire_csr_reg_index               ,
    output  logic                      retire_csr_reg_wr_en               ,
    output  logic [REG_WIDTH-1:0]      retire_csr_reg_val                 ,
    output  logic [INST_IDX_WIDTH-1:0] retire_csr_reg_inst_idx            ,
    output                             retire_csr_inst_commit_en          ,
    output logic [ADDR_WIDTH-1:0]      retire_csr_pc                      ,

    // trap
    output logic                       trap_vld                           ,
    output logic [ADDR_WIDTH-1:0]      trap_pc                            ,
    output logic [5:0]                 trap_cause                         ,
    output logic [ADDR_WIDTH-1:0]      trap_extra_info                    ,  //mtval
    input  logic                       trap_rdy                           ,
    output logic                       trap_indebug                       ,

    //debug
    output logic                       debug_vld                          ,
    output logic [2:0]                 debug_cause                        ,
    output logic [ADDR_WIDTH-1:0]      debug_pc                           ,

    output logic                       dret_en                            ,
    output logic                       mret_en                            ,
    output logic                       sret_en                            ,

    output logic                       rtu_pc_release_en                  ,
    output logic                       rtu_pc_update_en                   ,
    output logic [ADDR_WIDTH-1:0]      rtu_pc_val                         ,
    output logic                       rtu_pc_lock
    //output logic [ADDR_WIDTH-1:0]    rtu_real_pc_val,
    //output logic                     rtu_bp_type 
);

logic               spu_trap_en;
logic               lsu_excp_en;
logic               alu_excp_en;

logic               trap_en;
logic               spu_return_en;
logic [1:0]         spu_return_type;
logic [ADDR_WIDTH-1:0]  current_pc;

logic                     indebug_break_en;
logic                     indebug_exception;
  
assign retire_lsu_reg_index               = lsu_reg_index               ;
assign retire_lsu_reg_wr_en               = lsu_reg_wr_en               ;
assign retire_lsu_reg_val                 = lsu_reg_val                 ;
assign retire_lsu_reg_inst_idx_rd         = lsu_reg_inst_idx_rd         ;
assign retire_lsu_reg_inst_idx_wr         = lsu_reg_inst_idx_wr         ;
assign retire_lsu_inst_commit_en_rd       = lsu_inst_commit_en_rd && !lsu_excp_en   ;
assign retire_lsu_inst_commit_en_wr       = lsu_inst_commit_en_wr && !lsu_excp_en   ;

assign retire_alu_reg_index               = alu_reg_index               ;
assign retire_alu_reg_wr_en               = alu_reg_wr_en               ;
assign retire_alu_reg_val                 = alu_reg_val                 ;
assign retire_alu_reg_inst_idx            = alu_reg_inst_idx            ;
assign retire_alu_inst_commit_en          = alu_inst_commit_en && !alu_excp_en      ;

assign retire_mext_reg_index              = mext_reg_index              ;
assign retire_mext_reg_wr_en              = mext_reg_wr_en              ;
assign retire_mext_reg_val                = mext_reg_val                ;
assign retire_mext_reg_inst_idx           = mext_reg_inst_idx           ;
assign retire_mext_inst_commit_en         = mext_inst_commit_en         ;

assign retire_csr_reg_index               = csr_reg_index               ;
assign retire_csr_reg_wr_en               = csr_reg_wr_en               ;
assign retire_csr_reg_val                 = csr_reg_val                 ;
assign retire_csr_reg_inst_idx            = csr_reg_inst_idx            ;
assign retire_csr_inst_commit_en          = csr_inst_commit_en          ;

// trap handle

assign spu_trap_en  = spu_jump_vld && (spu_jump_op[1:0] == 2'b11);
assign lsu_excp_en  = lsu_exception_en;
assign alu_excp_en  = 1'b0;

// spu jump return
assign spu_return_en         = spu_jump_vld && (spu_jump_op[1:0] != 2'b11);
assign spu_return_type[1:0]  = spu_jump_op[1:0];

// commit module record retire pc and calcute current pc 
toy_commit u_toy_commit(
    .clk                            (clk  ),
    .rst_n                          (rst_n),
    .csr_mtvec                      (csr_mtvec),
    .csr_mepc                       (csr_mepc),
    .csr_stvec                      (csr_stvec),
    .csr_sepc                       (csr_sepc),
    .csr_dpc                        (csr_dpc),
    .trap_enter_smode               (trap_enter_smode),
    // input
    .retire_lsu_inst_commit_en_rd   (retire_lsu_inst_commit_en_rd   ),
    .retire_lsu_inst_commit_en_wr   (retire_lsu_inst_commit_en_wr   ),
    .retire_alu_inst_commit_en      (retire_alu_inst_commit_en      ),
    .retire_mext_inst_commit_en     (retire_mext_inst_commit_en     ),
    .retire_csr_inst_commit_en      (retire_csr_inst_commit_en      ),

    .lsu_pc                         (lsu_pc                         ),
    .alu_pc                         (alu_pc                         ),
    .mext_pc                        (mext_pc                        ),
    .csr_pc                         (csr_pc                         ),
    .spu_pc                         (spu_trap_pc                    ),

    //change flow enable
    .jb_pc_release_en               (jb_pc_release_en               ),
    .jb_pc_update_en                (jb_pc_update_en                ),
    .jb_pc_val                      (jb_pc_val                      ),
    .spu_return_en                  (spu_return_en                  ),
    .spu_return_type                (spu_return_type                ),
    .trap_vld                       (trap_vld                       ),
    .trap_rdy                       (trap_rdy                       ),
    .debug_vld                      (debug_vld                      ),
    .indebug_break_en               (indebug_break_en               ),
    .indebug_exception              (indebug_exception              ),
    .debug_step_en                  (debug_step_en                  ),

    .dret_en                        (dret_en                        ),
    .mret_en                        (mret_en                        ),
    .sret_en                        (sret_en                        ),

    //output
    .real_pc                        (current_pc                     ),
    .pc_release_en                  (rtu_pc_release_en              ),
    .pc_update_en                   (rtu_pc_update_en               ),
    .pc_val                         (rtu_pc_val                     ),
    .pc_lock                        (rtu_pc_lock                    )
);

toy_trap u_toy_trap(
    .clk                    (clk  ),
    .rst_n                  (rst_n),

    .current_pc             (current_pc         ),
    //input trap enable
    .spu_trap_en            (spu_trap_en        ),
    .spu_trap_cause         (spu_trap_cause     ),
    .spu_trap_inst          (spu_trap_inst      ),
    .spu_trap_pc            (spu_trap_pc        ),

    .lsu_excp_en            (lsu_excp_en        ),
    .lsu_exception_cause    (lsu_exception_cause),
    .lsu_pc                 (lsu_pc             ),
    .lsu_exception_inst     (lsu_exception_inst ),

    //debug state
    .debug_mode_en          (debug_mode_en    ),   
    .debug_ebreakm          (debug_ebreakm    ),   
    .debug_step_en          (debug_step_en    ),   
    .csr_mtvec              (csr_mtvec        ),
    .debug_step_release     (debug_step_release),

    .debug_vld              (debug_vld        ),
    .debug_cause            (debug_cause      ),
    .debug_pc               (debug_pc         ),
    .indebug_break_en       (indebug_break_en ),
    .indebug_exception      (indebug_exception),   

    //output
    .trap_vld               (trap_vld           ),       
    .trap_rdy               (trap_rdy           ),
    .trap_pc                (trap_pc            ),        
    .trap_cause             (trap_cause         ),     
    .trap_extra_info        (trap_extra_info    ),
    .trap_indebug           (trap_indebug       )
);

endmodule