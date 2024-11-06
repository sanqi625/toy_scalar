


module toy_mem_model #(
    parameter string            ARGPARSE_KEY    = "HEX" ,
    parameter integer unsigned  ALLOW_NO_HEX    = 1     ,
    parameter integer unsigned  ADDR_WIDTH      = 32    ,
    parameter integer unsigned  DATA_WIDTH      = 32
) (
    input  logic                     clk         ,

    input  logic                     en          ,
    input  logic [ADDR_WIDTH-1:0]    addr        ,
    output logic [DATA_WIDTH-1:0]    rd_data     ,
    input  logic [DATA_WIDTH-1:0]    wr_data     ,
    input  logic [DATA_WIDTH/8-1:0]  wr_byte_en  ,
    input  logic                     wr_en       
);

    //logic [DATA_WIDTH-1:0] mem [0:1<<10-1];

    typedef logic [31:0]    logic_32         ;


    logic_32                memory[logic_32]    ;
    logic   [31:0]          tmp_data            ;
    string                  arg_parse_str       ;
    string                  code_path           ;

    function logic_32 read_memory(logic_32 address);
        logic_32 data;

        if (memory.exists(address)) begin
            data = memory[address];
        end else begin
            memory[address] = 'x;
            data = 'x; 
        end

        return data;
    endfunction





    initial begin
        $sformat(arg_parse_str, "%s=%%s", ARGPARSE_KEY);
        
        // memory initialize ===========================================================
        if($value$plusargs(arg_parse_str, code_path)) begin
            $readmemh(code_path, memory);
            if($test$plusargs("DEBUG")) begin
                $display("print memory first 10 row parse from arg %s:", ARGPARSE_KEY);
                for(int i=0;i<10;i++) begin
                    $display("memory row[%0d] = %h" , i, read_memory(i));
                end
            end
        end else begin
            if(ALLOW_NO_HEX!=0) begin
                if($test$plusargs("DEBUG"))
                    $info("Missing required parameter +%s",ARGPARSE_KEY);
            end
            else begin
                $error("Missing required parameter +%s",ARGPARSE_KEY);
                $finish;
            end
        end

        // memory write handler ========================================================
        forever begin
            @(posedge clk)
            if(wr_en && en) begin
                tmp_data = read_memory(addr);

                if(wr_byte_en[0]) tmp_data[7 : 0] = wr_data[7 : 0];
                if(wr_byte_en[1]) tmp_data[15: 8] = wr_data[15: 8];
                if(wr_byte_en[2]) tmp_data[23:16] = wr_data[23:16];
                if(wr_byte_en[3]) tmp_data[31:24] = wr_data[31:24];

                memory[addr] <= tmp_data;
            end
        end
    end


    // memory read handler =========================================================
    initial begin
        forever begin
            @(posedge clk)            
            if(en && ~wr_en) rd_data <= read_memory(addr);
        end
    end




    initial begin
        if($test$plusargs("DEBUG")) begin
            forever begin
                @(posedge clk)
                if(en)
                    if(wr_en)
                        $display("[%s][wr] %h : %h", ARGPARSE_KEY, addr, wr_data    );
                    else
                        $display("[%s][rd] %h : %h", ARGPARSE_KEY, addr, memory[addr]  );
            end
        end
    end



endmodule





