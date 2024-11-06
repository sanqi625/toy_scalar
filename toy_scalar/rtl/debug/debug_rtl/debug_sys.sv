module debug_sys 
import debug_pack::*;
(
    input  logic                    jclk,
    input  logic                    jrst_n,
    input  logic                    tms,
    input  logic                    tdi,
    output logic                    tdo,

    input  logic                    dm_clk,
    input  logic                    dm_rst_n,
    // DM interface connect to hart
    output  logic                   debug_halt_int,

    output  logic                   sys_rst_n,
    output  logic                   dm2hart_rst_n,  //reset specifed core
    input   logic                   hart_havereset,  //reset ack

    input   logic                   debug_inst_req_vld,
    output  logic                   debug_inst_req_rdy,
    input   logic [31:0]            debug_inst_req_addr,
    input   logic [31:0]            debug_inst_req_data,
    input   logic [3:0]             debug_inst_req_strb,
    input   logic                   debug_inst_req_opcode,
    output  logic                   debug_inst_ack_vld,
    input   logic                   debug_inst_ack_rdy,
    output  logic [31:0]            debug_inst_ack_data,

    input   logic                   debug_lsu_req_vld,
    output  logic                   debug_lsu_req_rdy,
    input   logic [31:0]            debug_lsu_req_addr,
    input   logic [31:0]            debug_lsu_req_data,
    input   logic [3:0]             debug_lsu_req_strb,
    input   logic                   debug_lsu_req_opcode,
    output  logic                   debug_lsu_ack_vld,
    input   logic                   debug_lsu_ack_rdy,
    output  logic [31:0]            debug_lsu_ack_data,

    output  logic                   debug_sysbus_req_vld,
    input   logic                   debug_sysbus_req_rdy,
    output  logic [31:0]            debug_sysbus_req_addr,
    output  logic [31:0]            debug_sysbus_req_data,
    output  logic [3:0]             debug_sysbus_req_strb,
    output  logic                   debug_sysbus_req_opcode,
    input   logic                   debug_sysbus_ack_vld,
    output  logic                   debug_sysbus_ack_rdy,
    input   logic [31:0]            debug_sysbus_ack_data
);

    logic [DMI_WIDTH -1:0] update_data;
    logic                  update_vld;
    logic                  update_rdy;
    logic [DMI_WIDTH -1:0] capture_data;    
    logic [IR_REG_WIRTH-1:0]capture_addr;

    logic                  dmi_req_vld;
    logic                  dmi_req_rdy;
    logic [DMI_ADDR-1:0]   dmi_req_addr;
    logic [DMI_DATA-1:0]   dmi_req_data;
    logic [1:0]            dmi_req_op;

    logic                  dmi_req_vld_async;
    logic                  dmi_req_rdy_async;
    logic [DMI_ADDR-1:0]   dmi_req_addr_async;
    logic [DMI_DATA-1:0]   dmi_req_data_async;
    logic [1:0]            dmi_req_op_async;

    logic                  dmi_rsp_vld;
    logic                  dmi_rsp_rdy;
    logic [DMI_DATA-1:0]   dmi_rsp_data;
    logic [1:0]            dmi_rsp_op;

    logic                  dmi_rsp_vld_async;
    logic                  dmi_rsp_rdy_async;
    logic [DMI_DATA-1:0]   dmi_rsp_data_async;
    logic [1:0]            dmi_rsp_op_async;

    dtm_jtag u_dtm_jtag(
        .tclk                   (jclk   ),
        .trst_n                 (jrst_n ),
        .tms                    (tms         ),
        .tdi                    (tdi         ),
        .tdo                    (tdo         ),
        .tdo_en                 (      ),
        .wr_data                (update_data ),
        .wr_en                  (update_vld  ),
        .wr_rdy                 (update_rdy  ),
        .rd_data                (capture_data),
        .rd_addr                (capture_addr)
    );

    dtm_reg_bnk u_dtm_reg_bnk(
        .dtm_clk                (jclk   ),
        .rst_n                  (jrst_n ),
        .wr_data                (update_data ),
        .wr_en                  (update_vld  ),
        .wr_rdy                 (update_rdy  ),
        .capture_data           (capture_data),
        .capture_addr           (capture_addr),
        .dmi_req_vld            (dmi_req_vld ),
        .dmi_req_rdy            (dmi_req_rdy ),
        .dmi_req_addr           (dmi_req_addr),
        .dmi_req_data           (dmi_req_data),
        .dmi_req_op             (dmi_req_op  ),
        .dmi_rsp_vld            (dmi_rsp_vld_async ),
        .dmi_rsp_rdy            (dmi_rsp_rdy_async ),
        .dmi_rsp_data           (dmi_rsp_data_async),
        .dmi_rsp_op             (dmi_rsp_op_async  )
    );

 //assign dmi_req_vld_async = dmi_req_vld;
 //assign dmi_req_addr_async = dmi_req_addr;
 //assign dmi_req_data_async = dmi_req_data;
 //assign dmi_req_op_async = dmi_req_op;
 //assign dmi_req_rdy = dmi_req_rdy_async;
 //
 //assign dmi_rsp_vld_async = dmi_rsp_vld;
 //assign dmi_rsp_data_async = dmi_rsp_data;
 //assign dmi_rsp_op_async   = dmi_rsp_op;
 //assign dmi_rsp_rdy = dmi_rsp_rdy_async;

/*=====================================================*/
/*                   DMI REQ ASYNC                     */
/*=====================================================*/

logic [DMI_WIDTH-1:0] dmi_req_payload;
logic [DMI_WIDTH-1:0] dmi_req_payload_async;

assign dmi_req_payload[DMI_WIDTH-1:0] = {dmi_req_addr[DMI_ADDR-1:0],dmi_req_data[DMI_DATA-1:0],dmi_req_op[1:0]};

    cdc_dmi_async #(
        .DATA_WIDTH (DMI_WIDTH),
        .DEPTH      (4),
        .FALLTHROUGH("FALSE"))
        cdc_dmi_tx(
            .src_clk        (jclk),
            .src_rst_n      (jrst_n),
            .dmi_vld_i      (dmi_req_vld),
            .dmi_pld_i      (dmi_req_payload),
            .dmi_rdy_i      (dmi_req_rdy),
            .dst_clk        (dm_clk),
            .dst_rst_n      (dm_rst_n),
            .dmi_vld_o      (dmi_req_vld_async),
            .dmi_pld_o      (dmi_req_payload_async),
            .dmi_rdy_o      (dmi_req_rdy_async)
         );

assign dmi_req_addr_async = dmi_req_payload_async[DMI_WIDTH-1 -: DMI_ADDR];
assign dmi_req_data_async = dmi_req_payload_async[2 +: DMI_DATA];
assign dmi_req_op_async   = dmi_req_payload_async[1:0];
/*=====================================================*/
/*                   DMI RESP ASYNC                     */
/*=====================================================*/

logic [DMI_WIDTH - DMI_ADDR -1:0] dmi_rsp_payload;
logic [DMI_WIDTH - DMI_ADDR -1:0] dmi_rsp_payload_async;

assign dmi_rsp_payload = {dmi_rsp_data[DMI_DATA-1:0],dmi_rsp_op[1:0]};

    cdc_dmi_async #(
        .DATA_WIDTH (DMI_WIDTH - DMI_ADDR),
        .DEPTH      (4),
        .FALLTHROUGH("FALSE"))
        cdc_dmi_rx(
            .src_clk        (dm_clk),
            .src_rst_n      (dm_rst_n),
            .dmi_vld_i      (dmi_rsp_vld),
            .dmi_pld_i      (dmi_rsp_payload),
            .dmi_rdy_i      (dmi_rsp_rdy),
            .dst_clk        (jclk),
            .dst_rst_n      (jrst_n),
            .dmi_vld_o      (dmi_rsp_vld_async),
            .dmi_pld_o      (dmi_rsp_payload_async),
            .dmi_rdy_o      (dmi_rsp_rdy_async)
         );

    assign dmi_rsp_data_async[DMI_DATA-1:0] = dmi_rsp_payload_async[2 +: DMI_DATA];
    assign dmi_rsp_op_async[1:0]            = dmi_rsp_payload_async[1:0];

    debug_module u_debug_module(
        .dm_clk                 (dm_clk   ),
        .dm_rst_n               (dm_rst_n ),
        .sys_rst_n              (sys_rst_n),
        .dm2hart_rst_n          (dm2hart_rst_n),
        .hart_havereset         (hart_havereset),
        .dmi_req_vld            (dmi_req_vld_async ),
        .dmi_req_rdy            (dmi_req_rdy_async ),
        .dmi_req_addr           (dmi_req_addr_async),
        .dmi_req_data           (dmi_req_data_async),
        .dmi_req_op             (dmi_req_op_async  ),
        .dmi_rsp_vld            (dmi_rsp_vld ),
        .dmi_rsp_rdy            (dmi_rsp_rdy ),
        .dmi_rsp_data           (dmi_rsp_data),
        .dmi_rsp_op             (dmi_rsp_op  ),
        .debug_halt_int         (debug_halt_int      ),
        //.debug_halt_ack         ({{(HART_NUM_MAX-1){1'b0}},debug_halt_ack}),
        .debug_inst_req_vld     (debug_inst_req_vld  ),
        .debug_inst_req_rdy     (debug_inst_req_rdy  ),
        .debug_inst_req_addr    (debug_inst_req_addr ),
        .debug_inst_req_data    (debug_inst_req_data ),
        .debug_inst_req_strb    (debug_inst_req_strb ),
        .debug_inst_req_opcode  (debug_inst_req_opcode),
        .debug_inst_ack_vld     (debug_inst_ack_vld  ),
        .debug_inst_ack_rdy     (debug_inst_ack_rdy  ),
        .debug_inst_ack_data    (debug_inst_ack_data ),
        .debug_lsu_req_vld      (debug_lsu_req_vld   ),
        .debug_lsu_req_rdy      (debug_lsu_req_rdy   ),
        .debug_lsu_req_addr     (debug_lsu_req_addr  ),
        .debug_lsu_req_data     (debug_lsu_req_data  ),
        .debug_lsu_req_strb     (debug_lsu_req_strb  ),
        .debug_lsu_req_opcode   (debug_lsu_req_opcode),
        .debug_lsu_ack_vld      (debug_lsu_ack_vld   ),
        .debug_lsu_ack_rdy      (debug_lsu_ack_rdy   ),
        .debug_lsu_ack_data     (debug_lsu_ack_data  ),

        .debug_sysbus_req_vld   (debug_sysbus_req_vld   ),
        .debug_sysbus_req_rdy   (debug_sysbus_req_rdy   ),
        .debug_sysbus_req_addr  (debug_sysbus_req_addr  ),
        .debug_sysbus_req_data  (debug_sysbus_req_data  ),
        .debug_sysbus_req_strb  (debug_sysbus_req_strb  ),
        .debug_sysbus_req_opcode(debug_sysbus_req_opcode),
        .debug_sysbus_ack_vld   (debug_sysbus_ack_vld   ),
        .debug_sysbus_ack_rdy   (debug_sysbus_ack_rdy   ),
        .debug_sysbus_ack_data  (debug_sysbus_ack_data  )
    );

endmodule