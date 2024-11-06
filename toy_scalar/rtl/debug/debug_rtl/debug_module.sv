
module debug_module
    import toy_pack::*;
    import debug_pack::*;
(
    input                           dm_clk,
    input                           dm_rst_n,

    //output  logic [CORE_NUM-1:0]    dm2reset_core,
    output  logic                   dm2hart_rst_n,   //reset selecl hart
    output  logic                   sys_rst_n,       //reset all platform, except for the Debug Module and Debug Transport Modules.
    input   logic                   hart_havereset,  //reset has been completed
    // DMI
    input   logic                   dmi_req_vld,
    output  logic                   dmi_req_rdy,
    input   logic [DMI_ADDR-1:0]    dmi_req_addr,
    input   logic [DMI_DATA-1:0]    dmi_req_data,
    input   logic [1:0]             dmi_req_op,

    output  logic                   dmi_rsp_vld,
    input   logic                   dmi_rsp_rdy,
    output  logic [DMI_DATA-1:0]    dmi_rsp_data,
    output  logic [1:0]             dmi_rsp_op,
    // DM interface connect to hart
    output  logic                   debug_halt_int,

    //access instruction memory slave --access debug rom/ram
    input   logic                   debug_inst_req_vld,
    output  logic                   debug_inst_req_rdy,
    input   logic [31:0]            debug_inst_req_addr,
    input   logic [31:0]            debug_inst_req_data,
    input   logic [3:0]             debug_inst_req_strb,
    input   logic                   debug_inst_req_opcode,
    output  logic                   debug_inst_ack_vld,
    input   logic                   debug_inst_ack_rdy,
    output  logic [31:0]            debug_inst_ack_data,

    //access data memory salve -- access debug state register
    input   logic                   debug_lsu_req_vld,
    output  logic                   debug_lsu_req_rdy,
    input   logic [31:0]            debug_lsu_req_addr,
    input   logic [31:0]            debug_lsu_req_data,
    input   logic [3:0]             debug_lsu_req_strb,
    input   logic                   debug_lsu_req_opcode,
    output  logic                   debug_lsu_ack_vld,
    input   logic                   debug_lsu_ack_rdy,
    output  logic [31:0]            debug_lsu_ack_data,

    //access date memory master -- debug system bus access memory sys
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

/*=====================================================*/
/*                      parameter                      */
/*=====================================================*/

localparam OP_SUCCESS   = 2'b00;
localparam OP_FAIL      = 2'b10;
localparam OP_BUSY      = 2'b11;
 
localparam DM_IDLE      = 3'd0;
localparam DM_HALTED    = 3'd1;
localparam DM_GOING     = 3'd2;
localparam DM_RESUME    = 3'd3;
localparam DM_EXCEPTION = 3'd4;

localparam CMD_IDLE     = 3'd0;
localparam CMD_TRANSFER = 3'd1;
//localparam CMD_JUMP     = 3'd2;
localparam CMD_PROGBUF  = 3'd3;
//localparam CMD_EBREAK   = 3'd4;

/*=====================================================*/
/*                      variable                      */
/*=====================================================*/
logic [HART_NUM_MAX-1:0]    debug_halt_ack;
logic                       clr_resume_req;
logic                       debug_resume_int;             

logic [31:0]                hart_state_resume_1d;
logic                       resumereq_1d;
logic                       hart_resume_ack;
logic                       debug_resume_rel;
logic                       clr_havereset;
logic                       command_ready;
logic                       debug_command_en;

logic [2:0]                 dm_state,dm_next_state;
logic                       dm_rst_n_act;

logic                       command_end_cond;
logic                       prog_buff_end_cond;
logic                       execute_end;
logic                       debug_end;

logic                       debug_inst_command_ack_vld;
logic                       debug_inst_jump_ack_vld;
logic                       debug_inst_progbuf_ack_vld;
logic                       debug_inst_ebreak_ack_vld;

logic [2:0]                 cmd_state,cmd_next_state;
logic                       detect_ebreak;

logic [11:0]                imm12;
logic [4:0]                 rs1;
logic [4:0]                 rd;
logic [31:0]                gpr_ld_inst;
logic [31:0]                gpr_sw_inst;
logic [31:0]                cmd_jump_inst;
logic [31:0]                command_inst;
logic                       abstract_command_rd;
logic                       abstract_command_wr;

logic                       dmi_rsp_rd_vld;
logic                       dmi_rsp_state_vld;
logic                       dm_execute_success;
logic                       dm_execute_exception;
logic                       dm_busy;

logic                       debug_ram_wr;
logic                       debug_ram_cs;
logic [3:0]                 debug_ram_addr;
logic [31:0]                debug_ram_din;
logic [31:0]                debug_ram_dout;
logic                       debug_rom_en;
logic                       debug_ram_en;
logic                       debug_rom_sel_en;
logic                       debug_ram_sel_en;

logic                       debug_inst_rd_en;

logic [HART_NUM_MAX-1:0]    hart_unavail;
logic [HART_NUM_MAX-1:0]    hart_avail_sel;
logic [HART_NUM_MAX-1:0]    hart_running;
logic [HART_NUM_MAX-1:0]    hart_running_sel;
logic [HART_NUM_MAX-1:0]    hart_resume_sel;
logic [HART_NUM_MAX-1:0]    hartsel_o;

dmstatus_t                  dmstatus_reg;
dmcontrol_t                 dmcontrol_reg;

hart_state_t                hart_state_reg;
hart_info_t                 hart_info_reg;
abstractcs_t                abstractcs_reg;
command_t                   command_reg;

sbcs_t                      sbcs_reg;

logic [INST_WIDTH-1:0]      command_inst0;
logic [INST_WIDTH-1:0]      command_inst1;
logic [INST_WIDTH-1:0]      command_inst2;
logic                       command_abstract_end;

logic                       hart_halted_state;
logic                       hart_resume_state;
logic                       hart_running_state;

logic                       command_size_err;
//system bus access interface 

logic [1:0]     bus_state , bus_next_state;
logic           sb_access_busy;
logic           sbcs_wr;
logic [31:0]    sbaddress0_reg;
logic [31:0]    sbaddress1_reg;
logic [31:0]    sbaddress2_reg;
logic [31:0]    sbaddress3_reg;
logic [31:0]    sbdata0_reg;
logic [31:0]    sbdata1_reg;
logic [31:0]    sbdata2_reg;
logic [31:0]    sbdata3_reg;

logic           sbreadonaddr_en;
logic           sbreadonaddr_rd;

logic           sbreadondata_rden;
logic           sbreadondata_rd;
logic           sbreadondata_wren;
logic           sbreadondata_wr;
logic           sbaddr_rd;
logic           sbaddr_wr;

logic           sbaddr_req_handshake;
logic           sbaddr_ack_handshake;

/*=====================================================*/
/*                    DMI signals process              */
/*=====================================================*/

assign dm_reg_wr    = dmi_req_vld && dmi_req_rdy && (dmi_req_op[1:0] == OP_WRITE);
assign dm_reg_rd    = dmi_req_vld && dmi_req_rdy && (dmi_req_op[1:0] == OP_READ);

assign lsu_reg_wr   = debug_lsu_req_vld && debug_lsu_req_rdy && (debug_lsu_req_opcode == TOY_BUS_WRITE);
assign lsu_reg_rd   = debug_lsu_req_vld && debug_lsu_req_rdy && (debug_lsu_req_opcode == TOY_BUS_READ); 

assign debug_lsu_req_rdy = 1'b1;

assign dmi_req_rdy  = (dm_state != DM_GOING) && (dm_state != DM_RESUME) 
                        && (dm_state != DM_EXCEPTION);

//assign dm_rst_n = dm_rst_n_ext && dm_rst_n_act;
/*=====================================================*/
/*                     flag register                   
this register indicate when to execute/resume the command,
                    set by jtag, clear by dm           */
/*=====================================================*/

logic debug_going_req;
logic debug_resume_req;

// write command register trigger the going req
assign debug_going_req      = command_ready;

/*=====================================================*/
/*                  hart state register                */
/*=====================================================*/
wire                   state_flag_wr ;
wire                   state_flag_addr;
wire [31:0]            hart_exception_flag;

//assign state_flag_wr = lsu_reg_wr && (debug_lsu_req_addr[31:16] == DEBUG_LSU_BASE_ADDR);
assign state_flag_wr = lsu_reg_wr;
// Halted register

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        hart_state_reg.halt[31:0] <= 'b0;
    else if(state_flag_wr && (debug_lsu_req_addr[11:0] == HALT_ADDR))  //set and clr
        hart_state_reg.halt[31:0] <= debug_lsu_req_data[31:0];
end

assign debug_halt_ack[HART_NUM_MAX-1:0] = hart_state_reg.halt[HART_NUM_MAX-1:0];

// Going

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        hart_state_reg.going[31:0] <= 'b0;
    else if(state_flag_wr && (debug_lsu_req_addr[11:0] == GOING_ADDR))   //clear this bit
        hart_state_reg.going[31:0] <= debug_lsu_req_data[31:0];
    else if(debug_going_req)                                            //set which hart will execute command
        hart_state_reg.going[31:0] <= {{31{1'b0}},1'b1};
end

// Resume

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        hart_state_reg.resume[31:0] <= 'b0;
    else if(state_flag_wr && (debug_lsu_req_addr[11:0] == RESUME_ADDR))  //clear
        hart_state_reg.resume[31:0] <= debug_lsu_req_data[31:0];
    else if(debug_resume_req) //set
        hart_state_reg.resume[31:0] <= {{31{1'b0}},1'b1};  
end

// resume 1 cycle delay
always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        hart_state_resume_1d[31:0] <= 'b0;
    else 
        hart_state_resume_1d[31:0] <= hart_state_reg.resume[31:0];
end

assign hart_resume_ack = ~hart_state_reg.resume[0] && hart_state_resume_1d[0];  //resume acl pluse

// Exception

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        hart_state_reg.exception[31:0] <= 'b0;
    else if(dm_state[2:0] == DM_EXCEPTION) //clear TODO
        hart_state_reg.exception[31:0] <= 'b0;
    else if(state_flag_wr && (debug_lsu_req_addr[11:0] == EXCEP_ADDR))  //set
        hart_state_reg.exception[31:0] <= debug_lsu_req_data[31:0];
end

assign hart_exception_flag[31:0] = hart_state_reg.exception;

/*=====================================================*/
/*                    dmstatus register                */
/*=====================================================*/
assign hart_halted_state  = (dm_state == DM_HALTED);
assign hart_resume_state  = (dm_state == DM_RESUME);
assign hart_running_state = (dm_state == DM_IDLE);

//dmstatus, sw read-only in all fields
assign dmstatus_reg.unused1         = 7'b0;
assign dmstatus_reg.stickyunavail   = 1'b0;
assign dmstatus_reg.impebreak       = 1'b0; //open the ebreak at the end of the ptogbuf implictly
assign dmstatus_reg.unused0         = 2'b0;
assign dmstatus_reg.allnonexistent  = 1'b0;
assign dmstatus_reg.anynonexistent  = 1'b0;
//assign dmstatus_reg.allunavail      = 1'b0;
//assign dmstatus_reg.anyunavail      = 1'b0;
assign dmstatus_reg.authenticated   = 1'b1; //don't need authenticated
assign dmstatus_reg.authbusy        = 1'b0;
assign dmstatus_reg.hasresethaltreq = 1'b0; //don't support halt-on-reset
assign dmstatus_reg.confstrptrvalid = 1'b0; //don't support system bus
assign dmstatus_reg.version         = 4'd2; //DM conforms th version 1.0 for debug spec

//assign ndmresetpending_wr_en = ;

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmstatus_reg.ndmresetpending <= 1'b0;
    else if(!dm_rst_n_act)
        dmstatus_reg.ndmresetpending <= 1'b0;
    else if(~dmcontrol_reg.ndmreset)
        dmstatus_reg.ndmresetpending <= 1'b0;
    else if(dmcontrol_reg.ndmreset)
        dmstatus_reg.ndmresetpending <= 1'b1;
end

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmstatus_reg.allhavereset <= 1'b0;
    else if(!dm_rst_n_act)
        dmstatus_reg.allhavereset <= 1'b0;
    else if(clr_havereset)
        dmstatus_reg.allhavereset <= 1'b0;
    else if(hart_havereset)
        dmstatus_reg.allhavereset <= 1'b1;
end

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmstatus_reg.anyhavereset <= 1'b0;
    else if(!dm_rst_n_act)
        dmstatus_reg.anyhavereset <= 1'b0;
    else if(clr_havereset)
        dmstatus_reg.anyhavereset <= 1'b0;
    else if(hart_havereset)
        dmstatus_reg.anyhavereset <= 1'b1 ;
end

//assign hart_resume[HART_NUM_MAX-1:0]        = 20'h00001; //only support one hart into debug mode
//assign hart_resume_sel[HART_NUM_MAX-1:0]    = hart_state_reg.resume[HART_NUM_MAX-1:0] & hartsel_o;
assign hart_resume_sel[HART_NUM_MAX-1:0]    = hart_state_reg.resume[HART_NUM_MAX-1:0];

//always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
//    if(!dm_rst_n)
//        dmstatus_reg.allresumeack <= 1'b0;
//    else if(!dm_rst_n_act)
//        dmstatus_reg.allresumeack <= 1'b0;
//    else if(debug_resume_req || debug_resume_rel)
//        dmstatus_reg.allresumeack <= 1'b0;
//    //else if( (hart_resume_sel[HART_NUM_MAX-1:0] == 20'h0) && debug_resume_req)
//    //    dmstatus_reg.allresumeack <= 1'b0;
//    //else if( (hart_resume_sel[HART_NUM_MAX-1:0] == 20'h00001) && debug_resume_req)
//    //    dmstatus_reg.allresumeack <= 1'b1;
//    else if( hart_resume_ack)
//        dmstatus_reg.allresumeack <= 1'b1;
//end
//
//always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
//    if(!dm_rst_n)
//        dmstatus_reg.anyresumeack <= 1'b0;
//    else if(!dm_rst_n_act)
//        dmstatus_reg.anyresumeack <= 1'b0;
//    else if(debug_resume_req || debug_resume_rel)
//        dmstatus_reg.anyresumeack <= 1'b0;
//    //else if( ( hart_resume_sel[HART_NUM_MAX-1:0] == 20'h0) && debug_resume_req)
//    //    dmstatus_reg.anyresumeack <= 1'b0;
//    //else if( ( | hart_resume_sel[HART_NUM_MAX-1:0]) && debug_resume_req)
//    //    dmstatus_reg.anyresumeack <= 1'b1;
//    else if( hart_resume_ack)
//        dmstatus_reg.anyresumeack <= 1'b1;
//end

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmstatus_reg.allresumeack <= 1'b0;
    else if(!dm_rst_n_act)
        dmstatus_reg.allresumeack <= 1'b0;
    else if(debug_resume_req || debug_resume_rel)
        dmstatus_reg.allresumeack <= 1'b0;
    else if( hart_resume_state)
        dmstatus_reg.allresumeack <= 1'b1;
end

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmstatus_reg.anyresumeack <= 1'b0;
    else if(!dm_rst_n_act)
        dmstatus_reg.anyresumeack <= 1'b0;
    else if(debug_resume_req || debug_resume_rel)
        dmstatus_reg.anyresumeack <= 1'b0;
    else if( hart_resume_state)
        dmstatus_reg.anyresumeack <= 1'b1;
end

assign hart_unavail[HART_NUM_MAX-1:0]       = 20'hffffe; //only support one hart into debug mode
assign hart_avail_sel[HART_NUM_MAX-1:0]   = (~hart_unavail[HART_NUM_MAX-1:0]) & hartsel_o;

//always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
//    if(!dm_rst_n)
//        dmstatus_reg.allunavail <= 1'b0;
//    else if(|hart_avail_sel[HART_NUM_MAX-1:0]) //at least one hart is avaliable
//        dmstatus_reg.allunavail <= 1'b0;
//    else if(hart_avail_sel[HART_NUM_MAX-1:0] == 20'h0) //all hart is unavaliable
//        dmstatus_reg.allunavail <= 1'b1;
//end

assign dmstatus_reg.allunavail = 1'b0;

//always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
//    if(!dm_rst_n)
//        dmstatus_reg.anyunavail <= 1'b0;
//    else if(hart_avail_sel[HART_NUM_MAX-1:0] == hartsel_o)
//        dmstatus_reg.anyunavail <= 1'b0;
//    else if(hart_avail_sel[HART_NUM_MAX-1:0] != hartsel_o)
//        dmstatus_reg.anyunavail <= 1'b1;
//end

assign dmstatus_reg.anyunavail = 1'b0;

assign hart_running[HART_NUM_MAX-1:0] = 20'h00001; //only support one hart into debug mode
assign hart_running_sel[HART_NUM_MAX-1:0] = hart_running[HART_NUM_MAX-1:0] & hartsel_o;

//always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
//    if(!dm_rst_n)
//        dmstatus_reg.allrunning <= 1'b0;
//    else if( |hart_state_reg.halt[HART_NUM_MAX-1:0])
//        dmstatus_reg.allrunning <= 1'b0;
//    else if(hart_running_sel[HART_NUM_MAX-1:0] != hartsel_o)
//        dmstatus_reg.allrunning <= 1'b0;
//    else if(hart_running_sel[HART_NUM_MAX-1:0] == hartsel_o)
//        dmstatus_reg.allrunning <= 1'b1;
//end
//
//always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
//    if(!dm_rst_n)
//        dmstatus_reg.anyrunning <= 1'b0;
//    else if( |hart_state_reg.halt[HART_NUM_MAX-1:0])
//        dmstatus_reg.anyrunning <= 1'b0;
//    else if(hart_running_sel[HART_NUM_MAX-1:0] == 20'h0)
//        dmstatus_reg.anyrunning <= 1'b0;
//    else if(|hart_running_sel[HART_NUM_MAX-1:0])
//        dmstatus_reg.anyrunning <= 1'b1;
//end
always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmstatus_reg.allrunning <= 1'b0;
    else if(~sys_rst_n || ~dm2hart_rst_n)
        dmstatus_reg.allrunning <= 1'b0;
    else if(hart_halted_state)
        dmstatus_reg.allrunning <= 1'b0;
    else if(hart_running_state)
        dmstatus_reg.allrunning <= 1'b1;
end

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmstatus_reg.anyrunning <= 1'b0;
    else if(~sys_rst_n || ~dm2hart_rst_n)
        dmstatus_reg.anyrunning <= 1'b0;
    else if(hart_halted_state)
        dmstatus_reg.anyrunning <= 1'b0;
    else if(hart_running_state)
        dmstatus_reg.anyrunning <= 1'b1;
end

logic [HART_NUM_MAX-1:0] hart_halted_sel;

//assign debug_halt_en                     = |debug_halt_ack[HART_NUM_MAX-1:0];
assign hart_halted_sel[HART_NUM_MAX-1:0] = debug_halt_ack[HART_NUM_MAX-1:0] & hartsel_o;

//always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
//    if(!dm_rst_n)
//        dmstatus_reg.allhalted <= 1'b0;
//    else if(!dm_rst_n_act)
//        dmstatus_reg.allhalted <= 1'b0;
//    else if(debug_end)
//        dmstatus_reg.allhalted <= 1'b0;
//    else if( (hart_halted_sel[HART_NUM_MAX-1:0] != hartsel_o) && debug_halt_int)  //TODO
//        dmstatus_reg.allhalted <= 1'b0;
//    else if( (hart_halted_sel[HART_NUM_MAX-1:0] == hartsel_o) && debug_halt_int)
//        dmstatus_reg.allhalted <= 1'b1;
//end
//
//always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
//    if(!dm_rst_n)
//        dmstatus_reg.anyhalted <= 1'b0;
//    else if(!dm_rst_n_act)
//        dmstatus_reg.anyhalted <= 1'b0;
//    else if(debug_end)
//        dmstatus_reg.anyhalted <= 1'b0;
//    else if( (hart_halted_sel[HART_NUM_MAX-1:0] == {HART_NUM_MAX{1'b0}}) && debug_halt_int) //TODO
//        dmstatus_reg.anyhalted <= 1'b0;
//    else if( (|hart_halted_sel[HART_NUM_MAX-1:0]) && debug_halt_int)
//        dmstatus_reg.anyhalted <= 1'b1;
//end

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmstatus_reg.allhalted <= 1'b0;
    else if(!dm_rst_n_act)
        dmstatus_reg.allhalted <= 1'b0;
    else if(hart_running_state)
        dmstatus_reg.allhalted <= 1'b0;
    else if(hart_halted_state)  //TODO
        dmstatus_reg.allhalted <= 1'b1;
end

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmstatus_reg.anyhalted <= 1'b0;
    else if(!dm_rst_n_act)
        dmstatus_reg.anyhalted <= 1'b0;
    else if(hart_running_state)
        dmstatus_reg.anyhalted <= 1'b0;
    else if(hart_halted_state) //TODO
        dmstatus_reg.anyhalted <= 1'b1;
end
/*=====================================================*/
/*                    dmcontrol register                */
/*=====================================================*/
assign dmcontrol_wr = (dmi_req_addr == DM_CSR_DMCONTROL);

//haltreq
always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmcontrol_reg.haltreq <= 1'b0;
    else if(!dm_rst_n_act)
        dmcontrol_reg.haltreq <= 1'b0;    
    else if(dm_reg_wr && dmcontrol_wr)
        dmcontrol_reg.haltreq <= dmi_req_data[31];
end

assign debug_halt_int = dmcontrol_reg.haltreq;

//resumereq
//assign clr_resume_req = state_flag_wr && (debug_lsu_req_addr[11:0] == RESUME_ADDR); //clear resume state flag

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmcontrol_reg.resumereq <= 1'b0;
    else if(!dm_rst_n_act)
        dmcontrol_reg.resumereq <= 1'b0;
    else if(dm_reg_wr && dmcontrol_wr && ~dmcontrol_reg.haltreq)   //haltreq is 1 ,ignore the resumereq
        dmcontrol_reg.resumereq <= dmi_req_data[31] ? dmcontrol_reg.resumereq: dmi_req_data[30];
end

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin : blockName
    if(!dm_rst_n)
        resumereq_1d <= 1'b0;
    else
        resumereq_1d <= dmcontrol_reg.resumereq;
end

assign debug_resume_req = dmcontrol_reg.resumereq && ~resumereq_1d;
assign debug_resume_rel = ~dmcontrol_reg.resumereq && resumereq_1d;

//hartreset dm2reset_core_n

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin 
    if(!dm_rst_n)
        dmcontrol_reg.hartreset <= 1'b0;
    else if(!dm_rst_n_act)
        dmcontrol_reg.hartreset <= 1'b0;
    else if(clr_havereset)
        dmcontrol_reg.hartreset <= 1'b0;
    else if(dm_reg_wr && dmcontrol_wr)  //hartreset is 1 to reset the select hart, is 0 to deassert the hart
        dmcontrol_reg.hartreset <= dmi_req_data[29];    
end

assign dm2hart_rst_n = ~dmcontrol_reg.hartreset;

//ackhavereset, clear havereset for any selected harts

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmcontrol_reg.ackhavereset <= 1'b0;
    else if(!dm_rst_n_act)
        dmcontrol_reg.ackhavereset <= 1'b0;
    //else if(dmcontrol_reg.ackhavereset)
    //    dmcontrol_reg.ackhavereset <= 1'b0;
    else if(dm_reg_wr && dmcontrol_wr)
        dmcontrol_reg.ackhavereset <= dmi_req_data[28];
end

assign clr_havereset = dmcontrol_reg.ackhavereset;

//ackunavail
assign dmcontrol_reg.ackunavail = 1'b0;

//hasel, we don't impl the hartarray mask register,this value must tie 0
assign dmcontrol_reg.hasel = 1'b0;

//always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
//    if(!dm_rst_n)
//        dmcontrol_reg.hasel <= 1'b0;
//    else if(!dm_rst_n_act)
//        dmcontrol_reg.hasel <= 1'b0;
//    else if(dm_reg_wr && dmcontrol_wr)
//        dmcontrol_reg.hasel <= dmi_req_data[26];  //single hart is 0, multipy hart is 1
//end

//hartsello and hartsell1
always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)begin
        dmcontrol_reg.hartsello <= 10'b0;
        dmcontrol_reg.hartselhi <= 10'b0;
    end
    else if(!dm_rst_n_act)begin
        dmcontrol_reg.hartsello <= 10'b0;
        dmcontrol_reg.hartselhi <= 10'b0;
    end
    else if(dm_reg_wr && dmcontrol_wr)begin
        dmcontrol_reg.hartsello <= hart_running[HART_NUM_MAX-1 -10 :  0] & dmi_req_data[25:16];
        dmcontrol_reg.hartselhi <= hart_running[HART_NUM_MAX-1    -: 10] & dmi_req_data[15:6] ;
    end
end

assign hartsel_o[HART_NUM_MAX-1:0] = {dmcontrol_reg.hartselhi,dmcontrol_reg.hartsello};

//set single hart debug
//single hart对应hartsello[0]
//assign hart_sel_en = dmcontrol_reg.hartsello[0];

//setkeepalive and clrkeeoalive
assign dmcontrol_reg.setkeepalive = 1'b0;
assign dmcontrol_reg.clrkeepalive = 1'b0;

//setresethaltreq and clrresethaltreq
assign dmcontrol_reg.setresethaltreq = 1'b0;
assign dmcontrol_reg.clrresethaltreq = 1'b0;

//ndmreset
always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmcontrol_reg.ndmreset <= 1'b0;
    else if(!dm_rst_n_act)
        dmcontrol_reg.ndmreset <= 1'b0;
    else if(dm_reg_wr && dmcontrol_wr)
        dmcontrol_reg.ndmreset <= dmi_req_data[1];  //reset all hardware platform
end

assign sys_rst_n = ~dmcontrol_reg.ndmreset;

//dmactive
always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmcontrol_reg.dmactive <= 1'b0;
    else if(dm_reg_wr && dmcontrol_wr)
        dmcontrol_reg.dmactive <= dmi_req_data[0];  //reset debug module
end

assign dm_rst_n_act = dmcontrol_reg.dmactive;
//sw reset
//genvar i;
//generate
//    for(i=0;i<CORE_NUM;i=i+1)begin
//        if(dmcontrol_reg.hartreset)
//            assign dm2reset_core_n[i] = dmcontrol_reg.hartsello[i] ? 1'b0 : 1'b1;
//        else if(dmcontrol_reg.ndmreset)
//            assign dm2reset_core_n[i] = 1'b0;
//        else 
//            assign dm2reset_core_n[i] = 1'b1;
//    end
//endgenerate

//always_comb begin
//        if(dmcontrol_reg.hartreset)
//            dm2reset_core_n = ~dmcontrol_reg.hartsello;
//        else if(dmcontrol_reg.ndmreset)
//            dm2reset_core_n = {(CORE_NUM){1'b0}};
//        else 
//            dm2reset_core_n = {(CORE_NUM){1'b1}};
//end

/*=====================================================*/
/*           hart_info register(read-only)             */
/*=====================================================*/
//assign dmhartinfo_wr = (dmi_req_addr == DM_CSR_HARTINFO);

assign hart_info_reg.unused1    = 8'b0;
assign hart_info_reg.unused0    = 8'b0;
assign hart_info_reg.nscratch   = 4'b1;
assign hart_info_reg.dataaccess = 1'b1;  // data registe are shadowed in the hart memory map
assign hart_info_reg.datasize   = 4'd1;  //data register can be used for hart memory map
assign hart_info_reg.dataaddr   = 12'h400;  //TODO

/*=====================================================*/
/*                      DM state FSM                   */
/*=====================================================*/

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n || !sys_rst_n)
        dm_state[2:0] <= DM_IDLE;
    else
        dm_state[2:0] <= dm_next_state[2:0];
end

always_comb begin
    dm_next_state[2:0] = DM_IDLE;
    case(dm_state[2:0])
        DM_IDLE:    
        begin
            if( | hart_state_reg.halt[31:0] )
                dm_next_state[2:0] = DM_HALTED;
            else
                dm_next_state[2:0] = DM_IDLE;
        end
        DM_HALTED:
        begin
            if(command_ready)
                dm_next_state[2:0] = DM_GOING;
            else if( | hart_state_reg.resume[31:0] )
                dm_next_state[2:0] = DM_RESUME;
            else
                dm_next_state[2:0] = DM_HALTED;
        end
        DM_GOING:
        begin
            if(execute_end)  //TODO
                dm_next_state[2:0] = DM_HALTED;
            else if( | hart_exception_flag[31:0] )
                dm_next_state[2:0] = DM_EXCEPTION;
            else if( | hart_state_reg.resume[31:0] )
                dm_next_state[2:0] = DM_RESUME;
            else 
                dm_next_state[2:0] = DM_GOING;
        end
        DM_RESUME:
        begin
            if(hart_resume_ack)
                dm_next_state = DM_IDLE;
            else 
                dm_next_state = DM_RESUME;
        end
        DM_EXCEPTION:
        begin
            if(~ (|hart_exception_flag[31:0]) )
                dm_next_state[2:0] = DM_HALTED;
            else 
                dm_next_state[2:0] = DM_EXCEPTION;
        end
        default: dm_next_state = DM_IDLE;
    endcase    
end

assign command_end_cond = ( (cmd_state == CMD_TRANSFER) && (cmd_next_state == CMD_IDLE) ) ;  
assign prog_buff_end_cond = ( (cmd_state == CMD_PROGBUF) && (cmd_next_state == CMD_IDLE)  )  ;  //only for command execute, without program buffer

assign execute_end = command_end_cond || prog_buff_end_cond ;

assign debug_end   = (dm_state == DM_RESUME) && (dm_next_state == DM_IDLE);

/*=====================================================*/
/*                    abstractcs register              */
/*=====================================================*/
assign abstractcs_wr            = (dmi_req_addr == DM_CSR_ABSTRACTCS);

assign abstractcs_reg.unused2   = 3'b0;
assign abstractcs_reg.unused1   = 11'b0;
assign abstractcs_reg.unused0   = 4'b0;
//program buffer size. read-only
assign abstractcs_reg.progbufsize = 5'd16;

//busy. read-only
always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        abstractcs_reg.busy <= 1'b0;
    else if( (dm_state == DM_IDLE) || (dm_state == DM_HALTED) )
        abstractcs_reg.busy <= 1'b0;
    else if( (dm_state == DM_GOING) || (dm_state == DM_RESUME) || (dm_state == DM_EXCEPTION))
        abstractcs_reg.busy <= 1'b1;
end

//relaxedpriv. WARL
always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        abstractcs_reg.relaxedpriv <= 1'b0;
    else if( dm_reg_wr && abstractcs_wr)
        abstractcs_reg.relaxedpriv <= dmi_req_data[11];
end

//cmderr. R/W1C
always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        abstractcs_reg.cmderr <= 3'b0;
    else if( dm_reg_wr && abstractcs_wr && (dmi_req_data[10:8] == 3'b111) )
        abstractcs_reg.cmderr <= 3'b0;
    else if(execute_end)
        abstractcs_reg.cmderr <= 3'b0;
    else if( (abstractcs_reg.cmderr == 3'b0) && ( (dm_state == DM_GOING) ||(dm_state == DM_RESUME)) )
        abstractcs_reg.cmderr <= 3'b1;
    else if((dm_state == DM_EXCEPTION))
        abstractcs_reg.cmderr <= 3'd3;
end

//datacount. read-only
assign abstractcs_reg.datacount = 4'd1;

/*=====================================================*/
/*                    command register
               only support access register 
                        only write                     */
/*=====================================================*/
wire command_wr;

assign command_wr    = (dmi_req_addr == DM_CSR_COMMAND);
assign command_ready = dm_reg_wr && command_wr;

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        command_reg <= 'b0;
    else if( dm_reg_wr && command_wr)
        command_reg <= dmi_req_data[31:0];
end

/*=====================================================*/
/*                    Command FSM                      */
/*=====================================================*/

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n || !sys_rst_n)
        cmd_state[2:0] <= CMD_IDLE;
    else
        cmd_state[2:0] <= cmd_next_state[2:0];
end

always_comb begin
    cmd_next_state[2:0] = CMD_IDLE;
    case(cmd_state[2:0])
        CMD_IDLE :
        begin
            if(dm_state == DM_GOING)
                cmd_next_state[2:0] = CMD_TRANSFER;
            else 
                cmd_next_state[2:0] = CMD_IDLE;
        end
        CMD_TRANSFER:
        begin
            if(command_abstract_end && ~command_reg.postexec && debug_inst_rd_en && debug_command_en)
                cmd_next_state[2:0] = CMD_IDLE;
            else if(command_abstract_end && command_reg.postexec && debug_inst_rd_en && debug_command_en)
                cmd_next_state[2:0] = CMD_PROGBUF;
            else 
                cmd_next_state[2:0] = CMD_TRANSFER;
        end
        CMD_PROGBUF :
        begin
            if(detect_ebreak || (| hart_exception_flag[31:0]))
                cmd_next_state[2:0] = CMD_IDLE;
            else 
                cmd_next_state[2:0] = CMD_PROGBUF;
        end
        default : cmd_next_state[2:0] = CMD_IDLE;
    endcase
end

assign detect_ebreak = (debug_ram_dout[31:0] == EBREAK) && debug_inst_ack_vld && (cmd_state == CMD_PROGBUF);
/*=====================================================*/
/*           Abstract register decode                  */
/*=====================================================*/
//assign abstract_command_rd = (cmd_state==CMD_TRANSFER) && command_reg.transfer && ~command_reg.write; //sw, from GPR to data reg
//assign abstract_command_wr = (cmd_state==CMD_TRANSFER) && command_reg.transfer && command_reg.write;  //ld, from data reg to GPR
assign nop_abstract_cmd    = (cmd_state==CMD_TRANSFER) && ~command_reg.transfer; // only exectue progbuff

//// jump to progbuf cmd is jal x0,0x7fd0_706f (offset is relative to 0x2000_0004)
assign cmd_jump_inst[INST_WIDTH-1:0]      = 32'h7f90_706f;

access_reg_decode u_access_reg_decode(
    .abstract_command       (command_reg        ),
    //.abstract_command_en    (abstract_command_en),
    .access_reg_inst0       (command_inst0   ),
    .access_reg_inst1       (command_inst1   ),
    .command_size_err       (command_size_err)
);

assign command_inst2[INST_WIDTH-1:0]  = command_reg.postexec ? cmd_jump_inst : EBREAK;

assign command_abstract_end = debug_command_en && (debug_inst_req_addr[11:0]==12'd2);

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        command_inst[INST_WIDTH-1:0]  <= NOP;
    else if(debug_command_en)
        case(debug_inst_req_addr[11:0])
            12'd0:  command_inst[INST_WIDTH-1:0]  <= command_inst0[INST_WIDTH-1:0];
            12'd1:  command_inst[INST_WIDTH-1:0]  <= command_inst1[INST_WIDTH-1:0];
            12'd2:  command_inst[INST_WIDTH-1:0]  <= command_inst2[INST_WIDTH-1:0];
            default:command_inst[INST_WIDTH-1:0]  <= NOP;
        endcase
end

/*=====================================================*/
/*                    DATA register                    */
/*=====================================================*/
logic [31:0] data0_reg;

assign data0_wr    = (dmi_req_addr == DM_CSR_DATA0) || (debug_lsu_req_addr[11:0]==DATA_REG_ADDR);

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        data0_reg[31:0] <= 'b0;
    else if( dm_reg_wr  && data0_wr)  //jtag write
        data0_reg[31:0] <= dmi_req_data[31:0];
    else if( lsu_reg_wr && data0_wr)  //lsu write
        data0_reg[31:0] <= debug_lsu_req_data[31:0];
end

/*=====================================================*/
/*                    debug rom                        */
/*=====================================================*/
wire [ADDR_WIDTH-1:0]   debug_rom_addr;
wire [31:0]                 debug_rom_dout;

assign debug_rom_addr[ROM_ADDR_WIDTH-1:0] = debug_inst_req_addr[ROM_ADDR_WIDTH-1:0]; 

/*=====================================================*/
/*                    Test MEM                        */
/*=====================================================*/

    `ifdef DEBUG_ROM_TEST 
    logic debug_rom_rd_en;

    toy_mem_model #(
        .ARGPARSE_KEY   ("ROM_HEX"                  ),
        .ADDR_WIDTH     (ROM_ADDR_WIDTH             ),
        .DATA_WIDTH     (BUS_DATA_WIDTH         ))
    u_toy_debug_rom (
        .clk            (dm_clk                    ),
        .en             (debug_rom_rd_en            ),
        .addr           (debug_rom_addr[ROM_ADDR_WIDTH-1:0]      ),
        .rd_data        (debug_rom_dout[BUS_DATA_WIDTH-1:0]      ),
        .wr_data        (32'b0       ),
        .wr_byte_en     (4'b0    ),
        .wr_en          (1'b0    ));

    assign debug_rom_rd_en = debug_rom_en && debug_inst_rd_en;

    `endif

    `ifdef FPGA_SIM

        //dm_debug_rom u_debug_rom (
        //   .clk      (dm_clk),
        //   .rom_addr (debug_rom_addr[ROM_ADDR_WIDTH-1:0]),
        //   .rom_dout (debug_rom_dout[31:0]) 
        // );

        dm_debug_rom u_debug_rom (
            .a      (debug_rom_addr[ROM_ADDR_WIDTH-1:0]),      // input wire [5 : 0] a
            .spo    (debug_rom_dout[31:0])  // output wire [31 : 0] spo
        );

    `endif 

/*=====================================================*/
/*                      debug ram                      */
/*=====================================================*/

//debug ram/rom enable signals 
assign debug_command_en     = (debug_inst_req_addr[31:16] == DEBUG_INST_RAM_BASE) && (debug_inst_req_addr[15:12] == DEBUG_COMMADN_BASE);
assign debug_rom_en         = debug_inst_req_addr[31:16] == DEBUG_INST_ROM_BASE;
assign debug_ram_en         = (debug_inst_req_addr[31:16] == DEBUG_INST_RAM_BASE)  && (debug_inst_req_addr[15:12] == DEBUG_PROGBUF_BASE);

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)begin
        debug_rom_sel_en <= 1'b0;
        debug_ram_sel_en <= 1'b0;
    end else begin
        debug_rom_sel_en <= debug_rom_en;
        debug_ram_sel_en <= debug_ram_en || debug_command_en;  //progbuff and abstract command
    end
end

assign dmi_ram_en           = dmi_req_addr[7:4] == DMI_PROGBUF_BASE;

//assign debug_inst_req_rdy   = (cmd_state != CMD_IDLE) ;
assign debug_inst_req_rdy   = 1'b1;

assign debug_inst_rd_en     = debug_inst_req_vld && debug_inst_req_rdy 
                                && (debug_inst_req_opcode==TOY_BUS_READ);

assign debug_ram_rd = (debug_inst_rd_en && debug_ram_en && (cmd_state == CMD_PROGBUF) ) || (dm_reg_rd && dmi_ram_en);
//assign debug_ram_wr = dm_reg_wr && (dmi_req_addr[7:4] == DM_CSR_PROGBUF0[7:4]);
assign debug_ram_wr = dm_reg_wr && (dmi_req_addr[7:4] == 4'h2);
assign debug_ram_cs = debug_ram_wr || debug_ram_rd;

assign debug_ram_din  = dmi_req_data[31:0]; 
assign debug_ram_addr = dmi_ram_en ? dmi_req_addr[3:0] :
                            debug_ram_en ? debug_inst_req_addr[3:0] : 4'd0;

  debug_ram #(
    .SRAM_DEPTH (16)
  )u_debug_ram(
    .clk      (dm_clk),
    .rst_n    (dm_rst_n), 
    .ram_cs   (debug_ram_cs),
    .ram_wr_en(debug_ram_wr),
    .ram_addr (debug_ram_addr),
    .ram_wdat (debug_ram_din),
    .ram_dout (debug_ram_dout) 
  );

//debug instruction read debug ram/rom

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        debug_inst_ack_vld <= 1'b0;
    else
        debug_inst_ack_vld <= debug_inst_rd_en;
end

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        debug_inst_command_ack_vld <= 1'b0;
    else
        debug_inst_command_ack_vld <= (cmd_state== CMD_TRANSFER) && debug_command_en && debug_inst_rd_en;
end


always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        debug_inst_progbuf_ack_vld <= 1'b0;
    else
        debug_inst_progbuf_ack_vld <= (cmd_state== CMD_PROGBUF) && debug_ram_en && debug_inst_rd_en;
end

//assign debug_inst_ack_vld = debug_inst_command_ack_vld || debug_inst_progbuf_ack_vld || debug_inst_ebreak_ack_vld;

always_comb begin
    debug_inst_ack_data[31:0] = NOP;
    if(debug_rom_sel_en)
        debug_inst_ack_data[31:0] = debug_rom_dout[31:0];
    else if(debug_ram_sel_en)begin
        if( debug_inst_command_ack_vld )  
            debug_inst_ack_data[31:0] = command_inst[31:0];
        else if( debug_inst_progbuf_ack_vld )
            debug_inst_ack_data[31:0] = debug_ram_dout[31:0];
    end
    else 
        debug_inst_ack_data[31:0] = NOP;
end

/*=====================================================*/
/*                      jtag read                      */
/*=====================================================*/
logic [31:0] dm_csr_rdata;

always_comb begin
    dm_csr_rdata[31:0] = 32'h0;
    case(dmi_req_addr)
        DM_CSR_DATA0       :  dm_csr_rdata[31:0] = data0_reg[31:0];
        //DM_CSR_DATA1       :  dm_csr_rdata[31:0] = dm_flag_reg[31:0];  //TODO
        DM_CSR_DATA1       :  dm_csr_rdata[31:0] = 32'h0;
        DM_CSR_DATA2       :  dm_csr_rdata[31:0] = 32'h0;
        DM_CSR_DATA3       :  dm_csr_rdata[31:0] = 32'h0;
        DM_CSR_DATA4       :  dm_csr_rdata[31:0] = 32'h0;
        DM_CSR_DATA5       :  dm_csr_rdata[31:0] = 32'h0;
        DM_CSR_DATA6       :  dm_csr_rdata[31:0] = 32'h0;
        DM_CSR_DATA7       :  dm_csr_rdata[31:0] = 32'h0;
        DM_CSR_DATA8       :  dm_csr_rdata[31:0] = 32'h0;
        DM_CSR_DATA9       :  dm_csr_rdata[31:0] = 32'h0;
        DM_CSR_DATA10      :  dm_csr_rdata[31:0] = 32'h0;
        DM_CSR_DATA11      :  dm_csr_rdata[31:0] = 32'h0;
        DM_CSR_DMCONTROL   :  dm_csr_rdata[31:0] = dmcontrol_reg[31:0];
        DM_CSR_DMSTATUS    :  dm_csr_rdata[31:0] = dmstatus_reg[31:0];
        DM_CSR_HARTINFO    :  dm_csr_rdata[31:0] = hart_info_reg[31:0];
        DM_CSR_HALTSUM1    :  dm_csr_rdata[31:0] = 32'h0;
        DM_CSR_HAWINDOWSEL :  dm_csr_rdata[31:0] = 32'h0;
        DM_CSR_HAWINDOW    :  dm_csr_rdata[31:0] = 32'h0;
        DM_CSR_ABSTRACTCS  :  dm_csr_rdata[31:0] = abstractcs_reg[31:0];
        DM_CSR_COMMAND     :  dm_csr_rdata[31:0] = command_reg[31:0];
        DM_CSR_ABSTRACTAUTO:  dm_csr_rdata[31:0] = 32'h0;
        DM_CSR_PROGBUF0    :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];//dmi read debug ram
        DM_CSR_PROGBUF1    :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];
        DM_CSR_PROGBUF2    :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];
        DM_CSR_PROGBUF3    :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];
        DM_CSR_PROGBUF4    :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];
        DM_CSR_PROGBUF5    :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];
        DM_CSR_PROGBUF6    :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];
        DM_CSR_PROGBUF7    :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];
        DM_CSR_PROGBUF8    :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];
        DM_CSR_PROGBUF9    :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];
        DM_CSR_PROGBUF10   :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];
        DM_CSR_PROGBUF11   :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];
        DM_CSR_PROGBUF12   :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];
        DM_CSR_PROGBUF13   :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];
        DM_CSR_PROGBUF14   :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];
        DM_CSR_PROGBUF15   :  dm_csr_rdata[31:0] = debug_ram_dout[31:0];
        
        DM_CSR_SBADDRESS3  :  dm_csr_rdata[31:0] = sbaddress3_reg[31:0];
        DM_CSR_SBCS        :  dm_csr_rdata[31:0] = sbcs_reg[31:0];
        DM_CSR_SBADDRESS0  :  dm_csr_rdata[31:0] = sbaddress0_reg[31:0];
        DM_CSR_SBADDRESS1  :  dm_csr_rdata[31:0] = sbaddress1_reg[31:0];
        DM_CSR_SBADDRESS2  :  dm_csr_rdata[31:0] = sbaddress2_reg[31:0];
        DM_CSR_SBDATA0     :  dm_csr_rdata[31:0] = sbdata0_reg[31:0];
        DM_CSR_SBDATA1     :  dm_csr_rdata[31:0] = sbdata1_reg[31:0];
        DM_CSR_SBDATA2     :  dm_csr_rdata[31:0] = sbdata2_reg[31:0];
        DM_CSR_SBDATA3     :  dm_csr_rdata[31:0] = sbdata3_reg[31:0];
        default            :  dm_csr_rdata[31:0] = 32'h0;
    endcase
end

assign dm_busy = (dm_state === DM_GOING) && (dm_state == DM_RESUME) ;

assign dm_execute_success   = (dm_next_state==DM_HALTED) && (dm_state==DM_GOING);
assign dm_execute_exception = (dm_next_state==DM_EXCEPTION) && (dm_state==DM_GOING);
//assign dm_execute_going     = (dm_next_state=DM_GOING)  && (dm_state==DM_HALTED);

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmi_rsp_rd_vld <= 1'b0;
    else
        dmi_rsp_rd_vld <= dm_reg_rd;
end

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        dmi_rsp_state_vld <= 1'b0;
    else if(dmi_rsp_vld && dmi_rsp_rdy)
        dmi_rsp_state_vld <= 1'b0;
    else if(dm_execute_success || dm_execute_exception || dm_busy)
        dmi_rsp_state_vld <= 1'b1;
end

assign dmi_rsp_vld          = dmi_rsp_state_vld || dmi_rsp_rd_vld;
assign dmi_rsp_data[31:0]   = dmi_rsp_state_vld ? 32'h0 : 
                                dmi_rsp_rd_vld ? dm_csr_rdata[31:0] : 32'h0;

always_comb begin
    dmi_rsp_op[1:0] = OP_SUCCESS;
    case(dm_state)
        DM_IDLE:        dmi_rsp_op[1:0] = OP_SUCCESS;
        DM_HALTED:      
            begin
                if(command_size_err)
                    dmi_rsp_op[1:0] = OP_FAIL;
                else 
                    dmi_rsp_op[1:0] = OP_SUCCESS;
            end
        DM_GOING :      dmi_rsp_op[1:0] = OP_BUSY;
        DM_RESUME:      dmi_rsp_op[1:0] = OP_BUSY;
        DM_EXCEPTION:   dmi_rsp_op[1:0] = OP_FAIL;
        default:        dmi_rsp_op[1:0] = OP_FAIL;
    endcase
end

/*=====================================================*/
/*               Hart read by lsu                      */
/*=====================================================*/
logic state_flag_rd;

// assign state_flag_rd    = lsu_reg_rd && (debug_lsu_req_addr[31:16] == DEBUG_LSU_BASE_ADDR);
assign state_flag_rd    = lsu_reg_rd ;
//assign lsu_data_reg_rd  = lsu_reg_rd && (debug_lsu_req_addr[31:16] == DEBUG_LSU_BASE_ADDR);

always_ff @( posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        debug_lsu_ack_vld <= 1'b1;
    else
        debug_lsu_ack_vld <= state_flag_rd && debug_lsu_ack_rdy;
end

always_ff @( posedge dm_clk ) begin
    if(state_flag_rd)begin
        case(debug_lsu_req_addr[11:0])
            HALT_ADDR:      debug_lsu_ack_data[31:0] <= hart_state_reg.halt;
            GOING_ADDR:     debug_lsu_ack_data[31:0] <= hart_state_reg.going;
            RESUME_ADDR:    debug_lsu_ack_data[31:0] <= hart_state_reg.resume;
            EXCEP_ADDR:     debug_lsu_ack_data[31:0] <= hart_state_reg.exception;
            DATA_REG_ADDR:  debug_lsu_ack_data[31:0] <= data0_reg;
            default:        debug_lsu_ack_data[31:0] <= 32'h0;
        endcase
    end
    else 
        debug_lsu_ack_data[31:0] <= 32'b0;
end


/*=====================================================*/
/*                system bus access 
                control and status register            */
/*=====================================================*/

assign sbcs_wr = (dmi_req_addr == DM_CSR_SBCS);

//sbversion
assign sbcs_reg.sbversion   = 3'd1;
assign sbcs_reg.unused      = 6'd0;

//sbbusyerror
always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        sbcs_reg.sbbusyerror <= 1'b0;
    else if( dm_reg_wr && sbcs_wr && dmi_req_data[22]) //W1C
        sbcs_reg.sbbusyerror <= 1'b0;
    else if( sb_access_busy && (sbaddr_rd || sbaddr_wr) )
        sbcs_reg.sbbusyerror <= 1'b1;
end

//sbbusy
assign sbcs_reg.sbbusy        = sb_access_busy;

//sbreadonaddr
always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        sbcs_reg.sbreadonaddr <= 1'b0;
    else if( dm_reg_wr && sbcs_wr)
        sbcs_reg.sbreadonaddr <= dmi_req_data[20];
end

//sbaccess
always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        sbcs_reg.sbaccess <= SB_SIZE32;
    else if( dm_reg_wr && sbcs_wr)
        sbcs_reg.sbaccess <= dmi_req_data[19:17];
end

//sbautoincrement
always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        sbcs_reg.sbautoincrement <= 1'b0;
    else if( dm_reg_wr && sbcs_wr)
        sbcs_reg.sbautoincrement <= dmi_req_data[16];
end

//sbreadondata
always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        sbcs_reg.sbreadondata <= 1'b0;
    else if( dm_reg_wr && sbcs_wr)
        sbcs_reg.sbreadondata <= dmi_req_data[15];
end

//sberror TODO
always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        sbcs_reg.sberror <= SB_NO_ERR;
    else if( dm_reg_wr && sbcs_wr && (dmi_req_data[14:12] == 3'd1) ) //W1C
        sbcs_reg.sberror <= SB_NO_ERR;
    //else if()
    //    sbcs_reg.sberror <= ;
end

assign sbcs_reg.sbasize     = 7'd32;
assign sbcs_reg.sbaccess128 = 1'b0;
assign sbcs_reg.sbaccess64  = 1'b0;
assign sbcs_reg.sbaccess32  = 1'b1;
assign sbcs_reg.sbaccess16  = 1'b0;
assign sbcs_reg.sbaccess8   = 1'b0;

/*=====================================================*/
/*             system bus address register             */
/*=====================================================*/

assign sbaddress0_wr = (dmi_req_addr == DM_CSR_SBADDRESS0);
assign sbaddress1_wr = (dmi_req_addr == DM_CSR_SBADDRESS1);

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        sbaddress0_reg[31:0] <= 31'b0;
    else if( dm_reg_wr && sbaddress0_wr && ~sb_access_busy)
        sbaddress0_reg[31:0] <= dmi_req_data;
    else if( sbaddr_req_handshake && sbcs_reg.sbautoincrement)
        sbaddress0_reg[31:0] <= sbaddress0_reg[31:0] + 32'd4; //based 32bit bus width
end

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        sbaddress1_reg[31:0] <= 31'b0;
    else if( dm_reg_wr && sbaddress1_wr && ~sb_access_busy)
        sbaddress1_reg[31:0] <= dmi_req_data;
    //else if( sbaddr_req_handshake && sbcs_reg.sbautoincrement)
    //    sbaddress0_reg[31:0] <= sbaddress0_reg[31:0] + 32'd4; //based 32bit bus width
end

assign sbaddress2_reg[31:0] = 32'b0;
assign sbaddress3_reg[31:0] = 32'b0;

/*=====================================================*/
/*               system bus data register              */
/*=====================================================*/

assign sbdata0_reg_en = (dmi_req_addr == DM_CSR_SBDATA0);
assign sbdata1_reg_en = (dmi_req_addr == DM_CSR_SBDATA1);

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        sbdata0_reg[31:0] <= 31'b0;
    else if( dm_reg_wr && sbdata0_reg_en )
        sbdata0_reg[31:0] <= dmi_req_data;
    else if( sbaddr_ack_handshake )
        sbdata0_reg[31:0] <= debug_sysbus_ack_data[31:0];
end

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        sbdata1_reg[31:0] <= 31'b0;
    else if( dm_reg_wr && sbdata1_reg_en )
        sbdata1_reg[31:0] <= dmi_req_data;
    //else if( debug_sysbus_ack_vld && debug_sysbus_ack_rdy )
    //    sbdata0_reg[31:0] <= debug_sysbus_ack_data[63:32];
end

assign sbdata2_reg[31:0] = 32'b0;
assign sbdata3_reg[31:0] = 32'b0;
/*=====================================================*/
/*                 system bus control logic            */
/*=====================================================*/

localparam ACCESS_BUS_IDLE  = 2'b00;
localparam ACCESS_BUS_READ  = 2'b01;
localparam ACCESS_BUS_WRITE = 2'b10;
//localparam ACCESS_BUS_ERROR = 2'b11;

always_ff @(posedge dm_clk or negedge dm_rst_n)begin
    if(!dm_rst_n)
        bus_state <= ACCESS_BUS_IDLE;
    else
        bus_state <= bus_next_state;
end

always_comb begin
    bus_next_state = ACCESS_BUS_IDLE;
    case(bus_state[1:0])
    ACCESS_BUS_IDLE     : 
        begin
            if(sbaddr_rd)
                bus_next_state = ACCESS_BUS_READ;
            else if(sbaddr_wr && ~sbaddr_req_handshake)
                bus_next_state = ACCESS_BUS_WRITE;
            else 
                bus_next_state = ACCESS_BUS_IDLE;
        end
    ACCESS_BUS_READ     :
        begin
            if(sbaddr_ack_handshake)
                bus_next_state = ACCESS_BUS_IDLE;
            else 
                bus_next_state = ACCESS_BUS_READ;
        end
    ACCESS_BUS_WRITE    :
        begin
            if(sbaddr_req_handshake)
                bus_next_state = ACCESS_BUS_IDLE;
            else 
                bus_next_state = ACCESS_BUS_WRITE;
        end
    //ACCESS_BUS_ERROR    : bus_next_state = ACCESS_BUS_IDLE;
    default             : bus_next_state = ACCESS_BUS_IDLE;
    endcase
end

/*=====================================================*/
/*                 system bus read                     */
/*=====================================================*/

//write sbaddress register will trigger a read req access to mem sys

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        sbreadonaddr_en <= 1'b0;
    else if(sbaddr_req_handshake)
        sbreadonaddr_en <= 1'b0;
    else if( dm_reg_wr && (sbaddress0_wr || sbaddress1_wr) && ~sb_access_busy) 
        sbreadonaddr_en <= 1'b1;
end

assign sbreadonaddr_rd = sbreadonaddr_en && sbcs_reg.sbreadonaddr ;

//read sbdata register will trigger a read req access to mem sys

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        sbreadondata_rden <= 1'b0;
    else if(sbaddr_req_handshake)
        sbreadondata_rden <= 1'b0;
    else if( dm_reg_rd && (sbdata0_reg_en || sbdata1_reg_en) && ~sb_access_busy) 
        sbreadondata_rden <= 1'b1;
end

assign sbreadondata_rd  = sbreadondata_rden && sbcs_reg.sbreadondata;
assign sbaddr_rd        = sbreadonaddr_rd || sbreadondata_rd;

/*=====================================================*/
/*                 system bus write                    */
/*=====================================================*/
//write sbdata register will trigger a write req access to mem sys

//assign sbreadonaddr_wr = sbreadonaddr_en && ~sbcs_reg.sbreadonaddr;

always_ff @(posedge dm_clk or negedge dm_rst_n ) begin
    if(!dm_rst_n)
        sbreadondata_wren <= 1'b0;
    else if(sbaddr_req_handshake)
        sbreadondata_wren <= 1'b0;
    else if( dm_reg_wr && (sbdata0_reg_en || sbdata1_reg_en) && ~sb_access_busy) 
        sbreadondata_wren <= 1'b1;
end

assign sbreadondata_wr  = sbreadondata_wren && ~sbcs_reg.sbreadondata;
assign sbaddr_wr        = sbreadondata_wr;

/*=====================================================*/
/*                 system bus req/ack                  */
/*=====================================================*/

assign sb_access_busy = (bus_state[1:0] != ACCESS_BUS_IDLE);

assign sbaddr_req_handshake         = debug_sysbus_req_rdy && debug_sysbus_req_vld;

assign debug_sysbus_req_vld         = sbaddr_rd || sbaddr_wr;
assign debug_sysbus_req_addr[31:0]  = sbaddress0_reg[31:0];
assign debug_sysbus_req_data[31:0]  = sbdata0_reg[31:0];
assign debug_sysbus_req_strb[3:0]   = 4'hf;
assign debug_sysbus_req_opcode      = sbaddr_rd ? TOY_BUS_READ :
                                        sbaddr_wr ? TOY_BUS_WRITE : TOY_BUS_READ;

assign debug_sysbus_ack_rdy         = 1'b1;
assign sbaddr_ack_handshake         = debug_sysbus_ack_vld && debug_sysbus_ack_rdy;

// DEBUG =========================================================================================================

    `ifdef TOY_SIM
    initial begin
        if($test$plusargs("DBG")) begin
            $display("==================Debug module Reg Bank=========================");
            forever begin
                @(posedge dm_clk)

                if(dm_reg_wr) begin
                    $display("[Debug module reg] write DM < %h > reg, write data =%0h \n." ,dmi_req_addr, dmi_req_data);
                end

                if(dm_reg_rd) begin
                    $display("[Debug module reg] read DM reg, read state=%h, read data =%0h \n." ,dmi_rsp_op, dmi_rsp_data);
                end
                
            end
        end
    end

    initial begin
        forever begin
    
            @(posedge dm_clk)
            if(command_ready) begin
                    $display("[Debug module reg] command reg < %h > \n." ,command_reg);
            end
    
            if(debug_ram_wr) begin
                    $display("[Debug module: Program buffer] debug ram write inst is [%h] ",debug_ram_din);
            end
    
        end
    end

    `endif
endmodule