import toy_pack::*; 
module pmp_addr_check #(
    parameter integer unsigned ADDR_WIDTH = 32
) (
    input  logic [ADDR_WIDTH-1:0]    req_addr        ,
    input  logic [1:0]               pmp_cfg_A       ,
    input  logic [ADDR_WIDTH-1:0]    pmp_addr        ,
    input  logic [ADDR_WIDTH-1:0]    pmp_addr_last   ,
    input  logic [ADDR_WIDTH-1:0]    pmp_napot_mask  ,
    output logic                     hit        
);

    logic   TOR_hit  ;
    logic   NA4_hit  ;
    logic   NAPOT_hit;
    assign TOR_hit      = (req_addr >= pmp_addr_last) & (req_addr < pmp_addr);
    assign NA4_hit      = (req_addr == pmp_addr);
    assign NAPOT_hit    = (req_addr | pmp_napot_mask) == (pmp_addr | pmp_napot_mask);

    // req_mode .........OFF----2'b00
    //                   TOR----2'b01
    //                   NA4----2'b10
    //                   NAPOT--2'b11
    always_comb begin
        case(pmp_cfg_A)
            OFF     : hit = 1'b0            ;
            TOR     : hit = TOR_hit         ;
            NA4     : hit = NA4_hit         ;
            NAPOT   : hit = NAPOT_hit       ;
            default : hit = 1'b0            ;
        endcase
    end

endmodule