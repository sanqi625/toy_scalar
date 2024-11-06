module async_reset_sync_release (
    input   logic clk,
    input   logic async_reset_n,  // async reset，active low
    output  logic sync_reset_n    // sync reset release, active high
);

logic [1:0] sync_reset_ff;  

always @(posedge clk or negedge async_reset_n) begin
    if (!async_reset_n) begin
        sync_reset_ff <= 2'b00;  // async reset,
        sync_reset_n <= 0;
    end else begin
        sync_reset_ff <= {sync_reset_ff[0], 1'b1};  // reset sync release
        sync_reset_n <= sync_reset_ff[1];
    end
end

endmodule
