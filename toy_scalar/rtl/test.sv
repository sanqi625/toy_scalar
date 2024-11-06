`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/08/2024 04:39:49 PM
// Design Name: 
// Module Name: test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test();
    parameter integer unsigned ADDR_WIDTH = 32;
    parameter integer unsigned DATA_WIDTH = 32;

    logic                        clk         ;
    logic                        rst_n       ;

     logic                       jtag_clk    ;
     logic                       jtag_rst_n  ;
     logic                       jtag_tms   ;
     logic                       jtag_tdi   ;
    logic                        jtag_tdo   ;

     logic                        intr_meip;
     logic                        intr_msi;

//============================================================
// Clock and Reset generation
//============================================================

    // #20 is a cycle.

    initial begin
        rst_n = 1'b0;
        #100;
        rst_n = 1'b1;
    end

    initial begin
        clk = 1'b0;
        forever begin
                #50;
                clk = ~clk;
                #50;
                clk = ~clk;
            end
    end

toy_top_fpga u_top(
        .clk_in_p       (1'b0),
        .clk_in_n       (1'b0),
        .push_rst       (1'b1),

        .test_clk       (clk),
        .test_rst_n     (rst_n),

        .jtag_clk       (1'b0),
        .jtag_tms       (1'b0),
        .jtag_tdi       (1'b0),
        .jtag_tdo       (),
        .intr_meip      (),
        .peri_uart_rx_i (1'b0),
        .peri_uart_tx_o (),
        .gpio_out       (),
        .led_host_en    ()                
);

endmodule
