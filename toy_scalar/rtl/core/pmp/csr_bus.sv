
module csr_bus #(
    parameter integer unsigned ADDR_WIDTH  = 32    ,
    parameter integer unsigned REG_WIDTH   = 32    
) (
    input   logic   [1:0]                   csr_op      ,       //csr_op[1]---R, csr_op[0]---W
    input   logic   [2:0]                   csr_funct3  , 
    input   logic   [4:0]                   csr_imm     ,
    input   logic   [REG_WIDTH-1:0]         rs1_val     ,      
    input   logic   [ADDR_WIDTH-1:0]        csr_addr    ,
    input   logic                           csr_valid   ,
    input   logic                           csr_rrsp    ,       //csr module read rsp 
    output  logic   [ADDR_WIDTH-1:0]        csr_rdata   ,       //csr read data
    output  logic                           csr_rvalid  ,       //csr rsp valid (include reg rsp and rdata) 
    output  logic   [2:0]                   csr_reg_rsp ,       //bit2: 0--normal 1--exception bit[1:0]: cause

    //pmp port
    input   logic   [ADDR_WIDTH-1:0]        pmp_rdata   ,
    input   logic                           pmp_rvalid  ,
    input   logic   [2:0]                   pmp_act_rsp ,       //bit2: 0--normal 1--exception bit[1:0]: cause
    output  logic                           pmp_rrsp    ,
    output  logic   [ADDR_WIDTH-1:0]        pmp_addr    ,
    output  logic   [4:0]                   pmp_csr_imm ,
    output  logic   [REG_WIDTH-1:0]         pmp_rs1_val ,
    output  logic   [2:0]                   pmp_funct3  ,
    output  logic   [1:0]                   pmp_reg_op  ,
    output  logic                           pmp_reg_en  , 

    //aia port
    input   logic   [ADDR_WIDTH-1:0]        aia_rdata   ,
    input   logic                           aia_rvalid  ,
    input   logic   [2:0]                   aia_act_rsp ,      //bit2: 0--normal 1--exception bit[1:0]: cause
    output  logic                           aia_rrsp    ,
    output  logic   [ADDR_WIDTH-1:0]        aia_addr    ,
    output  logic   [4:0]                   aia_csr_imm ,
    output  logic   [REG_WIDTH-1:0]         aia_rs1_val ,
    output  logic   [2:0]                   aia_funct3  ,
    output  logic   [1:0]                   aia_reg_op  ,
    output  logic                           aia_reg_en  
);

    logic     pmp_addr_hit;
    logic     aia_addr_hit;

    assign pmp_addr_hit = (csr_addr>=12'h3a0) & (csr_addr<=12'h3ef);
    assign aia_addr_hit = (csr_addr==12'h0); //need to modify aia addr

    always_comb begin : aia_or_pmp_port_mux
        case ({pmp_addr_hit,aia_addr_hit})
        2'b10 : begin
                    pmp_addr    = csr_addr    ;
                    pmp_rrsp    = csr_rrsp    ;
                    pmp_csr_imm = csr_imm     ;
                    pmp_rs1_val = rs1_val     ;
                    pmp_funct3  = csr_funct3  ;
                    pmp_reg_op  = csr_op      ;
                    pmp_reg_en  = csr_valid   ;
                    csr_rdata   = pmp_rdata   ;
                    csr_reg_rsp = pmp_act_rsp ;
                    csr_rvalid  = pmp_rvalid  ;
        end
        2'b01 : begin
                    aia_addr    = csr_addr    ;
                    aia_rrsp    = csr_rrsp    ;
                    aia_csr_imm = csr_imm     ;
                    aia_rs1_val = rs1_val     ;
                    aia_funct3  = csr_funct3  ;
                    aia_reg_op  = csr_op      ;
                    aia_reg_en  = csr_valid   ;
                    csr_rdata   = aia_rdata   ;
                    csr_reg_rsp = aia_act_rsp ;
                    csr_rvalid  = aia_rvalid  ;
        end 
        default:begin
                    pmp_addr    = 'b0    ;
                    pmp_rrsp    = 'b0    ;
                    pmp_csr_imm = 'b0    ;
                    pmp_rs1_val = 'b0    ;
                    pmp_funct3  = 'b0    ;
                    pmp_reg_op  = 'b0    ;
                    pmp_reg_en  = 'b0    ;  
                    aia_addr    = 'b0    ;
                    aia_rrsp    = 'b0    ;
                    aia_csr_imm = 'b0    ;
                    aia_rs1_val = 'b0    ;
                    aia_funct3  = 'b0    ;
                    aia_reg_op  = 'b0    ;
                    aia_reg_en  = 'b0    ;
                    csr_rdata   = 'b0    ;
                    csr_reg_rsp = 'b0    ;
                    csr_rvalid  = 'b0    ;
        end
        endcase    
    end
    
endmodule