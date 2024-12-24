
module toy_csr
    import toy_pack::*;
(
`ifdef FPGA_SIM
    input  logic                        ila_clk    ,
`endif 
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
    
    // reg access
    output logic [4:0]                reg_index           ,
    output logic                      reg_wr_en           ,
    output logic [REG_WIDTH-1:0]      reg_val             ,
    output logic [INST_IDX_WIDTH-1:0] reg_inst_idx        ,
    output logic                      inst_commit_en      ,
    output logic [ADDR_WIDTH-1:0]     csr_pc              ,//add

    input  logic [63:0]               csr_INSTRET         ,

    // trap message
    input  logic                       trap_vld           ,
    input  logic [ADDR_WIDTH-1:0]      trap_pc            ,
    input  logic [5:0]                 trap_cause         ,
    input  logic [ADDR_WIDTH-1:0]      trap_extra_info    ,  // mtval/stval
    output logic                       trap_rdy           ,
    input  logic                       trap_indebug       ,

    input  logic                       debug_vld           ,
    input  logic [2:0]                 debug_cause         ,
    input  logic [ADDR_WIDTH-1:0]      debug_pc_val        ,
    input  logic                       dret_en             ,
    input  logic                       mret_en             ,
    input  logic                       sret_en             ,
    // external/software/timer interrupt enbale

    input  logic                       intr_meip_sync      ,
    input  logic                       intr_msip_sync      ,
    input  logic                       intr_seip_sync      ,
    input  logic                       intr_stip_sync      ,
    input  logic                       intr_ssip_sync      ,         
    input  logic                       intr_debug_sync     ,
    //output logic                      dm_halt_req_en      ,  //core enter into the debug mode
   
    output logic                      intr_vld            ,
    output logic [5:0]                intr_op             ,  //3 is sw intr, 7 is timer intr, 11 is external intr, 15 is debug halt req
    input  logic                      intr_rdy            ,

    output logic [REG_WIDTH-1:0]      csr_mtvec_val       ,
    output logic [REG_WIDTH-1:0]      csr_mepc_val        ,
    output logic [REG_WIDTH-1:0]      csr_stvec_val       ,
    output logic [REG_WIDTH-1:0]      csr_sepc_val        ,
    output logic [REG_WIDTH-1:0]      csr_dpc_val         ,
    output logic                      trap_enter_smode    ,

    //csr bus
    output logic   [1:0]              csr_bus_op          ,       //csr_op[1]---R, csr_op[0]---W
    output logic   [2:0]              csr_bus_funct3      , 
    output logic   [4:0]              csr_bus_imm         ,
    //output logic   [REG_WIDTH-1:0]    rs1_val             ,      
    output logic   [ADDR_WIDTH-1:0]   csr_bus_addr        ,
    output logic                      csr_bus_valid       ,
    output logic                      csr_bus_rrsp        ,       //csr module read rsp 
    input  logic   [ADDR_WIDTH-1:0]   csr_bus_rdata       ,       //csr read data
    input  logic                      csr_bus_rvalid      ,       //csr read valid 
    input  logic                      csr_bus_reg_rsp     ,       //0---normal  1---exception

    //pmp_port
    output logic   [2:0]              mode_state          ,

    //debug state
    output logic                      debug_mode_en       , 
    output logic                      debug_ebreakm       ,
    output logic                      debug_step_en       ,
    output logic                      debug_step_release  ,
    output logic                      debug_stepie_mask
);

    logic                   dm_ebreak_en;
    logic                   dm_trigger_en;
    logic                   dm_step_en;
    logic                   dm_rst_hart_en;
    logic                   debug_halt_req_p;
    logic [ADDR_WIDTH-1:0]  debug_pc;
    logic                   debug_step_en_1d;

    logic [ADDR_WIDTH-1:0]  dscratch0;
    logic [ADDR_WIDTH-1:0]  dscratch1;


    logic                   debug_csr_wr;
    logic                   debug_req_en;
    logic                   exit_debug_en;
    
    logic [11:0]            funct12     ;
    logic [2:0]             funct3      ;
    logic [11:0]            csr_addr    ;
    logic [REG_WIDTH-1:0]   csr_rdata   ;
    logic [REG_WIDTH-1:0]   csr_wdata   ;
    logic                   csr_wren    ;
    logic [4:0]             csr_imm     ;
    logic                   pmp_bus_valid;
    logic                   aia_bus_valid;

    dcsr_t                  csr_DCSR      ;
    dcsr_t                  csr_DCSR_wr   ;
    logic                   exception_en  ;

    logic                   intr_mtip;

    /*========================================*/
    /*           machine mode CSR             */
    /*========================================*/

    logic [63:0]            csr_CYCLE;
    logic [63:0]            csr_MTIMECMP;
    mstatus_t               csr_MSTATUS;
    mstatus_t               csr_MSTATUS_wr;
    logic                   csr_MSTATUS_wren;
    logic [REG_WIDTH-1:0]   csr_MSCRATCH;

    //machine mode trap
    logic [REG_WIDTH-1:0]   csr_MTVEC;
    mip_t                   csr_MIP;
    mie_t                   csr_MIE;
    medeleg_t               csr_MEDELEG;
    mideleg_t               csr_MIDELEG;
    logic [REG_WIDTH-1:0]   csr_MTVAL;
    logic [REG_WIDTH-1:0]   csr_MEPC;
    logic [REG_WIDTH-1:0]   csr_MCAUSE;

    /*========================================*/
    /*         supervisor mode CSR            */
    /*========================================*/
    sstatus_t               csr_SSTATUS;   
    sstatus_t               csr_SSTATUS_wr;    
    logic                   csr_SSTATUS_wren;

    //supervisor mode trap
    logic [REG_WIDTH-1:0]   csr_STVEC;      
    sip_t                   csr_SIP;
    sie_t                   csr_SIE;
    logic [REG_WIDTH-1:0]   csr_SEPC;
    logic [REG_WIDTH-1:0]   csr_SCAUSE;
    logic [REG_WIDTH-1:0]   csr_STVAL;

    scounteren_t            csr_SCOUNTEREN;
    logic [REG_WIDTH-1:0]   csr_SSCRATCH;
    logic [REG_WIDTH-1:0]   csr_SENVCFG;
    logic [31:0]            csr_SATP;

    //debug 
    logic                   debug_stepie_en;
    logic                   debug_stopcount_en;
    logic                   debug_stoptime_en;

    //trap 
    logic                   trap_intr;
    logic [4:0]             intr_cause;
    logic                   trap_enable;
    logic [19:0]            trap_vec_num;
    
    logic                   seip;
    logic                   stip;
    logic                   ssip;
    logic                   meip;
    logic                   mtip;
    logic                   msip;

    logic                   seip_en;
    logic                   stip_en;
    logic                   ssip_en;
    logic                   meip_en;
    logic                   mtip_en;
    logic                   msip_en;

    logic                   seip_nondeleg_vld;
    logic                   stip_nondeleg_vld;
    logic                   ssip_nondeleg_vld;
    logic                   seip_deleg_vld;
    logic                   stip_deleg_vld;
    logic                   ssip_deleg_vld;
    logic                   meip_vld;
    logic                   mtip_vld;
    logic                   msip_vld;

    logic [31:0]            csr_mip_value;
    logic [31:0]            csr_sip_value;

    logic                   medeleg_vld;
    logic                   mideleg_vld;
    logic                   mdeleg_vld;

    logic                   ssi_deleg_en;
    logic                   sti_deleg_en;
    logic                   sei_deleg_en;    

    logic [31:0]            interrupt_req;

    logic                   ret_en;
    logic                   MACHINE_state;
    logic                   SUPERVISOR_state;
    logic                   USER_state;

    assign csr_pc = pc;

    assign csr_mtvec_val   = csr_MTVEC;
    assign csr_mepc_val    = csr_MEPC;
    assign csr_dpc_val     = debug_pc; 

    assign funct3    = instruction_pld`INST_FIELD_FUNCT3    ;
    assign csr_imm   = instruction_pld`INST_FIELD_RS1       ;

    //assign reg_index = instruction_pld`INST_FIELD_RD        ;
    assign reg_index = inst_rd_idx                          ;
    assign reg_val   = csr_rdata                            ;
    assign reg_wr_en = csr_wren                             ;
    assign reg_inst_idx = instruction_idx                   ;
    assign inst_commit_en = csr_bus_valid ? csr_bus_rvalid : instruction_vld  ;
    
    assign csr_addr  = instruction_pld`INST_FIELD_FUNCT12   ;
    assign funct12   = instruction_pld`INST_FIELD_FUNCT12   ;

    assign instruction_rdy = csr_bus_valid ? csr_bus_rvalid : 1'b1;

    assign trap_rdy = 1'b1;

    assign trap_handshake  = trap_vld && trap_rdy;
    assign debug_handshake = debug_vld && trap_rdy; 

    //exception type
    assign trap_intr           = trap_cause[5];
    assign trap_enable         = trap_handshake && ~trap_indebug ; //not debug exception

    assign trap_enter_smode    = medeleg_vld || mideleg_vld;

    // always_comb begin
    //     if( (funct3 == F3_CSRRW  )|
    //         (funct3 == F3_CSRRS  )|
    //         (funct3 == F3_CSRRC  )|
    //         (funct3 == F3_CSRRWI )|
    //         (funct3 == F3_CSRRSI )|
    //         (funct3 == F3_CSRRCI ))     csr_wren = instruction_vld && instruction_rdy;
    //     else                            csr_wren = 1'b0;
    // end

    //csr bus 
    assign pmp_bus_valid = (csr_addr>=12'h3a0) & (csr_addr<=12'h3ef);
    assign aia_bus_valid = 1'b0; //need to modify 
    assign csr_bus_valid = (pmp_bus_valid | aia_bus_valid) & instruction_vld;
    assign csr_bus_op = 2'b11;
    assign csr_bus_funct3 = funct3;
    assign csr_bus_imm = csr_imm;
    assign csr_bus_addr = csr_addr;
    assign csr_bus_rrsp = 1'b1;

    assign csr_wren = inst_rd_en & instruction_vld & ((csr_bus_valid & csr_bus_rvalid) | ~csr_bus_valid);

    
    always_comb begin
        case(funct3)
        F3_CSRRW    : csr_wdata = rs1_val               ;
        F3_CSRRS    : csr_wdata = csr_rdata | rs1_val   ;
        F3_CSRRC    : csr_wdata = csr_rdata & ~rs1_val  ;
        F3_CSRRWI   : csr_wdata = csr_imm               ;
        F3_CSRRSI   : csr_wdata = csr_rdata | csr_imm   ;
        F3_CSRRCI   : csr_wdata = csr_rdata & ~csr_imm  ;
        //F3_PRIV     : 
        default     : csr_wdata = {REG_WIDTH{1'b0}}     ;
        endcase
    end

    //============================================================================================

    always_comb begin
        if(csr_bus_valid)
            csr_rdata = csr_bus_rdata;
        else begin 
            case(csr_addr)

            // Unprivileged Counter/Timers ==================================================
            CSR_ADDR_CYCLE      : csr_rdata = csr_CYCLE[REG_WIDTH-1:0]                  ;
            CSR_ADDR_CYCLEH     : csr_rdata = csr_CYCLE[2*REG_WIDTH-1:REG_WIDTH]        ;
            CSR_ADDR_TIME       : csr_rdata = csr_CYCLE[REG_WIDTH-1:0]                  ;       // tmp
            CSR_ADDR_TIMEH      : csr_rdata = csr_CYCLE[2*REG_WIDTH-1:REG_WIDTH]        ;
            CSR_ADDR_INSTRET    : csr_rdata = csr_INSTRET[REG_WIDTH-1:0]                ;
            CSR_ADDR_INSTRETH   : csr_rdata = csr_INSTRET[2*REG_WIDTH-1:REG_WIDTH]      ;

            // Machine Information Registers ================================================
            CSR_ADDR_MVENDORID  : csr_rdata = 32'b0                                     ;       // use 0 because this is not a commercial impl.
            CSR_ADDR_MARCHID    : csr_rdata = 32'b0                                     ;       // 
            CSR_ADDR_MIMPID     : csr_rdata = 32'b0                                     ;       //
            CSR_ADDR_MHARTID    : csr_rdata = 32'b1                                     ;
            //CSR_ADDR_MCONFIGPTR : csr_rdata = 32'b0                                     ;       // config ptr not impl.

            // Machine Trap Setup ===========================================================
            CSR_ADDR_MSTATUS    : csr_rdata = csr_MSTATUS                               ;
            CSR_ADDR_MISA       : csr_rdata = 32'b01000000_00000000_00000001_00000000   ;       // stands for rv32i
            CSR_ADDR_MEDELEG    : csr_rdata = csr_MEDELEG                               ;
            CSR_ADDR_MIDELEG    : csr_rdata = csr_MIDELEG                               ;
            CSR_ADDR_MIE        : csr_rdata = csr_MIE                                   ;
            CSR_ADDR_MTVEC      : csr_rdata = csr_MTVEC                                 ;       // trap handler base address.
            //CSR_ADDR_MCOUNTEREN : csr_rdata = 32'b0                                     ;       // not impl for only M mode system.
            //CSR_ADDR_MSTATUSH   : csr_rdata = 32'b0                                     ;       // mbe=0, sbe=0, always little endian

            // Machine Trap Handling ========================================================
            CSR_ADDR_MSCRATCH   : csr_rdata = csr_MSCRATCH                              ;
            CSR_ADDR_MEPC       : csr_rdata = csr_MEPC                                  ;
            CSR_ADDR_MCAUSE     : csr_rdata = csr_MCAUSE                                ;
            CSR_ADDR_MTVAL      : csr_rdata = csr_MTVAL                                 ;
            CSR_ADDR_MIP        : csr_rdata = csr_MIP                                   ;
            //CSR_ADDR_MTINST     : csr_rdata = 32'b0                                     ;       // not impl
            //CSR_ADDR_MTVAL2     : csr_rdata = 32'b0                                     ;       // not impl

            // Machine Counter/Timers =======================================================
            CSR_ADDR_MCYCLE     : csr_rdata = csr_CYCLE[REG_WIDTH-1:0]                  ;
            CSR_ADDR_MCYCLEH    : csr_rdata = csr_CYCLE[2*REG_WIDTH-1:REG_WIDTH]        ;
            CSR_ADDR_MINSTRET   : csr_rdata = csr_INSTRET[REG_WIDTH-1:0]                ;
            CSR_ADDR_MINSTRETH  : csr_rdata = csr_INSTRET[2*REG_WIDTH-1:REG_WIDTH]      ;

            // Non-Standard MTIME Compare ===================================================
            CSR_ADDR_MTIMECMP   : csr_rdata = csr_MTIMECMP[31:0]                        ;
            CSR_ADDR_MTIMECMPH  : csr_rdata = csr_MTIMECMP[63:32]                       ;

            // supervisor Trap Setup ===========================================================
            CSR_ADDR_SIE        : csr_rdata = csr_SIE                                   ;
            CSR_ADDR_STVEC      : csr_rdata = csr_STVEC                                 ;
            CSR_ADDR_SEPC       : csr_rdata = csr_SEPC                                  ;
            CSR_ADDR_SCAUSE     : csr_rdata = csr_SCAUSE                                ;
            CSR_ADDR_STVAL      : csr_rdata = csr_STVAL                                 ;
            CSR_ADDR_SIP        : csr_rdata = csr_sip_value                             ;

            CSR_ADDR_SSTATUS    : csr_rdata = csr_SSTATUS                               ;
            CSR_ADDR_SCOUNTEREN : csr_rdata = csr_SCOUNTEREN                            ;
            CSR_ADDR_SENVCFG    : csr_rdata = csr_SENVCFG                               ;
            CSR_ADDR_SSCRATCH   : csr_rdata = csr_SSCRATCH                              ;
            CSR_ADDR_SATP       : csr_rdata = csr_SATP                                  ;
            CSR_ADDR_SCONTEXT   : csr_rdata = 32'b0                                     ;  // not impl

            // Debug register data ===========================================================
            CSR_ADDR_DCSR       : csr_rdata = csr_DCSR                                  ;
            CSR_ADDR_DPC        : csr_rdata = debug_pc                                  ;
            CSR_ADDR_DSCRATCH0  : csr_rdata = dscratch0[31:0]                           ;
            CSR_ADDR_DSCRATCH0  : csr_rdata = dscratch1[31:0]                           ;



            default             : csr_rdata = 32'b0                                     ;
            endcase
        end 
    end

    // trap cause bin2onehot =========================================
    always_comb begin
        trap_vec_num[19:0] = 20'b0;
        case(trap_cause[4:0])
            5'd0 : trap_vec_num[19:0] = 20'h00001;
            5'd1 : trap_vec_num[19:0] = 20'h00002;
            5'd2 : trap_vec_num[19:0] = 20'h00004;
            5'd3 : trap_vec_num[19:0] = 20'h00008;
            5'd4 : trap_vec_num[19:0] = 20'h00010;
            5'd5 : trap_vec_num[19:0] = 20'h00020;
            5'd6 : trap_vec_num[19:0] = 20'h00040;
            5'd7 : trap_vec_num[19:0] = 20'h00080;
            5'd8 : trap_vec_num[19:0] = 20'h00100;
            5'd9 : trap_vec_num[19:0] = 20'h00200;
            //5'd10: trap_vec_num[19:0] = 20'h00400;
            5'd11: trap_vec_num[19:0] = 20'h00800;
            5'd12: trap_vec_num[19:0] = 20'h01000;
            5'd13: trap_vec_num[19:0] = 20'h02000;
            5'd14: trap_vec_num[19:0] = 20'h04000;
            5'd15: trap_vec_num[19:0] = 20'h08000;
            default: trap_vec_num[19:0] = 20'h0;
        endcase
    end
 
    // CSR CYCLE =========================================
    

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)  
            csr_CYCLE <= 64'b0;
        else if(debug_stopcount_en)
            csr_CYCLE <= csr_CYCLE ;
        else        
            csr_CYCLE <= csr_CYCLE + 1'b1;
    end



    // CSR TIMECMP =======================================

    // non-standard csr.


    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                              csr_MTIMECMP[31:0]   <= 32'h8000_0000       ;
        else if(csr_wren & (csr_addr == CSR_ADDR_MTIMECMP))     csr_MTIMECMP[31:0]   <= csr_wdata   ;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                              csr_MTIMECMP[63:32] <= 32'h0000_0000        ;
        else if(csr_wren & (csr_addr == CSR_ADDR_MTIMECMPH))    csr_MTIMECMP[63:32] <= csr_wdata    ;
    end

    /*========================================*/
    /*        privileged mode switch          */
    /*========================================*/

    always_ff @(posedge clk or negedge rst_n)begin
        if(!rst_n)
            mode_state <= MACHINE;
        else if(trap_enable)
            mode_state <= mdeleg_vld ? SUPERVISOR : MACHINE;
        else if(ret_en)
            mode_state <= mret_en ? {1'b0,csr_MSTATUS.mpp} :
                            sret_en ? {2'b0,csr_SSTATUS.spp} :
                              dret_en ? csr_DCSR.prv : 'b0;
        else if(debug_handshake)
            mode_state <= DEBUG;
    end

    assign ret_en   = mret_en || sret_en || dret_en;

    assign debug_mode_en    = (mode_state == DEBUG);
    assign MACHINE_state    = (mode_state == MACHINE); 
    assign SUPERVISOR_state = (mode_state == SUPERVISOR);
    assign USER_state       = (mode_state == USER);

    /*========================================*/
    /*            Exception                   */
    /*========================================*/

    assign medeleg_vld = (mode_state[1] == 1'b0) && !trap_intr && |(trap_vec_num[19:0] & csr_MEDELEG[19:0]);

    /*========================================*/
    /*            interrupt                   */
    /*========================================*/

    assign seip = csr_SIP.seip || intr_seip_sync;
    assign stip = csr_SIP.stip || intr_stip_sync;
    assign ssip = csr_SIP.ssip || intr_ssip_sync;

    assign meip = csr_MIP.meip;
    assign mtip = csr_MIP.mtip;
    assign msip = csr_MIP.msip;

    assign csr_mip_value[31:0] = { 20'b0, meip , 1'b0,
                                          seip , 1'b0,
                                          mtip , 1'b0,
                                          stip , 1'b0,
                                          msip , 1'b0,
                                          ssip , 1'b0}; 

    assign meip_en = meip && csr_MIE.meie;
    assign mtip_en = meip && csr_MIE.mtie;
    assign msip_en = meip && csr_MIE.msie;

    assign seip_en = seip && csr_SIE.seie;
    assign stip_en = stip && csr_SIE.stie;
    assign ssip_en = ssip && csr_SIE.ssie;

    assign meip_vld          = meip_en && ((mode_state != MACHINE) || csr_MSTATUS.mie);
    assign mtip_vld          = mtip_en && ((mode_state != MACHINE) || csr_MSTATUS.mie); 
    assign msip_vld          = msip_en && ((mode_state != MACHINE) || csr_MSTATUS.mie);

    assign ssi_deleg_en = csr_MIDELEG.ssie;
    assign sti_deleg_en = csr_MIDELEG.stie;
    assign sei_deleg_en = csr_MIDELEG.seie;

    assign seip_nondeleg_vld = ( ((mode_state == MACHINE) && csr_MSTATUS.mie) ||
                                 (mode_state == SUPERVISOR) || (mode_state == USER) ) && seip_en && !sei_deleg_en;
    assign stip_nondeleg_vld = ( ((mode_state == MACHINE) && csr_MSTATUS.mie) ||
                                 (mode_state == SUPERVISOR) || (mode_state == USER) ) && stip_en && !sti_deleg_en;
    assign ssip_nondeleg_vld = ( ((mode_state == MACHINE) && csr_MSTATUS.mie) ||
                                 (mode_state == SUPERVISOR) || (mode_state == USER) ) && ssip_en && !ssi_deleg_en;

    assign seip_deleg_vld    = ( ((mode_state == SUPERVISOR) && csr_MSTATUS.sie) ||
                                 (mode_state == USER) ) && seip_en && sei_deleg_en;
    assign stip_deleg_vld    = ( ((mode_state == SUPERVISOR) && csr_MSTATUS.sie) ||
                                 (mode_state == USER) ) && stip_en && sti_deleg_en;
    assign ssip_deleg_vld    = ( ((mode_state == SUPERVISOR) && csr_MSTATUS.sie) ||
                                 (mode_state == USER) ) && ssip_en && ssi_deleg_en;

    assign interrupt_req[31:0] = {20'b0, meip_vld || seip_nondeleg_vld, 1'b0,
                                    seip_deleg_vld, 1'b0,
                                    mtip_vld || stip_nondeleg_vld, 1'b0,
                                    stip_deleg_vld, 1'b0,
                                    msip_vld || ssip_nondeleg_vld, 1'b0,
                                    ssip_deleg_vld,1'b0};
    
    assign intr_vld             = |interrupt_req[31:0];

    always_comb begin
        intr_cause[4:0] = 5'b0;
        case(interrupt_req[31:0])
            SUPERVISOR_SW_INT       : intr_cause[4:0] = MCAUSE_SSI; 
            MACHINE_SW_INT          : intr_cause[4:0] = MCAUSE_MSI;
            SUPERVISOR_TIME_INT     : intr_cause[4:0] = MCAUSE_STI;
            MACHINE_TIME_INT        : intr_cause[4:0] = MCAUSE_MTI;
            SUPERVISOR_EXT_INT      : intr_cause[4:0] = MCAUSE_SEI;
            MACHINE_EXT_INT         : intr_cause[4:0] = MCAUSE_MEI;
            DEBUG_HALT_REQ_INT      : intr_cause[4:0] = DEBUG_HALT_REQ;
            default                 : intr_cause[4:0] = 5'b0; 
        endcase
    end

    assign intr_op[5:0] = {1'b1,intr_cause[4:0]};

    //assign intr_req_handshake  = intr_vld && intr_rdy && ~debug_halt_req_p; //TODO
    assign intr_debug_clr      = intr_vld && intr_rdy && debug_halt_req_p;

    // Interrupt Handle ======================================================================

    assign mideleg_vld = (mode_state[1] == 1'b0) && trap_intr && |(trap_vec_num[19:0] & csr_MIDELEG[19:0]);

    // machine deleg to ssupervisor ======================================================================
    assign mdeleg_vld = medeleg_vld && mideleg_vld;

    /*========================================*/
    /*        supervisor mode CSR R/W         */
    /*========================================*/

    // CSR SSTAATUS =========================================

    assign csr_SSTATUS_wren = csr_wren & (csr_addr == CSR_ADDR_SSTATUS);

    assign csr_SSTATUS_wr   = csr_wdata;

    assign csr_SSTATUS.ube  = 1'b0; // always litte endian
    assign csr_SSTATUS.mxr  = 1'b0; 
    assign csr_SSTATUS.sum  = 1'b0; 
    //assign csr_SSTATUS.spp  = 1'b0; 

    assign csr_SSTATUS.xs   = 2'b0;  // user extension always clean.
    assign csr_SSTATUS.fs   = 2'b0;  // no float unit.
    assign csr_SSTATUS.vs   = 2'b0;  // no vector unit.
    assign csr_SSTATUS.sd   = 1'b0;  // summarize for above, always clean.

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            csr_SSTATUS.wrpi5   <= 'b0              ;
            csr_SSTATUS.wrpi4   <= 'b0              ;
            csr_SSTATUS.wrpi3   <= 'b0              ;
            csr_SSTATUS.wrpi2   <= 'b0              ;
            csr_SSTATUS.wrpi1   <= 'b0              ;
            csr_SSTATUS.wrpi0   <= 'b0              ;
        end
        else if(csr_wren & (csr_addr == CSR_ADDR_SSTATUS)) begin
            csr_SSTATUS.wrpi5   <= csr_SSTATUS_wr.wrpi5   ;
            csr_SSTATUS.wrpi4   <= csr_SSTATUS_wr.wrpi4   ;
            csr_SSTATUS.wrpi3   <= csr_SSTATUS_wr.wrpi3   ;
            csr_SSTATUS.wrpi2   <= csr_SSTATUS_wr.wrpi2   ;
            csr_SSTATUS.wrpi1   <= csr_SSTATUS_wr.wrpi1   ;
            csr_SSTATUS.wrpi0   <= csr_SSTATUS_wr.wrpi0   ;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                      csr_SSTATUS.sie     <= 1'b0                 ;
        else if(trap_enable && mdeleg_vld)              csr_SSTATUS.sie     <= 1'b0                 ;
        else if(sret_en)                                csr_SSTATUS.sie     <= csr_SSTATUS.spie     ;
        else if(csr_MSTATUS_wren)                       csr_SSTATUS.sie     <= csr_MSTATUS_wr.sie   ;
        else if(csr_SSTATUS_wren)                       csr_SSTATUS.sie     <= csr_SSTATUS_wr.sie   ;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                      csr_SSTATUS.spie    <= 1'b0                 ;
        else if(trap_enable && mdeleg_vld)              csr_SSTATUS.spie    <= csr_SSTATUS.sie      ;
        else if(sret_en)                                csr_SSTATUS.spie    <= 1'b1                 ;
        else if(csr_MSTATUS_wren)                       csr_SSTATUS.spie    <= csr_MSTATUS_wr.spie  ;
        else if(csr_SSTATUS_wren)                       csr_SSTATUS.spie    <= csr_SSTATUS_wr.spie  ;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                      csr_SSTATUS.spp     <= 1'b0                 ;
        else if(trap_enable && mdeleg_vld)              csr_SSTATUS.spp     <= mode_state[0]        ; //spp is 0 for user mode, 1 for supervisor mode
        else if(sret_en)                                csr_SSTATUS.spp     <= 1'b1                 ;
        else if(csr_MSTATUS_wren)                       csr_SSTATUS.spp     <= csr_MSTATUS_wr.spp   ;
        else if(csr_SSTATUS_wren)                       csr_SSTATUS.spp     <= csr_SSTATUS_wr.spp   ;
    end

    // CSR SIP =========================================

    assign csr_SSIE_wren = csr_wren & (csr_addr == CSR_ADDR_SIE);
    assign csr_SSIP_wren = csr_wren & (csr_addr == CSR_ADDR_SIP);

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            csr_SIP.ssip    <= 1'b0                 ;
            csr_SIP.stip    <= 1'b0                 ;
            csr_SIP.seip    <= 1'b0                 ;
        end else if(csr_wren & (csr_addr == CSR_ADDR_MIP)) begin   //Only machine mode can write SIP, subsets of the MIP                
            csr_SIP.ssip    <= csr_wdata[1]         ;
            csr_SIP.stip    <= csr_wdata[5]         ;
            csr_SIP.seip    <= csr_wdata[9]         ;
        end else if(csr_SSIP_wren && ssi_deleg_en) begin                       
            csr_SIP.ssip    <= csr_wdata[1]         ;
            csr_SIP.stip    <= csr_SIP.stip         ;
            csr_SIP.seip    <= csr_SIP.seip         ;
        end
    end

    assign csr_sip_value[31:0] = { 26'b0, 
                                    seip && csr_MIDELEG.seie,3'b0,
                                    stip && csr_MIDELEG.stie,3'b0,
                                    ssip && csr_MIDELEG.ssie,3'b0,1'b0};

    // CSR SIE =========================================
    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            csr_SIE.ssie    <= 1'b0                 ;
            csr_SIE.stie    <= 1'b0                 ;
            csr_SIE.seie    <= 1'b0                 ;
        end else if(csr_wren & (csr_addr == CSR_ADDR_MIE)) begin  //Only machine mode can write SIE, subsets of the MIE                        
            csr_SIE.ssie    <= csr_wdata[1]         ;
            csr_SIE.stie    <= csr_wdata[5]         ;
            csr_SIE.seie    <= csr_wdata[9]         ;
        end else if(csr_SSIE_wren && ssi_deleg_en) begin                       
            csr_SIE.ssie    <= csr_wdata[1]         ;
            csr_SIE.stie    <= csr_SIP.stip         ;
            csr_SIE.seie    <= csr_SIP.seip         ;
        end
    end

    // CSR STVEC =========================================

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            csr_STVEC[REG_WIDTH-1:2] <= 'b0;
            csr_STVEC[1:0]           <= 'b0;
        end
        else if(csr_wren & (csr_addr == CSR_ADDR_STVEC)) begin
            csr_STVEC[REG_WIDTH-1:2] <= csr_wdata[REG_WIDTH-1:2];
            if(csr_wdata[1]==1'b0) begin //[1:0] only writeable when equal to 2'b00 or 2'b01;
                csr_STVEC[1:0] <= csr_wdata[1:0];
            end
        end
    end

    // CSR SEPC =========================================

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                          csr_SEPC <= 32'b0       ;
        else if(trap_enable && mdeleg_vld)                  csr_SEPC <= trap_pc     ;
        else if(csr_wren & (csr_addr == CSR_ADDR_MEPC))     csr_SEPC <= csr_wdata   ;
    end

    // CSR SCAUSE =========================================

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            csr_SCAUSE <= 32'b0;
        end
        else if(trap_enable && mdeleg_vld) begin
            csr_SCAUSE <= {trap_intr,26'b0,trap_cause[4:0]};
        end 
    end

    // CSR STVAL =========================================

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                          csr_STVAL <= 32'b0              ;
        else if(trap_intr && trap_enable)                   csr_STVAL <= 32'b0              ; //external interrupt will clear mtval reg
        else if(trap_enable && mdeleg_vld)                  csr_STVAL <= trap_extra_info    ;
        else if(csr_wren & (csr_addr == CSR_ADDR_STVAL))    csr_STVAL <= csr_wdata          ;
    end

    // CSR SCOUNTEREN =========================================
    
    assign csr_SCOUNTEREN = 'h0;

    // CSR SENVCFG  =========================================

    assign csr_SENVCFG = 'h0;

    // CSR SSCRATCH =========================================

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                          csr_SSCRATCH <= 32'hb000_0000      ;
        else if(csr_wren & (csr_addr == CSR_ADDR_SSCRATCH)) csr_SSCRATCH <= csr_wdata   ;
    end

    // CSR SATP =========================================

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                          csr_SATP <= 32'h0000_0000      ;
        else if(csr_wren & (csr_addr == CSR_ADDR_SATP))     csr_SATP <= csr_wdata   ;
    end

    // CSR SCONTEXT =========================================

    //assign csr_SCONTEXT = 32'h0;

    /*========================================*/
    /*          machine mode CSR R/W          */
    /*========================================*/

    // CSR MTVEC =========================================

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            csr_MTVEC[REG_WIDTH-1:2] <= 'b0;
            csr_MTVEC[1:0]           <= 'b0;
        end
        else if(csr_wren & (csr_addr == CSR_ADDR_MTVEC)) begin
            csr_MTVEC[REG_WIDTH-1:2] <= csr_wdata[REG_WIDTH-1:2];
            if(csr_wdata[1]==1'b0) begin //[1:0] only writeable when equal to 2'b00 or 2'b01;
                csr_MTVEC[1:0] <= csr_wdata[1:0];
            end
        end
    end


    // CSR MSTATUS & MSTATUSH ============================


    assign csr_MSTATUS_wren = csr_wren & (csr_addr == CSR_ADDR_MSTATUS);

    //assign csr_MSTATUS = 0;//todo

    assign csr_MSTATUS_wr = csr_wdata;

    assign csr_MSTATUS.ube  = 1'b0; // always litte endian
    assign csr_MSTATUS.tvm  = 1'b0; // read only 0 when s-mode is not supported.
    assign csr_MSTATUS.tsr  = 1'b0; // read only 0 when s-mode is not supported.
    assign csr_MSTATUS.tw   = 1'b0; // read only 0 in m-mode only system.
    assign csr_MSTATUS.mxr  = 1'b0; // read only 0 when s-mode is not supported.
    assign csr_MSTATUS.sum  = 1'b0; // read only 0 when s-mode is not supported.
    assign csr_MSTATUS.mprv = 1'b0; // read only 0 when s-mode is not supported.
    
    //assign csr_MSTATUS.mpp  = 2'b0; // read only 0 in m-mode only system.
    //assign csr_MSTATUS.spp  = 1'b0; // read only 0 in m-mode only system.

    assign csr_MSTATUS.xs   = 2'b0;  // user extension always clean.
    assign csr_MSTATUS.fs   = 2'b0;  // no float unit.
    assign csr_MSTATUS.vs   = 2'b0;  // no vector unit.
    assign csr_MSTATUS.sd   = 1'b0;  // summarize for above, always clean.

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            csr_MSTATUS.wpri0   <= 'b0              ;
            csr_MSTATUS.wpri1   <= 'b0              ;
            csr_MSTATUS.wpri2   <= 'b0              ;
            csr_MSTATUS.wpri3   <= 'b0              ;
        end
        else if(csr_wren & (csr_addr == CSR_ADDR_MSTATUS)) begin
            csr_MSTATUS.wpri0   <= csr_MSTATUS_wr   ;
            csr_MSTATUS.wpri1   <= csr_MSTATUS_wr   ;
            csr_MSTATUS.wpri2   <= csr_MSTATUS_wr   ;
            csr_MSTATUS.wpri3   <= csr_MSTATUS_wr   ;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                      csr_MSTATUS.sie     <= 1'b0                 ;
        else if(trap_enable && mdeleg_vld)              csr_MSTATUS.sie     <= 1'b0                 ;
        else if(sret_en)                                csr_MSTATUS.sie     <= csr_MSTATUS.spie     ;
        else if(csr_MSTATUS_wren)                       csr_MSTATUS.sie     <= csr_MSTATUS_wr.sie   ;
        else if(csr_SSTATUS_wren)                       csr_MSTATUS.sie     <= csr_SSTATUS_wr.sie   ;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                      csr_MSTATUS.mie     <= 1'b0                 ; 
        else if(trap_enable && !mdeleg_vld)             csr_MSTATUS.mie     <= 1'b0                 ;
        else if(mret_en)                                csr_MSTATUS.mie     <= csr_MSTATUS.mpie     ;
        else if(csr_MSTATUS_wren)                       csr_MSTATUS.mie     <= csr_MSTATUS_wr.mie   ;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                      csr_MSTATUS.spie    <= 1'b0                 ;
        else if(trap_enable && mdeleg_vld)              csr_MSTATUS.spie    <= csr_MSTATUS.sie      ;
        else if(sret_en)                                csr_MSTATUS.spie    <= 1'b1                 ;
        else if(csr_MSTATUS_wren)                       csr_MSTATUS.spie    <= csr_MSTATUS_wr.spie  ;
        else if(csr_SSTATUS_wren)                       csr_MSTATUS.spie    <= csr_SSTATUS_wr.spie  ;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                      csr_MSTATUS.mpie    <= 1'b0                 ;
        else if(trap_enable && !mdeleg_vld)             csr_MSTATUS.mpie    <= csr_MSTATUS.mie      ;
        else if(mret_en)                                csr_MSTATUS.mpie    <= 1'b1                 ;
        else if(csr_MSTATUS_wren)                       csr_MSTATUS.mpie    <= csr_MSTATUS_wr.mpie  ;       
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                      csr_MSTATUS.spp     <= 1'b0                 ;
        else if(trap_enable && mdeleg_vld)              csr_MSTATUS.spp     <= mode_state[0]        ; //TODO
        else if(sret_en)                                csr_MSTATUS.spp     <= 1'b1                 ; //TODO
        else if(csr_MSTATUS_wren)                       csr_MSTATUS.spp     <= csr_MSTATUS_wr.spp   ;
        else if(csr_SSTATUS_wren)                       csr_MSTATUS.spp     <= csr_SSTATUS_wr.spp   ;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                      csr_MSTATUS.mpp     <= 2'b0                 ;
        else if(trap_enable && !mdeleg_vld)             csr_MSTATUS.mpp     <= mode_state           ;
        else if(mret_en)                                csr_MSTATUS.mpp     <= 2'b11                 ; //TODO
        else if(csr_MSTATUS_wren)                       csr_MSTATUS.mpp     <= csr_MSTATUS_wr.spie  ;    
    end

    // CSR MIP ===========================================



    assign csr_MIP.unused0 = 1'b0   ;
    assign csr_MIP.unused1 = 1'b0   ;
    assign csr_MIP.unused2 = 1'b0   ;
    assign csr_MIP.unused3 = 1'b0   ;
    assign csr_MIP.unused4 = 1'b0   ;
    assign csr_MIP.unused5 = 1'b0   ;
    assign csr_MIP.unused6 = 20'b0  ;

    //assign csr_MIP.ssip = 1'b0                          ; 
    //assign csr_MIP.msip = intr_msip                     ; 
    //assign csr_MIP.stip = 1'b0                          ; 
    assign intr_mtip = (csr_CYCLE > csr_MTIMECMP)    ; 
    //assign csr_MIP.seip = 1'b0                          ; 
    //assign csr_MIP.meip = intr_meip                     ; 
    
    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            csr_MIP.ssip    <= 1'b0             ;
            csr_MIP.msip    <= 1'b0             ;
            csr_MIP.stip    <= 1'b0             ;
            csr_MIP.mtip    <= 1'b0             ;
            csr_MIP.seip    <= 1'b0             ;
            csr_MIP.meip    <= 1'b0             ;
        end else if( intr_meip_sync || intr_msip_sync || intr_mtip )begin
            csr_MIP.ssip    <= 1'b0             ;
            csr_MIP.msip    <= intr_msip_sync && ~intr_meip_sync  ;
            csr_MIP.stip    <= 1'b0             ;
            csr_MIP.mtip    <= intr_mtip && ~intr_msip_sync && ~intr_meip_sync;
            csr_MIP.seip    <= 1'b0             ;
            csr_MIP.meip    <= intr_meip_sync     ;
        end else if(csr_wren & (csr_addr == CSR_ADDR_MIP)) begin
            csr_MIP.ssip    <= csr_wdata[1]     ;
            csr_MIP.msip    <= csr_wdata[3]     ;
            csr_MIP.stip    <= csr_wdata[5]     ;
            csr_MIP.mtip    <= csr_wdata[7]     ;
            csr_MIP.seip    <= csr_wdata[9]     ;
            csr_MIP.meip    <= csr_wdata[11]    ;
        end
    end

    // CSR MIE ===========================================

    assign csr_MIE.unused0 = 1'b0   ;
    assign csr_MIE.unused1 = 1'b0   ;
    assign csr_MIE.unused2 = 1'b0   ;
    assign csr_MIE.unused3 = 1'b0   ;
    assign csr_MIE.unused4 = 1'b0   ;
    assign csr_MIE.unused5 = 1'b0   ;
    assign csr_MIE.unused6 = 20'b0  ;

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            csr_MIE.ssie    <= 1'b0             ;
            csr_MIE.msie    <= 1'b0             ;
            csr_MIE.stie    <= 1'b0             ;
            csr_MIE.mtie    <= 1'b0             ;
            csr_MIE.seie    <= 1'b0             ;
            csr_MIE.meie    <= 1'b1             ; //TODO
        end
        else if(csr_wren & (csr_addr == CSR_ADDR_MIE)) begin
            csr_MIE.ssie    <= csr_wdata[1]     ;
            csr_MIE.msie    <= csr_wdata[3]     ;
            csr_MIE.stie    <= csr_wdata[5]     ;
            csr_MIE.mtie    <= csr_wdata[7]     ;
            csr_MIE.seie    <= csr_wdata[9]     ;
            csr_MIE.meie    <= csr_wdata[11]    ;
        end
    end

    // CSR MEDELEG =========================================

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                          csr_MEDELEG <= 32'b0              ;
        else if(csr_wren & (csr_addr == CSR_ADDR_MEDELEG))  csr_MEDELEG <= csr_wdata          ;
    end

    // CSR MIDELEG =========================================

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                          csr_MIDELEG <= 32'b0              ;
        else if(csr_wren & (csr_addr == CSR_ADDR_MIDELEG))  csr_MIDELEG <= csr_wdata          ;
    end

    // CSR MTVAL ===========================================

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                          csr_MTVAL <= 32'b0              ;
        else if(trap_intr && trap_enable)                   csr_MTVAL <= 32'b0              ; //external interrupt will clear mtval reg
        else if(trap_enable && !mdeleg_vld)                 csr_MTVAL <= trap_extra_info    ;
        else if(csr_wren & (csr_addr == CSR_ADDR_MTVAL))    csr_MTVAL <= csr_wdata          ;
    end

    // CSR MEPC ============================================

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                          csr_MEPC <= 32'b0       ;
        else if(trap_enable && !mdeleg_vld)                 csr_MEPC <= trap_pc     ;
        else if(csr_wren & (csr_addr == CSR_ADDR_MEPC))     csr_MEPC <= csr_wdata   ;
    end

    // CSR MSCRATCH ========================================




    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                          csr_MSCRATCH <= 32'hb000_0000      ;
        else if(csr_wren & (csr_addr == CSR_ADDR_MSCRATCH)) csr_MSCRATCH <= csr_wdata   ;
    end



    // CSR MCAUSE ==========================================


    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            csr_MCAUSE <= 32'b0;
        end
        else if(trap_enable && !mdeleg_vld) begin
            csr_MCAUSE <= {trap_intr,26'b0,trap_cause[4:0]};
        end 
    end

    //interrupt
    //assign interrupt_vld = intr_meip || intr_msip || dm_halt_req_en;

    // Exit debug mode      ==========================================
    assign exit_debug_en = 1'b0;

    // Capture debug halt req pluse==========================================

    always_ff @( posedge clk or negedge rst_n ) begin  //Pending debug halt req
        if(!rst_n)
            debug_halt_req_p <= 1'b0;
        else if(intr_debug_clr)
            debug_halt_req_p <= 1'b0;
        else if(intr_debug_sync)
            debug_halt_req_p <= 1'b1;
    end

    //// Capture debug ebreak req==========================================
    //assign dm_ebreak_en = exception_ebreak_en && debug_ebreakm;
//
    //// Capture debug trigger req==========================================
    //assign dm_trigger_en = 1'b0;
//
    //// Capture debug step req==========================================
    //assign dm_step_en = exception_step_en && debug_step_en;
//
    //// Capture debug rst hart req==========================================
    //assign dm_rst_hart_en = 1'b0;
//
    //// enter debug==========================================
//
    //assign debug_req_en = dm_halt_req_en || dm_ebreak_en || dm_trigger_en || dm_step_en || dm_rst_hart_en;

    assign debug_csr_wr = debug_handshake;

    // Debug CSR DCSR==========================================
    //localparam BREAK_EN     = 5'b00001;
    //localparam TRIGGER_EN   = 5'b00010;
    //localparam HALT_REQ_EN  = 5'b00100;
    //localparam DM_STEP_EN   = 5'b01000;
    //localparam RST_HART_EN  = 5'b10000;

    assign csr_DCSR_wr = csr_wdata;
    
    assign csr_DCSR.xdebugver = 4'd4;  //indicate external debug support,read-only
    assign csr_DCSR.unused2   = 12'b0;
    assign csr_DCSR.unused1   = 1'b0;
    assign csr_DCSR.unused0   = 1'b0;

    always_ff @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin                                          
            csr_DCSR.ebreakm  <= 'b0 ;  //0:cause exception in M mode
            csr_DCSR.ebreaks  <= 'b0 ;
            csr_DCSR.ebreaku  <= 'b0 ;
            csr_DCSR.stepie   <= 'b0 ;
            csr_DCSR.stopcount<= 'b0 ;
            csr_DCSR.stoptime <= 'b0 ;
            csr_DCSR.mprven   <= 'b0 ;
            csr_DCSR.step     <= 'b0 ;
        end
        else if(csr_wren && (csr_addr == CSR_ADDR_DCSR))begin
            csr_DCSR.ebreakm  <= csr_DCSR_wr.ebreakm   ;
            csr_DCSR.ebreaks  <= csr_DCSR_wr.ebreaks   ;
            csr_DCSR.ebreaku  <= csr_DCSR_wr.ebreaku   ;
            csr_DCSR.stepie   <= csr_DCSR_wr.stepie    ;
            csr_DCSR.stopcount<= csr_DCSR_wr.stopcount ;
            csr_DCSR.stoptime <= csr_DCSR_wr.stoptime  ;
            csr_DCSR.mprven   <= csr_DCSR_wr.mprven    ;
            csr_DCSR.step     <= csr_DCSR_wr.step      ;
        end
    end

    //debug step and ebreak enable
    assign debug_step_en         = csr_DCSR.step && ~debug_mode_en ; // m mode and step is enable will execute only one instruciton

    assign debug_ebreakm        = csr_DCSR.ebreakm; // ebreak instructions in M-mode enter Debug Mode

    //interrupt disable during step mode
    assign debug_stepie_en      = csr_DCSR.stepie && debug_step_en; // interrupt will disable during stepping
    assign debug_stepie_mask    = debug_stepie_en || ~debug_step_en;

    //sys count disable during debug mode  
    assign debug_stopcount_en   = csr_DCSR.stopcount && debug_mode_en;

    //sys timer disable during debug mode  
    assign debug_stoptime_en    = csr_DCSR.stoptime && debug_mode_en; 

    always_ff @( posedge clk or negedge rst_n ) begin
        if(!rst_n)
            debug_step_en_1d <= 1'b0;
        else
            debug_step_en_1d <= debug_step_en;
    end

    assign debug_step_release = ~debug_step_en && debug_step_en_1d;

    //debug cause
    //assign debug_mode_cause = {dm_rst_hart_en,dm_step_en,dm_halt_req_en,dm_trigger_en,dm_ebreak_en};

    //csr_DCSR.cause read-only
    always_ff @(posedge clk or negedge rst_n)begin
        if(!rst_n)                                          
            csr_DCSR.cause  <= DM_IDLE ;
        else if(debug_csr_wr)begin
            csr_DCSR.cause  <= debug_cause[2:0];
        end
    end

    assign csr_DCSR.nmip = 1'b0;  //read-only

    always_ff @(posedge clk or negedge rst_n)begin
        if(!rst_n)                                          
            csr_DCSR.prv  <= 2'b0 ;
        else if(debug_csr_wr)
            csr_DCSR.prv  <= mode_state[1:0];
        else if(csr_wren && (csr_addr == CSR_ADDR_DCSR) && debug_mode_en)  
            csr_DCSR.prv  <= csr_DCSR_wr.prv ;
    end

    // Debug PC  ==========================================

    always_ff @(posedge clk or negedge rst_n)begin
        if(!rst_n)
            debug_pc <= 'b0;
        else if(debug_csr_wr)begin
            case(debug_cause)
                DM_EBREAK   :   debug_pc <= debug_pc_val ; //TODO
                DM_TRIGGER  :   debug_pc <= 'b0          ;
                DM_HALT_REQ :   debug_pc <= debug_pc_val ;
                DM_STEP     :   debug_pc <= debug_pc_val ;
                DM_RST_HART :   debug_pc <= 'b0     ;
                default     :   debug_pc <= 'b0     ;
            endcase
        end
        else if(csr_wren && (csr_addr == CSR_ADDR_DPC) && debug_mode_en)  //debugger may write dpc to change where the hart resumes
            debug_pc <= csr_wdata;
    end

    // Debug scratch register  ==========================================

    always_ff @(posedge clk or negedge rst_n)begin
        if(!rst_n)
            dscratch0 <= 'b0;
        else if(csr_wren && (csr_addr == CSR_ADDR_DSCRATCH0) && debug_mode_en)
            dscratch0 <= csr_wdata;
    end

    always_ff @(posedge clk or negedge rst_n)begin
        if(!rst_n)
            dscratch1 <= 'b0;
        else if(csr_wren && (csr_addr == CSR_ADDR_DSCRATCH1) && debug_mode_en)
            dscratch1 <= csr_wdata;
    end

    //exception handle
    `ifdef TOY_SIM
    initial begin
        if($test$plusargs("DEBUG")) begin
            forever begin
                @(posedge clk)
                
                if(intr_vld && intr_rdy)begin
                    $display("[CSR] Trigger Interrupt!!!");
                end
            end
        end
    end

    `endif


`ifdef FPGA_SIM

    csr_ila u_csr_ila (
	    .clk(ila_clk), // input wire clk   

	    .probe0(csr_MSTATUS), // input wire [31:0]  probe0  
	    .probe1(csr_MSCRATCH), // input wire [31:0]  probe1 
	    .probe2(csr_MEPC    ), // input wire [31:0]  probe2 
	    .probe3(csr_MCAUSE  ), // input wire [31:0]  probe3 
	    .probe4(csr_MTVAL   ), // input wire [31:0]  probe4 
	    .probe5(csr_MIP     ), // input wire [31:0]  probe5 
	    .probe6(csr_DCSR ), // input wire [31:0]  probe6 
	    .probe7(debug_pc ), // input wire [31:0]  probe7 
	    .probe8(dscratch0), // input wire [31:0]  probe8 
	    .probe9(dscratch1),
        .probe10(intr_meip_sync), // input wire [31:0]  probe9
        .probe11(csr_CYCLE),
        .probe12(csr_MTVEC)
    );

`endif 

endmodule