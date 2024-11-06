

module toy_fecth3
    import toy_pack::*;
(
`ifdef FPGA_SIM
    input  logic                      ila_clk    ,
`endif 
    input  logic                      clk                     ,
    input  logic                      rst_n                   ,

    // memory access
    input  logic                      mem_ack_vld             ,
    output logic                      mem_ack_rdy             ,
    input  logic [INST_WIDTH-1:0]     mem_ack_data            ,
    output logic [ADDR_WIDTH-1:0]     mem_req_addr            ,
    output logic                      mem_req_vld             ,
    input  logic                      mem_req_rdy             ,

    // pc update
    input logic                       rtu_pc_release_en      ,
    input logic                       rtu_pc_update_en       ,
    input logic [ADDR_WIDTH-1:0]      rtu_pc_val             ,
    input logic                       rtu_lock               ,

    input logic                       debug_step_en           ,
    input logic                       debug_step_release      ,

    input logic                       jb_pc_release_en        ,
    input logic                       jb_pc_update_en         ,
    input logic [ADDR_WIDTH-1:0]      jb_pc_val               ,

    // fetch to exec
    output logic                      instruction_vld         ,
    input  logic                      instruction_rdy         ,
    output logic [INST_WIDTH-1:0]     instruction_pld         ,
    output logic [ADDR_WIDTH-1:0]     instruction_pc          ,
    output logic [INST_IDX_WIDTH-1:0] instruction_idx         ,
    output logic [32:0]               instruction_op          ,

    input  logic                      interrupt_vld           ,
    input  logic [31:0]               interrupt_op            ,
    output logic                      interrupt_rdy           
);

    logic [4:0]                     opcode          ;
    logic                           fetch_jump_inst ;
    logic                           instruction_en  ;

    logic [INST_WIDTH-1:0]          pc              ;
    logic                           pc_lock         ;
    logic [INST_WIDTH-1:0]          fetch_pc        ;
    logic [INST_WIDTH-1:0]          fetch_pc_nxt    ;

    logic                           interrupt_en    ;

    logic                           pc_release_en   ;
    logic                           pc_update_en    ;
    logic [ADDR_WIDTH-1:0]          pc_val          ;
    logic                           mis_align_mem_data;

    logic [INST_WIDTH-1:0]          fetch_instruction_pld;

    logic                           step_inst_vld;
    logic                           one_instruction_sent;

    logic [1:0]                     step_state,next_step_state;
    logic                           step_insert_en;
    logic [INST_WIDTH-1:0]          step_insert_instruction;
    logic                           step_first_en;

    localparam STEP_INIT        = 2'b00;
    localparam STEP_FIRST_INST  = 2'b01;
    localparam STEP_INSERT_INST = 2'b10;
    localparam STEP_END         = 2'b11;

    //logic                           mem_clean_agent ;
    //logic [3:0]                     inst_idx        ;





    assign instruction_en = instruction_vld && instruction_rdy;

    // trap and jb pc update will not valid at the same cycle.
    assign pc_release_en        = rtu_pc_release_en    | jb_pc_release_en      ;
    assign pc_update_en         = rtu_pc_update_en     | jb_pc_update_en       ;
    assign pc_val               = rtu_pc_update_en ? rtu_pc_val : jb_pc_val   ;

    // Fetch PC =========================================================================

    assign mem_req_addr = fetch_pc_nxt  ;
    assign mem_req_vld  = 1'b1  ;           //1'b1;// || instruction_rdy;

    always_comb begin
        if(pc_update_en && pc_release_en)       fetch_pc_nxt = pc_val;
        else                                    fetch_pc_nxt = fetch_pc;
        //else if(mem_req_vld && mem_req_rdy)     fetch_pc_nxt = fetch_pc + 4;
    end


    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                      fetch_pc <= 32'h8000_0000       ;
        else if(pc_update_en && pc_release_en)          //fetch_pc <= pc_val + 4          ;
            if(pc_val[1] == 1'b0)                       fetch_pc <= pc_val + 4          ;
            else                                        fetch_pc <= pc_val + 2          ;
        else if(mem_req_vld && mem_req_rdy)             fetch_pc <= fetch_pc + 4        ;           
            //if(pc_val[1] == 1'b0)                       fetch_pc <= fetch_pc + 4        ;
            //else                                        fetch_pc <= fetch_pc + 2        ;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                      mis_align_mem_data <= 1'b0;
        else if(fetch_pc_nxt[1] == 1'b0)                mis_align_mem_data <= 1'b0;
        else                                            mis_align_mem_data <= 1'b1;
    end


    // PC =================================================================================

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                                      pc      <= 32'h8000_0000        ;
        else if(pc_update_en && pc_release_en)          pc      <= pc_val               ;
        else if(instruction_en)
            if(instruction_pld[1:0] == 2'b11)           pc      <= pc + 4               ;
            else                                        pc      <= pc + 2               ;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)                  pc_lock <= 1'b0                 ;
        else if(pc_release_en)      pc_lock <= 1'b0                 ;
        else if(fetch_jump_inst)    pc_lock <= 1'b1                 ;
    end



    assign opcode = instruction_pld`INST_FIELD_OPCODE;

    always_comb begin
        case(opcode)
        OPC_JAL             : fetch_jump_inst = instruction_en;
        OPC_JALR            : fetch_jump_inst = instruction_en;
        OPC_BRANCH          : fetch_jump_inst = instruction_en;
        default             : fetch_jump_inst = 1'b0;
        endcase
    end




    // Instruction Buffer ===============================================================

    logic queue_vld;
    logic queue_rdy;

    toy_fetch_queue2 #(
        .DEPTH(32),
        .PLD_TYPE(logic[32-1:0]))
    u_fifo (
        .clk    (clk                                ),
        .rst_n  (rst_n                              ),
        .clear  (pc_update_en                       ),
        .req_vld(mem_ack_vld                        ),
        .req_rdy(mem_ack_rdy                        ),
        .req_pld(mem_ack_data                       ),
        .mis_align_mem_data(mis_align_mem_data      ),
        .ack_vld(queue_vld                          ),
        .ack_rdy(queue_rdy                          ),
        .ack_pld(fetch_instruction_pld              ));

    assign instruction_pc   = pc                            ;
    assign instruction_vld  = (queue_vld        && ~pc_lock && ~rtu_lock && (~debug_step_en || step_first_en) ) || interrupt_en || step_insert_en;
    assign queue_rdy        = instruction_rdy   && ~pc_lock && ~rtu_lock  && ~interrupt_en;

    // Interrupt ===============================================================

    assign interrupt_rdy                        = instruction_rdy;
    //assign interrupt_en                         = interrupt_vld && interrupt_rdy;
    assign interrupt_en                         = interrupt_vld;

    //instruction op bit[32] is 1 indicates the instruction is trap, bit[32] is 0 indicates is the real instrcution
    //instruction op trap bit[31] is 1 indicates that interrupt, otherwise is exception

    assign instruction_op[32:0]                  = interrupt_en  ? {1'b1,interrupt_op[31:0]} : 33'd0; 

    assign instruction_pld[INST_WIDTH-1:0]       = interrupt_en ? {(INST_WIDTH){1'b0}} : 
                                                    step_insert_en ? step_insert_instruction : fetch_instruction_pld[INST_WIDTH-1:0]; 

    //single step process

    always_ff @( posedge clk or negedge rst_n ) begin
        if(!rst_n)
            step_state[1:0] <= STEP_INIT;
        else
            step_state[1:0] <= next_step_state[1:0];
    end

    always_comb begin
        next_step_state[1:0] = STEP_INIT;
        case(step_state[1:0])
            STEP_INIT       : 
                begin
                    if(debug_step_en)
                        next_step_state[1:0] = STEP_FIRST_INST;
                    else 
                        next_step_state[1:0] = STEP_INIT;
                end
            STEP_FIRST_INST :
                begin
                    if(instruction_vld && instruction_rdy)
                        next_step_state[1:0] = STEP_INSERT_INST;
                    else 
                        next_step_state[1:0] = STEP_FIRST_INST;
                end
            STEP_INSERT_INST:
                begin
                    if(instruction_vld && instruction_rdy)
                        next_step_state[1:0] = STEP_END;
                    else 
                        next_step_state[1:0] = STEP_INSERT_INST;
                end
            STEP_END      :
                begin
                    if(debug_step_release)
                        next_step_state[1:0] = STEP_INIT;
                    else 
                        next_step_state[1:0] = STEP_END;
                end
            default       : next_step_state[1:0] = STEP_INIT;
        endcase
    end

    assign step_insert_en                           = step_state[1:0] == STEP_INSERT_INST;
    assign step_first_en                            = step_state[1:0] == STEP_FIRST_INST;
    assign step_insert_instruction[INST_WIDTH-1:0]  = EBREAK;

    //assign mem_ack_rdy      = 1'b1   ;

    //always_ff @(posedge clk or negedge rst_n) begin
    //    if(~rst_n)  mem_clean_agent <= 1'b0;
    //    //else        mem_clean_agent <= pc_update_en;
    //end



    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)              instruction_idx <= 0;
        else if(instruction_en) instruction_idx <= instruction_idx + 1;
    end


//===============================================================================
// Simulation
//===============================================================================

    `ifdef TOY_SIM
    logic [63:0] cycle;

    assign debug_en = u_csr.mode_state == DEBUG;


    always_ff @(posedge clk or negedge rst_n) begin
        if(~rst_n)  cycle <= 0;
        else        cycle <= cycle + 1;
    end

    initial begin
        string  fname   ;
        int     fhandle ;
        if($value$plusargs("PC=%s", fname)) begin
            fhandle = $fopen(fname, "w");
            forever begin
                @(posedge clk)
                if(instruction_vld & instruction_rdy) begin
                    $fdisplay(fhandle, "[pc=%h][inst=%h][cycle=%0d]", instruction_pc, instruction_pld, cycle);
                end
            end
        end
    end

    initial begin
        forever begin

            @(posedge clk)
            if(mem_req_vld && mem_req_rdy && (mem_req_addr==DEBUG_PC_ADDR)) begin
                $display("[Fetch] Debug PC begin !!!");
                $display("[Fetch] Debug PC [%h]",mem_req_addr);
            end

            if(debug_en && instruction_vld && instruction_rdy)begin
                $display("[Fetch] Debug instrcution: PC[%h], inst[%h]",instruction_pc,instruction_pld);
            end


        end
    end

    `endif

`ifdef FPGA_SIM

    inst_exec_ila u_inst_exec_ila (
        .clk(ila_clk), // input wire clk

	    .probe0(instruction_vld), // input wire [0:0]  probe0  
	    .probe1(instruction_rdy), // input wire [0:0]  probe1 
	    .probe2(instruction_pld), // input wire [31:0]  probe2 
	    .probe3(instruction_pc ), // input wire [31:0]  probe3 
	    .probe4(instruction_op), // input wire [32:0]  probe4 
	    .probe5(interrupt_vld), // input wire [0:0]  probe5 
	    .probe6(interrupt_op ), // input wire [31:0]  probe6 
	    .probe7(interrupt_rdy) // input wire [0:0]  probe7
        );

`endif 


endmodule
