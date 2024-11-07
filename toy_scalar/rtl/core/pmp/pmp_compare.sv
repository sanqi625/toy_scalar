import toy_pack::*;
module pmp_compare #(
    parameter integer unsigned PMP_CHANNEL_NUM  = 32,
    parameter integer unsigned ADDR_WIDTH   = 32
) (
    input  logic [ADDR_WIDTH-1:0]         req_addr                                ,
    input  logic [2:0]                    mode_state                              ,
    input  logic [1:0]                    v_req_mode                              ,
    input  pmp_cfg_t                      v_pmp_cfg         [PMP_CHANNEL_NUM-1:0] ,
    input  logic [ADDR_WIDTH-1:0]         v_pmp_addr        [PMP_CHANNEL_NUM-1:0] ,
    input  logic [ADDR_WIDTH-1:0]         v_pmp_napot_mask  [PMP_CHANNEL_NUM-1:0] ,
    output logic                          pass
);

    localparam logic [1:0] LOAD   = 2'b01;
    localparam logic [1:0] STORE  = 2'b10;
    localparam logic [1:0] FETCH  = 2'b11;

    logic                                 v_hit_is_all0                         ;
    logic [PMP_CHANNEL_NUM-1:0]           v_hit                                 ;
    logic [PMP_CHANNEL_NUM-1:0]           v_hit_m1                              ;
    logic [PMP_CHANNEL_NUM-1:0]           v_hit_m1_n                            ;
    logic [PMP_CHANNEL_NUM-1:0]           v_hit_one_hot                         ;
    logic [PMP_CHANNEL_NUM-1:0]           v_hit_one_hot_m1                      ;
    logic [$clog2(PMP_CHANNEL_NUM)-1:0]   v_hit_index                           ;
    logic [ADDR_WIDTH-1:0]                pmp_addr_last  [PMP_CHANNEL_NUM-1:0]  ;
    pmp_cfg_t                             v_hit_entry                           ;

    assign pmp_addr_last[PMP_CHANNEL_NUM-1:1] = v_pmp_addr[PMP_CHANNEL_NUM-2:0];
    assign pmp_addr_last[0] = {ADDR_WIDTH{1'b0}};

    generate for(genvar i=0;i<PMP_CHANNEL_NUM;i=i+1) begin: addr_check_unit
        
        pmp_addr_check #(
            .ADDR_WIDTH(ADDR_WIDTH))
        u_check_unit (
            .req_addr       (req_addr               ),
            .pmp_cfg_A      (v_pmp_cfg[i].a         ),
            .pmp_addr       (v_pmp_addr[i]          ),
            .pmp_addr_last  (pmp_addr_last[i]       ),
            .pmp_napot_mask (v_pmp_napot_mask[i]    ),
            .hit            (v_hit[i]               ));

    end endgenerate

    // leading one and mux
    assign v_hit_is_all0 = ~(|v_hit);
    assign v_hit_m1 = v_hit - 1;
    assign v_hit_m1_n = ~v_hit_m1;
    assign v_hit_one_hot = v_hit & v_hit_m1_n;
    assign v_hit_one_hot_m1 = v_hit_one_hot - 1;

    always_comb begin : hit_find_unit
        v_hit_index = 'b0;
        for (integer j=PMP_CHANNEL_NUM-1;j>=0;j=j+1) begin
            if(v_hit[j])begin 
                v_hit_index = j;
            end 
        end
    end

    //to mux
    assign v_hit_entry = v_hit_is_all0 ? 8'b0 : v_pmp_cfg[v_hit_index];
    assign pass = ((mode_state==MACHINE) & (~v_hit_entry.lock)) |
                  ((v_req_mode==LOAD) & v_hit_entry.r) | 
                  ((v_req_mode==STORE) & v_hit_entry.w) |
                  ((v_req_mode==FETCH) & v_hit_entry.x);

endmodule