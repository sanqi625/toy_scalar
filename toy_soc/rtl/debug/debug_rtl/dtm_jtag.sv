
module dtm_jtag
    import debug_pack::*;
(
    input  logic                  tclk,
    input  logic                  trst_n,
    input  logic                  tms,
    input  logic                  tdi,
    output logic                  tdo,
    output logic                  tdo_en,

    //output logic                  sel_bypass,
    //output logic                  sel_idcode,
    //output logic                  sel_dmi,
    //output logic                  sel_dtmcs,

    output logic [DMI_WIDTH -1:0] wr_data,
    output logic                  wr_en,
    input  logic                  wr_rdy,

    input  logic [DMI_WIDTH -1:0] rd_data,
    output logic [IR_REG_WIRTH-1:0] rd_addr

    //output   logic dtm_req_data, //data and address
    //output   logic dtm_req_op,  //read or write
    //output   logic dtm_req_vld,
    //input    logic dtm_req_rdy,
//
    //input    logic dtm_rsp_data,  //only data
    //input    logic dtm_rsp_vld,
    //output   logic dtm_rsp_rdy,
);

/*=====================================================*/
/*                      parameter                       */
/*=====================================================*/


/*=====================================================*/
/*                      variable                       */
/*=====================================================*/
wire tms_i;
//wire io_sm_tap_en;

reg [5:0] tap5_cur_st;
reg [5:0] tap5_nxt_st;

assign tms_i = tms;
//assign io_sm_tap_en = 1'b1;
/*=====================================================*/
/*======================TAP FSM========================*/
/*=====================================================*/

localparam TAP5_RESET          = 6'b000000;
localparam TAP5_IDLE           = 6'b000001;
localparam TAP5_SELECT_DR_SCAN = 6'b000011;
localparam TAP5_SELECT_IR_SCAN = 6'b000010;
localparam TAP5_CAPTURE_IR     = 6'b000110;
localparam TAP5_SHIFT_IR       = 6'b000100;
localparam TAP5_EXIT1_IR       = 6'b000101;

localparam TAP5_UPDATE_IR      = 6'b010000; 
localparam TAP5_CAPTURE_DR     = 6'b001011;
localparam TAP5_SHIFT_DR       = 6'b001010;
localparam TAP5_EXIT1_DR       = 6'b001000;

localparam TAP5_UPDATE_DR      = 6'b100000; 
localparam TAP5_PAUSE_IR       = 6'b001101;
localparam TAP5_EXIT2_IR       = 6'b001111;
localparam TAP5_PAUSE_DR       = 6'b001100;
localparam TAP5_EXIT2_DR       = 6'b001110;

always_ff @(posedge tclk or negedge trst_n) begin
  if (!trst_n)
    tap5_cur_st[5:0] <= TAP5_RESET;
  else 
    tap5_cur_st[5:0] <= tap5_nxt_st[5:0];
end

always_comb begin
  case(tap5_cur_st[5:0])
    TAP5_RESET:
      if (!tms_i)
        tap5_nxt_st[5:0] = TAP5_IDLE;
      else
        tap5_nxt_st[5:0] = TAP5_RESET;
    TAP5_IDLE:
      if (tms_i)      
        tap5_nxt_st[5:0] = TAP5_SELECT_DR_SCAN;
      else
        tap5_nxt_st[5:0] = TAP5_IDLE;
    TAP5_SELECT_DR_SCAN:
      if (tms_i)
        tap5_nxt_st[5:0] = TAP5_SELECT_IR_SCAN;
      else
        tap5_nxt_st[5:0] = TAP5_CAPTURE_DR;
    TAP5_SELECT_IR_SCAN:
      if (!tms_i)
        tap5_nxt_st[5:0] = TAP5_CAPTURE_IR;
      else
        tap5_nxt_st[5:0] = TAP5_RESET;
    TAP5_CAPTURE_IR:
      if (!tms_i)
        tap5_nxt_st[5:0] = TAP5_SHIFT_IR;
      else
        tap5_nxt_st[5:0] = TAP5_EXIT1_IR;
    TAP5_SHIFT_IR: 
      if (tms_i)
        tap5_nxt_st[5:0] = TAP5_EXIT1_IR;
      else
        tap5_nxt_st[5:0] = TAP5_SHIFT_IR;
    TAP5_EXIT1_IR:
      if (tms_i)
        tap5_nxt_st[5:0] = TAP5_UPDATE_IR;
      else
        tap5_nxt_st[5:0] = TAP5_PAUSE_IR;
    TAP5_PAUSE_IR:
      if (tms_i)
        tap5_nxt_st[5:0] = TAP5_EXIT2_IR;
      else
        tap5_nxt_st[5:0] = TAP5_PAUSE_IR;
    TAP5_EXIT2_IR:
      if (tms_i)
        tap5_nxt_st[5:0] = TAP5_UPDATE_IR;
      else
        tap5_nxt_st[5:0] = TAP5_SHIFT_IR;
    TAP5_UPDATE_IR:
      if (tms_i)
        tap5_nxt_st[5:0] = TAP5_SELECT_DR_SCAN;
      else
        tap5_nxt_st[5:0] = TAP5_IDLE;
    TAP5_CAPTURE_DR: 
      if (!tms_i)
        tap5_nxt_st[5:0] = TAP5_SHIFT_DR;
      else
        tap5_nxt_st[5:0] = TAP5_EXIT1_DR;
    TAP5_SHIFT_DR:
      if (tms_i)
        tap5_nxt_st[5:0] = TAP5_EXIT1_DR;
      else
        tap5_nxt_st[5:0] = TAP5_SHIFT_DR;
    TAP5_EXIT1_DR:
      if (!tms_i)
        tap5_nxt_st[5:0] = TAP5_PAUSE_DR;
      else
        tap5_nxt_st[5:0] = TAP5_UPDATE_DR;
    TAP5_PAUSE_DR:
      if (tms_i)
        tap5_nxt_st[5:0] = TAP5_EXIT2_DR;
      else
        tap5_nxt_st[5:0] = TAP5_PAUSE_DR;
    TAP5_EXIT2_DR:
      if (tms_i)
        tap5_nxt_st[5:0] = TAP5_UPDATE_DR;
      else
        tap5_nxt_st[5:0] = TAP5_SHIFT_DR;
    TAP5_UPDATE_DR:
      if (tms_i)
        tap5_nxt_st[5:0] = TAP5_SELECT_DR_SCAN;
      else
        tap5_nxt_st[5:0] = TAP5_IDLE;
    default:
        tap5_nxt_st[5:0] = TAP5_RESET;
  endcase
end

/*=====================================================*/
/*                  Instruction register               */
/*=====================================================*/
wire [31:0]             idcode_reg;
wire [31:0]             dtmcs_reg;

reg [IR_REG_WIRTH-1:0]  IR_hold_reg;
reg [DMI_WIDTH-1:0]     shift_reg;

//assign capture_ir_en = (tap5_cur_st[5:0]== TAP5_CAPTURE_IR);
//assign shift_ir_en   = (tap5_cur_st[5:0]== TAP5_SHIFT_IR);
//assign update_ir_en  = (tap5_cur_st[5:0]== TAP5_UPDATE_IR);

always_ff @(posedge tclk or negedge trst_n) begin
  if(!trst_n)
      shift_reg[DMI_WIDTH-1:0] <= 'b0;
  else begin
    case(tap5_cur_st[5:0])
      TAP5_CAPTURE_IR : shift_reg[DMI_WIDTH-1:0] <= {{(DMI_WIDTH-1){1'b0}},1'b1};
      TAP5_SHIFT_IR   : shift_reg[DMI_WIDTH-1:0] <= {{(DMI_WIDTH-IR_REG_WIRTH){1'b0}},tdi,shift_reg[IR_REG_WIRTH-1:1]};
      TAP5_CAPTURE_DR : begin
        case (IR_hold_reg[IR_REG_WIRTH-1:0])
          IDCODE_REG_ADDR: shift_reg[DMI_WIDTH-1:0] <= rd_data[DMI_WIDTH-1:0];
          DTMCS_REG_ADDR : shift_reg[DMI_WIDTH-1:0] <= rd_data[DMI_WIDTH-1:0];
          DMI_REG_ADDR   : shift_reg[DMI_WIDTH-1:0] <= rd_data[DMI_WIDTH-1:0];
          BYPASS_REG_ADDR: shift_reg[DMI_WIDTH-1:0] <= {DMI_WIDTH{1'b0}};
          default:         shift_reg[DMI_WIDTH-1:0] <= {DMI_WIDTH{1'b0}};
        endcase
      end
      TAP5_SHIFT_DR   : begin
        case (IR_hold_reg[IR_REG_WIRTH-1:0])
          IDCODE_REG_ADDR: shift_reg[DMI_WIDTH-1:0] <= {{(DMI_WIDTH-32){1'b0}},tdi,shift_reg[31:1]};
          DTMCS_REG_ADDR : shift_reg[DMI_WIDTH-1:0] <= {{(DMI_WIDTH-32){1'b0}},tdi,shift_reg[31:1]};
          DMI_REG_ADDR   : shift_reg[DMI_WIDTH-1:0] <= {tdi,shift_reg[DMI_WIDTH-1:1]};
          BYPASS_REG_ADDR: shift_reg[DMI_WIDTH-1:0] <= {{(DMI_WIDTH-1){1'b0}},tdi};    //when bypass ,tdo == tdi
          default:         shift_reg[DMI_WIDTH-1:0] <= {{(DMI_WIDTH-1){1'b0}},tdi};
        endcase
      end
      default:          shift_reg[IR_REG_WIRTH-1:0] <= shift_reg[IR_REG_WIRTH-1:0];
    endcase
  end
end

always_ff @(posedge tclk or negedge trst_n) begin
  if(!trst_n)
      IR_hold_reg[IR_REG_WIRTH-1:0] <= IDCODE_REG_ADDR;
  else if(tap5_cur_st[5:0] == TAP5_RESET)
      IR_hold_reg[IR_REG_WIRTH-1:0] <= IDCODE_REG_ADDR;
  else if(tap5_cur_st[5:0] == TAP5_UPDATE_IR)
      IR_hold_reg[IR_REG_WIRTH-1:0] <= shift_reg[IR_REG_WIRTH-1 : 0];
end 

//assign sel_idcode = (IR_hold_reg[IR_REG_WIRTH-1:0] == IDCODE_REG_ADDR);
//assign sel_dtmcs  = (IR_hold_reg[IR_REG_WIRTH-1:0] == DTMCS_REG_ADDR);
//assign sel_dmi    = (IR_hold_reg[IR_REG_WIRTH-1:0] == DMI_REG_ADDR);
//assign sel_bypass = (IR_hold_reg[IR_REG_WIRTH-1:0] == BYPASS_REG_ADDR);
assign rd_addr[IR_REG_WIRTH-1:0] = IR_hold_reg[IR_REG_WIRTH-1:0];

/*=====================================================*/
/*                     Data register                   */
/*=====================================================*/
reg [DMI_WIDTH-1:0] DR_hold_reg;

always_ff @(posedge tclk or negedge trst_n)begin
  if(!trst_n)
      DR_hold_reg[DMI_WIDTH-1:0] <= 'b0;
  else if(tap5_cur_st[5:0] == TAP5_UPDATE_DR)
      DR_hold_reg[DMI_WIDTH-1:0] <= shift_reg[DMI_WIDTH-1:0];
end

assign update_handshake = wr_en && wr_rdy;

//always_ff @(posedge tclk or negedge trst_n)begin
//  if(!trst_n)
//      wr_en <= 1'b0;
//  else if(update_handshake)
//      wr_en <= 1'b0;
//  else if(tap5_cur_st[5:0] == TAP5_UPDATE_DR)
//      wr_en <= 1'b1;
//end

always_ff @(posedge tclk or negedge trst_n)begin
  if(!trst_n)
      wr_en <= 1'b0;
  else 
      wr_en <= (tap5_cur_st[5:0] == TAP5_UPDATE_DR) && wr_rdy;
end

assign wr_data[DMI_WIDTH-1:0] = DR_hold_reg[DMI_WIDTH-1:0];

/*=====================================================*/
/*                         TDO                          */
/*=====================================================*/

always_ff @(negedge tclk or negedge trst_n)begin
  if(!trst_n)begin
      tdo <= 1'b0;
      tdo_en  <= 1'b0;
  end else if(tap5_cur_st[5:0] == TAP5_SHIFT_IR)begin
      tdo <= shift_reg[0];
      tdo_en  <= 1'b1;
  end else if(tap5_cur_st[5:0] == TAP5_SHIFT_DR)begin
      tdo <= shift_reg[0];
      tdo_en  <= 1'b1;
  end else begin
      tdo <= 1'b0;
      tdo_en  <= 1'b0;
  end
end

/*=====================================================*/
/*                   DTM interface                     */
/*=====================================================*/
    
    // DEBUG =========================================================================================================
    logic jtag_rd;

    assign jtag_rd = tap5_cur_st[5:0] == TAP5_CAPTURE_DR;

    `ifdef TOY_SIM
    initial begin
        if($test$plusargs("DBG")) begin
            $display("==================Jtag read=========================");
            forever begin
                @(posedge tclk)

                if(rd_addr==IDCODE_REG_ADDR) begin
                    if(jtag_rd)
                      $display("[dtm jtag] jtag read dtm < IDCODE > reg, read data =%0h \n." ,rd_data);
                    else if(wr_en)
                      $display("[dtm jtag] jtag write dtm < IDCODE > reg, write data =%0h \n." ,wr_data);
                    else  
                      ;
                end

                if(rd_addr==DTMCS_REG_ADDR) begin
                    if(jtag_rd)
                      $display("[dtm jtag] jtag read dtm < DTMCS > reg, read data =%0h \n." ,rd_data);
                    else if(wr_en)
                      $display("[dtm jtag] jtag write dtm < DTMCS > reg, write data =%0h \n." ,wr_data);
                    else  
                      ;
                end

                if(rd_addr==DMI_REG_ADDR) begin
                    if(jtag_rd)
                      $display("[dtm jtag] jtag read dtm < DMI > reg, read data =%0h \n." ,rd_data);
                    else if(wr_en)
                      $display("[dtm jtag] jtag write dtm < DMI > reg, write data =%0h, dm_addr =%h, dm_data =%h, dm_op =%h \n." ,wr_data, wr_data[DMI_WIDTH-1 -: DMI_ADDR], wr_data[31+2 : 2], wr_data[1:0]);
                    else  
                      ;
                end

                if(rd_addr==BYPASS_REG_ADDR) begin
                    if(jtag_rd)
                      $display("[dtm jtag] jtag read dtm < BYPASS >, read data =%0h \n." ,rd_data);
                    else if(wr_en)
                      $display("[dtm jtag] jtag write dtm < BYPASS > reg, write data =%0h , data will be ignored \n." ,wr_data);
                    else  
                      ;
                end
                
            end
        end
    end

    `endif

endmodule