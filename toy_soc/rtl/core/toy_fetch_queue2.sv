
module toy_fetch_queue2 #(
    parameter   int unsigned DEPTH    = 8             ,
    parameter   type         PLD_TYPE = logic[32-1:0]
)(
    input   logic               clk         ,
    input   logic               rst_n       ,

    input   logic               clear       ,

    input   logic               req_vld     ,
    output  logic               req_rdy     ,
    input   PLD_TYPE            req_pld     ,
    input   logic               mis_align_mem_data,
    
    output  logic               ack_vld     ,
    input   logic               ack_rdy     ,
    output  PLD_TYPE            ack_pld
);

    logic [15:0]                pld_mem  [DEPTH-1:0]    ;
    logic [DEPTH-1:0]           pld_en                  ;
    logic [$clog2(DEPTH)-1:0]   rd_ptr                  ;
    logic [$clog2(DEPTH)-1:0]   rd_ptr_add_1            ;
    logic [$clog2(DEPTH)-1:0]   wr_ptr                  ;
    logic [$clog2(DEPTH)-1:0]   wr_ptr_add_1            ;

    logic rd_halfword_0_size   ; // 0: 16bit    1: 32bit
    logic rd_ch0_en     ;
    logic wr_en         ;


    //##############################################
    // write ptr
    //##############################################

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)      wr_ptr <= 0;
        else if(clear)  wr_ptr <= 0;
        else if(wr_en & mis_align_mem_data) wr_ptr <= wr_ptr + 1;
        else if(wr_en)  wr_ptr <= wr_ptr + 2;
    end

    //##############################################
    // write ctrl
    //##############################################

    assign req_rdy = (~pld_en[wr_ptr]) & (~pld_en[wr_ptr_add_1]) ;
    assign wr_en = req_vld & req_rdy;

    //##############################################
    // memory
    //############################################## 

    generate for(genvar i=0; i<DEPTH; i=i+1) begin
        always_ff @(posedge clk or negedge rst_n) begin
            if(~rst_n)                                          pld_en[i] <= 1'b0;
            else if(clear)                                      pld_en[i] <= 1'b0;

            // read
            else if((rd_ptr==i) & rd_ch0_en)                    pld_en[i] <= 1'b0;
            else if((rd_ptr_add_1==i) & rd_ch0_en & rd_halfword_0_size)  pld_en[i] <= 1'b0;
            // full write
            else if(mis_align_mem_data) begin 
                if((wr_ptr==i) & wr_en)                         pld_en[i] <= 1'b1;
            end
            else begin
                if((wr_ptr==i) & wr_en)                         pld_en[i] <= 1'b1;
                else if((wr_ptr_add_1==i) & wr_en)              pld_en[i] <= 1'b1;
            end
        end

        always_ff @(posedge clk or negedge rst_n) begin
            if(~rst_n)                                          pld_mem[i] <= 0;
            else if(mis_align_mem_data) begin
                if((wr_ptr==i) & wr_en)                         pld_mem[i] <= req_pld[31:16];
            end
            else begin
                if((wr_ptr==i) & wr_en)                         pld_mem[i] <= req_pld[15:0];
                else if((wr_ptr_add_1==i) & wr_en)              pld_mem[i] <= req_pld[31:16];
            end
        end
    end endgenerate

    //##############################################
    // read ptr
    //##############################################

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)          rd_ptr <= 0;
        else if(clear)      rd_ptr <= 0;
        else if(rd_ch0_en)
            if(rd_halfword_0_size) rd_ptr <= rd_ptr + 2;
            else            rd_ptr <= rd_ptr + 1;
    end



    //##############################################
    // Output mux
    //##############################################

    logic [15:0]    rd_halfword_pld_0   ;
    logic [15:0]    rd_halfword_pld_1   ;
    logic           rd_halfword_en_0    ;
    logic           rd_halfword_en_1    ;

    //logic           rd_halfword_0_size  ;


    always_comb begin
        rd_halfword_pld_0 = pld_mem[rd_ptr]   ;
        rd_halfword_pld_1 = pld_mem[rd_ptr_add_1] ;        
    end

    always_comb begin
        rd_halfword_en_0  = pld_en[rd_ptr]    ;
        rd_halfword_en_1  = pld_en[rd_ptr_add_1]  ;
    end

    assign rd_ptr_add_1 = rd_ptr + 1;
    assign wr_ptr_add_1 = wr_ptr + 1;

    // check whether each halfword is the low 16 bit of a 32 bit inst.
    assign rd_halfword_0_size = (rd_halfword_pld_0[1:0] == 2'b11) ? 1'b1 : 1'b0; 



    always_comb begin
        if(rd_halfword_en_0)
            if(~rd_halfword_0_size)   ack_vld = 1'b1;// halfword 0 is 16 bit inst
            else if(rd_halfword_en_1) ack_vld = 1'b1;
            else                      ack_vld = 1'b0;
        else                          ack_vld = 1'b0;
    end

    assign ack_pld = {rd_halfword_pld_1, rd_halfword_pld_0};
    assign rd_ch0_en = ack_vld & ack_rdy;

endmodule