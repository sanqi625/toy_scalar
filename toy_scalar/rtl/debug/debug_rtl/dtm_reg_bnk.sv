
module dtm_reg_bnk
    import debug_pack::*;
(
    input logic                     dtm_clk,
    input logic                     rst_n,

// interface to jtag tap 
    input   logic [DMI_WIDTH -1:0]  wr_data,
    input   logic                   wr_en,
    //input   logic [IR_REG_WIRTH-1:0]wr_addr, //add
    output  logic                   wr_rdy,
    
    output  logic [DMI_WIDTH -1:0]  capture_data,
    input   logic [IR_REG_WIRTH-1:0]capture_addr,
   //input   logic                   capture_en,
   // output  logic                   capture_rdy,

//DTM interface
    //input   logic dtm_req_data, //data and address
    //input   logic dtm_req_op,  //read or write
    //input   logic dtm_req_vld,
    //output  logic dtm_req_rdy,
//
    //output  logic dtm_rsp_data,  //only data
    //output  logic dtm_rsp_vld,
    //input   logic dtm_rsp_rdy,

// DMI
    output logic                    dmi_req_vld,
    input  logic                    dmi_req_rdy,
    output logic [DMI_ADDR-1:0]     dmi_req_addr,
    output logic [DMI_DATA-1:0]     dmi_req_data,
    output logic [1:0]              dmi_req_op,

    input  logic                    dmi_rsp_vld,
    output logic                    dmi_rsp_rdy,
    input  logic [DMI_DATA-1:0]     dmi_rsp_data,
    input  logic [1:0]              dmi_rsp_op
);
/*=====================================================*/
/*                      parameter                       */
/*=====================================================*/

localparam SEL_IDCODE = 5'b00001;
localparam SEL_DTMCS  = 5'b00010;
localparam SEL_DMI    = 5'b00100;
localparam SEL_BYPASS = 5'b01000;
localparam SEL_STICKY = 5'b10000; 

localparam OP_BUSY    = 2'b11;
localparam OP_FAIL    = 2'b10;
localparam OP_SUCS    = 2'b00;

/*=====================================================*/
logic        sticky_flag;
logic        sticky_fail;
logic        sticky_busy;
logic [DMI_WIDTH-1:0 ]stick_data;

logic        csr_DTMCS_wren;
logic        dtm_rst_n;
logic        clr_stick;
logic [31:0] capture_dtmcs;

logic        dtmcs_reg_rdy;
logic        dmi_reg_rdy;
logic        sw_dtm_rst_n;
logic [31:0] idcode_reg;

dtmcs_t dtmcs_reg;
dmi_t   dmi_wr_reg;
dmi_t   dmi_rd_reg;

logic [3:0] Version;
logic [15:0] PartNumber;
logic [10:0] Manufld;

assign dtm_rst_n    = rst_n && sw_dtm_rst_n;
assign sticky_flag  = sticky_busy || sticky_fail;

assign dtmcs_reg_rdy    = 1'b1;
assign dmi_reg_rdy      = ~sticky_flag && dmi_req_rdy;

assign wr_rdy       = dtmcs_reg_rdy || dmi_reg_rdy;

// dtm busy decided by DM can receive extra req,include abstract command / program buffer /data reg
assign sticky_busy  = (dmi_rd_reg.op == OP_BUSY);
assign sticky_fail  = (dmi_rd_reg.op == OP_FAIL);

/*=====================================================*/
/*                    Data register
               inlcude idcode/dtmcs/dmi                */
/*=====================================================*/
assign data_reg_wren = wr_en && wr_rdy;

//IDCODE reg
//assign idcode_reg[31:0]  =  {4'b0001,16'b0,11'b0,1'b1}; //read_only

assign Version[3:0]     = 4'h1;
assign PartNumber[15:0] = 16'h0001;
assign Manufld[10:0]    = 11'h000;
//assign idcode_reg[31:0] = 32'h1e200a6d;
assign idcode_reg[31:0] = {Version[3:0],PartNumber[15:0],Manufld[10:0],1'b1};
//10001001
//DTMCS reg
assign csr_DTMCS_wren = data_reg_wren && (capture_addr==DTMCS_REG_ADDR);

assign dtmcs_reg.unused1 = 14'b0;
assign dtmcs_reg.errinfo = 3'b0;            //not implemented
assign dtmcs_reg.unused0 = 1'b0;
assign dtmcs_reg.idle    = 3'd2;           //internal cycle
assign dtmcs_reg.abits   = DMI_ADDR;
assign dtmcs_reg.version = 4'd1;

//only dmihardreset and dmireset can be written by software
always_ff @(posedge dtm_clk or negedge dtm_rst_n) begin
    if(!dtm_rst_n)
        dtmcs_reg.dmihardreset   <= 1'b0              ;
    else if(csr_DTMCS_wren)
        dtmcs_reg.dmihardreset   <= wr_data[17] ? 1'b1 : wr_data[17];
end

always_ff @(posedge dtm_clk or negedge dtm_rst_n) begin
    if(!dtm_rst_n) 
        dtmcs_reg.dmireset       <= 1'b0              ;
    else if(clr_stick)
        dtmcs_reg.dmireset       <= 1'b0              ;
    else if(csr_DTMCS_wren)
        dtmcs_reg.dmireset       <= wr_data[16] ? 1'b1 : dtmcs_reg.dmireset;
end

assign sw_dtm_rst_n = ~dtmcs_reg.dmihardreset;
assign clr_stick    =  dtmcs_reg.dmireset;  //clear op sticky error

always_ff @(posedge dtm_clk or negedge dtm_rst_n) begin
    if(!dtm_rst_n)
        dtmcs_reg.dmistat <= 'b0;
    else if(clr_stick)
        dtmcs_reg.dmistat <= 'b0;
    else
        dtmcs_reg.dmistat <= dmi_rd_reg.op;
end

assign capture_dtmcs[31:0] = {dtmcs_reg.unused1,dtmcs_reg.errinfo,1'b0,1'b0,
                                dtmcs_reg.unused0,dtmcs_reg.idle,
                                dtmcs_reg.abits,dtmcs_reg.version};

//DMI write reg
assign csr_DMI_wren = data_reg_wren && (capture_addr==DMI_REG_ADDR) && dmi_reg_rdy;// dmi reg should not in sticky state

always_ff @(posedge dtm_clk or negedge dtm_rst_n )begin
    if(!dtm_rst_n)begin
        dmi_wr_reg.op   <= 'b0;
        dmi_wr_reg.data <= 'b0;
        dmi_wr_reg.addr <= 'b0;
    end
    else if(csr_DMI_wren)begin
        dmi_wr_reg.op   <= wr_data[1:0];
        dmi_wr_reg.data <= wr_data[31+2 : 2];
        dmi_wr_reg.addr <= wr_data[DMI_WIDTH-1 -: DMI_ADDR];
    end
end

//assign dmi_req_addr[DMI_ADDR-1:0]    = dmi_wr_reg.addr;
//assign dmi_req_data[31:0]            = dmi_wr_reg.data;
//assign dmi_req_op[1:0]               = dmi_wr_reg.op;

//always_ff @(posedge dtm_clk or negedge dtm_rst_n)begin
//    if(!dtm_rst_n)
//        dmi_req_vld <= 1'b0;
//    else if(csr_DMI_wren && dmi_req_rdy)
//        dmi_req_vld <= 1'b1;
//    else
//        dmi_req_vld <= 1'b0;
//end
assign dmi_req_addr[DMI_ADDR-1:0]    = wr_data[DMI_WIDTH-1 -: DMI_ADDR];
assign dmi_req_data[31:0]            = wr_data[31+2 : 2];
assign dmi_req_op[1:0]               = wr_data[1:0];

assign dmi_req_vld = csr_DMI_wren && dmi_req_rdy;

//DMI read reg
assign dmi_rsp_rdy     = 1'b1;  //TODO

assign csr_DMI_rsp_wr  = dmi_rsp_vld && dmi_rsp_rdy;

assign dmi_rd_reg.addr[DMI_ADDR-1:0] = dmi_wr_reg.addr;

always_ff @(posedge dtm_clk or negedge dtm_rst_n) begin
    if(!dtm_rst_n)
        dmi_rd_reg.op   <= 'b0;
    else if(clr_stick)
        dmi_rd_reg.op   <= 'b0;
    else if(csr_DMI_rsp_wr)
        dmi_rd_reg.op   <= dmi_rsp_op[1:0];
    else if(dmi_req_vld && (dmi_req_op==OP_READ))
        dmi_rd_reg.op   <= OP_BUSY;
end

always_ff @(posedge dtm_clk or negedge dtm_rst_n) begin
    if(!dtm_rst_n)
        dmi_rd_reg.data <= 'b0;
    else if(csr_DMI_rsp_wr)
        dmi_rd_reg.data <= dmi_rsp_data[31:0];
end

assign stick_data[DMI_WIDTH-1:0] = {{DMI_WIDTH{1'b0}},32'b0,dmi_rd_reg.op};

/*=====================================================*/
/*                    Capture data                     */
/*=====================================================*/

always_comb begin
    capture_data[DMI_WIDTH-1:0] = {{(DMI_WIDTH-32){1'b0}},idcode_reg[31:0]};
    if(sticky_flag)
        capture_data[DMI_WIDTH-1:0] = stick_data[DMI_WIDTH-1:0];
    else begin
        case(capture_addr[IR_REG_WIRTH-1:0])
            IDCODE_REG_ADDR: capture_data[DMI_WIDTH-1:0] = {{(DMI_WIDTH-32){1'b0}},idcode_reg[31:0]};
            DTMCS_REG_ADDR:  capture_data[DMI_WIDTH-1:0] = {{(DMI_WIDTH-32){1'b0}},capture_dtmcs[31:0]};
            DMI_REG_ADDR:    capture_data[DMI_WIDTH-1:0] = dmi_rd_reg[DMI_WIDTH-1:0];
            BYPASS_REG_ADDR: capture_data[DMI_WIDTH-1:0] = {DMI_WIDTH{1'b0}};
            default :        capture_data[DMI_WIDTH-1:0] = {{(DMI_WIDTH-32){1'b0}},idcode_reg[31:0]};
        endcase
    end
end


    //DEBUG =========================================================================================================

    `ifdef TOY_SIM
    initial begin
        if($test$plusargs("DBG")) begin
            $display("==================DTM Reg Bank=========================");
            forever begin
                @(posedge dtm_clk)

                if(csr_DMI_rsp_wr) begin
                    $display("[DTM REG BNK] rsp_data =%h, rsp_op=%0d .\n" , dmi_rsp_data[31:0],dmi_rsp_op[1:0]);
                end
                
            end
        end
    end
    
    `endif
///*=====================================================*/
///*                   DMI REQ ASYNC                     */
///*=====================================================*/
//assign dmi_req_payload[DMI_WIDTH-1:0] = {dmi_req_addr[DMI_ADDR-1:0],dmi_req_data[DMI_DATA-1:0],dmi_req_op[1:0]};
//
//cdc_dmi_async #(
//    .DATA_WIDTH (DMI_WIDTH),
//    .DEPTH      (2),
//    .FALLTHROUGH("FALSE")(
//        .src_clk        (dtm_clk),
//        .src_rst_n      (dtm_rst_n),
//        .dmi_vld_i      (dmi_req_vld),
//        .dmi_pld_i      (dmi_req_payload),
//        .dmi_rdy_i      (dmi_req_rdy),
//        .dst_clk        (dm_clk),
//        .dst_rst_n      (dm_rst_n),
//        .dmi_vld_o      (dmi_req_vld_o),
//        .dmi_pld_o      (dmi_req_payload_o),
//        .dmi_rdy_o      (dmi_req_rdy_o)
//     );
//
//
///*=====================================================*/
///*                   DMI RESP ASYNC                     */
///*=====================================================*/
//
//cdc_dmi_async #(
//    .DATA_WIDTH (DMI_WIDTH),
//    .DEPTH      (2),
//    .FALLTHROUGH("FALSE")(
//        .src_clk        (dm_clk),
//        .src_rst_n      (dm_rst_n),
//        .dmi_vld_i      (dmi_rsp_vld_i),
//        .dmi_pld_i      (dmi_rsp_payload_i),
//        .dmi_rdy_i      (dmi_rsp_rdy_i),
//        .dst_clk        (dtm_clk),
//        .dst_rst_n      (dtm_rst_n),
//        .dmi_vld_o      (dmi_rsp_vld),
//        .dmi_pld_o      (dmi_rsp_payload),
//        .dmi_rdy_o      (dmi_rsp_rdy)
//     );
//
//assign dmi_rsp_data[DMI_DATA-1:0]   = dmi_req_payload[2 +: DMI_DATA];
//assign dmi_rsp_op[1:0]            = dmi_req_payload[1:0];

endmodule