

module toy_top_fpga
    import toy_pack::*;
(
    input logic         clk_in_p,
    input logic         clk_in_n,
    input logic         push_rst   ,

`ifdef FPGA_TEST
    input logic         test_clk,
    input logic         test_rst_n,
`endif 

    input logic         jtag_clk   ,
    //input logic         jtag_rst_n ,
    input logic         jtag_tms   ,
    input logic         jtag_tdi   ,
    output logic         jtag_tdo   ,

    input logic         intr_meip  ,

    //usrt port
    input  logic                        peri_uart_rx_i             ,
    output logic                        peri_uart_tx_o             ,
    //output logic                      peri_uart_int              ,

    //gpio port
    //input  logic [31:0]              peri_gpio_in               ,
    output logic [3:0]                 gpio_out              ,
    output logic                       led_host_en           
    //output logic                       led_trap_en           
    //output logic [31:0]              peri_gpio_dir              
);

    localparam CLK_CNT_MAX = 10000000;

    logic                           clk                      ;
    //logic                           rst_n                    ;

    logic [ADDR_WIDTH-1:0]          inst_mem_addr            ;
    logic [BUS_DATA_WIDTH-1:0]      inst_mem_rd_data         ;
    logic [BUS_DATA_WIDTH-1:0]      inst_mem_wr_data         ;
    logic [BUS_DATA_WIDTH/8-1:0]    inst_mem_wr_byte_en      ;
    logic                           inst_mem_wr_en           ;
    logic                           inst_mem_en              ;

    logic [ADDR_WIDTH-1:0]          dtcm_mem_addr            ;
    logic [BUS_DATA_WIDTH-1:0]      dtcm_mem_rd_data         ;
    logic [BUS_DATA_WIDTH-1:0]      dtcm_mem_wr_data         ;
    logic [BUS_DATA_WIDTH/8-1:0]    dtcm_mem_wr_byte_en      ;
    logic                           dtcm_mem_wr_en           ;
    logic                           dtcm_mem_en              ;

    logic [ADDR_WIDTH-1:0]          ext_mem_addr             ;
    logic [BUS_DATA_WIDTH-1:0]      ext_mem_rd_data          ;
    logic [BUS_DATA_WIDTH-1:0]      ext_mem_wr_data          ;
    logic [BUS_DATA_WIDTH/8-1:0]    ext_mem_wr_byte_en       ;
    logic                           ext_mem_wr_en            ;
    logic                           ext_mem_en               ;

    logic                           dm_clk                      ;
    logic                           dm_rst_n                    ;

    //usrt port
    //logic                           peri_uart_rx_i             ;
    //logic                           peri_uart_tx_o             ;
    //logic                           peri_uart_int              ;

    //gpio port
    logic [31:0]                    peri_gpio_in               ;
    logic [31:0]                    peri_gpio_out              ;
    logic [31:0]                    peri_gpio_dir              ;
    logic                           peri_gpio_int              ;

    logic                           rst_n;

    logic [31:0]                    clk_cnt;
    logic [3:0]                     led;
    logic                           led_end;

    logic                           async_rst_n;

    logic to_host_addr_match,to_host_data_match;
//============================================================
// Core
//============================================================

    //clock buffer
    logic jtag_clk_ibuf;
    logic jtag_clk_bufg;
    logic jtag_clk_gen;
    logic ila_clk;

    // 实例化 IBUF
    IBUF ibuf_inst (
        .I(jtag_clk),
        .O(jtag_clk_buf)
    );

    // 实例化 BUFG
    BUFG bufg_inst (
        .I(jtag_clk_buf),
        .O(jtag_clk_bufg)
    );

    assign jtag_clk_gen = jtag_clk_bufg;

    assign async_rst_n = ~push_rst;

    clk_src u_clk_src
    (
    // Clock out ports
    .clk_out1(clk),     // output clk_out1
    .ila_clk(ila_clk),     // output ila_clk
    // Clock in ports
    .clk_in1_p(clk_in_p),    // input clk_in1_p
    .clk_in1_n(clk_in_n)     // input clk_in1_n
    );    

    //reset
    async_reset_sync_release u_reset_syn_rel(
        .clk            (clk),
        .async_reset_n  (async_rst_n),
        .sync_reset_n   (rst_n)
    );

    toy_scalar u_toy_scalar (
`ifdef FPGA_SIM
        .ila_clk                (ila_clk                ),
`endif 
        .clk                    (clk                    ),  //TODO
        .rst_n                  (rst_n                  ),  //TODO
     
        .inst_mem_addr          (inst_mem_addr          ),
        .inst_mem_rd_data       (inst_mem_rd_data       ),
        .inst_mem_wr_data       (inst_mem_wr_data       ),
        .inst_mem_wr_byte_en    (inst_mem_wr_byte_en    ),
        .inst_mem_wr_en         (inst_mem_wr_en         ),
        .inst_mem_en            (inst_mem_en            ),

        .dtcm_mem_addr          (dtcm_mem_addr          ),
        .dtcm_mem_rd_data       (dtcm_mem_rd_data       ),
        .dtcm_mem_wr_data       (dtcm_mem_wr_data       ),
        .dtcm_mem_wr_byte_en    (dtcm_mem_wr_byte_en    ),
        .dtcm_mem_wr_en         (dtcm_mem_wr_en         ),
        .dtcm_mem_en            (dtcm_mem_en            ),

        .ext_mem_addr           (ext_mem_addr           ),
        .ext_mem_rd_data        (                       ),
        .ext_mem_wr_data        (ext_mem_wr_data        ),
        .ext_mem_wr_byte_en     (ext_mem_wr_byte_en     ),
        .ext_mem_wr_en          (ext_mem_wr_en          ),
        .ext_mem_en             (ext_mem_en             ),

        .intr_meip              (intr_meip              ),
        .intr_msip              (1'b0                   ),
        
        .custom_instruction_vld (                       ),
        .custom_instruction_rdy (1'b1                   ),
        .custom_instruction_pld (                       ),
        .custom_rs1_val         (                       ),
        .custom_rs2_val         (                       ),
        .custom_pc              (                       ),
        
        .jtag_clk               (jtag_clk_gen               ),
        .jtag_rst_n             (/*jtag_rst_n*/1'b1             ),
        .jtag_tms               (jtag_tms               ),
        .jtag_tdi               (jtag_tdi               ),
        .jtag_tdo               (jtag_tdo               ),
        .dm_clk                 (clk                    ),
        .dm_rst_n               (rst_n                  ),

        .peri_uart_rx_i         (peri_uart_rx_i            ),
        .peri_uart_tx_o         (peri_uart_tx_o            ),
        .peri_uart_int          (peri_uart_int             ),
        .peri_gpio_in           (peri_gpio_in              ),
        .peri_gpio_out          (peri_gpio_out             ),
        .peri_gpio_dir          (peri_gpio_dir             ),
        .peri_gpio_int          (peri_gpio_int             )
        );

    assign to_host_addr_match   = (ext_mem_addr==32'h0000_0000);
    assign to_host_data_match   = (ext_mem_wr_data[0] == 1'b1) ;
    assign led_end              = to_host_addr_match && ext_mem_wr_en && ext_mem_en && to_host_data_match;

    always_ff @( posedge clk or negedge rst_n ) begin
        if(~rst_n)
            led_host_en <= 1'b0;
        else if(led_end)
            led_host_en <= 1'b1;
    end
   
//============================================================
// Clock count
//============================================================

always_ff @( posedge clk or negedge rst_n ) begin
    if(~rst_n)
        clk_cnt <= 32'd0;
    else if(clk_cnt == CLK_CNT_MAX)
        clk_cnt <= 32'd0;
    else 
        clk_cnt <= clk_cnt + 32'd1;
end

assign one_sec = (clk_cnt == CLK_CNT_MAX);

always_ff @( posedge clk or negedge rst_n ) begin
    if(~rst_n)
        led[3:0] <= 4'b0001;
    else if(led_end)
        led[3:0] <= 4'b1111;
    else if(one_sec)
        led[3:0] <= {led[2:0],led[3]};
end

assign gpio_out[3:0]    = led[3:0];

//============================================================
// Memory
//============================================================

`ifdef BOOT_TEST

logic [BUS_DATA_WIDTH/8-1:0] dtcm_wea;

assign dtcm_wea[BUS_DATA_WIDTH/8-1:0] = dtcm_mem_wr_byte_en[BUS_DATA_WIDTH/8-1:0] & {4{dtcm_mem_wr_en}} ;

boot_itcm u_boot_itcm (
    .clka         (clk),    // input wire clka  //TODO
    //.rsta         (rst_n),            // input wire rsta
    .ena          (inst_mem_en),      // input wire ena
    .wea          (inst_mem_wr_en),      // input wire [3 : 0] wea
    .addra        (inst_mem_addr),  // input wire [13 : 0] addra
    .dina         (inst_mem_wr_data),    // input wire [31 : 0] dina
    .douta        (inst_mem_rd_data)  // output wire [31 : 0] douta
    //.rsta_busy    ()  // output wire rsta_busy
);

boot_dtcm u_boot_dtcm (
    .clka         (clk),    // input wire clka  //TODO
    .ena          (dtcm_mem_en),      // input wire ena
    .wea          (dtcm_wea),      // input wire [3 : 0] wea
    .addra        (dtcm_mem_addr),  // input wire [14 : 0] addra
    .dina         (dtcm_mem_wr_data),    // input wire [31 : 0] dina
    .douta        (dtcm_mem_rd_data)  // output wire [31 : 0] douta
);  

`else

mem_model u_inst_mem (
  .clka         (clk),    // input wire clka
  .ena          (inst_mem_en),      // input wire ena
  .wea          (inst_mem_wr_en),      // input wire [3 : 0] wea
  .addra        (inst_mem_addr),  // input wire [13 : 0] addra
  .dina         (inst_mem_wr_data),    // input wire [31 : 0] dina
  .douta        (inst_mem_rd_data)  // output wire [31 : 0] douta
);

mem_model u_data_mem (
  .clka         (clk),    // input wire clka
  .ena          (dtcm_mem_en),      // input wire ena
  .wea          (dtcm_mem_wr_en),      // input wire [3 : 0] wea
  .addra        (dtcm_mem_addr),  // input wire [13 : 0] addra
  .dina         (dtcm_mem_wr_data),    // input wire [31 : 0] dina
  .douta        (dtcm_mem_rd_data)  // output wire [31 : 0] douta
);

`endif 

//`ifdef FPGA_SIM
//
//jtag_ila u_jtag_ila (
//	.clk(ila_clk), // input wire clk
//
//	.probe0(jtag_clk_gen), // input wire [0:0]  probe0  
//	.probe1(jtag_tdi_buf), // input wire [0:0]  probe1 
//	.probe2(jtag_tdo_buf), // input wire [0:0]  probe2 
//	.probe3(jtag_tms_buf), // input wire [0:0]  probe3 
//	.probe4(intr_meip) // input wire [0:0]  probe4
//);
//`endif

`ifdef FPGA_SIM

top_ila u_top_ila (
	.clk(ila_clk), // input wire clk

	.probe0(rst_n       ), // input wire [0:0]  probe0  
	.probe1(led[3:0]    ), // input wire [0:0]  probe1 
	.probe2(led_host_en ), // input wire [0:0]  probe2 
	.probe3(intr_meip   ), // input wire [0:0]  probe3 
    .probe4(ext_mem_addr[ADDR_WIDTH-1:0]),
    .probe5(ext_mem_wr_data[BUS_DATA_WIDTH-1:0]),
    .probe6(ext_mem_wr_en),
    .probe7(ext_mem_en),
    .probe8(peri_uart_rx_i),
    .probe9(peri_uart_tx_o)
);

tcm_ila u_tcm_ila (
	.clk(ila_clk), // input wire clk

	.probe0(inst_mem_en), // input wire [0:0]  probe0  
	.probe1(inst_mem_wr_en), // input wire [0:0]  probe1 
	.probe2(inst_mem_addr), // input wire [13:0]  probe2 
	.probe3(inst_mem_wr_data), // input wire [31:0]  probe3 
	.probe4(inst_mem_rd_data), // input wire [31:0]  probe4 
	.probe5(dtcm_mem_en), // input wire [0:0]  probe5 
	.probe6(dtcm_mem_wr_en), // input wire [0:0]  probe6 
	.probe7(dtcm_mem_addr), // input wire [14:0]  probe7 
	.probe8(dtcm_mem_wr_data), // input wire [31:0]  probe8 
	.probe9(dtcm_mem_rd_data) // input wire [31:0]  probe9
);

`endif

//============================================================
// Trap LED
//============================================================


endmodule