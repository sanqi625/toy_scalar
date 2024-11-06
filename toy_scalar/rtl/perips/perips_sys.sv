//`define UART_TEST

module perips_sys
    import toy_pack::*;
    import debug_pack::*;
(
    input  logic             clk   ,
    input  logic             rst_n ,

`ifdef FPGA_SIM
    input  logic            ila_clk,
    input  logic [ADDR_WIDTH-1:0]      fetch_mem_req_addr      ,
    input  logic                       fetch_mem_req_vld       ,
`endif

    input  logic             peripheral_out0_req_vld    ,
	output logic             peripheral_out0_req_rdy    ,
	input  logic [31:0]      peripheral_out0_req_addr   ,
	input  logic [31:0]      peripheral_out0_req_data   ,
	input  logic [3:0]       peripheral_out0_req_strb   ,
	input  logic             peripheral_out0_req_opcode ,
	output logic             peripheral_out0_ack_vld    ,
	input  logic             peripheral_out0_ack_rdy    ,
	output logic [31:0]      peripheral_out0_ack_data   ,

    //usrt port
    input  logic             peri_uart_rx_i             ,
    output logic             peri_uart_tx_o             ,
    output logic             peri_uart_int              ,

    //gpio port
    input  logic [31:0]      peri_gpio_in               ,
    output logic [31:0]      peri_gpio_out              ,
    output logic [31:0]      peri_gpio_dir              ,
    output logic             peri_gpio_int
);

parameter APB_ADDR_WIDTH      = 32;
parameter PERI_APB_ADDR_WIDTH = 12;

logic [APB_ADDR_WIDTH - 1:0]    peri_apb_paddr;  
logic                           peri_apb_pwrite; 
logic                           peri_apb_psel;   
logic                           peri_apb_penable;
logic [31:0]                    peri_apb_pwdata; 
logic [31:0]                    peri_apb_prdata; 
logic                           peri_apb_pready; 
logic                           peri_apb_pslverr;



logic [APB_ADDR_WIDTH - 1:0]    m_paddr;  
logic                           m_pwrite; 
logic                           m_penable;
logic [31:0]                    m_pwdata; 
logic                           uart_psel;
logic                           gpio_psel;

logic [31:0]                    uart_prdata; 
logic                           uart_pready; 
logic                           uart_pslverr;
logic [31:0]                    gpio_prdata; 
logic                           gpio_pready; 
logic                           gpio_pslverr;

//logic                          peripheral_out0_req_read;
//logic                          peripheral_out0_req_write;
//assign peripheral_out0_req_read  = peripheral_out0_req_opcode==TOY_BUS_READ;
//assign peripheral_out0_req_write = peripheral_out0_req_opcode==TOY_BUS_WRITE; 

sysbus2apb u_susbus2apb(
    .clk                (clk           ),
    .rst_n              (rst_n         ),
    .bus_req_vld        (peripheral_out0_req_vld   ),
	.bus_req_rdy        (peripheral_out0_req_rdy   ),
	.bus_req_addr       (peripheral_out0_req_addr  ),
	.bus_req_data       (peripheral_out0_req_data  ),
	.bus_req_strb       (peripheral_out0_req_strb  ),  //not used
	.bus_req_opcode     (peripheral_out0_req_opcode),
	.bus_ack_vld        (peripheral_out0_ack_vld   ),
	.bus_ack_rdy        (peripheral_out0_ack_rdy   ),
	.bus_ack_data       (peripheral_out0_ack_data  ),

    .apb_paddr          (peri_apb_paddr  ),
    .apb_pwrite         (peri_apb_pwrite ),
    .apb_psel           (peri_apb_psel   ),
    .apb_penable        (peri_apb_penable), 
    .apb_pwdata         (peri_apb_pwdata ),
    .apb_prdata         (peri_apb_prdata ),
    .apb_pready         (peri_apb_pready ),
    .apb_pslverr        (peri_apb_pslverr)
  );

apb_bus u_apb_bus(
	.s_paddr        (peri_apb_paddr  ),
	.s_pwdata       (peri_apb_pwdata ),
	.s_pwrite       (peri_apb_pwrite ),
	.s_penable      (peri_apb_penable),
	.s_psel         (peri_apb_psel   ),
	.s_prdata       (peri_apb_prdata ),
	.s_pready       (peri_apb_pready ),
	.s_pslverr      (peri_apb_pslverr),

	.m_pwdata       (m_pwdata ),
	.m_pwrite       (m_pwrite ),
	.m_penable      (m_penable),
	.m_paddr        (m_paddr  ),

	.m0_psel        (uart_psel  ),
	.m1_psel        (gpio_psel  ),

	.m0_pready      (uart_pready),
	.m1_pready      (gpio_pready),

	.m0_rdata       (uart_prdata ),
	.m1_rdata       (gpio_prdata ),

	.m0_slverr      (uart_pslverr),
	.m1_slverr      (gpio_pslverr)    
    );

apb_uart_sv #(
    .APB_ADDR_WIDTH (PERI_APB_ADDR_WIDTH)  //APB slaves are 4KB by default
) u_apb_uart_sv (
    .CLK            (clk                ),
    .RSTN           (rst_n              ),
    .PADDR          (m_paddr[PERI_APB_ADDR_WIDTH-1:0]),
    .PWDATA         (m_pwdata           ),
    .PWRITE         (m_pwrite           ),
    .PSEL           (uart_psel          ),
    .PENABLE        (m_penable          ),
    .PRDATA         (uart_prdata         ),
    .PREADY         (uart_pready        ),
    .PSLVERR        (uart_pslverr       ),
    .rx_i           (peri_uart_rx_i     ),
    .tx_o           (peri_uart_tx_o     ),    
    .event_o        (peri_uart_int      )   
);

apb_gpio #(
    .APB_ADDR_WIDTH (PERI_APB_ADDR_WIDTH)  //APB slaves are 4KB by default
) u_apb_gpio (
    .HCLK           (clk                ),
    .HRESETn        (rst_n              ),
    .PADDR          (m_paddr[PERI_APB_ADDR_WIDTH-1:0]),
    .PWDATA         (m_pwdata           ),
    .PWRITE         (m_pwrite           ),
    .PSEL           (gpio_psel          ),
    .PENABLE        (m_penable          ),
    .PRDATA         (gpio_prdata        ),
    .PREADY         (gpio_pready        ),
    .PSLVERR        (gpio_pslverr       ),
    .gpio_in        (peri_gpio_in       ),
    .gpio_in_sync   (                   ),
    .gpio_out       (peri_gpio_out      ),
    .gpio_dir       (peri_gpio_dir      ),
    .gpio_padcfg    (                   ),
    .gpio_iof       (                   ),
    .interrupt      (peri_gpio_int      )
);

`ifdef UART_TEST

// UART receive
localparam  UART_DATA_WIDTH = 9;

string  print_char ;
string  print_buffer;
reg [UART_DATA_WIDTH-1:0] rx_data;
integer rx_count;
reg [7:0] rx_buffer[0:127];
reg [3:0] bit_index;
reg [15:0] sample_count;
reg receiving;
reg uart_print_en;

initial begin
    rx_count = 0;
    bit_index = 0;
    receiving = 0;
end

always @(posedge clk) begin
        if (receiving == 0) begin
            if (peri_uart_tx_o == 0) begin // detect start bit
                receiving <= 1;
                sample_count <= 0;
                bit_index <= 0;
                uart_print_en <= 0;
            end else begin
                receiving <= 0;
                sample_count <= 0;
                bit_index <= 0;
                uart_print_en <= 0;
            end
        end else begin
            if (sample_count == 52) begin 
                sample_count <= 0;
                uart_print_en <= (bit_index == UART_DATA_WIDTH-1) ? 1'b1 : 1'b0;
                if (bit_index < UART_DATA_WIDTH) begin
                    rx_data[bit_index] <= peri_uart_tx_o;
                    bit_index <= bit_index + 1;
                end else begin // receive stop bit
                    receiving <= 0;
                    rx_buffer[rx_count] <= rx_data;
                    rx_count <= rx_count + 1;
                end
            end else begin
                uart_print_en <= 1'b0;
                sample_count <= sample_count + 1;
            end
        end
end

//uart output test
initial begin
    print_char      = "";
    print_buffer    = "";
    forever begin

        @(posedge clk)
        if(uart_print_en) begin
                //if($test$plusargs("DEBUG")
                $sformat(print_char, "%c", rx_data[8:1]);
                if(print_char == "\n") begin
                    $display("[Perips][UART_OUTPUT] %s", print_buffer);
                    print_buffer = "";
                end 
                else begin
                    $sformat(print_buffer, "%s%s", print_buffer,print_char);
                end
            end
        end
end

`elsif TOY_SIM

logic   uart_en   ;
logic   wr_en     ;
string  print_char ;
string  print_buffer;

assign uart_en      = uart_psel && m_penable;
assign wr_en        = m_pwrite;

initial begin
    print_char      = "";
    print_buffer    = "";
    forever begin

        @(posedge clk)
        if(uart_en) begin
            if(wr_en) begin
                //if($test$plusargs("DEBUG")
                    $sformat(print_char, "%c", peri_apb_pwdata[7:0]);
                    if(print_char == "\n") begin
                        $display("[Perips][UART_INPUT] %s", print_buffer);
                        print_buffer = "";
                    end 
                    else begin
                        $sformat(print_buffer, "%s%s", print_buffer,print_char);
                    end
                end
            end
        end
end

`elsif FPGA_TEST

logic   uart_en   ;
logic   wr_en     ;
string  print_char ;
string  print_buffer;

assign uart_en      = uart_psel && m_penable;
assign wr_en        = m_pwrite;

initial begin
    print_char      = "";
    print_buffer    = "";
    forever begin

        @(posedge clk)
        if(uart_en) begin
            if(wr_en) begin
                //if($test$plusargs("DEBUG")
                    $sformat(print_char, "%c", peri_apb_pwdata[7:0]);
                    if(print_char == "\n") begin
                        $display("[Perips][UART_INPUT] %s", print_buffer);
                        print_buffer = "";
                    end 
                    else begin
                        $sformat(print_buffer, "%s%s", print_buffer,print_char);
                    end
                end
            end
        end
end

`endif

`ifdef FPGA_SIM
apb_uart_ila u_apb_uart_ila (
	.clk(ila_clk), // input wire clk

	.probe0(m_pwdata ), // input wire [31:0]  probe0  
	.probe1(m_pwrite ), // input wire [0:0]  probe1 
	.probe2(m_penable), // input wire [0:0]  probe2 
	.probe3(m_paddr  ), // input wire [31:0]  probe3 
	.probe4(uart_psel), // input wire [0:0]  probe4 
	.probe5(uart_pready), // input wire [0:0]  probe5
    .probe6(fetch_mem_req_addr),
    .probe7(fetch_mem_req_vld)
);

`endif

endmodule