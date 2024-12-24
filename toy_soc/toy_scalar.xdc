set_property PACKAGE_PIN Y9 [get_ports clk_in_p]
set_property PACKAGE_PIN E15 [get_ports {gpio_out[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {gpio_out[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {gpio_out[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {gpio_out[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {gpio_out[3]}]
set_property PACKAGE_PIN W17 [get_ports {gpio_out[2]}]
set_property PACKAGE_PIN W5 [get_ports {gpio_out[3]}]
set_property PACKAGE_PIN D15 [get_ports {gpio_out[1]}]

set_property PACKAGE_PIN V7 [get_ports led_host_en]
set_property IOSTANDARD LVCMOS25 [get_ports led_host_en]

set_property IOSTANDARD LVDS_25 [get_ports clk_in_p]
set_property PACKAGE_PIN V10 [get_ports jtag_clk]
set_property PACKAGE_PIN V9 [get_ports jtag_tms]
set_property PACKAGE_PIN V8 [get_ports jtag_tdi]
set_property PACKAGE_PIN R7 [get_ports jtag_tdo]

set_property PACKAGE_PIN G19 [get_ports intr_meip]
set_property IOSTANDARD LVCMOS25 [get_ports intr_meip]

set_property PACKAGE_PIN F19 [get_ports push_rst]
set_property PACKAGE_PIN P18 [get_ports peri_uart_rx_i]
set_property PACKAGE_PIN W10 [get_ports peri_uart_tx_o]
set_property IOSTANDARD LVCMOS25 [get_ports peri_uart_tx_o]
set_property IOSTANDARD LVCMOS25 [get_ports peri_uart_rx_i]

set_property IOSTANDARD LVCMOS25 [get_ports jtag_clk]
set_property IOSTANDARD LVCMOS25 [get_ports jtag_tdi]
set_property IOSTANDARD LVCMOS25 [get_ports jtag_tdo]
set_property IOSTANDARD LVCMOS25 [get_ports jtag_tms]

set_property IOSTANDARD LVCMOS25 [get_ports push_rst]

#main clock
set DIFF_CLK_PERIOD 6.4
set MAIN_CLK_PERIOD 100

set MAIN_CLK_MIN 0
set MAIN_CLK_MAX 0.3

set UNCERTAINTY_SETUP 0.3
set UNCERTAINTY_HOLDUP 0.05

create_clock -period $DIFF_CLK_PERIOD -name diff_clk [get_ports clk_in_p]
#create_generated_clock -name main_clk -source [get_ports clk_in_p] -divide_by 15.6 [get_pins u_clk_gen/clk_out1]

#create_generated_clock -name main_clk -source [get_ports clk_in_p] -edges {1 2 3} -edge_shift {0.000 46.800 93.600} [get_pins u_clk_src/clk_out1]
#create_generated_clock -name ila_clk  -source [get_ports clk_in_p] -edges {1 2 3} -edge_shift {0.000 13.600 27.200} [get_pins u_clk_src/ila_clk]

create_generated_clock -name main_clk -source [get_ports clk_in_p] -edges {1 2 3} -edge_shift {0.000 80.133 160.267} [get_pins u_clk_src/clk_out1]
create_generated_clock -name ila_clk  -source [get_ports clk_in_p] -edges {1 2 3} -edge_shift {0.000 13.467 26.933 } [get_pins u_clk_src/ila_clk]

set_clock_uncertainty -setup [expr $UNCERTAINTY_SETUP*$DIFF_CLK_PERIOD] [get_clocks diff_clk]
set_clock_uncertainty -hold  [expr $UNCERTAINTY_HOLDUP] [get_clocks diff_clk]

set_input_delay -clock main_clk -min [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MIN] [get_ports peri_uart_rx_i]
set_input_delay -clock main_clk -max [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MAX] [get_ports peri_uart_rx_i]

set_output_delay -clock main_clk -min [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MIN] [get_ports peri_uart_tx_o]
set_output_delay -clock main_clk -max [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MAX] [get_ports peri_uart_tx_o]
set_output_delay -clock main_clk -min [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MIN] [get_ports gpio_out[0]]
set_output_delay -clock main_clk -max [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MAX] [get_ports gpio_out[0]]
set_output_delay -clock main_clk -min [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MIN] [get_ports gpio_out[1]]
set_output_delay -clock main_clk -max [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MAX] [get_ports gpio_out[1]]
set_output_delay -clock main_clk -min [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MIN] [get_ports gpio_out[2]]
set_output_delay -clock main_clk -max [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MAX] [get_ports gpio_out[2]]
set_output_delay -clock main_clk -min [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MIN] [get_ports gpio_out[3]]
set_output_delay -clock main_clk -max [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MAX] [get_ports gpio_out[3]]

set_output_delay -clock main_clk -min [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MIN] [get_ports led_host_en]
set_output_delay -clock main_clk -max [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MAX] [get_ports led_host_en]

#set_false_path -through [get_ports peri_uart_rx_i]
#set_false_path -through [get_ports peri_uart_tx_o]
#set_false_path -through [get_ports gpio_out[0]]
#set_false_path -through [get_ports gpio_out[1]]
#set_false_path -through [get_ports gpio_out[2]]
#set_false_path -through [get_ports gpio_out[3]]

#jtag clock

set JTAG_CLK_PERIOD 1000
set JTAG_CLK_DELAY_MIN 0
set JTAG_CLK_DELAY_MAX 0.3

create_clock -period $JTAG_CLK_PERIOD -name jtag_clk [get_ports jtag_clk]
create_generated_clock -name jtag_clk_bufg -source [get_ports jtag_clk] -divide_by 1 [get_pins bufg_inst/O]

set_clock_uncertainty -setup [expr $UNCERTAINTY_SETUP*$JTAG_CLK_PERIOD] [get_clocks jtag_clk_bufg]
set_clock_uncertainty -hold  [expr $UNCERTAINTY_HOLDUP] [get_clocks jtag_clk_bufg]

set_input_delay -clock jtag_clk_bufg -min [expr $JTAG_CLK_PERIOD*$JTAG_CLK_DELAY_MIN] [get_ports jtag_tdi]
set_input_delay -clock jtag_clk_bufg -max [expr $JTAG_CLK_PERIOD*$JTAG_CLK_DELAY_MAX] [get_ports jtag_tdi]
set_input_delay -clock jtag_clk_bufg -min [expr $JTAG_CLK_PERIOD*$JTAG_CLK_DELAY_MIN] [get_ports jtag_tms]
set_input_delay -clock jtag_clk_bufg -max [expr $JTAG_CLK_PERIOD*$JTAG_CLK_DELAY_MAX] [get_ports jtag_tms]

set_output_delay -clock jtag_clk_bufg -min [expr $JTAG_CLK_PERIOD*$JTAG_CLK_DELAY_MIN] -clock_fall [get_ports jtag_tdo]
set_output_delay -clock jtag_clk_bufg -max [expr $JTAG_CLK_PERIOD*$JTAG_CLK_DELAY_MAX] -clock_fall  [get_ports jtag_tdo]

#async clock
set_clock_groups -asynchronous -group [get_clocks main_clk] \
                                -group [get_clocks jtag_clk_bufg] \
                                -group [get_clocks ila_clk]

##reset and external interrupt
set_input_delay -clock main_clk -min [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MIN] [get_ports push_rst]
set_input_delay -clock main_clk -max [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MAX] [get_ports push_rst]
set_input_delay -clock main_clk -min [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MIN] [get_ports intr_meip]
set_input_delay -clock main_clk -max [expr $MAIN_CLK_PERIOD*$MAIN_CLK_MAX] [get_ports intr_meip]

#constrain external clock

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets jtag_clk_buf]
