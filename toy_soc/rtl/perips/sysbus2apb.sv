module sysbus2apb
    import toy_pack::*;
(
    input logic                 clk,
    input logic                 rst_n,

    input  logic                bus_req_vld    ,
	output logic                bus_req_rdy    ,
	input  logic [31:0]         bus_req_addr   ,
	input  logic [31:0]         bus_req_data   ,
	input  logic [3:0]          bus_req_strb   ,  //not used
	input  logic                bus_req_opcode ,
	output logic                bus_ack_vld    ,
	input  logic                bus_ack_rdy    ,
	output logic [31:0]         bus_ack_data   ,

    output logic [31:0]         apb_paddr,
    output logic                apb_pwrite,
    output logic                apb_psel,
    output logic                apb_penable,
    output logic [31:0]         apb_pwdata,
    input  logic [31:0]         apb_prdata,
    input  logic                apb_pready,
    input  logic                apb_pslverr
);

logic [31:0]    rdata_buf;
logic           sel_reg;
logic           vld_delay;
logic           first_handshake;
logic           not_handshake;
logic           delay_handshake;

assign apb_paddr    = bus_req_addr;
assign apb_pwrite   = bus_req_opcode == TOY_BUS_WRITE;
assign apb_psel     = bus_req_vld;
assign apb_penable  = bus_req_vld;
assign apb_pwdata   = bus_req_data;

always_ff @( posedge clk or negedge rst_n ) begin
    if(!rst_n)
        sel_reg <= 1'b0;
    else 
        sel_reg <= apb_psel;
end

assign bus_ack_vld  = apb_pready && apb_psel;

always_ff @( posedge clk or negedge rst_n ) begin
    if(!rst_n)begin
        rdata_buf <= 'b0;
        vld_delay <= 1'b0;
    end else if(delay_handshake)begin
        rdata_buf <= 'b0;
        vld_delay <= 1'b0;
    end else if(not_handshake)begin
        rdata_buf <= apb_prdata;
        vld_delay <= 1'b1;
    end
end

assign first_handshake  = bus_ack_vld && bus_ack_rdy && ~apb_pwrite;
assign not_handshake    = bus_ack_vld && ~bus_ack_rdy && ~apb_pwrite;
assign delay_handshake  = vld_delay && bus_ack_rdy;

assign bus_ack_data = first_handshake ? apb_prdata :
                      delay_handshake ? rdata_buf : 32'b0;


assign bus_req_rdy = apb_pready;

endmodule