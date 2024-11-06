
package debug_pack;

localparam IR_REG_WIRTH       = 5;
localparam DMI_ADDR          = 8;
localparam DMI_DATA          = 32;
localparam DMI_WIDTH         = 2 + 32 + DMI_ADDR;

localparam OP_READ      = 2'b01;
localparam OP_WRITE     = 2'b10;

localparam CORE_NUM          = 1; //delete
localparam HART_NUM_MAX      = 20;

localparam ROM_DEPTH         = 65536; //2^16
localparam ROM_ADDR_WIDTH    = $clog2(ROM_DEPTH);

localparam RV_XLEN              = 8'd32;
//localparam DMI_OTS           = 10;

//localparam STATE_FLAG_BASE    = 16'h1300;

localparam DMI_PROGBUF_BASE    = 4'h2;

//localparam DEBUG_INST_COMMAND_BASE = 16'h11c0; //81c0_0000
//localparam DEBUG_DATA_REG       = 32'h1200_0400;

/*=====================================================*/
/*                          DTM REG                    */
/*=====================================================*/
    typedef enum logic[4:0] { 
        IDCODE_REG_ADDR    = 5'h01,
        DTMCS_REG_ADDR     = 5'h10,
        DMI_REG_ADDR       = 5'h11,
        BYPASS_REG_ADDR    = 5'h1f
    } dmi_data_reg;

    typedef struct packed { 
        logic [DMI_ADDR-1:0] addr;
        logic [31:0]         data;
        logic [1:0]          op;
    } dmi_t;

    typedef struct packed {
        logic [10:0]unused1;
        logic [2:0] errinfo;
        logic       dmihardreset;
        logic       dmireset;
        logic       unused0;
        logic [2:0] idle;
        logic [1:0] dmistat;
        logic [5:0] abits;
        logic [3:0] version;
    } dtmcs_t;

/*=====================================================*/
/*                          DM REG                     */
/*=====================================================*/

    typedef struct packed {
        logic [6:0] unused1;
        logic       ndmresetpending;
        logic       stickyunavail;
        logic       impebreak;
        logic [1:0] unused0;
        logic       allhavereset;
        logic       anyhavereset;
        logic       allresumeack;
        logic       anyresumeack;
        logic       allnonexistent;
        logic       anynonexistent;
        logic       allunavail;
        logic       anyunavail;
        logic       allrunning;
        logic       anyrunning;
        logic       allhalted;
        logic       anyhalted;
        logic       authenticated;
        logic       authbusy;
        logic       hasresethaltreq;
        logic       confstrptrvalid;
        logic [3:0] version;
    } dmstatus_t;

    typedef struct packed {
        logic       haltreq;
        logic       resumereq;
        logic       hartreset;
        logic       ackhavereset;
        logic       ackunavail;
        logic       hasel;
        logic [9:0] hartsello;
        logic [9:0] hartselhi;
        logic       setkeepalive;
        logic       clrkeepalive;
        logic       setresethaltreq;
        logic       clrresethaltreq;
        logic       ndmreset;
        logic       dmactive;
    } dmcontrol_t;

    typedef struct packed {
        logic [7:0] unused1;
        logic [3:0] nscratch;
        logic [2:0] unused0;
        logic       dataaccess;
        logic [3:0] datasize;
        logic [11:0]dataaddr;
    } hart_info_t;

    typedef struct packed {
        logic [2:0] unused2;
        logic [4:0] progbufsize;
        logic [10:0]unused1;
        logic       busy;
        logic       relaxedpriv;
        logic [2:0] cmderr;
        logic [3:0] unused0;
        logic [3:0] datacount;
    } abstractcs_t;

    typedef struct packed {
        logic [7:0] cmdtype;
        logic       unused;
        logic [2:0] arsize;
        logic       aarpostincrement;
        logic       postexec;
        logic       transfer;
        logic       write;
        logic [15:0]regno;
    } command_t;

    typedef struct packed {
        logic [2:0]     sbversion;
        logic [5:0]     unused;
        logic           sbbusyerror;
        logic           sbbusy;
        logic           sbreadonaddr;
        logic [2:0]     sbaccess;
        logic           sbautoincrement;
        logic           sbreadondata;
        logic [2:0]     sberror;
        logic [6:0]     sbasize;
        logic           sbaccess128;
        logic           sbaccess64;
        logic           sbaccess32;
        logic           sbaccess16;
        logic           sbaccess8;
    } sbcs_t;

    typedef enum logic [11:0] { 
        ACCESS_REG_COMMAND = 12'd0,
        QUICK_ACCESS       = 12'd1,
        ACCESS_MEM_COMMAND = 12'd2 
    } cmdtype_t;

    typedef enum logic [2:0] { 
        SB_SIZE8            = 3'd0,
        SB_SIZE16           = 3'd1,
        SB_SIZE32           = 3'd2,
        SB_SIZE64           = 3'd3,
        SB_SIZE128          = 3'd4
    } sb_size_t;

    typedef enum logic [2:0] { 
        SB_NO_ERR           = 3'd0,
        SB_TIMEOUT          = 3'd1,
        SB_BAD_ADDR         = 3'd2,
        SB_ALIG_ERR         = 3'd3,
        SB_SIZE_ERR         = 3'd4,
        SB_OTHER_ERR        = 3'd5
    } sb_error_t;

/*=====================================================*/
/*                          DM REG                     */
/*=====================================================*/

    typedef enum logic [DMI_ADDR-1:0] {  
        DM_CSR_DATA0        = 8'h04,
        DM_CSR_DATA1        = 8'h05,  //use for flag reg
        DM_CSR_DATA2        = 8'h06,
        DM_CSR_DATA3        = 8'h07,
        DM_CSR_DATA4        = 8'h08,
        DM_CSR_DATA5        = 8'h09,
        DM_CSR_DATA6        = 8'h0a,
        DM_CSR_DATA7        = 8'h0b,
        DM_CSR_DATA8        = 8'h0c,
        DM_CSR_DATA9        = 8'h0d,
        DM_CSR_DATA10       = 8'h0e,
        DM_CSR_DATA11       = 8'h0f,

        DM_CSR_DMCONTROL    = 8'h10,
        DM_CSR_DMSTATUS     = 8'h11,
        DM_CSR_HARTINFO     = 8'h12,
        DM_CSR_HALTSUM1     = 8'h13,
        DM_CSR_HAWINDOWSEL  = 8'h14,
        DM_CSR_HAWINDOW     = 8'h15,

        DM_CSR_ABSTRACTCS   = 8'h16,
        DM_CSR_COMMAND      = 8'h17,
        DM_CSR_ABSTRACTAUTO = 8'h18,

        DM_CSR_PROGBUF0     = 8'h20,
        DM_CSR_PROGBUF1     = 8'h21,
        DM_CSR_PROGBUF2     = 8'h22,
        DM_CSR_PROGBUF3     = 8'h23,
        DM_CSR_PROGBUF4     = 8'h24,
        DM_CSR_PROGBUF5     = 8'h25,
        DM_CSR_PROGBUF6     = 8'h26,
        DM_CSR_PROGBUF7     = 8'h27,
        DM_CSR_PROGBUF8     = 8'h28,
        DM_CSR_PROGBUF9     = 8'h29,
        DM_CSR_PROGBUF10    = 8'h2a,
        DM_CSR_PROGBUF11    = 8'h2b,
        DM_CSR_PROGBUF12    = 8'h2c,
        DM_CSR_PROGBUF13    = 8'h2d,
        DM_CSR_PROGBUF14    = 8'h2e,
        DM_CSR_PROGBUF15    = 8'h2f,

        DM_CSR_HALTSUM2     = 8'h34,
        DM_CSR_HALTSUM3     = 8'h35,

        DM_CSR_SBADDRESS3   = 8'h37,
        DM_CSR_SBCS         = 8'h38,
        DM_CSR_SBADDRESS0   = 8'h39,
        DM_CSR_SBADDRESS1   = 8'h3a,
        DM_CSR_SBADDRESS2   = 8'h3b,
        DM_CSR_SBDATA0      = 8'h3c,
        DM_CSR_SBDATA1      = 8'h3d,
        DM_CSR_SBDATA2      = 8'h3e,
        DM_CSR_SBDATA3      = 8'h3f
    } dm_csr_t;

    typedef enum logic [11:0]{  
        DATA_REG_ADDR   = 12'h400,
        HALT_ADDR       = 12'h404,
        GOING_ADDR      = 12'h408,
        RESUME_ADDR     = 12'h40c,
        EXCEP_ADDR      = 12'h410
    } hart_state_addr_t;

    typedef struct packed {
        logic [31:0] halt;
        logic [31:0] going;
        logic [31:0] resume;
        logic [31:0] exception;
    } hart_state_t;

endpackage