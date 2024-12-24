
module toy_trap
    import toy_pack::*; 
(
    input  logic                        clk,                 
    input  logic                        rst_n,

    input  logic [ADDR_WIDTH-1:0]       current_pc,

    // spu
    input  logic                        spu_trap_en,         
    input  logic [5:0]                  spu_trap_cause,      
    input  logic [INST_WIDTH-1:0]       spu_trap_inst,       
    input  logic [ADDR_WIDTH-1:0]       spu_trap_pc,

    // lsu
    input  logic                        lsu_excp_en,         
    input  logic [5:0]                  lsu_exception_cause, 
    input  logic [ADDR_WIDTH-1:0]       lsu_pc,
    input  logic [INST_WIDTH-1:0]       lsu_exception_inst,

    //debug state
    input  logic                        debug_mode_en, 
    input  logic                        debug_ebreakm,
    input  logic                        debug_step_en,       
    input  logic [REG_WIDTH-1:0]        csr_mtvec,
    input  logic                        debug_step_release,

    //trap out
    output logic                        trap_vld, 
   // output logic                        trap_op, // 1 is debug , 0 is normal trap
    input  logic                        trap_rdy,                 
    output logic [ADDR_WIDTH-1:0]       trap_pc,                    
    output logic [5:0]                  trap_cause,              
    output logic [INST_WIDTH-1:0]       trap_extra_info,
    output logic                        trap_indebug,

    output logic                        debug_vld,
    output logic [2:0]                  debug_cause,
    output logic [ADDR_WIDTH-1:0]       debug_pc,

    output logic                        indebug_break_en,         
    output logic                        indebug_exception              
);

logic           outdebug_ebreak_en;
logic           debug_req_en;
logic           dm_halt_en;
logic           dm_ebreak_en;
logic           dm_trigger_en;
logic           dm_step_en;
logic           dm_rst_hart_en;
logic           trap_under_step;

assign trap_vld         = lsu_excp_en || (spu_trap_en && ~debug_req_en);  //trap include debug exception
assign debug_vld        = debug_req_en;
//assign trap_op          = debug_req_en ? 1'b1 : 1'b0;
//assign trap_cause[31:0] = debug_req_en ?  {{(32-3){1'b0}},debug_cause[2:0]} : normal_trap_cause[31:0];

//==========================================================================
// Trap
//==========================================================================

always_comb begin
    trap_cause[5:0] = 'b0;
    if(spu_trap_en)
        trap_cause[5:0] = spu_trap_cause[5:0]; //break point, TODO
    else if(lsu_excp_en)
        trap_cause[5:0] = lsu_exception_cause[5:0];  //lsu exception
end

assign trap_pc[ADDR_WIDTH-1:0] = current_pc[ADDR_WIDTH-1:0];

always_comb begin
    trap_extra_info[31:0] = 'b0;
    if(spu_trap_en)
        trap_extra_info[31:0] = spu_trap_inst[31:0]; //break point, TODO
    else if(lsu_excp_en)
        trap_extra_info[31:0] = lsu_exception_inst[31:0];  //lsu exception
end

//==========================================================================
// debug
//==========================================================================

assign indebug_exception        = spu_trap_en && (spu_trap_cause != MCAUSE_BREAK) && debug_mode_en; //debug mode exception except ebreak
assign indebug_break_en         = spu_trap_en && (spu_trap_cause == MCAUSE_BREAK) && debug_mode_en;  //debug mode ebreak
assign trap_indebug             = indebug_exception || indebug_break_en;

always_ff @( posedge clk or negedge rst_n ) begin
    if(!rst_n)
        trap_under_step <= 1'b0;
    else if(debug_step_release)
        trap_under_step <= 1'b0;
    else if(trap_vld && debug_step_en)
        trap_under_step <= 1'b1;
end

assign debug_pc[ADDR_WIDTH-1:0] = trap_under_step ? csr_mtvec : current_pc[ADDR_WIDTH-1:0];

//debug halt req
assign dm_halt_en   =  spu_trap_en && (spu_trap_cause[5:0]==DEBUG_HALT_REQ);

// Capture debug ebreak req==========================================
assign outdebug_ebreak_en = spu_trap_en && (spu_trap_cause[5:0] == MCAUSE_BREAK) && ~debug_mode_en; 

assign dm_ebreak_en = outdebug_ebreak_en && debug_ebreakm && ~debug_step_en;

// Capture debug trigger req==========================================
assign dm_trigger_en = 1'b0;

// Capture debug step req==========================================
assign dm_step_en = outdebug_ebreak_en && debug_ebreakm && debug_step_en;

// Capture debug rst hart req==========================================
assign dm_rst_hart_en = 1'b0;

assign debug_req_en = dm_halt_en || dm_ebreak_en || dm_trigger_en || dm_step_en || dm_rst_hart_en;

assign debug_cause[2:0] = dm_ebreak_en ? DM_EBREAK :
                           dm_trigger_en  ? DM_TRIGGER  :
                           dm_halt_en     ? DM_HALT_REQ :
                           dm_step_en     ? DM_STEP     :
                           dm_rst_hart_en ? DM_RST_HART : DM_IDLE;

endmodule