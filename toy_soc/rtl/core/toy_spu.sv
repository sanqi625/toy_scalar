
module toy_spu
    import toy_pack::*; 
(
    input  logic                      clk                       ,
    input  logic                      rst_n                     ,

    input  logic                      spu_instruction_vld       ,
    output logic                      spu_instruction_rdy       ,
    input  logic [INST_WIDTH-1:0]     spu_instruction_pld       ,
    input  logic [INST_IDX_WIDTH-1:0] spu_instruction_idx       ,
    input  logic                      spu_instruction_op        , 
    input  logic [5:0]                front_trap_cause          ,
    input  logic [ADDR_WIDTH-1:0]     spu_pc                    ,

    output logic                      spu_jump_vld              ,
    output logic [1:0]                spu_jump_op               ,  // sret/mret/dret,2'b11 is trap
    //input  logic                      spu_trap_rdy              ,
    output logic [5:0]                spu_trap_cause            ,
    output logic [ADDR_WIDTH-1:0]     spu_trap_pc               ,
    output logic [INST_WIDTH-1:0]     spu_trap_inst             ,
    output logic                      spu_wfi_vld                   
);

logic [11:0]                funct12         ;
logic                       sys_excp_en     ;
logic [31:0]                sys_excp_cause  ;
logic                       sys_jump_en     ;
logic                       spu_jump_en     ;
logic                       spu_wfi         ;

logic                       front_trap_en   ;
logic                       system_inst_en  ;

////==========================================================================
//  ecall/ebreak and illegal instruction exception
//  interrupt 
//  sret/mret/dret and wfi instruction
////==========================================================================

    assign spu_instruction_rdy  = 1'b1;
    
    assign funct12              = spu_instruction_pld`INST_FIELD_FUNCT12   ;

    assign front_trap_en        = spu_instruction_op;  //decode illegal instruction, interrrupt, fetch exception
    assign system_inst_en       = ~spu_instruction_op;

//==========================================================================
// system instruction decode
//==========================================================================

    always_comb begin :SPU 
        sys_excp_en     = 1'b0;
        sys_excp_cause  = MCAUSE_RESERVED;
        sys_jump_en     = 1'b0;
        spu_jump_op     = 2'b0;
        spu_wfi         = 1'b0;
        //spu_dec_err     = 1'b0; 
        case(funct12)
            F12_ECALL   : 
                begin
                    spu_jump_op    = 2'b11; //trap
                    sys_excp_en    = 1'b1;
                    sys_excp_cause = MCAUSE_ECALL_M;
                end
            F12_EBREAK  :
                begin
                    spu_jump_op    = 2'b11;
                    sys_excp_en    = 1'b1;
                    sys_excp_cause = MCAUSE_BREAK;
                end
            F12_SRET    :
                begin
                    sys_jump_en = 1'b1;
                    spu_jump_op = 2'b00; //sret
                end
            F12_MRET    :
                begin
                    sys_jump_en = 1'b1;
                    spu_jump_op = 2'b01; //mret
                end
            F12_DRET    :
                begin
                    sys_jump_en = 1'b1;
                    spu_jump_op = 2'b10; //dret
                end
            F12_WFI     :
                begin
                    spu_wfi  = 1'b1;
                end
            default:
                begin
                    spu_jump_op     = 2'b11; //trap
                    sys_excp_en     = 1'b1;
                    //spu_dec_err     = 1'b1;
                    sys_excp_cause  = MCAUSE_ILLEGAL_INSTR;
                end
        endcase
    end

//==========================================================================
// spu jump return(include trap jump and system instruction jump)
//==========================================================================

assign spu_jump_en       = sys_jump_en || sys_excp_en;
assign spu_jump_vld      = spu_instruction_vld && (front_trap_en || (system_inst_en && spu_jump_en ));

//==========================================================================
// spu trap
//==========================================================================

//assign spu_trap_enter_vld   = spu_instruction_vld && (front_trap_en || (system_inst_en && sys_excp_en));
assign spu_trap_cause[5:0] = front_trap_en ? front_trap_cause[5:0] :
                                sys_excp_en ? sys_excp_cause[5:0] : 6'b0;

assign spu_trap_pc[ADDR_WIDTH-1:0]      = spu_pc;
assign spu_trap_inst[INST_WIDTH-1:0]    = spu_instruction_pld[INST_WIDTH-1:0];

//==========================================================================
// wfi
//==========================================================================

assign spu_wfi_vld       = spu_instruction_vld && system_inst_en && spu_wfi;

 `ifdef TOY_SIM
    logic  debug_halt_en,debug_dret_en;

    assign debug_halt_en = spu_trap_cause[5:0] == DEBUG_HALT_REQ; //TODO
    assign debug_dret_en = spu_jump_op == 2'b10;

    initial begin
        forever begin
            @(posedge clk)
            if(spu_jump_vld && debug_halt_en) begin
                $display("/===================Enter debug mode=====================");
                $display("[SPU] Debug begin !!!");
            end

            if(spu_jump_vld && debug_dret_en) begin
                $display("/===================Exit debug mode=====================");
                $display("[SPU] Debug end !!!");
            end
        end
    end
`endif

endmodule