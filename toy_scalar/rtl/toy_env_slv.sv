
module toy_env_slv #(
    parameter integer unsigned ADDR_WIDTH = 32,
    parameter integer unsigned DATA_WIDTH = 32
) (
    output logic                        clk         ,
    output logic                        rst_n       ,

    input  logic                        en          ,
    input  logic [ADDR_WIDTH-1:0]       addr        ,
    output logic [DATA_WIDTH-1:0]       rd_data     ,
    input  logic [DATA_WIDTH-1:0]       wr_data     ,
    input  logic [DATA_WIDTH/8-1:0]     wr_byte_en  ,
    input  logic                        wr_en       ,

    output  logic                       jtag_clk    ,
    output  logic                       jtag_rst_n  ,
    output  logic                       jtag_tms   ,
    output  logic                       jtag_tdi   ,
    input  logic                        jtag_tdo   ,

    output logic                        intr_meip,
    output logic                        intr_msip
);

    parameter INTR_TEST_EN = 0;

    int unsigned timeout_cycle;
    int cycle;

    assign rd_data = 0;

//============================================================
// Clock and Reset generation
//============================================================

    initial begin
        cycle = 0;
        forever begin
            @(posedge clk)
            cycle = cycle + 1;
        end
    end

//============================================================
// Interrupt generation
//============================================================

    logic [31:0]  inter_cnt;
    logic [31:0] inter_trigger_cnt;

    localparam INTER_CNT_MAX = 200000;

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            inter_cnt <= 'd0;
        else if(inter_cnt == INTER_CNT_MAX)
            inter_cnt <= 'd0;
        else 
            inter_cnt <= inter_cnt + 'd1;
    end

    //assign intr_meip = (INTR_TEST_EN==1) ? (inter_cnt == INTER_CNT_MAX) : 1'b0;
    assign intr_meip = 1'b0;

    assign intr_msip = 1'b0;

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            inter_trigger_cnt <= 'd0;
        else if(intr_meip)
            inter_trigger_cnt <= inter_trigger_cnt + 'd1;
    end


    // #20 is a cycle.

    initial begin
        timeout_cycle = 10;
        if($value$plusargs("TIMEOUT=%d", timeout_cycle)) begin
            $display("[SYSTEM] Timeout threshold is set to %0d cycles.", timeout_cycle);
        end
        else begin
            $display("[SYSTEM] Used default timeout setting %0d cycles.", timeout_cycle);
        end

        rst_n = 1'b0;
        #100;
        rst_n = 1'b1;
        //if(timeout_cycle == 0) begin
        //
        //end
        //else begin
        //for(int i=0;i<timeout_cycle;i=i+1) begin
        //    #20;
        //end
        //$fatal("[SYSTEM] Timeout occurs after executing %0d cycles !", timeout_cycle);
    end

    parameter STDIN = 32'h8000_0000;

    string command = "" ;    
    string char0        ;
    string char01       ;
    string char012      ;
    string print_buffer ;
    string print_char   ;

    logic [31:0]    pc                  ;
    logic [31:0]    target_pc           ;
    logic [31:0]    registers [0:31]    ;
    int tmp;

    generate for(genvar i=0;i<32;i=i+1) begin
        assign registers[i] = u_toy_scalar.u_core.u_dispatch.u_rf.registers[i];
    end endgenerate

    assign pc = u_toy_scalar.u_core.u_fetch.pc;

    initial begin
        if($test$plusargs("OPEN_LISTEN"))begin
                $display("OPEN LISTENING!!!");
                forever begin
                    for(int i=0;i<timeout_cycle;i=i+1) begin
                        #1000;
                    end
                    //$fatal("[SYSTEM] Timeout occurs after LISTENING %0d 10s !", timeout_cycle);
                end
        end
    end

    initial begin
        clk = 1'b0;

        if($test$plusargs("DEBUG")) begin
            $display("Toy Terminal:");
            forever begin
                $write("(toy):");
                tmp = $fscanf(STDIN, "%s", command);
                $display("command: \"%s\"",command);
                if(command == "") begin

                end
                else begin
                    char0       = $sformatf("%s", command.substr(0, 0));
                    char01      = $sformatf("%s", command.substr(0, 1));
                    char012     = $sformatf("%s", command.substr(0, 2));
                    if(char012 == "upc") begin
                        $display("Get upc command: \"%s\"", command);
                        if ($sscanf(command, "upc=%h", target_pc) == 1) begin
                            $display("Target pc = %h", target_pc);
                            forever begin
                                if(pc == target_pc) begin
                                    break; 
                                end
                                else begin
                                    #50;
                                    clk = ~clk;
                                    #50;
                                    clk = ~clk;
                                end
                            end
                        end else begin
                            $display("Failed to extract values from the string upc;");
                        end
                    end
                    else if (char012 == "reg") begin
                        $display("zero: 0x%h  ra: 0x%h  sp: 0x%h  gp: 0x%h", registers[0]    ,registers[1]   ,registers[2]   ,registers[3]   );
                        $display("  tp: 0x%h  t0: 0x%h  t1: 0x%h  t2: 0x%h", registers[4]    ,registers[5]   ,registers[6]   ,registers[7]   );
                        $display("  s0: 0x%h  s1: 0x%h  a0: 0x%h  a1: 0x%h", registers[8]    ,registers[9]   ,registers[10]  ,registers[11]  );
                        $display("  a2: 0x%h  a3: 0x%h  a4: 0x%h  a5: 0x%h", registers[12]   ,registers[13]  ,registers[14]  ,registers[15]  );
                        $display("  a6: 0x%h  a7: 0x%h  s2: 0x%h  s3: 0x%h", registers[16]   ,registers[17]  ,registers[18]  ,registers[19]  );
                        $display("  s4: 0x%h  s5: 0x%h  s6: 0x%h  s7: 0x%h", registers[20]   ,registers[21]  ,registers[22]  ,registers[23]  );
                        $display("  s8: 0x%h  s9: 0x%h s10: 0x%h s11: 0x%h", registers[24]   ,registers[25]  ,registers[26]  ,registers[27]  );
                        $display("  t3: 0x%h  t4: 0x%h  t5: 0x%h  t6: 0x%h", registers[28]   ,registers[29]  ,registers[30]  ,registers[31]  );

                    end

                    else if(char0 == "r") begin
                        #50;
                        clk = ~clk;
                        #50;
                        clk = ~clk;
                    end
                    else if(char0 == "q") begin
                        break;
                    end
                    else if(char0 == "\n") begin

                    end
                    else if(char01 == "pc") begin
                        $display("pc = %h", pc);
                    end
                end

            end
        end
        else begin
            forever begin
                #50;
                clk = ~clk;
                #50;
                clk = ~clk;
            end
        end
    end








    //always_ff @(posedge clk) begin
    initial begin
        print_char      = "";
        print_buffer    = "";
        forever begin

            @(posedge clk)
            if(en) begin
                if(wr_en) begin
                    //if($test$plusargs("DEBUG"))
                    if((addr>=0)&&(addr<=1023)) begin
                        $display("[SYSTEM][cycle=%d][pc=%h] Receive a cmd from core, cmd[%h] = %h", cycle, pc, addr, wr_data);

                        if($test$plusargs("DEBUG") | $test$plusargs("DUMP")) begin
                            for(int i=0;i<32;i++) begin
                                $display("x%0d = %h", i, registers[i]);
                            end
                        end
                        $display("[SYSTEM][cycle=%d][pc=%h] Receive exit command %h, exit.", cycle, pc, wr_data);

                        
                        if(wr_data[0]==1'b1) begin
                            if(wr_data[31:1]==0) begin
                                $display("receive exit signal 0, success exit.");
                                $finish;
                            end
                            else begin
                                $fatal("receive exit signal %d, fatal exit." , wr_data[31:1]);
                            end
                        end

                    end
                    else if(addr==1024) begin

                        $sformat(print_char, "%c", wr_data[7:0]);
                        if(print_char == "\n") begin
                            $display("[PRINT][cycle=%d] %s", cycle, print_buffer);
                            print_buffer = "";
                        end 
                        else begin
                            $sformat(print_buffer, "%s%s", print_buffer,print_char);
                        end
                       
                    end
                    else begin
                        
                    end
                end
            end
        end
    end

    initial begin
        if($test$plusargs("INTER"))begin
            forever begin
                @(posedge clk)
                if(intr_meip)begin
                $display("[PRINT][cycle=%d] SIM ENV external interrupt trigger cnt = %d", cycle ,inter_trigger_cnt);
                end

                if(inter_trigger_cnt>4)begin
                    $display("Trigger 4 times");
                    $finish;
                end
            end
        end
    end

//============================================================
// Jtag signal generation
//============================================================

 `ifdef OPEN_LISTEN
    jtagdpi u_jtagdpi(
      .clk_i(clk),
      .rst_ni(rst_n),

      .jtag_tck(jtag_clk),
      .jtag_tms(jtag_tms),
      .jtag_tdi(jtag_tdi),
      .jtag_tdo(jtag_tdo),
      .jtag_trst_n(jtag_rst_n),
      .jtag_srst_n(),
      .jtag_close()
    );
  `else
        assign jtag_tdi = 1'b0;
        assign jtag_clk = 1'b0;
        assign jtag_tms = 1'b0;
        assign jtag_rst_n = 1'b1;

  `endif

endmodule