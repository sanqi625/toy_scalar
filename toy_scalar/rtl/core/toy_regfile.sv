
module toy_regfile 
    import toy_pack::*;
(
    input  logic                        clk              ,
    input  logic                        rst_n            ,

    `ifdef FPGA_SIM
    input logic                       ila_clk,
    input  logic                      fetched_instruction_vld     ,
    input  logic [INST_WIDTH-1:0]     fetched_instruction_pld     , 
    input  logic [ADDR_WIDTH-1:0]     fetched_instruction_pc      ,

    `endif

    // input channel ==================================================
    input  logic [31:0]                 wr_ch0_en_bitmap ,
    input  logic [31:0]                 wr_ch1_en_bitmap ,
    input  logic [31:0]                 wr_ch2_en_bitmap ,
    input  logic [31:0]                 wr_ch3_en_bitmap ,
    input  logic [REG_WIDTH-1:0]        wr_ch0_data      ,
    input  logic [REG_WIDTH-1:0]        wr_ch1_data      ,
    input  logic [REG_WIDTH-1:0]        wr_ch2_data      ,
    input  logic [REG_WIDTH-1:0]        wr_ch3_data      ,

    // output channel =================================================
    input  logic [4:0]                  rd_ch0_index     ,
    input  logic [4:0]                  rd_ch1_index     ,
    input  logic [4:0]                  rd_ch2_index     ,
    input  logic [4:0]                  rd_ch3_index     ,
    input  logic [4:0]                  rd_ch4_index     ,
    input  logic [4:0]                  rd_ch5_index     ,
    input  logic [4:0]                  rd_ch6_index     ,
    input  logic [4:0]                  rd_ch7_index     ,
    output logic [REG_WIDTH-1:0]        rd_ch0_data      ,
    output logic [REG_WIDTH-1:0]        rd_ch1_data      ,
    output logic [REG_WIDTH-1:0]        rd_ch2_data      ,
    output logic [REG_WIDTH-1:0]        rd_ch3_data      ,
    output logic [REG_WIDTH-1:0]        rd_ch4_data      ,
    output logic [REG_WIDTH-1:0]        rd_ch5_data      ,
    output logic [REG_WIDTH-1:0]        rd_ch6_data      ,
    output logic [REG_WIDTH-1:0]        rd_ch7_data      

);

    logic [REG_WIDTH-1:0] registers         [0:31]  ;
    logic [31:0]          registers_wren            ;
    logic [REG_WIDTH-1:0] registers_wrdata  [0:31]  ;

    // register define =========================================

    generate for(genvar i=0;i<32;i=i+1) begin

        if(i==0) begin
            assign registers[i] = 32'b0;
        end else begin
            always_ff @(posedge clk or negedge rst_n) begin
                if(~rst_n) begin
                    registers[i] <= 32'b0;
                end
                else if(registers_wren[i]) begin 
                    registers[i] <= registers_wrdata[i];
                end
            end
        end
    end endgenerate


    // input decode ============================================

    generate for(genvar i=0;i<32;i=i+1) begin
        if(i==0) begin
            assign registers_wren[i]    = 1'b0  ;
            assign registers_wrdata[i]  = 32'b0 ;
        end else begin
            assign registers_wren[i]    =   wr_ch0_en_bitmap[i] |
                                            wr_ch1_en_bitmap[i] |
                                            wr_ch2_en_bitmap[i] |
                                            wr_ch3_en_bitmap[i] ;

            assign registers_wrdata[i]  =   wr_ch0_en_bitmap[i] ? wr_ch0_data :
                                            wr_ch1_en_bitmap[i] ? wr_ch1_data :
                                            wr_ch2_en_bitmap[i] ? wr_ch2_data :
                                            wr_ch3_en_bitmap[i] ? wr_ch3_data :
                                                                  registers[i] ;
        end


    end endgenerate


    // output mux ==============================================
    assign rd_ch0_data = registers[rd_ch0_index];
    assign rd_ch1_data = registers[rd_ch1_index];
    assign rd_ch2_data = registers[rd_ch2_index];
    assign rd_ch3_data = registers[rd_ch3_index];
    assign rd_ch4_data = registers[rd_ch4_index];
    assign rd_ch5_data = registers[rd_ch5_index];
    assign rd_ch6_data = registers[rd_ch6_index];
    assign rd_ch7_data = registers[rd_ch7_index];

    //`ifdef FPGA_SIM
    //gpr_ila u_gpr_ila (
    //    .clk(ila_clk), // input wire clk
    //
    //    .probe0(registers[1]), // input wire [31:0]  probe0  
    //    .probe1(registers[2]), // input wire [31:0]  probe1 
    //    .probe2(registers[3]), // input wire [31:0]  probe2 
    //    .probe3(registers[4]), // input wire [31:0]  probe3 
    //    .probe4(registers[5]), // input wire [31:0]  probe4 
    //    .probe5(registers[6]), // input wire [31:0]  probe5 
    //    .probe6(registers[7]), // input wire [31:0]  probe6 
    //    .probe7(registers[8]), // input wire [31:0]  probe7 
    //    .probe8(registers[9]), // input wire [31:0]  probe8 
    //    .probe9(registers[10]), // input wire [31:0]  probe9 
    //    .probe10(registers[11]), // input wire [31:0]  probe10 
    //    .probe11(registers[12]), // input wire [31:0]  probe11 
    //    .probe12(registers[13]), // input wire [31:0]  probe12 
    //    .probe13(registers[14]), // input wire [31:0]  probe13 
    //    .probe14(registers[15]), // input wire [31:0]  probe14 
    //    .probe15(registers[16]), // input wire [31:0]  probe15 
    //    .probe16(registers[17]), // input wire [31:0]  probe16 
    //    .probe17(fetched_instruction_vld),
    //    .probe18(fetched_instruction_pld),
    //    .probe19(fetched_instruction_pc )
    //);
    //
    //`endif


endmodule





    //logic [31:0]            reg_wren_bitmap ;
    //logic [REG_WIDTH-1:0]   reg_wr_data     ;
//
    //always_comb begin
    //    reg_wren_bitmap = 32'b0;
    //    for(int wr_idx=0;i<WRITE_CH_NUM;i=i+1) begin
    //        reg_wren_bitmap = reg_wren_bitmap | (reg_wr_bitmap[wr_idx] & {32{reg_wr_en[wr_idx]}});
    //    end
    //end
