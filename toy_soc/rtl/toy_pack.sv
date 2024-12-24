
`define INST_FIELD_OPEXT    [1 : 0]
`define INST_FIELD_OPCODE   [6 : 2]
`define INST_FIELD_RD       [11: 7]
`define INST_FIELD_FUNCT3   [14:12]
`define INST_FIELD_RS1      [19:15]
`define INST_FIELD_RS2      [24:20]
`define INST_FIELD_FUNCT7   [31:25]
`define INST_FIELD_FUNCT12  [31:20]
`define INST_FILED_U_IMM    [31:20]
//`define INST_FIELD_FUNCT6   [31:26]
//`define INST_CUSTOM_FIELD0  [11: 7]
//`define INST_CUSTOM_FIELD1  [25:15]

package toy_pack;

    localparam integer unsigned ADDR_WIDTH = 32;
    localparam integer unsigned DATA_WIDTH = 32;
    localparam integer unsigned INST_WIDTH = 32;
    localparam integer unsigned REG_WIDTH  = 32;
    localparam integer unsigned INST_IDX_WIDTH = 5;

    localparam integer unsigned BUS_DATA_WIDTH = 32;

    localparam DEBUG_PC_ADDR            = {16'h0001,16'h0};
    localparam DEBUG_INST_ROM_BASE      = 16'h0001; //0001_0000
    localparam DEBUG_DATA_LSU_BASE      = 16'h0000; //0000_0000
    localparam DEBUG_INST_RAM_BASE      = 16'h0002;  //0002_0000

    localparam DEBUG_COMMADN_BASE       = 4'h0; //0002_0000
    localparam DEBUG_PROGBUF_BASE       = 4'h8; //0002_8000

    localparam DBEUG_LOOP_ADDR          = 32'h00010030;
    localparam DBEUG_EXP_ADDR           = 32'b00010010;

    localparam NOP                      = 32'h00000013;
    localparam EBREAK                   = 32'h00100073;
    
    // localparam DEBUG_BASE_PC       = DEBUG_INST_BASE_ADDR; //1000_0000
    // localparam DEBUG_INST_ROM_BASE = DEBUG_BASE_PC; //1000_0000
    

    //localparam STATE_FALG_ADDR   = 16'h1001;

    // all the funct3 codes

    typedef enum logic [2:0] {
        F3_ADDSUB = 3'b000,
        F3_SLT    = 3'b010,
        F3_SLTU   = 3'b011,
        F3_XOR    = 3'b100,
        F3_OR     = 3'b110,
        F3_AND    = 3'b111,
        F3_SLL    = 3'b001,
        F3_SR     = 3'b101
    } funct3_op_t;

    typedef enum logic [2:0] {
        F3_BEQ  = 3'b000,
        F3_BNE  = 3'b001,
        F3_BLT  = 3'b100,
        F3_BGE  = 3'b101,
        F3_BLTU = 3'b110,
        F3_BGEU = 3'b111
    } funct3_branch_t;

    typedef enum logic [2:0] {
        F3_LB  = 3'b000,
        F3_LH  = 3'b001,
        F3_LW  = 3'b010,
        F3_LBU = 3'b100,
        F3_LHU = 3'b101
    } funct3_load_t;

    typedef enum logic [2:0] {
        F3_SB  = 3'b000,
        F3_SH  = 3'b001,
        F3_SW  = 3'b010
    } funct3_store_t;

    typedef enum logic [2:0] {
        F3_FENCE  = 3'b000,
        F3_FENCEI = 3'b001
    } funct3_misc_mem_t;

    typedef enum logic [2:0] {
        F3_CSRRW  = 3'b001,
        F3_CSRRS  = 3'b010,
        F3_CSRRC  = 3'b011,
        F3_CSRRWI = 3'b101,
        F3_CSRRSI = 3'b110,
        F3_CSRRCI = 3'b111,
        F3_PRIV   = 3'b000
    } funct3_system_t;

    typedef enum logic [2:0] {
        F3_MUL      = 3'b000,
        F3_MULH     = 3'b001,
        F3_MULHSU   = 3'b010,
        F3_MULHU    = 3'b011,
        F3_DIV      = 3'b100,
        F3_DIVU     = 3'b101,
        F3_REM      = 3'b110,
        F3_REMU     = 3'b111
    } funct3_mul_t;


    typedef enum logic {
        TOY_BUS_READ    = 1'b0,
        TOY_BUS_WRITE   = 1'b1
    } toy_bus_op_t;


    typedef enum logic [11:0] {
        F12_ECALL       = 12'b000000000000,
        F12_EBREAK      = 12'b000000000001,
        F12_SRET        = 12'b000100000010,
        F12_MRET        = 12'b001100000010,
        F12_DRET        = 12'b011110110010,
        F12_WFI         = 12'b000100000101
    } funct12_t;

    typedef enum logic [6:0] {
        F12_SFENCE_VMA  = 7'b0001001,
        F12_SINVAL_VMA  = 7'b0001011,
        F12_SFENC_INV   = 7'b0001100
    } funct7_t;


    typedef struct packed {
        logic [31:0] instruction    ;
        logic [31:0] pc             ;
    } instr_t;


    // RISC-V opcodes
    typedef enum logic [4:0] {
        OPC_LOAD        = 5'b00000,
        //OPC_LOAD_FP   = 5'b00001,
        OPC_CUST0       = 5'b00010,
        OPC_MISC_MEM    = 5'b00011,
        OPC_OP_IMM      = 5'b00100,
        OPC_AUIPC       = 5'b00101,
        //OPC_OP_IMM_32 = 5'b00110,
        //OPC_48B1      = 5'b00111,
    
        OPC_STORE       = 5'b01000,
        //OPC_STORE_FP  = 5'b01001,
        OPC_CUST1       = 5'b01010,
        OPC_AMO         = 5'b01011,
        OPC_OP          = 5'b01100,
        OPC_LUI         = 5'b01101,
        //OPC_OP_32     = 5'b01110,
        //OPC_64B       = 5'b01111,

        //OPC_MADD      = 5'b10000,
        //OPC_MSUB      = 5'b10001,
        //OPC_NMSUB     = 5'b10010,
        //OPC_NMADD     = 5'b10011,
        //OPC_OP_FP     = 5'b10100,
        //OPC_RSVD1     = 5'b10101,
        OPC_CUST2       = 5'b10110,
        //OPC_48B2      = 5'b10111,

        OPC_BRANCH      = 5'b11000,
        OPC_JALR        = 5'b11001,
        //OPC_RSVD2     = 5'b11010,
        OPC_JAL         = 5'b11011,
        OPC_SYSTEM      = 5'b11100,
        //OPC_RSVD3     = 5'b11101,
        OPC_CUST3       = 5'b11110
        //OPC_80B       = 5'b11111,
    } opcode_t;

    typedef enum logic [5:0] { 
        F6_USER_CUSTOM0 = 6'b100011,
        F6_USER_CUSTOM1 = 6'b110011,
        F6_SUPR_CUSTOM0 = 6'b100111,
        F6_SUPR_CUSTOM1 = 6'b110111,
        F6_HYPR_CUSTOM0 = 6'b101011,
        F6_HYPR_CUSTOM1 = 6'b111011,
        F6_MACH_CUSTOM0 = 6'b101111,
        F6_MACH_CUSTOM1 = 6'b111111
     } funct6_t;


    // CSR addresses
    typedef enum logic [11:0] {

        CSR_ADDR_SSTATUS   = 12'h100,
        CSR_ADDR_SIE       = 12'h104,
        CSR_ADDR_STVEC     = 12'h105,
        CSR_ADDR_SCOUNTEREN= 12'h106,
        CSR_ADDR_SENVCFG   = 12'h10A,
        CSR_ADDR_SSCRATCH  = 12'h140,
        CSR_ADDR_SEPC      = 12'h141,
        CSR_ADDR_SCAUSE    = 12'h142,
        CSR_ADDR_STVAL     = 12'h143,
        CSR_ADDR_SIP       = 12'h144,
        CSR_ADDR_SATP      = 12'h180,
        CSR_ADDR_SCONTEXT  = 12'h5A8,

        CSR_ADDR_CYCLE     = 12'hC00,
        CSR_ADDR_TIME      = 12'hC01,
        CSR_ADDR_INSTRET   = 12'hC02,
        CSR_ADDR_CYCLEH    = 12'hC80,
        CSR_ADDR_TIMEH     = 12'hC81,
        CSR_ADDR_INSTRETH  = 12'hC82,

        CSR_ADDR_MISA      = 12'h301,
        CSR_ADDR_MVENDORID = 12'hF11,
        CSR_ADDR_MARCHID   = 12'hF12,
        CSR_ADDR_MIMPID    = 12'hF13,
        CSR_ADDR_MHARTID   = 12'hF14,

        CSR_ADDR_MSTATUS   = 12'h300,
        CSR_ADDR_MEDELEG   = 12'h302,
        CSR_ADDR_MIDELEG   = 12'h303,
        CSR_ADDR_MIE       = 12'h304,
        CSR_ADDR_MTVEC     = 12'h305,

        CSR_ADDR_MSCRATCH  = 12'h340,
        CSR_ADDR_MEPC      = 12'h341,
        CSR_ADDR_MCAUSE    = 12'h342,
        CSR_ADDR_MTVAL     = 12'h343,
        CSR_ADDR_MIP       = 12'h344,

        CSR_ADDR_MCYCLE    = 12'hB00,
        CSR_ADDR_MTIME     = 12'hB01,
        CSR_ADDR_MCYCLEH   = 12'hB80,
        CSR_ADDR_MINSTRET  = 12'hB02,
        CSR_ADDR_MTIMEH    = 12'hB81,
        CSR_ADDR_MINSTRETH = 12'hB82,

        // non-standard but we don't want to memory-map mtimecmp
        CSR_ADDR_MTIMECMP  = 12'h7C1,
        CSR_ADDR_MTIMECMPH = 12'h7C2,

        // provisional debug CSRs
        CSR_ADDR_DCSR      = 12'h7B0,
        CSR_ADDR_DPC       = 12'h7B1,
        CSR_ADDR_DSCRATCH0 = 12'h7B2,
        CSR_ADDR_DSCRATCH1 = 12'h7B3
    } csr_t;

    typedef enum logic [31:0] { 
        SUPERVISOR_SW_INT   = 32'h0000_0002,
        MACHINE_SW_INT      = 32'h0000_0008,
        SUPERVISOR_TIME_INT = 32'h0000_0020,
        MACHINE_TIME_INT    = 32'h0000_0080,
        SUPERVISOR_EXT_INT  = 32'h0000_0200,
        MACHINE_EXT_INT     = 32'h0000_0800,
        DEBUG_HALT_REQ_INT  = 32'h0001_0000
    } interrupt_t;

    // mstatus register
    typedef struct packed {
        logic       sd      ;       // done
        logic [7:0] wpri3   ;       // done
        logic       tsr     ;       // done
        logic       tw      ;       // done
        logic       tvm     ;       // done
        logic       mxr     ;       // done
        logic       sum     ;       // done
        logic       mprv    ;       // done
        logic [1:0] xs      ;       // done
        logic [1:0] fs      ;       // done
        logic [1:0] mpp     ;       // done
        logic [1:0] vs      ;       // done
        logic       spp     ;       // done
        logic       mpie    ;       // done
        logic       ube     ;       // done
        logic       spie    ;       // done
        logic       wpri2   ;       // done
        logic       mie     ;       // done
        logic       wpri1   ;       // done
        logic       sie     ;       // done
        logic       wpri0   ;       // done
    } mstatus_t;


    // machine interrupts pending register
    typedef struct packed {
        logic [19:0]    unused6 ;
        logic           meip    ;
        logic           unused5 ;
        logic           seip    ;
        logic           unused4 ;
        logic           mtip    ;
        logic           unused3 ;
        logic           stip    ;
        logic           unused2 ;
        logic           msip    ;
        logic           unused1 ;
        logic           ssip    ;
        logic           unused0 ;
    } mip_t;

    // machine interrupts enabled register
    typedef struct packed {
        logic [19:0]    unused6 ;
        logic           meie    ;
        logic           unused5 ;
        logic           seie    ;
        logic           unused4 ;
        logic           mtie    ;
        logic           unused3 ;
        logic           stie    ;
        logic           unused2 ;
        logic           msie    ;
        logic           unused1 ;
        logic           ssie    ;
        logic           unused0 ;
    } mie_t;

    // machine exception deleg register
    typedef struct packed {
        logic [15:0]    custom_used;
        logic           sstore_page_fault;
        logic           unused1;
        logic           load_page_fault;
        logic           inst_page_fault ;
        logic           ecall_from_m    ;
        logic           unused0 ;
        logic           ecall_from_s    ;
        logic           ecall_from_u ;
        logic           store_access_fault    ;
        logic           store_addr_misalig ;
        logic           load_access_fault    ;
        logic           load_addr_misalig ;
        logic           breakpoint    ;
        logic           illegal_inst ;
        logic           inst_access_fault    ;
        logic           inst_addr_misalig ;
    } medeleg_t;

    // machine interrupts deleg register
    typedef struct packed {
        logic [21:0]    unused3 ;
        logic           seie    ;
        logic [2:0]     unused2 ;
        logic           stie    ;
        logic [2:0]     unused1 ;
        logic           ssie    ;
        logic           unused0 ;
    } mideleg_t;


    typedef enum logic [5:0] {
        // interrupt codes have the top bit set to 1.
        MCAUSE_SSI     = {1'b1, 5'd1},
        MCAUSE_MSI     = {1'b1, 5'd3},
        MCAUSE_STI     = {1'b1, 5'd5},
        MCAUSE_MTI     = {1'b1, 5'd7},
        MCAUSE_SEI     = {1'b1, 5'd9},
        MCAUSE_MEI     = {1'b1, 5'd11},
        DEBUG_HALT_REQ = {1'b1, 5'd16},

        MCAUSE_INSTR_MISALIGN = 6'd0,
        MCAUSE_INSTR_FAULT    = 6'd1,
        MCAUSE_ILLEGAL_INSTR  = 6'd2,
        MCAUSE_BREAK          = 6'd3,
        MCAUSE_LOAD_MISALIGN  = 6'd4,
        MCAUSE_LOAD_FAULT     = 6'd5,
        MCAUSE_STORE_MISALIGN = 6'd6,
        MCAUSE_STORE_FAULT    = 6'd7,
        MCAUSE_ECALL_U        = 6'd8,
        MCAUSE_ECALL_S        = 6'd9,
        MCAUSE_RESERVED       = 6'd10, //reserved
        MCAUSE_ECALL_M        = 6'd11
        //DCAUSE_STEP           = 6'd24
    } mcause_t;


    typedef enum logic [4:0] { 
        AMOLR       = 5'b00010,
        AMOSC       = 5'b00011,
        AMOSWAP     = 5'b00001,
        AMOADD      = 5'b00000,
        AMOXOR      = 5'b00100,
        AMOAND      = 5'b01100,
        AMOOR       = 5'b01000,
        AMOMIN      = 5'b10000,
        AMOMAX      = 5'b10100,
        AMOMINU     = 5'b11000,
        AMOMAXU     = 5'b11100
    } amo_opcode_t;

    typedef enum logic [2:0] { 
        DEBUG         = 3'b100,
        MACHINE       = 3'b011,
        UNUSED        = 3'b010,
        SUPERVISOR    = 3'b001,
        USER          = 3'b000
        } mode_t;

/* Supervisor CSR */

        // sstatus register
        typedef struct packed {
            logic       sd      ;       // done
            logic [10:0]wrpi5   ;       // done
            logic       mxr     ;       // done
            logic       sum     ;       // done
            logic       wrpi4   ;       // done
            logic [1:0] xs      ;       // done
            logic [1:0] fs      ;       // done
            logic [1:0] wrpi3   ;       // done
            logic [1:0] vs      ;       // done
            logic       spp     ;       // done
            logic       wrpi2   ;       // done
            logic       ube     ;       // done
            logic       spie    ;       // done
            logic [1:0] wrpi1   ;       // done
            logic       sie     ;       // done
            logic       wrpi0   ;       // done
        } sstatus_t;

    // supervisor interrupts pending register
    typedef struct packed {
        logic [19:0]    platform_use ;
        logic [5:0]     unused3 ;
        logic           seip    ;
        logic [2:0]     unused2 ;
        logic           stip    ;
        logic [2:0]     unused1 ;
        logic           ssip    ;
        logic           unused0 ;
    } sip_t;

    // supervisor interrupts enable register
    typedef struct packed {
        logic [19:0]    platform_use ;
        logic [5:0]     unused3 ;
        logic           seie    ;
        logic [2:0]     unused2 ;
        logic           stie    ;
        logic [2:0]     unused1 ;
        logic           ssie    ;
        logic           unused0 ;
    } sie_t;

    typedef struct packed {
        logic           hmp31;
        logic           hpm30;
        logic           hpm29;
        logic [22:0]    unused;
        logic           hpm5;
        logic           hpm4;
        logic           hpm3;
        logic           ir;
        logic           tm;
        logic           cy;
    } scounteren_t;

    typedef struct packed {
        logic           mode;
        logic [8:0]     asid;
        logic [21:0]    ppn;
    } satp_t;

/* Debug CSR */
    typedef enum logic [2:0] { 
        DM_IDLE      = 3'd0,
        DM_EBREAK    = 3'd1,
        DM_TRIGGER   = 3'd2,
        DM_HALT_REQ  = 3'd3,
        DM_STEP      = 3'd4,
        DM_RST_HART  = 3'd5
    } dm_cause_t;

    typedef struct packed {
        logic [3:0]  xdebugver  ;       // done
        logic [11:0] unused2    ;       // done
        logic        ebreakm    ;       // done
        logic        unused1    ;
        logic        ebreaks    ;       // done
        logic        ebreaku    ;       // done
        logic        stepie     ;       // done
        logic        stopcount  ;       // done
        logic        stoptime   ;       // done
        logic [2:0]  cause      ;       // done
        logic        unused0    ;
        logic        mprven     ;       // done
        logic        nmip       ;       // done
        logic        step       ;       // done
        logic [1:0]  prv        ;       // done
    } dcsr_t;

        // PMP Package ---/////////////////////////////////////////

    typedef enum logic[1:0] { 
        OFF   = 2'b00,
        TOR   = 2'b01,
        NA4   = 2'b10,
        NAPOT = 2'b11
    } A_mode_t;

    typedef struct packed {
        logic        lock  ; 
        logic [1:0]  rsv   ;    //Reserve
        logic [1:0]  a     ;
        logic        x     ;
        logic        w     ;
        logic        r     ;
    } pmp_cfg_t;

    //typedef enum logic [2:0] {
    //    CF3_ADDI4SPN    = 3'b000,
    //    CF3_LW          = 3'b010,
    //    CF3_SW          = 3'b110
    //} cfunct3_op00_t;


    //typedef enum logic [2:0] {


    //} cfunct3_op01_t;

    //typedef enum logic [2:0] { 
    //    CF3_SLLI        = 3'b000,
    //    CF3_LWSP        = 3'b010,
    //    CF3_JMEJA       = 3'b100,
    //    CF3_SWSP        = 3'b110
    //} cfunct3_op10_t;

endpackage





// internal, decoded opcodes
// typedef enum logic [5:0] {
//     INTERNAL_INST_LUI,
//     INTERNAL_INST_AUIPC,
//     INTERNAL_INST_JAL,
//     INTERNAL_INST_JALR,
//     INTERNAL_INST_BEQ,
//     INTERNAL_INST_BNE,
//     INTERNAL_INST_BLT,
//     INTERNAL_INST_BGE,
//     INTERNAL_INST_BLTU,
//     INTERNAL_INST_BGEU,
//     INTERNAL_INST_LOAD,
//     INTERNAL_INST_STORE,
//     //INTERNAL_INST_LB,
//     //INTERNAL_INST_LH,
//     //INTERNAL_INST_LW,
//     //INTERNAL_INST_LBU,
//     //INTERNAL_INST_LHU,
//     //INTERNAL_INST_SB,
//     //INTERNAL_INST_SH,
//     //INTERNAL_INST_SW,
//     INTERNAL_INST_ADDI,
//     INTERNAL_INST_SLTI,
//     INTERNAL_INST_SLTIU,
//     INTERNAL_INST_XORI,
//     INTERNAL_INST_ORI,
//     INTERNAL_INST_ANDI,
//     INTERNAL_INST_SLLI,
//     INTERNAL_INST_SRLI,
//     INTERNAL_INST_SRAI,
//     INTERNAL_INST_ADD,
//     INTERNAL_INST_SUB,
//     INTERNAL_INST_SLL,
//     INTERNAL_INST_SLT,
//     INTERNAL_INST_SLTU,
//     INTERNAL_INST_XOR,
//     INTERNAL_INST_SRL,
//     INTERNAL_INST_SRA,
//     INTERNAL_INST_OR,
//     INTERNAL_INST_AND,
//     INTERNAL_INST_FENCE,
//     INTERNAL_INST_FENCE_I,
//     INTERNAL_INST_ECALL,
//     INTERNAL_INST_EBREAK,
//     INTERNAL_INST_INVALID
// } internal_inst_opcode;
