module toy_lsu 
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
    input  logic [ADDR_WIDTH-1:0]     pc                  ,
    input  logic [REG_WIDTH-1:0]      rs1_val             ,
    input  logic [REG_WIDTH-1:0]      rs2_val             ,
    input  logic [31:0]               inst_imm            ,

    // reg access
    output logic [4:0]                reg_index           ,
    output logic                      reg_wr_en           ,
    output logic [REG_WIDTH-1:0]      reg_val             ,
    
    output logic [INST_IDX_WIDTH-1:0] reg_inst_idx_wr     ,
    output logic [INST_IDX_WIDTH-1:0] reg_inst_idx_rd     ,
    output logic                      inst_commit_en_rd   ,
    output logic                      inst_commit_en_wr   ,

    output logic [ADDR_WIDTH-1:0]     lsu_pc              ,//add
    output logic                      lsu_exception_en    ,
    output logic [31:0]               lsu_exception_cause ,
    output logic [INST_WIDTH-1:0]     lsu_exception_inst  ,      

    //mem access
    output logic                      mem_req_vld         ,
    input  logic                      mem_req_rdy         ,
    output logic [ADDR_WIDTH-1:0]     mem_req_addr        ,
    output logic [DATA_WIDTH-1:0]     mem_req_data        ,
    output logic [DATA_WIDTH/8-1:0]   mem_req_strb        ,
    output logic                      mem_req_opcode      ,

    input  logic                      mem_ack_vld         ,
    output logic                      mem_ack_rdy         ,
    input  logic [DATA_WIDTH-1:0]     mem_ack_data        ,

    //csr bus
    input  logic [1:0]                csr_op              ,       //csr_op[1]---R, csr_op[0]---W
    input  logic [2:0]                csr_funct3          , 
    input  logic [REG_WIDTH-1:0]      csr_rs1_val         ,
    input  logic [4:0]                csr_imm             ,      
    input  logic [ADDR_WIDTH-1:0]     csr_addr            ,
    input  logic                      csr_valid           ,
    input  logic                      csr_rrsp            ,       //csr module read rsp 
    output logic [ADDR_WIDTH-1:0]     csr_rdata           ,       //csr read data
    output logic                      csr_rvalid          ,       //csr read valid 
    output logic                      csr_reg_rsp         ,       //0---normal  1---exception

    //pmp port
    input  logic [2:0]                mode_state          ,

    //fetch port
    input  logic [ADDR_WIDTH-1:0]     fetch_req_addr      ,
    input  logic [1:0]                fetch_req_mode      ,
    output logic                      fetch_addr_pass 


);

    logic                   is_amo      ;
    logic                   is_store    ;
    logic                   is_lr       ;
    logic                   is_sc       ;
    logic                   amo_store   ;
    logic                   sc_success  ;

    logic [4:0]             opcode      ;
    logic [4:0]             opcode_dly  ;
    logic [2:0]             funct3      ;
    logic [2:0]             funct3_dly  ;
    logic [REG_WIDTH-1:0]   raw_address ;
    logic [REG_WIDTH-1:0]   raw_address_r       ;
    logic [1:0]             word_offset         ;
    logic [1:0]             word_offset_dly1    ;
    logic [REG_WIDTH-1:0]   lrsc_tag            ;
    logic                   lrsc_tag_valid      ;
    
    logic [REG_WIDTH-1:0]   rs2_val_r           ;

    assign inst_commit_en_wr = is_store && instruction_vld & instruction_rdy;
    assign inst_commit_en_rd = reg_wr_en;
    assign reg_inst_idx_wr = instruction_idx;


    
    assign opcode   = instruction_pld`INST_FIELD_OPCODE         ;
    assign funct3   = instruction_pld`INST_FIELD_FUNCT3         ;
    assign is_store = (opcode == OPC_STORE) |  
                      (instruction_pld[31:27] == AMOSC)  ; //&& instruction_vld  ;
    assign is_amo   = (opcode == OPC_AMO) && (instruction_pld[31:27] != AMOLR) && (instruction_pld[31:27] != AMOSC)  ;
    assign is_lr    = (opcode == OPC_AMO) & (instruction_pld[31:27] == AMOLR);
    assign is_sc    = (opcode == OPC_AMO) & (instruction_pld[31:27] == AMOSC); 

    assign mem_ack_rdy = 1'b1;
    assign instruction_rdy = is_amo ? (amo_store & mem_req_vld & mem_req_rdy) : 1'b1;

//===================================================================
// state control
//===================================================================

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                          amo_store <= 1'b0;
        else if(amo_store) begin
            if(mem_req_vld & mem_req_rdy)                  amo_store <= 1'b0;
        end
        else begin
            if(instruction_vld & is_amo)                   amo_store <= 1'b1;
        end
    end

//===================================================================
// register update
//===================================================================
    logic [1:0] sc_state;

    logic [DATA_WIDTH-1:0]  shifted_rd_data;
    
    assign shifted_rd_data  = (mem_ack_data >> word_offset_dly1*8)  ;

    always_comb begin
        case(sc_state) 
        2'b00:              reg_val = 32'b0;
        2'b01:              reg_val = 32'b1;
        2'b10:              reg_val = mem_ack_data;
        2'b11: begin
            case(funct3_dly)
            F3_LB       :   reg_val = {{24{shifted_rd_data[7]}}   ,   shifted_rd_data[7:0]    };
            F3_LBU      :   reg_val = {24'b0                      ,   shifted_rd_data[7:0]    };
            F3_LH       :   reg_val = {{16{shifted_rd_data[15]}}  ,   shifted_rd_data[15:0]   };
            F3_LHU      :   reg_val = {16'b0                      ,   shifted_rd_data[15:0]   };
            F3_LW       :   reg_val = mem_ack_data;
            default     :   reg_val = mem_ack_data;
            endcase
        end
        default:            reg_val = mem_ack_data;
        endcase
    end

    always_ff @(posedge clk) begin
        reg_wr_en <= (inst_rd_en & instruction_vld & (~amo_store));
    end

    always_ff @(posedge clk) begin
        if(instruction_vld) begin
            if(opcode == OPC_AMO) begin
                if (instruction_pld[31:27] == AMOSC) begin
                    if(sc_success)                      sc_state <= 2'b00;  // sc success
                    else                                sc_state <= 2'b01;  // sc fail
                end 
                else begin
                                                        sc_state <= 2'b10;  // other amo
                end
            end
            else begin
                                                        sc_state <= 2'b11;  // not amo operation.
            end
        end
    end


    always_ff @(posedge clk) begin
        if(instruction_vld) begin
            //opcode_dly          <= opcode           ;
            word_offset_dly1    <= word_offset      ;
            reg_index           <= inst_rd_idx      ;
            reg_inst_idx_rd     <= instruction_idx  ;
            funct3_dly          <= funct3           ;
        end
    end


//===================================================================
// memory access
//===================================================================




    assign raw_address      = rs1_val + inst_imm     ;
    assign word_offset      = raw_address[1:0]  ;
    //assign mem_req_addr     = amo_store ? raw_address_r : raw_address               ;
    assign mem_req_addr     = raw_address ;
    assign mem_req_vld      = amo_store ? 1'b1 : instruction_vld                    ; // need more status bit to wait amo read finish.
    assign mem_req_opcode   = (is_store | amo_store) ? TOY_BUS_WRITE : TOY_BUS_READ ;

    always_comb begin
        if(amo_store) begin
            case(instruction_pld[31:27])
            //AMOLR   :
            AMOSC   :   mem_req_data = rs2_val;
            AMOSWAP :   mem_req_data = rs2_val;
            AMOADD  :   mem_req_data = rs2_val + mem_ack_data;
            AMOXOR  :   mem_req_data = rs2_val ^ mem_ack_data;
            AMOAND  :   mem_req_data = rs2_val & mem_ack_data;
            AMOOR   :   mem_req_data = rs2_val | mem_ack_data;
            AMOMIN  :   mem_req_data = ($signed(rs2_val) <  $signed(mem_ack_data)) ? rs2_val : mem_ack_data;
            AMOMAX  :   mem_req_data = ($signed(rs2_val) <  $signed(mem_ack_data)) ? mem_ack_data : rs2_val;
            AMOMINU :   mem_req_data = (rs2_val <  mem_ack_data) ? rs2_val : mem_ack_data;
            AMOMAXU :   mem_req_data = (rs2_val <  mem_ack_data) ? mem_ack_data : rs2_val;
            default:    mem_req_data = rs2_val;
            endcase
        end
        else begin
                        mem_req_data = rs2_val << word_offset*8 ;
        end
    end

    always_comb begin
        if(opcode == OPC_AMO) begin
            if(instruction_pld[31:27] == AMOSC) begin
                if(sc_success)  mem_req_strb = 4'b1111;
                else            mem_req_strb = 4'b0000;
            end
            else begin
                            mem_req_strb = 4'b1111;
            end

            //if(sc_success & (instruction_pld[31:27] == AMOSC))  mem_req_strb = 4'b0000;
            //else            mem_req_strb = 4'b1111;
        end
        else begin
            case(funct3) 
            F3_LB,F3_LBU:   mem_req_strb = 4'b0001 << word_offset    ;
            F3_LH,F3_LHU:   mem_req_strb = 4'b0011 << word_offset    ;
            F3_LW:          mem_req_strb = 4'b1111 << word_offset    ;
            default:        mem_req_strb = 4'b0000                   ;
            endcase
        end
    end


//===================================================================
// lr/sc tag
//===================================================================

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                              lrsc_tag <= 32'b0           ;
        else if(instruction_vld & instruction_rdy & is_lr)      lrsc_tag <= raw_address     ;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                              lrsc_tag_valid <= 1'b0;
        else if(instruction_vld & instruction_rdy & is_lr)      lrsc_tag_valid <= 1'b1;
        else if(instruction_vld & instruction_rdy & is_sc)      lrsc_tag_valid <= 1'b0;
    end

    assign sc_success = (raw_address == lrsc_tag) & lrsc_tag_valid;


//===================================================================
// CSR Bus
//===================================================================

//pmp port
logic   [ADDR_WIDTH-1:0]        pmp_rdata   ;
logic                           pmp_rvalid  ;
logic                           pmp_act_rsp ;       //pmp_act_rsp: 0----normal  1----exception
logic                           pmp_rrsp    ;
logic   [11:0]                  pmp_addr    ;
logic   [4:0]                   pmp_csr_imm ;
logic   [REG_WIDTH-1:0]         pmp_rs1_val ;
logic   [2:0]                   pmp_funct3  ;
logic   [1:0]                   pmp_reg_op  ;
logic                           pmp_reg_en  ;   

csr_bus #(
    .ADDR_WIDTH (ADDR_WIDTH)    ,
    .REG_WIDTH  (REG_WIDTH )    
) u_csr_bus (
    .csr_op      (csr_op     ),       //csr_op[1]---R, csr_op[0]---W
    .csr_funct3  (csr_funct3 ), 
    .csr_imm     (csr_imm    ),
    .rs1_val     (csr_rs1_val),      
    .csr_addr    (csr_addr   ),
    .csr_valid   (csr_valid  ),
    .csr_rrsp    (csr_rrsp   ),       //csr module read rsp 
    .csr_rdata   (csr_rdata  ),       //csr read data
    .csr_rvalid  (csr_rvalid ),       //csr rsp valid 
    .csr_reg_rsp (csr_reg_rsp),       //0---normal  1---exception

    .pmp_rdata   (pmp_rdata  ),
    .pmp_rvalid  (pmp_rvalid ),
    .pmp_act_rsp (pmp_act_rsp),       //pmp_act_rsp: 0----normal  1----exception
    .pmp_rrsp    (pmp_rrsp   ),
    .pmp_addr    (pmp_addr   ),
    .pmp_csr_imm (pmp_csr_imm),
    .pmp_rs1_val (pmp_rs1_val),
    .pmp_funct3  (pmp_funct3 ),
    .pmp_reg_op  (pmp_reg_op ),
    .pmp_reg_en  (pmp_reg_en ),

    .aia_rdata   ('b0        ),
    .aia_rvalid  ('b0        ),
    .aia_act_rsp ('b0        )
);

//===================================================================
// PMP
//===================================================================

logic [ADDR_WIDTH-1:0]              v_req_addr   [1:0]  ;
logic [1:0]                         v_req_mode   [1:0]  ; //instruction mode：01--load; 10--store; 11--fetc
logic [1:0]                         v_pass              ;
logic                               lsu_access_exception;

//lsu addr check
assign v_req_addr[0] = raw_address;
assign v_req_mode[0] = (is_store | amo_store) ? 2'b10 : 2'b01;
assign lsu_access_exception = ~v_pass[0] & mem_req_vld;

//fetch addr check
assign v_req_addr[1] = fetch_req_addr;
assign v_req_mode[1] = fetch_req_mode;
assign fetch_addr_pass = v_pass[1];

pmp #(
    .PMP_CHANNEL_NUM ('d32)    ,//the num of pmp addr and cfg
    .REQ_CHANNEL_NUM ('d2 )    ,//the num of addr which need to check
    .REG_WIDTH       ('d32)    ,
    .ADDR_WIDTH      ('d32)
) u_pmp(    
    .clk            (clk           ),
    .rst_n          (rst_n         ),
    //csr_bus
    .csr_req_en     (pmp_reg_en    ),
    .csr_req_op     (pmp_reg_op    ), //csr_op[1]---R, csr_op[0]---W
    .csr_funct3     (pmp_funct3    ),
    .csr_imm        (pmp_csr_imm   ),
    .rs1_val        (pmp_rs1_val   ),
    .csr_rrsp       (pmp_rrsp      ),
    .csr_req_addr   (pmp_addr      ),
    .csr_req_rdata  (pmp_rdata     ),
    .csr_req_rvalid (pmp_rvalid    ),
    .csr_act_rsp    (pmp_act_rsp   ),
    //pmp_port
    .mode_state     (mode_state    ),
    .v_req_addr     (v_req_addr    ),
    .v_req_mode     (v_req_mode    ),//instruction mode：01--load; 10--store; 11--fetc
    .v_pass         (v_pass        )
);


//===================================================================
// Exception
//===================================================================
    assign lsu_pc                               = pc;
    assign lsu_exception_cause                  = lsu_access_exception ? ((is_lr|is_sc|is_store) ? 32'd7 
                                                                                                  :32'd5) 
                                                                                                  :32'd0;
    assign lsu_exception_en                     = lsu_access_exception;
    assign lsu_exception_inst[INST_WIDTH-1:0]   = instruction_pld[INST_WIDTH-1:0];


//===================================================================
// sim debug
//===================================================================





    `ifdef TOY_SIM

    logic [ADDR_WIDTH-1:0] mem_req_addr_dly;
    
    always_ff @(posedge clk) begin
        if(mem_req_vld & mem_req_rdy) mem_req_addr_dly <= mem_req_addr;
    end


    initial begin
        if($test$plusargs("DEBUG")) begin
            forever begin
                @(posedge clk)

                if(is_store) begin
                    $display("[lsu][st] receive a inst[%h] = [0x%h].",pc, instruction_pld); 
                    $display("[lsu][st] mem[0x%h] = %h = reg[%0d]", mem_req_addr, rs2_val, instruction_pld`INST_FIELD_RS2);
                end

                if(reg_wr_en) begin
                    if($isunknown(mem_ack_data))
                        $display("[lsu][ls] ERROR!!!! load x val from mem[%h]= %h.", mem_req_addr_dly, mem_ack_data);
                    $display("[lsu][ld] reg[%d] = %h, mem[%h]= %h", reg_index, reg_val, mem_req_addr_dly, mem_ack_data);
                    $display("[lsu][ld] mem data: %h.", mem_ack_data);
                end

                if(instruction_vld && instruction_rdy && ~is_store) begin
                    $display("[lsu][ld] receive a inst[%h] = [0x%h].",pc, instruction_pld); 
                end

            end
        end
    end
    `endif


endmodule


    //    if(opcode == OPC_AMO) begin
    //        if (instruction_pld[31:27] == AMOSC) begin
    //            if(sc_success)                      reg_val = 32'b0;
    //            else                                reg_val = 32'b1;
    //        end 
    //        else                                    reg_val = mem_ack_data;
    //    end
    //    else begin
    //        case(funct3_dly)
    //        F3_LB       : reg_val = {{24{shifted_rd_data[7]}}   ,   shifted_rd_data[7:0]    };
    //        F3_LBU      : reg_val = {24'b0                      ,   shifted_rd_data[7:0]    };
    //        F3_LH       : reg_val = {{16{shifted_rd_data[15]}}  ,   shifted_rd_data[15:0]   };
    //        F3_LHU      : reg_val = {16'b0                      ,   shifted_rd_data[15:0]   };
    //        F3_LW       : reg_val = mem_ack_data;
    //        default     : reg_val = mem_ack_data;
    //        endcase
    //    end
    //end 





    //always_ff @(posedge clk) begin
    //    reg_wr_en           <= (inst_rd_en & instruction_vld & instruction_rdy) | (~amo_store & instruction_vld & is_amo );
    //end 
