
module toy_commit
    import toy_pack::*; 
(
    input  logic                     clk,                         
    input  logic                     rst_n,         

    input  logic [ADDR_WIDTH-1:0]    csr_mtvec,
    //input  logic [ADDR_WIDTH-1:0]    csr_dbvec,
    input  logic [ADDR_WIDTH-1:0]    csr_mepc, 
    input  logic [ADDR_WIDTH-1:0]    csr_stvec,
    input  logic [ADDR_WIDTH-1:0]    csr_sepc, 
    input  logic [ADDR_WIDTH-1:0]    csr_dpc,  
    input  logic                     trap_enter_smode,

    input  logic                     retire_lsu_inst_commit_en_rd,
    input  logic                     retire_lsu_inst_commit_en_wr,
    input  logic                     retire_alu_inst_commit_en,   
    input  logic                     retire_mext_inst_commit_en,  
    input  logic                     retire_csr_inst_commit_en,   

    input  logic [ADDR_WIDTH-1:0]    lsu_pc,                      
    input  logic [ADDR_WIDTH-1:0]    alu_pc,                      
    input  logic [ADDR_WIDTH-1:0]    mext_pc,                     
    input  logic [ADDR_WIDTH-1:0]    csr_pc,                      
    input  logic [ADDR_WIDTH-1:0]    spu_pc,                 

    input  logic                     jb_pc_release_en,
    input  logic                     jb_pc_update_en,             
    input  logic [ADDR_WIDTH-1:0]    jb_pc_val,                   
    input  logic                     spu_return_en,               
    input  logic [1:0]               spu_return_type,
    input  logic                     trap_vld,
    input  logic                     trap_rdy,
    //debug
    input  logic                     debug_vld,
    input  logic                     indebug_break_en,
    input  logic                     indebug_exception,
    input  logic                     debug_step_en,
    
    output logic                     dret_en,
    output logic                     mret_en,
    output logic                     sret_en,

    output logic [ADDR_WIDTH-1:0]    real_pc,
    output logic                     pc_release_en,
    output logic                     pc_update_en ,
    output logic [ADDR_WIDTH-1:0]    pc_val       ,
    output logic                     pc_lock                                 
);

logic                   commit_en;
logic                   retire_lsu_inst_commit_en;
logic [ADDR_WIDTH-1:0]  spu_return_addr;

logic                   change_flow_enter_lock;
logic                   change_flow_exit_lock;
logic                   debug_handshake;
logic                   trap_handshake;

logic                   commit_conflict;
logic [ADDR_WIDTH-1:0]  current_pc;

assign retire_lsu_inst_commit_en = retire_lsu_inst_commit_en_rd || retire_lsu_inst_commit_en_wr;
assign commit_en                 = retire_alu_inst_commit_en || retire_lsu_inst_commit_en
                                    || retire_mext_inst_commit_en || retire_csr_inst_commit_en;

assign trap_handshake   = trap_vld  && trap_rdy;
assign debug_handshake  = debug_vld && trap_rdy;
// don't support compress instruction 
// current pc 是将要执行的pc值，还未commit
always_ff @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        current_pc <= 'b0;
    else if(commit_en)begin
        case({retire_lsu_inst_commit_en,retire_alu_inst_commit_en,retire_mext_inst_commit_en,retire_csr_inst_commit_en})
            4'b0001 : current_pc <= csr_pc  + 32'd4;
            4'b0010 : current_pc <= mext_pc + 32'd4;  
            4'b0100 : 
                begin
                    if(jb_pc_update_en)
                        current_pc <= jb_pc_val;
                    else 
                        current_pc <= alu_pc + 32'd4;
                end
            4'b1000 : current_pc <= lsu_pc   + 32'd4;
            4'b1001 : current_pc <= csr_pc   + 32'd4; //csr and lsu read
            4'b1010 : current_pc <= mext_pc  + 32'd4; //mext and lsu read
            4'b1100 : 
                begin //alu and lsu read
                    if(jb_pc_update_en)
                        current_pc <= jb_pc_val;
                    else 
                        current_pc <= alu_pc + 32'd4;
                end
            default : current_pc <= current_pc;
        endcase
    end     
    else if(trap_handshake)
        begin
            if(indebug_break_en)
                current_pc <= DBEUG_LOOP_ADDR;
            else if(indebug_exception)
                current_pc <= DBEUG_EXP_ADDR;
            else 
                current_pc <= trap_enter_smode ? csr_stvec : csr_mtvec;
        end
    else if(debug_handshake)
        current_pc <= DEBUG_PC_ADDR;
    else if(spu_return_en)
        current_pc <= spu_return_addr;
end


assign commit_conflict = commit_en && (trap_handshake || debug_handshake);

assign real_pc = commit_conflict ? (current_pc + 4): current_pc; 

//decode spu return address
always_comb begin
    spu_return_addr[ADDR_WIDTH-1:0] = 'b0;
    mret_en                         = 1'b0;
    sret_en                         = 1'b0;
    dret_en                         = 1'b0;
    case(spu_return_type)
        2'b00   :   
            begin //SRET
                spu_return_addr = csr_sepc; 
                sret_en         = 1'b1 && spu_return_en;
            end
        2'b01   :   
            begin //MRET
                spu_return_addr = csr_mepc; 
                mret_en         = 1'b1 && spu_return_en;
            end
        2'b10   :   
            begin //DRET
                spu_return_addr = csr_dpc; 
                dret_en         = 1'b1 && spu_return_en;
            end
        default :   spu_return_addr = csr_mepc;
    endcase
end

//change flow 
//when trigger trap, mret/sret/dret should be return original pc

always_ff @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        pc_release_en   <= 1'b0        ;
        pc_update_en    <= 1'b0        ;
        pc_val          <= 'b0         ;
    end
    else if(retire_alu_inst_commit_en )begin
        pc_release_en   <= jb_pc_release_en         ;
        pc_update_en    <= jb_pc_update_en          ;
        pc_val          <= jb_pc_val                ;
    end
    else if(debug_handshake)begin
        pc_release_en   <= 1'b1        ;
        pc_update_en    <= 1'b1        ;
        pc_val          <= DEBUG_PC_ADDR;     //enter into debug rom
    end
    else if(trap_handshake && ~debug_step_en)begin //Under step mode, trap should not jump, only update trap csr reg
        pc_release_en   <= 1'b1        ;
        pc_update_en    <= 1'b1        ;
        if(indebug_break_en)
            pc_val      <= DBEUG_LOOP_ADDR;  //enter into debug loop
        else if(indebug_exception)
            pc_val      <= DBEUG_EXP_ADDR;  //enter into debug exception
        else 
            pc_val      <= trap_enter_smode ? csr_stvec : csr_mtvec   ;
    end
    else if(spu_return_en && !spu_return_type[1])begin
        pc_release_en   <= 1'b1        ;
        pc_update_en    <= 1'b1        ;
        pc_val          <= spu_return_addr;
    end else if(spu_return_en && spu_return_type[1])begin
        pc_release_en   <= 1'b1        ;
        pc_update_en    <= 1'b1        ;
        pc_val          <= csr_dpc     ;
    end else begin
        pc_release_en   <= 1'b0        ;
        pc_update_en    <= 1'b0        ;
        pc_val          <= 'b0         ;
    end
end

always_ff @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        change_flow_enter_lock <= 1'b0;
    else if(pc_release_en )
        change_flow_enter_lock <= 1'b0;
    else if(trap_handshake || debug_handshake)
        change_flow_enter_lock <= 1'b1;
end

always_ff @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        change_flow_exit_lock <= 1'b0;
    else if(pc_release_en)
        change_flow_exit_lock <= 1'b0;
    else if(spu_return_en)
        change_flow_exit_lock <= 1'b1;
end

assign pc_lock = change_flow_enter_lock || change_flow_exit_lock;

`ifdef TOY_SIM
    initial begin
        if($test$plusargs("DEBUG")) begin
            forever begin
                @(posedge clk)
                if(pc_release_en && pc_update_en) begin
                    $display("[Commit] pc_release_en = %0b", pc_release_en );
                    $display("[Commit] pc_update_en  = %0b", pc_update_en  );
                    $display("[Commit] pc_val  = %0d", pc_val  );
                    //$display("[alu] reg_data = instruction_pld[30] ? ($signed(rs1_val) >>> rs2_val[4:0]) : (rs1_val >> rs2_val[4:0]);");
                    //$display("[alu] %h = %h ? (%h >>> %h) : (%h >> %h);",reg_data,instruction_pld[30],$signed(rs1_val),i_type_imm_32[4:0],rs1_val,i_type_imm_32[4:0]);
                end

                if(mret_en)begin
                    $display("[Commit] mret !!! \n" );
                    $display("[Commit] mepc  = %0h", csr_mtvec  );
                end
            end
        end
    end
`endif

endmodule