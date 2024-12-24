

module toy_scalar
    import toy_pack::*;
(

`ifdef FPGA_SIM
    input  logic                        ila_clk    ,
`endif 
    input  logic                        clk                       ,
    input  logic                        rst_n                     ,

    output logic [ADDR_WIDTH-1:0]       inst_mem_addr             ,
    input  logic [INST_WIDTH-1:0]       inst_mem_rd_data          ,
    output logic [BUS_DATA_WIDTH-1:0]   inst_mem_wr_data          ,
    output logic [BUS_DATA_WIDTH/8-1:0] inst_mem_wr_byte_en       ,
    output logic                        inst_mem_wr_en            ,
    output logic                        inst_mem_en               ,

    output logic [ADDR_WIDTH-1:0]       dtcm_mem_addr             ,
    output logic [BUS_DATA_WIDTH-1:0]   dtcm_mem_wr_data          ,
    input  logic [BUS_DATA_WIDTH-1:0]   dtcm_mem_rd_data          ,
    output logic [BUS_DATA_WIDTH/8-1:0] dtcm_mem_wr_byte_en       ,
    output logic                        dtcm_mem_wr_en            ,
    output logic                        dtcm_mem_en               ,

    output logic [ADDR_WIDTH-1:0]       ext_mem_addr              ,
    input  logic [BUS_DATA_WIDTH-1:0]   ext_mem_rd_data           ,
    output logic [BUS_DATA_WIDTH-1:0]   ext_mem_wr_data           ,
    output logic [BUS_DATA_WIDTH/8-1:0] ext_mem_wr_byte_en        ,
    output logic                        ext_mem_wr_en             ,
    output logic                        ext_mem_en                ,

    output logic                        custom_instruction_vld    ,
    input  logic                        custom_instruction_rdy    ,
    output logic [INST_WIDTH-1:0]       custom_instruction_pld    ,
    output logic [REG_WIDTH-1:0]        custom_rs1_val            ,
    output logic [REG_WIDTH-1:0]        custom_rs2_val            ,
    output logic [ADDR_WIDTH-1:0]       custom_pc                 ,

    input  logic                        intr_meip                 ,
    input  logic                        intr_msip                 ,

    input  logic                        intr_seip                 ,
    input  logic                        intr_stip                 ,
    input  logic                        intr_ssip                 ,

    input  logic                        jtag_clk                  ,
    input  logic                        jtag_rst_n                ,
    input  logic                        jtag_tms                  ,
    input  logic                        jtag_tdi                  ,
    output logic                        jtag_tdo                  ,
    input  logic                        dm_clk                    ,
    input  logic                        dm_rst_n                  ,

    //usrt port
    input  logic                        peri_uart_rx_i             ,
    output logic                        peri_uart_tx_o             ,
    output logic                        peri_uart_int              ,

    //gpio port
    input  logic [31:0]                 peri_gpio_in               ,
    output logic [31:0]                 peri_gpio_out              ,
    output logic [31:0]                 peri_gpio_dir              ,
    output logic                        peri_gpio_int               
);

    logic                       debug_halt_req          ;
    logic                       debug_halt_ack          ;

    logic                       fetch_mem_ack_vld       ;
    logic                       fetch_mem_ack_rdy       ;
    logic [INST_WIDTH-1:0]      fetch_mem_ack_data      ;
    logic [ADDR_WIDTH-1:0]      fetch_mem_req_addr      ;
    logic                       fetch_mem_req_vld       ;
    logic                       fetch_mem_req_rdy       ;

    logic                       lsu_mem_req_vld         ;
    logic                       lsu_mem_req_rdy         ;
    logic [ADDR_WIDTH-1:0]      lsu_mem_req_addr        ;
    logic [DATA_WIDTH-1:0]      lsu_mem_req_data        ;
    logic [DATA_WIDTH/8-1:0]    lsu_mem_req_strb        ;
    logic                       lsu_mem_req_opcode      ;
    logic                       lsu_mem_ack_vld         ;
    logic                       lsu_mem_ack_rdy         ;
    logic [DATA_WIDTH-1:0]      lsu_mem_ack_data        ;

    logic                       debug_req_vld           ;
	logic                       debug_req_rdy           ;
	logic [ADDR_WIDTH-1:0]      debug_req_addr          ;
	logic [DATA_WIDTH-1:0]      debug_req_data          ;
	logic [DATA_WIDTH/8-1:0]    debug_req_strb          ;
	logic                       debug_req_opcode        ;
	logic                       debug_ack_vld           ;
	logic                       debug_ack_rdy           ;
	logic [DATA_WIDTH-1:0]      debug_ack_data          ;

    logic                       sel_debug_inst;
    logic                       debug_inst_req_vld;
    logic                       debug_inst_req_rdy;
    logic                       debug_inst_ack_vld;
    logic                       debug_inst_ack_rdy;
    logic [DATA_WIDTH-1:0]      debug_inst_ack_data;

    logic                       sel_debug_lsu;
    logic                       debug_lsu_req_vld;
    logic                       debug_lsu_req_rdy;
    logic                       debug_lsu_ack_vld;
    logic                       debug_lsu_ack_rdy;
    logic [DATA_WIDTH-1:0]      debug_lsu_ack_data;

    logic [ADDR_WIDTH-1:0]      debug_req_addr_comb;

    logic                       debug_sysbus_req_vld;
    logic                       debug_sysbus_req_rdy;
    logic [31:0]                debug_sysbus_req_addr;
    logic [31:0]                debug_sysbus_req_data;
    logic [3:0]                 debug_sysbus_req_strb;
    logic                       debug_sysbus_req_opcode;

    logic                       debug_sysbus_ack_vld;
    logic                       debug_sysbus_ack_rdy;
    logic [31:0]                debug_sysbus_ack_data;

    logic                       peripheral_out0_req_vld    ;
	logic                       peripheral_out0_req_rdy    ;
	logic [31:0]                peripheral_out0_req_addr   ;
	logic [31:0]                peripheral_out0_req_data   ;
	logic [3:0]                 peripheral_out0_req_strb   ;
	logic                       peripheral_out0_req_opcode ;
	logic                       peripheral_out0_ack_vld    ;
	logic                       peripheral_out0_ack_rdy    ;
	logic [31:0]                peripheral_out0_ack_data   ;

    logic                       hart_rst_n;
    logic                       hart_rst_n_1d;

    logic                       sys_rst_n;
    logic                       dm2hart_rst_n;  //reset specifed core
    logic                       hart_havereset;  //reset ack
//=================================================================
// Core
//=================================================================

    toy_core u_core(
`ifdef FPGA_SIM
        .ila_clk                (ila_clk                ),
`endif 
        .clk                    (clk                    ),
        .rst_n                  (rst_n && hart_rst_n    ),

        .fetch_mem_ack_vld      (fetch_mem_ack_vld      ),
        .fetch_mem_ack_rdy      (fetch_mem_ack_rdy      ),
        .fetch_mem_ack_data     (fetch_mem_ack_data     ),
        .fetch_mem_req_addr     (fetch_mem_req_addr     ),
        .fetch_mem_req_vld      (fetch_mem_req_vld      ),
        .fetch_mem_req_rdy      (fetch_mem_req_rdy      ),

        .lsu_mem_req_vld        (lsu_mem_req_vld        ),
        .lsu_mem_req_rdy        (lsu_mem_req_rdy        ),
        .lsu_mem_req_addr       (lsu_mem_req_addr       ),
        .lsu_mem_req_data       (lsu_mem_req_data       ),
        .lsu_mem_req_strb       (lsu_mem_req_strb       ),
        .lsu_mem_req_opcode     (lsu_mem_req_opcode     ),
        .lsu_mem_ack_vld        (lsu_mem_ack_vld        ),
        .lsu_mem_ack_rdy        (lsu_mem_ack_rdy        ),
        .lsu_mem_ack_data       (lsu_mem_ack_data       ),

        .custom_instruction_vld (custom_instruction_vld ),
        .custom_instruction_rdy (custom_instruction_rdy ),
        .custom_instruction_pld (custom_instruction_pld ),
        .custom_rs1_val         (custom_rs1_val         ),
        .custom_rs2_val         (custom_rs2_val         ),
        .custom_pc              (custom_pc              ),

        .intr_meip              (intr_meip              ),
        .intr_msip              (intr_msip              ),
        .intr_seip              (intr_seip              ),
        .intr_stip              (intr_stip              ),
        .intr_ssip              (intr_ssip              ),
        .debug_halt_req         (debug_halt_req         )
        //.debug_halt_ack         (debug_halt_ack         )
    );

//=================================================================
// Bus
//=================================================================

    toy_bus_DWrap_network_toy_bus u_bus (
        .clk                        (clk                        ),
        .rst_n                      (rst_n && hart_rst_n        ),

	    .fetch_in0_req_vld          (fetch_mem_req_vld          ),
	    .fetch_in0_req_rdy          (fetch_mem_req_rdy          ),
	    .fetch_in0_req_addr         (fetch_mem_req_addr         ),
	    .fetch_in0_req_data         ({BUS_DATA_WIDTH{1'b0}}     ),
	    .fetch_in0_req_strb         ({(BUS_DATA_WIDTH/8){1'b0}} ),
	    .fetch_in0_req_opcode       (TOY_BUS_READ               ),
	    .fetch_in0_ack_vld          (fetch_mem_ack_vld          ),
	    .fetch_in0_ack_rdy          (fetch_mem_ack_rdy          ),
	    .fetch_in0_ack_data         (fetch_mem_ack_data         ),

        .lsu_in0_req_vld            (lsu_mem_req_vld            ),
        .lsu_in0_req_rdy            (lsu_mem_req_rdy            ),
        .lsu_in0_req_addr           (lsu_mem_req_addr           ),
        .lsu_in0_req_data           (lsu_mem_req_data           ),
        .lsu_in0_req_strb           (lsu_mem_req_strb           ),
        .lsu_in0_req_opcode         (lsu_mem_req_opcode         ),
        .lsu_in0_ack_vld            (lsu_mem_ack_vld            ),
        .lsu_in0_ack_rdy            (lsu_mem_ack_rdy            ),
        .lsu_in0_ack_data           (lsu_mem_ack_data           ),

        .debug_sysbus_in0_req_vld   (debug_sysbus_req_vld       ),
        .debug_sysbus_in0_req_rdy   (debug_sysbus_req_rdy       ),
        .debug_sysbus_in0_req_addr  (debug_sysbus_req_addr      ),
        .debug_sysbus_in0_req_data  (debug_sysbus_req_data      ),
        .debug_sysbus_in0_req_strb  (debug_sysbus_req_strb      ),
        .debug_sysbus_in0_req_opcode(debug_sysbus_req_opcode    ),
        .debug_sysbus_in0_ack_vld   (debug_sysbus_ack_vld       ),
        .debug_sysbus_in0_ack_rdy   (debug_sysbus_ack_rdy       ),
        .debug_sysbus_in0_ack_data  (debug_sysbus_ack_data      ),

	    .itcm_out0_mem_en           (inst_mem_en                ),
	    .itcm_out0_mem_addr         (inst_mem_addr              ),
	    .itcm_out0_mem_rd_data      (inst_mem_rd_data           ),
	    .itcm_out0_mem_wr_data      (inst_mem_wr_data           ),
	    .itcm_out0_mem_wr_byte_en   (inst_mem_wr_byte_en        ),
	    .itcm_out0_mem_wr_en        (inst_mem_wr_en             ),

	    .dtcm_out0_mem_en           (dtcm_mem_en                ),
	    .dtcm_out0_mem_addr         (dtcm_mem_addr              ),
	    .dtcm_out0_mem_rd_data      (dtcm_mem_rd_data           ),
	    .dtcm_out0_mem_wr_data      (dtcm_mem_wr_data           ),
	    .dtcm_out0_mem_wr_byte_en   (dtcm_mem_wr_byte_en        ),
	    .dtcm_out0_mem_wr_en        (dtcm_mem_wr_en             ),

	    .eslv_out0_mem_en           (ext_mem_en                 ),
	    .eslv_out0_mem_addr         (ext_mem_addr               ),
	    .eslv_out0_mem_rd_data      (ext_mem_rd_data            ),
	    .eslv_out0_mem_wr_data      (ext_mem_wr_data            ),
	    .eslv_out0_mem_wr_byte_en   (ext_mem_wr_byte_en         ),
	    .eslv_out0_mem_wr_en        (ext_mem_wr_en              ),

        .debug_out0_req_vld         (debug_req_vld              ),
	    .debug_out0_req_rdy         (debug_req_rdy              ),
	    .debug_out0_req_addr        (debug_req_addr             ),
	    .debug_out0_req_data        (debug_req_data             ),
	    .debug_out0_req_strb        (debug_req_strb             ),
	    .debug_out0_req_opcode      (debug_req_opcode           ),
	    .debug_out0_ack_vld         (debug_ack_vld              ),
	    .debug_out0_ack_rdy         (debug_ack_rdy              ),
	    .debug_out0_ack_data        (debug_ack_data             ),

        .peripheral_out0_req_vld    (peripheral_out0_req_vld    ),
        .peripheral_out0_req_rdy    (peripheral_out0_req_rdy    ),
        .peripheral_out0_req_addr   (peripheral_out0_req_addr   ),
        .peripheral_out0_req_data   (peripheral_out0_req_data   ),
        .peripheral_out0_req_strb   (peripheral_out0_req_strb   ),
        .peripheral_out0_req_opcode (peripheral_out0_req_opcode ),
        .peripheral_out0_ack_vld    (peripheral_out0_ack_vld    ),
        .peripheral_out0_ack_rdy    (peripheral_out0_ack_rdy    ),
        .peripheral_out0_ack_data   (peripheral_out0_ack_data   )
        );

    assign debug_req_addr_comb[ADDR_WIDTH-1:0] = {debug_req_addr[31:16],debug_req_addr[15:12],2'b0,debug_req_addr[11:2]};

//=================================================================
// Reset
//=================================================================

assign hart_rst_n = sys_rst_n && dm2hart_rst_n;

always_ff @(posedge clk ) begin
    hart_rst_n_1d <= hart_rst_n;
end

assign hart_havereset = ~hart_rst_n && hart_rst_n_1d;

//=================================================================
// Debug
//=================================================================
    debug_sys u_debug_sys(
        .jclk                           (jtag_clk              ),
        .jrst_n                         (jtag_rst_n            ),
        .tms                            (jtag_tms              ),
        .tdi                            (jtag_tdi              ),
        .tdo                            (jtag_tdo              ),

        .dm_clk                         (dm_clk                 ),
        .dm_rst_n                       (dm_rst_n               ),
        // DM interface connect to hart
        .debug_halt_int                 (debug_halt_req         ),
        .sys_rst_n                      (sys_rst_n              ),
        .dm2hart_rst_n                  (dm2hart_rst_n          ),  //reset specifed core
        .hart_havereset                 (hart_havereset         ),  //reset ack

        .debug_inst_req_vld             (debug_inst_req_vld     ),
        .debug_inst_req_rdy             (debug_inst_req_rdy     ),
        .debug_inst_req_addr            (debug_req_addr_comb[31:0]),  //select debug rom/debug ram
        .debug_inst_req_data            (debug_req_data         ),
        .debug_inst_req_strb            (debug_req_strb         ),
        .debug_inst_req_opcode          (debug_req_opcode       ),
        .debug_inst_ack_vld             (debug_inst_ack_vld     ),
        .debug_inst_ack_rdy             (debug_inst_ack_rdy     ),
        .debug_inst_ack_data            (debug_inst_ack_data    ),

        .debug_lsu_req_vld              (debug_lsu_req_vld      ),
        .debug_lsu_req_rdy              (debug_lsu_req_rdy      ),
        .debug_lsu_req_addr             (debug_req_addr[31:0]   ),  //state reg addr don't cut low 2 bits
        .debug_lsu_req_data             (debug_req_data         ),
        .debug_lsu_req_strb             (debug_req_strb         ),
        .debug_lsu_req_opcode           (debug_req_opcode       ),
        .debug_lsu_ack_vld              (debug_lsu_ack_vld      ),
        .debug_lsu_ack_rdy              (debug_lsu_ack_rdy      ),
        .debug_lsu_ack_data             (debug_lsu_ack_data     ),

        .debug_sysbus_req_vld           (debug_sysbus_req_vld   ),
        .debug_sysbus_req_rdy           (debug_sysbus_req_rdy   ),
        .debug_sysbus_req_addr          (debug_sysbus_req_addr  ),
        .debug_sysbus_req_data          (debug_sysbus_req_data  ),
        .debug_sysbus_req_strb          (debug_sysbus_req_strb  ),
        .debug_sysbus_req_opcode        (debug_sysbus_req_opcode),
        .debug_sysbus_ack_vld           (debug_sysbus_ack_vld   ),
        .debug_sysbus_ack_rdy           (debug_sysbus_ack_rdy   ),
        .debug_sysbus_ack_data          (debug_sysbus_ack_data  )
    );

assign sel_debug_inst       = (debug_req_addr_comb[31:16] == DEBUG_INST_ROM_BASE) || (debug_req_addr_comb[31:16] == DEBUG_INST_RAM_BASE);
assign sel_debug_lsu        = debug_req_addr_comb[31:16] == DEBUG_DATA_LSU_BASE;

assign debug_inst_req_vld   = debug_req_vld && sel_debug_inst;
assign debug_lsu_req_vld    = debug_req_vld && sel_debug_lsu;
assign debug_req_rdy        = debug_inst_req_rdy || debug_lsu_req_rdy;

assign debug_ack_vld        = debug_inst_ack_vld || debug_lsu_ack_vld;
assign debug_ack_data       = ({(DATA_WIDTH){debug_inst_ack_vld}} & debug_inst_ack_data) |
                                ({(DATA_WIDTH){debug_lsu_ack_vld}} & debug_lsu_ack_data);

assign debug_inst_ack_rdy   = debug_ack_rdy;
assign debug_lsu_ack_rdy    = debug_ack_rdy;

//=================================================================
// peripheral sys
//=================================================================

perips_sys u_perips_sys
(
`ifdef FPGA_SIM
        .ila_clk                (ila_clk                ),
        .fetch_mem_req_addr     (fetch_mem_req_addr     ),
        .fetch_mem_req_vld      (fetch_mem_req_vld      ),
`endif 
    .clk                        (clk                       ),
    .rst_n                      (rst_n                     ),
    .peripheral_out0_req_vld    (peripheral_out0_req_vld   ),
	.peripheral_out0_req_rdy    (peripheral_out0_req_rdy   ),
	.peripheral_out0_req_addr   (peripheral_out0_req_addr  ),
	.peripheral_out0_req_data   (peripheral_out0_req_data  ),
	.peripheral_out0_req_strb   (peripheral_out0_req_strb  ),
	.peripheral_out0_req_opcode (peripheral_out0_req_opcode),
	.peripheral_out0_ack_vld    (peripheral_out0_ack_vld   ),
	.peripheral_out0_ack_rdy    (peripheral_out0_ack_rdy   ),
	.peripheral_out0_ack_data   (peripheral_out0_ack_data  ),
    .peri_uart_rx_i             (peri_uart_rx_i            ),
    .peri_uart_tx_o             (peri_uart_tx_o            ),
    .peri_uart_int              (peri_uart_int             ),
    .peri_gpio_in               (peri_gpio_in              ),
    .peri_gpio_out              (peri_gpio_out             ),
    .peri_gpio_dir              (peri_gpio_dir             ),
    .peri_gpio_int              (peri_gpio_int             )
);


`ifndef FPGA_SIM
    int cycle;
    logic [ADDR_WIDTH-1:0] pc;

    assign pc = u_toy_scalar.u_core.u_fetch.pc;

    initial begin
        cycle = 0;
        forever begin
            @(posedge clk)
            cycle = cycle + 1;
        end
    end

    logic ram_rd_en ;
    logic ram_ack_en;
    assign ram_rd_en = debug_inst_req_vld && debug_req_rdy;
    assign ram_ack_en = debug_ack_vld && debug_ack_rdy;
`endif 

//`ifdef TOY_SIM
//    initial begin
//        forever begin
//    
//            @(posedge clk)
//            if(ram_rd_en) begin
//                    $display("[TOP: DEBUG ROM REQ] Access debug rom!!!");
//                    $display("[TOP: DEBUG ROM REQ] mem req addr=[%h], mem req addr comb=[%h], req_op=[%d]",debug_req_addr,debug_req_addr_comb,debug_req_opcode);
//            end
//    
//            if(ram_ack_en) begin
//                    $display("[TOP: DEBUG ROM ACK] debug rom inst is [%h] ",debug_ack_data);
//            end
//    
//        end
//    end
//
//`endif
//

//    initial begin
//        forever begin
//
//            @(posedge clk)
//            if(lsu_mem_req_vld) begin
//                //if(wr_en) begin
//                    //if($test$plusargs("DEBUG"))
//                    if(lsu_mem_req_addr[ADDR_WIDTH-1 -: 4] == 4'hc) begin
//                        $display("[Recevive Exter Mem Req][cycle=%d][pc=%h] Receive a cmd from core, cmd[%h] = %h", cycle, pc, lsu_mem_req_addr, lsu_mem_req_data);
//                        //$display("[SYSTEM][cycle=%d][pc=%h] Receive exit command %h, exit.", cycle, pc, wr_data);
//                    end
//                //end
//            end
//
//        end
//    end

endmodule