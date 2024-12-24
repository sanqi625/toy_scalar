module cdc_dmi_async #(
    parameter DATA_WIDTH = 8, 
    parameter DEPTH = 16,
    parameter FALLTHROUGH = "FALSE")(
        input  logic                  src_clk,     
        input  logic                  src_rst_n,        
        input  logic                  dmi_vld_i,
        input  logic[DATA_WIDTH-1:0]  dmi_pld_i, 
        output logic                  dmi_rdy_i, 

        input  logic                  dst_clk,
        input  logic                  dst_rst_n,  
        output logic                  dmi_vld_o,
        output logic [DATA_WIDTH-1:0] dmi_pld_o,
        input  logic                  dmi_rdy_o
     );

    logic wfull,rempty;
    logic winc,rinc;

    assign dmi_rdy_i = !wfull;
    assign winc      = dmi_vld_i && dmi_rdy_i;

    assign rinc      = !rempty && dmi_rdy_o;

    always_ff @( posedge dst_clk or negedge dst_rst_n ) begin
        if(!dst_rst_n)
            dmi_vld_o <= 1'b0;
        else if(rempty)
            dmi_vld_o <= 1'b0;
        else if(!rempty)
            dmi_vld_o <= 1'b1;
    end

    async_fifo #(
        .DSIZE          (DATA_WIDTH),
        .ASIZE          ($clog2(DEPTH)),
        .AWFULLSIZE     (1),
        .AREMPTYSIZE    (1),
        .FALLTHROUGH    ("FALSE")
    )u_async_fifo(
        .wclk       (src_clk),
        .wrst_n     (src_rst_n),
        .winc       (winc),
        .wdata      (dmi_pld_i),
        .wfull      (wfull),
        .awfull     (),
        .rclk       (dst_clk),
        .rrst_n     (dst_rst_n),
        .rinc       (rinc),
        .rdata      (dmi_pld_o),
        .rempty     (rempty),
        .arempty    ()
    );               

endmodule
