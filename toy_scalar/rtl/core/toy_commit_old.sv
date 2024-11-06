
module toy_commit
    import toy_pack::*;
(
    input logic clk,
    input logic rst_n,

    /*==================== commit req ====================*/
    //LSU
    input  logic [4:0]                lsu_reg_index               ,
    input  logic                      lsu_reg_wr_en               ,
    input  logic [REG_WIDTH-1:0]      lsu_reg_val                 ,
    input  logic [INST_IDX_WIDTH-1:0] lsu_reg_inst_idx_rd         ,
    input  logic [INST_IDX_WIDTH-1:0] lsu_reg_inst_idx_wr         ,
    input                             lsu_inst_commit_en_rd       ,
    input                             lsu_inst_commit_en_wr       ,

    input logic [ADDR_WIDTH-1:0]      lsu_pc                      ,
    input logic                       lsu_exception_en            ,  //exception
    input logic [31:0]                lsu_exception_cause         ,

    //ALU
    input  logic [4:0]                alu_reg_index               ,
    input  logic                      alu_reg_wr_en               ,
    input  logic [REG_WIDTH-1:0]      alu_reg_val                 ,
    input  logic [INST_IDX_WIDTH-1:0] alu_reg_inst_idx            ,
    input                             alu_inst_commit_en          ,

    input logic [ADDR_WIDTH-1:0]      alu_pc                      ,

    input logic                       jb_pc_release_en       ,
    input logic                       jb_pc_update_en        ,
    input logic [ADDR_WIDTH-1:0]      jb_pc_val              ,
    //input logic                       alu_exception_en            ,  //exception
    //input logic [3:0]                 alu_exception_cause         ,

    //MEXT
    input  logic [4:0]                mext_reg_index              ,
    input  logic                      mext_reg_wr_en              ,
    input  logic [REG_WIDTH-1:0]      mext_reg_val                ,
    input  logic [INST_IDX_WIDTH-1:0] mext_reg_inst_idx           ,
    input                             mext_inst_commit_en         ,

    input  logic [ADDR_WIDTH-1:0]     mext_pc                     ,

    //CSR
    input  logic [4:0]                csr_reg_index               ,
    input  logic                      csr_reg_wr_en               ,
    input  logic [REG_WIDTH-1:0]      csr_reg_val                 ,
    input  logic [INST_IDX_WIDTH-1:0] csr_reg_inst_idx            ,
    input                             csr_inst_commit_en          ,
    input logic [ADDR_WIDTH-1:0]      csr_pc                      ,

    input  logic                      dispatch_trap_vld         ,
    output logic                      dispatch_trap_rdy         ,
    input  logic [31:0]               dispatch_trap_cause      ,
    input  logic [ADDR_WIDTH-1:0]     dispatch_trap_pc         ,
    input  logic [INST_WIDTH-1:0]     dispatch_trap_inst       ,
    //input  logic                      dispatch_trap_type        ,

    //input logic                       dm_halt_req_en              ,

    /*==================== commit rsp ====================*/
    //LSU
    output  logic [4:0]                retire_lsu_reg_index               ,
    output  logic                      retire_lsu_reg_wr_en               ,
    output  logic [REG_WIDTH-1:0]      retire_lsu_reg_val                 ,
    output  logic [INST_IDX_WIDTH-1:0] retire_lsu_reg_inst_idx_rd         ,
    output  logic [INST_IDX_WIDTH-1:0] retire_lsu_reg_inst_idx_wr         ,
    output                             retire_lsu_inst_commit_en_rd       ,
    output                             retire_lsu_inst_commit_en_wr       ,

    //ALU
    output  logic [4:0]                retire_alu_reg_index               ,
    output  logic                      retire_alu_reg_wr_en               ,
    output  logic [REG_WIDTH-1:0]      retire_alu_reg_val                 ,
    output  logic [INST_IDX_WIDTH-1:0] retire_alu_reg_inst_idx            ,
    output                             retire_alu_inst_commit_en          ,

    //MEXT
    output  logic [4:0]                retire_mext_reg_index              ,
    output  logic                      retire_mext_reg_wr_en              ,
    output  logic [REG_WIDTH-1:0]      retire_mext_reg_val                ,
    output  logic [INST_IDX_WIDTH-1:0] retire_mext_reg_inst_idx           ,
    output                             retire_mext_inst_commit_en         ,

    //CSR
    output  logic [4:0]                retire_csr_reg_index               ,
    output  logic                      retire_csr_reg_wr_en               ,
    output  logic [REG_WIDTH-1:0]      retire_csr_reg_val                 ,
    output  logic [INST_IDX_WIDTH-1:0] retire_csr_reg_inst_idx            ,
    output                             retire_csr_inst_commit_en          ,
    output logic [ADDR_WIDTH-1:0]      retire_csr_pc                      ,

    // trap message
    output logic                       trap_vld            ,
    output logic [ADDR_WIDTH-1:0]      trap_pc             ,
    output logic [31:0]                trap_cause          ,
    output logic [ADDR_WIDTH-1:0]      trap_extra_info     ,  //mtval
    input  logic                       trap_step_en        , 
    input  logic                       trap_rdy            

);

logic [ADDR_WIDTH-1:0] latest_retire_pc;
logic                  commit_en;
logic                  trap_en;
logic                  retire_lsu_inst_commit_en;
logic                  trap_type;

logic [ADDR_WIDTH-1:0] jb_pc;
logic                  jb_vld;

assign retire_lsu_reg_index               = lsu_reg_index               ;
assign retire_lsu_reg_wr_en               = lsu_reg_wr_en               ;
assign retire_lsu_reg_val                 = lsu_reg_val                 ;
assign retire_lsu_reg_inst_idx_rd         = lsu_reg_inst_idx_rd         ;
assign retire_lsu_reg_inst_idx_wr         = lsu_reg_inst_idx_wr         ;
assign retire_lsu_inst_commit_en_rd       = lsu_inst_commit_en_rd && !trap_en   ;
assign retire_lsu_inst_commit_en_wr       = lsu_inst_commit_en_wr && !trap_en       ;

assign retire_alu_reg_index               = alu_reg_index               ;
assign retire_alu_reg_wr_en               = alu_reg_wr_en               ;
assign retire_alu_reg_val                 = alu_reg_val                 ;
assign retire_alu_reg_inst_idx            = alu_reg_inst_idx            ;
assign retire_alu_inst_commit_en          = alu_inst_commit_en && !trap_en          ;

assign retire_mext_reg_index              = mext_reg_index              ;
assign retire_mext_reg_wr_en              = mext_reg_wr_en              ;
assign retire_mext_reg_val                = mext_reg_val                ;
assign retire_mext_reg_inst_idx           = mext_reg_inst_idx           ;
assign retire_mext_inst_commit_en         = mext_inst_commit_en && !trap_en         ;

assign retire_csr_reg_index               = csr_reg_index               ;
assign retire_csr_reg_wr_en               = csr_reg_wr_en               ;
assign retire_csr_reg_val                 = csr_reg_val                 ;
assign retire_csr_reg_inst_idx            = csr_reg_inst_idx            ;
assign retire_csr_inst_commit_en          = csr_inst_commit_en && !trap_en          ;

assign dispatch_trap_rdy                  = 1'b1; //TODO

assign trap_en = (lsu_exception_en || dispatch_trap_vld ) && trap_rdy;  //normal trap except debug exception

assign retire_lsu_inst_commit_en = retire_lsu_inst_commit_en_rd || retire_lsu_inst_commit_en_wr;
assign commit_en                 = retire_alu_inst_commit_en || retire_lsu_inst_commit_en
                                    || retire_mext_inst_commit_en || retire_csr_inst_commit_en;

//lsu and alu commit same time
//assign commit_conflict = retire_lsu_inst_commit_en_rd && (retire_alu_inst_commit_en || retire_lsu_inst_commit_en_wr
//                                   || retire_mext_inst_commit_en || retire_csr_inst_commit_en);

always_ff @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        latest_retire_pc <= 'b0;
    else if(commit_en)begin
        case({retire_lsu_inst_commit_en,retire_alu_inst_commit_en,retire_mext_inst_commit_en,retire_csr_inst_commit_en})
            4'b0001 : latest_retire_pc <= csr_pc;
            4'b0010 : latest_retire_pc <= mext_pc;  
            4'b0100 : latest_retire_pc <= alu_pc;
            4'b1000 : latest_retire_pc <= lsu_pc;
            4'b1001 : latest_retire_pc <= csr_pc; //csr and lsu read
            4'b1010 : latest_retire_pc <= mext_pc; //mext and lsu read
            4'b1100 : latest_retire_pc <= alu_pc; //alu and lsu read
            default : latest_retire_pc <= latest_retire_pc;
        endcase
    end
end

//record next pc is jump address
always_ff @( posedge clk or negedge rst_n ) begin
    if(!rst_n)
        jb_pc <= 'b0;
    else if( jb_pc_release_en && jb_pc_update_en )
        jb_pc <= jb_pc_val;
end

always_ff @( posedge clk or negedge rst_n ) begin
    if(!rst_n)
        jb_vld <= 1'b0;
    else if(jb_pc_release_en && jb_pc_update_en)
        jb_vld <= 1'b1;
    else if(commit_en)
        jb_vld <= 1'b0;
end

assign trap_vld     = trap_en || (commit_en && trap_step_en && trap_rdy); //add step trap

//assign trap_type    = dispatch_trap_type ? 1'b1 :
//                        (lsu_exception_en || dispatch_trap_vld)? 1'b0 : 1'b0;
assign trap_type    = dispatch_trap_cause[31] ; //external interrupt

always_comb begin
    trap_cause[31:0] = 'b0;
    if(dispatch_trap_vld || trap_step_en)
        trap_cause[31:0] = dispatch_trap_cause[31:0]; //break point, TODO
    else if(lsu_exception_en)
        trap_cause[31:0] = lsu_exception_cause[31:0];
    //else if(alu_exception_en)
    //    trap_cause <= alu_exception_cause;
end

//exception pc
logic [ADDR_WIDTH-1:0] current_pc;

always_comb begin
    current_pc[ADDR_WIDTH-1:0] = 'b0;
    if(commit_en)begin
        case({retire_lsu_inst_commit_en,retire_alu_inst_commit_en,retire_mext_inst_commit_en,retire_csr_inst_commit_en})
            4'b0001 : current_pc = csr_pc;
            4'b0010 : current_pc = mext_pc;  
            4'b0100 : current_pc = alu_pc;
            4'b1000 : current_pc = lsu_pc;
            4'b1001 : current_pc = csr_pc; //csr and lsu read
            4'b1010 : current_pc = mext_pc; //mext and lsu read
            4'b1100 : current_pc = alu_pc; //alu and lsu read
            default : current_pc = 'b0;
        endcase
    end
end


always_comb begin
    trap_pc = 'b0;
    if(trap_type)  //interrupt 
        trap_pc = jb_vld ? jb_pc : (latest_retire_pc + 4);  //next instruction
    else if(trap_step_en)  //step
        trap_pc = (jb_pc_release_en && jb_pc_update_en) ? jb_pc_val :  (current_pc + 4);
    else begin  //exception
        if(lsu_exception_en)
            trap_pc = lsu_pc;
        else if(dispatch_trap_vld)
            trap_pc = dispatch_trap_pc;
    end
end

//TODO
assign trap_extra_info = dispatch_trap_inst[INST_WIDTH-1:0];

    int cycle;
    logic [ADDR_WIDTH-1:0] pc;

    assign pc = u_toy_scalar.u_core.u_fetch.pc;

    initial begin
        cycle = 0;
        forever begin
            @(posedge clk)
            cycle = cycle + 1;
        end
    end

    initial begin
        forever begin

            @(posedge clk)
            if(trap_vld) begin
                $display("[Commit][cycle=%d][pc=%h] Trigger Trap!!!, trap_pc = [%h], trap_type = [%h], trap_cause = [%h]", cycle, pc, trap_pc, trap_type,trap_cause);
                //$display("[SYSTEM][cycle=%d][pc=%h] Receive exit command %h, exit.", cycle, pc, wr_data);
            end

        end
    end

endmodule