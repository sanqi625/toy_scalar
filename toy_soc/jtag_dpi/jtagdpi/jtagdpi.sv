// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

module jtagdpi #(
  parameter string Name = "riscv_jtag", // name of the JTAG interface (display only)
  parameter int ListenPort = 1258 // TCP port to listen on
)(
  input  logic clk_i,
  input  logic rst_ni,

  output logic jtag_tck,
  output logic jtag_tms,
  output logic jtag_tdi,
  input  logic jtag_tdo,
  output logic jtag_trst_n,
  output logic jtag_srst_n,
  output logic jtag_close
);

  import "DPI-C"
  function chandle jtagdpi_create(input string name, input int listen_port);

  import "DPI-C"
  function void jtagdpi_tick(input chandle ctx, output bit tck, output bit tms,
                             output bit tdi, output bit trst_n,
                             output bit srst_n, input bit tdo);

  import "DPI-C"
  function void jtagdpi_close(input chandle ctx);

  chandle ctx;

  initial begin
    jtag_close=0;
    ctx = jtagdpi_create(Name, ListenPort);
  end

  final begin
    $display("JTAG TEST END");
    jtagdpi_close(ctx);
    jtag_close =1;
    //ctx = 0;
  end

  always_ff @(posedge clk_i, negedge rst_ni) begin
    jtagdpi_tick(ctx, jtag_tck, jtag_tms, jtag_tdi, jtag_trst_n, jtag_srst_n,
                 jtag_tdo);
  end

endmodule
