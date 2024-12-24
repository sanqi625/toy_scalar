module toy_ext_inter(
    input logic                     clk,
    input logic                     rst_n,
    input logic                     intr_meip           ,
    input logic                     intr_msip           ,

    input logic                     intr_seip           ,
    input logic                     intr_stip           ,
    input logic                     intr_ssip           ,
    input logic                     debug_halt_req      ,
    input logic                     debug_stepie_mask   ,

    //input  logic                    intr_clr,
    //output logic                    intr_vld,
    //output logic [3:0]              intr_op,  //0 is sw intr, 1 is timer intr, 2 is external intr, 3 is debug halt req
    //input  logic                    intr_rdy,

    output logic                    intr_meip_sync      ,
    output logic                    intr_msip_sync      ,
    output logic                    intr_seip_sync      ,
    output logic                    intr_stip_sync      ,
    output logic                    intr_ssip_sync      ,
    output logic                    intr_debug_sync
);

    // Capture interrupt req==========================================

    logic exter_intr_req_1d;
    logic sw_intr_req_1d;
    logic debug_intr_req_1d;
    logic timer_intr_req_1d;

    logic s_exter_intr_req_1d;
    logic s_timer_intr_req_1d;
    logic s_sw_intr_req_1d;
    
    always_ff @( posedge clk or negedge rst_n ) begin
        if(!rst_n)begin
            exter_intr_req_1d <= 1'b0;
            sw_intr_req_1d    <= 1'b0;
            debug_intr_req_1d <= 1'b0;
        end else begin
            exter_intr_req_1d <= intr_meip;
            sw_intr_req_1d    <= intr_msip;
            debug_intr_req_1d <= debug_halt_req;
        end
    end

    always_ff @( posedge clk or negedge rst_n ) begin
        if(!rst_n)begin
            s_exter_intr_req_1d <= 1'b0;
            s_timer_intr_req_1d <= 1'b0;
            s_sw_intr_req_1d    <= 1'b0;
        end else begin
            s_exter_intr_req_1d <= intr_seip;
            s_timer_intr_req_1d <= intr_stip;
            s_sw_intr_req_1d    <= intr_ssip;
        end
    end

    assign intr_meip_sync    = ~exter_intr_req_1d && intr_meip      && debug_stepie_mask;
    assign intr_msip_sync    = ~sw_intr_req_1d    && intr_msip      && debug_stepie_mask;
    assign intr_debug_sync   = ~debug_intr_req_1d && debug_halt_req && debug_stepie_mask;

    assign intr_seip_sync    = ~s_exter_intr_req_1d && intr_seip;
    assign intr_stip_sync    = ~s_timer_intr_req_1d && intr_stip;
    assign intr_ssip_sync    = ~s_sw_intr_req_1d    && intr_ssip;

    //assign intr_vld         = (exter_intr_en || sw_intr_en || timer_intr_en || debug_intr_en) && ~interrupt_instruction_sent;
    //assign intr_op[3:0]     = sw_intr_en ? 4'd3 : 
    //                            timer_intr_en ? 4'd7 :
    //                            exter_intr_en ? 4'd11 :
    //                            debug_intr_en ? 4'd15 : 4'd0;

// interrupt pending

    //always_ff @(posedge clk or negedge rst_n) begin
    //    if(~rst_n)                                                          
    //        interrupt_instruction_sent <= 1'b0;
    //    else if(intr_vld && intr_rdy)                
    //        interrupt_instruction_sent <= 1'b1;
    //    else if(intr_clr)                                               
    //        interrupt_instruction_sent <= 1'b0;
    //end

    initial begin
        forever begin

            @(posedge clk)
            if(intr_debug_sync) begin
                $display("[Exter interrupt] Trigger Debug interrupt!!!");
            end

        end
    end

endmodule