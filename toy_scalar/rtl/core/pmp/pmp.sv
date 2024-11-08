
module pmp #(
    parameter integer unsigned PMP_CHANNEL_NUM  = 32    ,//the num of pmp addr and cfg
    parameter integer unsigned REQ_CHANNEL_NUM  = 3     ,//the num of addr which need to check
    parameter integer unsigned REG_WIDTH        = 32    ,
    parameter integer unsigned ADDR_WIDTH       = 32
) (    
    input   logic                               clk                                 ,
    input   logic                               rst_n                               ,

    input   logic                               csr_req_en                          ,
    input   logic [1:0]                         csr_req_op                          , //csr_op[1]---R, csr_op[0]---W
    input   logic [2:0]                         csr_funct3                          ,
    input   logic [4:0]                         csr_imm                             ,
    input   logic [REG_WIDTH-1:0]               rs1_val                             ,
    //input   logic [31:0]                        csr_wdata                       ,
    input   logic                               csr_rrsp                            ,
    input   logic [11:0]                        csr_req_addr                        ,
    output  logic [31:0]                        csr_req_rdata                       ,
    output                                      csr_req_rvalid                      ,
    output  logic                               csr_act_rsp                         ,
 
    input   logic [2:0]                         mode_state                          ,

    input   logic [ADDR_WIDTH-1:0]              v_req_addr   [REQ_CHANNEL_NUM-1:0]  ,
    input   logic [1:0]                         v_req_mode   [REQ_CHANNEL_NUM-1:0]  ,//instruction mode：01--load; 10--store; 11--fetc
    output  logic [REQ_CHANNEL_NUM-1:0]         v_pass                             
);


    //=========================================================================================
    // PMP config
    //=========================================================================================

    pmp_cfg_t                      v_pmp_cfg         [PMP_CHANNEL_NUM-1:0];    
    logic [ADDR_WIDTH-1:0]         v_pmp_addr        [PMP_CHANNEL_NUM-1:0];   
    logic [ADDR_WIDTH-1:0]         v_pmp_napot_mask  [PMP_CHANNEL_NUM-1:0];
    logic [79:0]                   v_pmp_en                               ;

    //generate NAPORT mask
    logic [ADDR_WIDTH-1:0]    pmp_addr_a1                        ;
    logic [ADDR_WIDTH-1:0]    pmp_addr_n                         ;
    logic [ADDR_WIDTH-1:0]    pmp_addr_onehot                    ;
    logic [ADDR_WIDTH-1:0]    pmp_addr_onehot_m1                 ;
    logic [ADDR_WIDTH-1:0]    pmp_napot_mask                     ;  

    //v_pmp_addr_write
    pmp_cfg_t                 v_pmp_cfg_last  [PMP_CHANNEL_NUM-1:0]   ;
    //v_pmp_addr_read
    logic [6:0]               v_pmp_read_addr                         ;
    logic [4:0]               v_pmp_read_addr_base                    ;
    //v_pmp_wdata
    logic [ADDR_WIDTH-1:0]    csr_wdata                               ;
    //v_pmp_rvalid
    logic                     read_valid                              ;

    //csr_wdata
    always_comb begin: csr_wdata_module
        case(csr_funct3)
        F3_CSRRW    : csr_wdata = rs1_val                   ;
        F3_CSRRS    : csr_wdata = csr_req_rdata | rs1_val   ;
        F3_CSRRC    : csr_wdata = csr_req_rdata & ~rs1_val  ;
        F3_CSRRWI   : csr_wdata = csr_imm                   ;
        F3_CSRRSI   : csr_wdata = csr_req_rdata | csr_imm   ;
        F3_CSRRCI   : csr_wdata = csr_req_rdata & ~csr_imm  ;
        //F3_PRIV     : 
        default     : csr_wdata = {REG_WIDTH{1'b0}}     ;
        endcase
    end

    //pmp rsp normal or exception
    assign  csr_act_rsp = (mode_state!=MACHINE) & csr_req_en;

    //v_pmp_wren generation
    assign v_pmp_read_addr = csr_req_addr-'h3A0;

    always_comb begin
        v_pmp_en = 'b0;
        if(mode_state==MACHINE & csr_req_en)begin
            v_pmp_en[v_pmp_read_addr] = 1'b1;
        end 
        else begin  
            v_pmp_en[v_pmp_read_addr] = 1'b0;
        end 
    end

    //generate NAPOT mask
    assign pmp_addr_a1 = csr_wdata + 1;
    assign pmp_addr_n = ~csr_wdata;
    assign pmp_addr_onehot = pmp_addr_a1 & pmp_addr_n;
    assign pmp_addr_onehot_m1 = pmp_addr_onehot - 1;
    assign pmp_napot_mask = pmp_addr_onehot | pmp_addr_onehot_m1;
    assign v_pmp_cfg_last[PMP_CHANNEL_NUM-2:0] = v_pmp_cfg[PMP_CHANNEL_NUM-1:1];
    assign v_pmp_cfg_last[PMP_CHANNEL_NUM-1] = 8'b0;

    generate for(genvar i=0;i<PMP_CHANNEL_NUM;i=i+1) begin

        always_ff @(posedge clk or negedge rst_n) begin
            if(~rst_n) begin
                v_pmp_addr[i]       <= 'b0;
                v_pmp_napot_mask[i] <= 'b0;
            end 
            else if((~v_pmp_cfg[i].lock) & v_pmp_en[i+16] & csr_req_op[0] & (~v_pmp_cfg_last[i].lock) & (v_pmp_cfg_last[i].a!=TOR)) begin
                v_pmp_addr[i]       <= csr_wdata;
                v_pmp_napot_mask[i] <= pmp_napot_mask;
            end 
        end

    end endgenerate

    logic tag;
    assign tag = (~v_pmp_cfg[0].lock) & v_pmp_en[0] & csr_req_op[0];
    
    generate for(genvar j=0; j<(PMP_CHANNEL_NUM/4);j=j+1) begin:pmp_cfg_write_array

        always_ff @(posedge clk or negedge rst_n) begin
            if      (~rst_n)                                    v_pmp_cfg[j*4] <= 'b0;
            else if ((~v_pmp_cfg[j*4].lock) & v_pmp_en[j] & csr_req_op[0])    v_pmp_cfg[j*4] <= csr_wdata[7:0];
        end 

        always_ff @(posedge clk or negedge rst_n) begin
            if      (~rst_n)                                    v_pmp_cfg[j*4+1] <= 'b0;
            else if ((~v_pmp_cfg[j*4+1].lock) & v_pmp_en[j] & csr_req_op[0])  v_pmp_cfg[j*4+1] <= csr_wdata[15:8];
        end 

        always_ff @(posedge clk or negedge rst_n) begin
            if      (~rst_n)                                    v_pmp_cfg[j*4+2] <= 'b0;
            else if ((~v_pmp_cfg[j*4+2].lock) & v_pmp_en[j] & csr_req_op[0])  v_pmp_cfg[j*4+2] <= csr_wdata[23:16];
        end 

        always_ff @(posedge clk or negedge rst_n) begin
            if      (~rst_n)                                    v_pmp_cfg[j*4+3] <= 'b0;
            else if ((~v_pmp_cfg[j*4+3].lock) & v_pmp_en[j] & csr_req_op[0])  v_pmp_cfg[j*4+3] <= csr_wdata[31:24];
        end 

    end endgenerate


    // read data    
    assign v_pmp_read_addr_base = {v_pmp_read_addr, 2'b00};

    always_comb begin:pmp_reg_read
        if (csr_req_en & csr_req_op[1]) begin
            if(csr_req_addr<'h3B0)begin
                csr_req_rdata[7:0]    = v_pmp_cfg[v_pmp_read_addr_base];
                csr_req_rdata[15:8]   = v_pmp_cfg[v_pmp_read_addr_base+1];
                csr_req_rdata[23:16]  = v_pmp_cfg[v_pmp_read_addr_base+2];
                csr_req_rdata[31:24]  = v_pmp_cfg[v_pmp_read_addr_base+3];
            end
            else begin 
                csr_req_rdata  = v_pmp_addr[csr_req_addr-'h3B0];
            end 
        end
        else begin
            csr_req_rdata = 'b0;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin : read_valid_module
        if (~rst_n) begin
            read_valid <= 1'd0;
        end     
        else if (csr_req_en & csr_req_op[1]) begin
            read_valid <= 1'd1;
        end 
        else if (csr_rrsp) begin
            read_valid <= 1'd0;
        end
    end

    assign csr_req_rvalid = csr_req_en | read_valid;

    //=========================================================================================
    // PMP compare array
    //=========================================================================================


    generate for(genvar i=0; i<REQ_CHANNEL_NUM; i=i+1) begin:pmp_compare_array
        
        pmp_compare #(
            .PMP_CHANNEL_NUM  (PMP_CHANNEL_NUM  ),
            .ADDR_WIDTH       (ADDR_WIDTH       )) 
        u_pmp_checker (
            .mode_state         (mode_state         ),
            .req_addr           (v_req_addr[i]      ),
            .v_req_mode         (v_req_mode[i]      ),
            .v_pmp_cfg          (v_pmp_cfg          ),
            .v_pmp_addr         (v_pmp_addr         ),
            .v_pmp_napot_mask   (v_pmp_napot_mask   ),
            .pass               (v_pass[i]          ));

    end endgenerate


endmodule