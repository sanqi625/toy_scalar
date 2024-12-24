

module toy_top 
    import toy_pack::*;
();

    logic                           clk                      ;
    logic                           rst_n                    ;

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

    logic                           jtag_clk                    ;
    logic                           jtag_rst_n                  ;
    logic                           jtag_tms                   ;
    logic                           jtag_tdi                   ;
    logic                           jtag_tdo                   ;
    logic                           dm_clk                      ;
    logic                           dm_rst_n                    ;

    //usrt port
    logic                           peri_uart_rx_i             ;
    logic                           peri_uart_tx_o             ;
    logic                           peri_uart_int              ;

    //gpio port
    logic [31:0]                    peri_gpio_in               ;
    logic [31:0]                    peri_gpio_out              ;
    logic [31:0]                    peri_gpio_dir              ;
    logic                           peri_gpio_int              ;

//============================================================
// Core
//============================================================

    toy_scalar u_toy_scalar (
        .clk                    (clk                    ),
        .rst_n                  (rst_n                  ),
     
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
        .ext_mem_rd_data        (ext_mem_rd_data        ),
        .ext_mem_wr_data        (ext_mem_wr_data        ),
        .ext_mem_wr_byte_en     (ext_mem_wr_byte_en     ),
        .ext_mem_wr_en          (ext_mem_wr_en          ),
        .ext_mem_en             (ext_mem_en             ),

        .intr_meip              (intr_meip              ),
        .intr_msip              (intr_msip              ),

        .intr_seip              (1'b0                   ),
        .intr_stip              (1'b0                   ),
        .intr_ssip              (1'b0                   ),
        
        .custom_instruction_vld (                       ),
        .custom_instruction_rdy (1'b1                   ),
        .custom_instruction_pld (                       ),
        .custom_rs1_val         (                       ),
        .custom_rs2_val         (                       ),
        .custom_pc              (                       ),
        
        .jtag_clk               (jtag_clk               ),
        .jtag_rst_n             (jtag_rst_n             ),
        .jtag_tms               (jtag_tms              ),
        .jtag_tdi               (jtag_tdi              ),
        .jtag_tdo               (jtag_tdo              ),
        .dm_clk                 (clk                 ),
        .dm_rst_n               (rst_n               ),

        .peri_uart_rx_i         (peri_uart_rx_i            ),
        .peri_uart_tx_o         (peri_uart_tx_o            ),
        .peri_uart_int          (peri_uart_int             ),
        .peri_gpio_in           (peri_gpio_in              ),
        .peri_gpio_out          (peri_gpio_out             ),
        .peri_gpio_dir          (peri_gpio_dir             ),
        .peri_gpio_int          (peri_gpio_int             )
        );

//============================================================
// Env Slave
//============================================================

    toy_env_slv #(
        .ADDR_WIDTH (ADDR_WIDTH         ),
        .DATA_WIDTH (BUS_DATA_WIDTH     ))
    u_toy_env_slv(
        .clk                    (clk                ),
        .rst_n                  (rst_n              ),
        
        .en                     (ext_mem_en      ),
        .addr                   (ext_mem_addr   ),
        .rd_data                (ext_mem_rd_data   ),
        .wr_data                (ext_mem_wr_data),
        .wr_byte_en             (ext_mem_wr_byte_en   ),
        .wr_en                  (ext_mem_wr_en        ),

        .intr_meip              (intr_meip),
        .intr_msip              (intr_msip),

        .jtag_clk               (jtag_clk           ),
        .jtag_rst_n             (jtag_rst_n         ),
        .jtag_tms               (jtag_tms          ),
        .jtag_tdi               (jtag_tdi          ),
        .jtag_tdo               (jtag_tdo          )
        );

//============================================================
// Memory
//============================================================

    toy_mem_model #(
        .ARGPARSE_KEY   ("HEX"                  ),
        .ADDR_WIDTH     (ADDR_WIDTH             ),
        .DATA_WIDTH     (BUS_DATA_WIDTH         ))
    u_inst_mem (
        .clk            (clk                    ),
        .en             (inst_mem_en            ),
        .addr           (inst_mem_addr          ),
        .rd_data        (inst_mem_rd_data       ),
        .wr_data        (inst_mem_wr_data       ),
        .wr_byte_en     (inst_mem_wr_byte_en    ),
        .wr_en          (inst_mem_wr_en         ));

    toy_mem_model #(
        .ARGPARSE_KEY   ("DATA_HEX"             ),
        .ADDR_WIDTH     (15             ),
        .DATA_WIDTH     (BUS_DATA_WIDTH         ))
    u_data_mem (
        .clk            (clk                    ),
        .en             (dtcm_mem_en            ),
        .addr           (dtcm_mem_addr          ),
        .rd_data        (dtcm_mem_rd_data       ),
        .wr_data        (dtcm_mem_wr_data       ),
        .wr_byte_en     (dtcm_mem_wr_byte_en    ),
        .wr_en          (dtcm_mem_wr_en         ));

    initial begin
        if($test$plusargs("WAVE")) begin
            $fsdbDumpfile("wave.fsdb");
            $fsdbDumpvars("+all");
            $fsdbDumpMDA;
            $fsdbDumpon;
        end
    end

//============================================================
// Clock count
//============================================================

localparam   CLK_CNT_MAX =100;

logic [3:0] gpio_out;
logic [31:0] clk_cnt;
logic one_sec;
logic [3:0] led;

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
        else if(one_sec)
            led[3:0] <= {led[2:0],led[3]};
    end
    
    assign gpio_out[3:0]    = led[3:0];

endmodule