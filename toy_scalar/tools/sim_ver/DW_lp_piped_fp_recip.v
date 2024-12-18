////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 2009 - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Bruce Dean       2/20/09
//
// VERSION:   Verilog Simulation Model
//
// DesignWare_version: ef4e0a9d
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//
// ABSTRACT: Low power pipelined Floating Point Reciprocal Simulation Model 
//
//           This receives operand in which the reciprocal operation is performed.
//           Configurable to provide pipeline registers for both static and re-timing placement.
//           Also, contains pipeline management to optimized for low power.
//
//  parameters:     Valid Values    Description
//  ==========      ============    =============
//   sig_width           >= 1         default: 8
//                                  Width of 'a' operand
//
//   exp_width           >= 1         default: 8
//                                  Width of 'a' operand
//
//   ieee_compliance    0 to 1      support the IEEE Compliance 
//                       0        - IEEE 754 compatible without denormal support
//                                  (NaN becomes Infinity, Denormal becomes Zero)
//                       1        - IEEE 754 compatible with denormal support
//                                  (NaN and denormal numbers are supported)
//   faithful_round     0 to 1      select the faithful_rounding that admits 1 ulp error
//                                  0- default value. it keeps all rounding modes
//                                  1- z has 1 ulp error. RND input does not affect
//                                  the output
//   op_iso_mode      0 to 4        default: 0
//                                  Type of operand isolation
//                                    If 'in_reg' is '1', this parameter is ignored...effectively set to '1'.
//                                    0 => Follow intent defined by Power Compiler user setting
//                                    1 => no operand isolation
//                                    2 => 'and' gate isolaton
//                                    3 => 'or' gate isolation
//                                    4 => preferred isolation style: 'and' gate
//
//   id_width        1 to 1024      default: 8
//                                  Launch identifier width
//
//   in_reg          0 to 1         default: 0
//                                  Input register control
//                                    0 => no input register
//                                    1 => include input register
//
//   stages          1 to 1022      default: 4
//                                  Number of logic stages in the pipeline
//
//   out_reg         0 to 1         default: 0
//                                  Output register control
//                                    0 => no output register
//                                    1 => include output register
//
//   no_pm            0 to 1        default: 1
//                                  No pipeline management used
//                                    0 => Use pipeline management
//                                    1 => Do not use pipeline management - launch input
//                                          becomes global register enable to block
//
//   rst_mode        0 to 1         default: 0
//                                  Control asynchronous or synchronous reset 
//                                  behavior of rst_n
//                                    0 => asynchronous reset
//                                    1 -> synchronous reset 
//
//  ports       Size            Direction    Description
//  =====       ====            =========    ===========
//  clk         1 bit           Input	     Clock Input
//  rst_n       1 bit           Input	     Reset Input, Active Low
//
//  a           M bits	        Input	     reciprocand
//  rnd         3 bits          Input        Rounding mode
//  z           M bits	        Output       z = 1/a
//  IIl0IO11  8 bits          Output     
//
//  launch      1 bit           Input	     Active High Control input to launch data into pipe
//  launch_id   id_width bits   Input	     ID tag for data being launched (optional)
//  pipe_full   1 bit           Output       Status Flag indicating no slot for new data
//  pipe_ovf    1 bit           Output       Status Flag indicating pipe overflow
//
//  accept_n    1 bit           Input	     Flow Control Input, Active Low
//  arrive      1 bit           Output       Data Available output
//  arrive_id   id_width bits   Output       ID tag for data that's arrived (optional)
//  push_out_n  1 bit           Output       Active Low Output used with FIFO (optional)
//  pipe_census R bits          Output       Output bus indicating the number
//                                           of pipe stages currently occupied
//
//  * where M equals   sig_width +exp_width+1 bits                                       
//                                           
// Modified:
//  DLL  05/20/21  Fixed mismatch of 'z' and 'status' when "in_reg=1" and "no_pm=1"
//                 to synthesis model addressed by STAR #9001427904
//
//  RJK  03/08/17  Corrected port order to match synthesis model
//
//  LMSU 02/17/15  Updated to eliminate derived internal clock and reset signals
//
////////////////////////////////////////////////////////////////////////////////
module DW_lp_piped_fp_recip(clk,rst_n,a,rnd,z,status,launch,launch_id,
                       pipe_full,pipe_ovf,accept_n,arrive,arrive_id,push_out_n,pipe_census);

parameter integer sig_width       = 23;
parameter integer exp_width       = 8;
parameter integer ieee_compliance = 0;
parameter integer faithful_round  = 0;
parameter integer op_iso_mode     = 0;
parameter integer id_width        = 8;
parameter integer in_reg          = 0;
parameter integer stages          = 4;
parameter integer out_reg         = 0;
parameter integer no_pm           = 1;
parameter integer rst_mode        = 0;



input                    clk;    // Clock Input
input                    rst_n;  // Async. Reset
input  [(sig_width+exp_width):0]     a;      // Dividend In
input  [2:0]             rnd;    // rounding mode
output [(sig_width+exp_width):0]     z;      // Pipelined z of a / b
output [7:0]             status; // Pipelined b == 0 flag

input                    launch;      // Input to launch data into pipe
input  [id_width-1:0]    launch_id;   // ID tag of data launched
output                   pipe_full;   // Pipe Slots Full Output (used for flow control)
output                   pipe_ovf;    // Pipe Overflow Signal

input                    accept_n;    // Hold Data Out Input (flow control)
output                   arrive;      // Data Arrival Output
output [id_width-1:0]    arrive_id;   // ID tag of arrival data
output                   push_out_n;  // Active Low Output used when FIFO follows

output [(((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>256)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4096)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16384)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32768)?16:15):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8192)?14:13)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>1024)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2048)?12:11):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>512)?10:9))):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>64)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>128)?8:7):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32)?6:5)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8)?4:3):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2)?2:1)))))-1:0] pipe_census; // Pipe Stages Occupied Output

// synopsys translate_off
wire  [(sig_width+exp_width):0]          OI1O01lO;
wire  [2:0]                  OI10OlI0;
wire                         l11Ol0O0;
wire  [id_width-1:0]         lO10OO00;
wire                         OIOl1I1O;

reg   [(sig_width+exp_width):0]          OOOOOOI0;
reg   [2:0]                  lI1I0OOl;
wire  [(sig_width+exp_width):0]          IO1000lI;
wire  [2:0]                  OI1lO0I1;

wire  [((sig_width+exp_width + 1)+2):0]         lIl00lI0;

wire  [(sig_width+exp_width):0]          IO010OOI;
wire  [(sig_width+exp_width + 8):0]        O0l1OO11;
wire  [(sig_width+exp_width + 8):0]        O11lOOO1;

wire  [7:0]                  IIl0IO11;

wire  [(((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)-1:0] OI1OI1I1;
reg   [((stages-1+out_reg<1) ? 1 : stages-1+out_reg)-1:0] l0100OlO;

wire                         l000111I;
wire                         OIlI001I;
wire                         IO111llO;
wire  [id_width-1:0]         OO0OOOOI;
wire                         OOl1O1l1;
wire  [(((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)-1:0] lOIIlIIl;
wire  [(((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>256)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4096)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16384)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32768)?16:15):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8192)?14:13)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>1024)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2048)?12:11):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>512)?10:9))):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>64)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>128)?8:7):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32)?6:5)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8)?4:3):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2)?2:1)))))-1:0]      ll001l10;

wire                         O1OIOOI1;
wire                         O1OOOI00;
reg                          OlIOIOII;
wire                         l101I11l;
wire  [id_width-1:0]         OIIl10OO;
wire  [id_width-1:0]         O0IIO1Il;
wire                         llIOl1Ol;
wire  [(((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)-1:0] O11IOOlI;
wire  [(((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>256)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4096)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16384)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32768)?16:15):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8192)?14:13)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>1024)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2048)?12:11):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>512)?10:9))):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>64)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>128)?8:7):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32)?6:5)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8)?4:3):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2)?2:1)))))-1:0]      IO001110;

assign lIl00lI0    = {a, rnd};

assign {OI1O01lO, OI10OlI0} = (lIl00lI0 | (lIl00lI0 ^ lIl00lI0));
assign l11Ol0O0              = (launch | (launch ^ launch));
assign lO10OO00           = (launch_id | (launch_id ^ launch_id));
assign OIOl1I1O            = (accept_n | (accept_n ^ accept_n));

generate if (rst_mode==0) begin : DW_OO01I1OO
  always @ (posedge clk or negedge rst_n) begin : input_registers_PROC
    if (rst_n === 1'b0) begin
      OOOOOOI0   <= {(sig_width+exp_width)+1{1'b0}};
      lI1I0OOl <= {3{1'b0}};
    end else if (rst_n === 1'b1) begin
      if (OI1OI1I1[0] === 1'b1) begin
        OOOOOOI0   <= OI1O01lO;
        lI1I0OOl <= OI10OlI0;
      end else if (OI1OI1I1[0] !== 1'b0) begin
        OOOOOOI0   <= ((OOOOOOI0 ^ OI1O01lO) & {(sig_width+exp_width)+1{1'bx}}) ^ OOOOOOI0;
        lI1I0OOl <= ((lI1I0OOl ^ OI10OlI0) & {3{1'bx}}) ^ lI1I0OOl;
      end
    end else begin
      OOOOOOI0   <= {(sig_width+exp_width)+1{1'bx}};
      lI1I0OOl <= {3{1'bx}};
    end
  end
end else begin : DW_l0O1OIOO
  always @ (posedge clk) begin : input_registers_PROC
    if (rst_n === 1'b0) begin
      OOOOOOI0   <= {(sig_width+exp_width)+1{1'b0}};
      lI1I0OOl <= {3{1'b0}};
    end else if (rst_n === 1'b1) begin
      if (OI1OI1I1[0] === 1'b1) begin
        OOOOOOI0   <= OI1O01lO;
        lI1I0OOl <= OI10OlI0;
      end else if (OI1OI1I1[0] !== 1'b0) begin
        OOOOOOI0   <= ((OOOOOOI0 ^ OI1O01lO) & {(sig_width+exp_width)+1{1'bx}}) ^ OOOOOOI0;
        lI1I0OOl <= ((lI1I0OOl ^ OI10OlI0) & {3{1'bx}}) ^ lI1I0OOl;
      end
    end else begin
      OOOOOOI0   <= {(sig_width+exp_width)+1{1'bx}};
      lI1I0OOl <= {3{1'bx}};
    end
  end
end endgenerate

assign IO1000lI   = (in_reg==0) ?   OI1O01lO :   OOOOOOI0;
assign OI1lO0I1 = (in_reg==0) ? OI10OlI0 : lI1I0OOl;

reg   [id_width-1 : 0]     O1I110I1 [0 : ((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2))];





generate
  if (rst_mode==0) begin
    always @ (posedge clk or negedge rst_n) begin : PROC_pl_registers_arrive_id
      integer l11l0Ol1;

      if (rst_n === 1'b0) begin
        for (l11l0Ol1=0 ; l11l0Ol1 <= ((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2)) ; l11l0Ol1=l11l0Ol1+1) begin
          O1I110I1[l11l0Ol1] <= {id_width{1'b0}};
        end
      end else if (rst_n === 1'b1) begin
        for (l11l0Ol1=0 ; l11l0Ol1 <= ((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2)) ; l11l0Ol1=l11l0Ol1+1) begin
          if (OI1OI1I1[l11l0Ol1] === 1'b1)
            O1I110I1[l11l0Ol1] <= (l11l0Ol1 == 0)? lO10OO00 : O1I110I1[l11l0Ol1-1];
          else if (OI1OI1I1[l11l0Ol1] !== 1'b0)
            O1I110I1[l11l0Ol1] <= ((O1I110I1[l11l0Ol1] ^ ((l11l0Ol1 == 0)? lO10OO00 : O1I110I1[l11l0Ol1-1]))
          		      & {id_width{1'bx}}) ^ O1I110I1[l11l0Ol1];
        end
      end else begin
        for (l11l0Ol1=0 ; l11l0Ol1 <= ((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2)) ; l11l0Ol1=l11l0Ol1+1) begin
          O1I110I1[l11l0Ol1] <= {id_width{1'bx}};
        end
      end
    end
  end else begin
    always @ (posedge clk) begin : PROC_pl_registers_arrive_id
      integer l11l0Ol1;

      if (rst_n === 1'b0) begin
        for (l11l0Ol1=0 ; l11l0Ol1 <= ((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2)) ; l11l0Ol1=l11l0Ol1+1) begin
          O1I110I1[l11l0Ol1] <= {id_width{1'b0}};
        end
      end else if (rst_n === 1'b1) begin
        for (l11l0Ol1=0 ; l11l0Ol1 <= ((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2)) ; l11l0Ol1=l11l0Ol1+1) begin
          if (OI1OI1I1[l11l0Ol1] === 1'b1)
            O1I110I1[l11l0Ol1] <= (l11l0Ol1 == 0)? lO10OO00 : O1I110I1[l11l0Ol1-1];
          else if (OI1OI1I1[l11l0Ol1] !== 1'b0)
            O1I110I1[l11l0Ol1] <= ((O1I110I1[l11l0Ol1] ^ ((l11l0Ol1 == 0)? lO10OO00 : O1I110I1[l11l0Ol1-1]))
          		      & {id_width{1'bx}}) ^ O1I110I1[l11l0Ol1];
        end
      end else begin
        for (l11l0Ol1=0 ; l11l0Ol1 <= ((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2)) ; l11l0Ol1=l11l0Ol1+1) begin
          O1I110I1[l11l0Ol1] <= {id_width{1'bx}};
        end
      end
    end
  end
endgenerate

  assign O0IIO1Il = (in_reg+stages+out_reg == 1)? lO10OO00 : O1I110I1[((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2))];


DW_fp_recip #(sig_width, exp_width, 
	    ieee_compliance, faithful_round) 
  U_fp_recip (
	    .a(IO1000lI),
	    .rnd(OI1lO0I1),
	    .z(IO010OOI),
	    .status(IIl0IO11) );

assign O0l1OO11 = {IO010OOI,(IIl0IO11 ^ 8'b00000001)};
  

reg   [(sig_width+exp_width + 8) : 0]     OI0O1OI0 [0 : stages-1];




  reg   [(sig_width+exp_width + 8) +1 -1 : 0]     pl_input_reg;
  reg   [(sig_width+exp_width + 8) +1 -1 : 0]     pl_output_reg;
  localparam REG_IN   = 0;

  always @(O0l1OO11 or pl_input_reg) begin : PROC_pl_regs_index0
    reg   [(sig_width+exp_width + 8) +1 -1 : 0]     pl_pipe_in_data;

    if (REG_IN == 0) begin
      pl_pipe_in_data = O0l1OO11;
    end else begin
      pl_pipe_in_data = pl_input_reg;
    end

    OI0O1OI0[0] = pl_pipe_in_data;
  end

generate
  if (rst_mode==0) begin
    always @ (posedge clk or negedge rst_n) begin : PROC_pl_registers
      integer l11l0Ol1;

      if (rst_n === 1'b0) begin
        pl_input_reg <= {(sig_width+exp_width + 8) +1 {1'b0}};
        for (l11l0Ol1=1; l11l0Ol1<=stages-1; l11l0Ol1=l11l0Ol1+1) begin
          OI0O1OI0[l11l0Ol1] <= {(sig_width+exp_width + 8) +1 {1'b0}};
        end
        pl_output_reg <= {(sig_width+exp_width + 8) +1 {1'b0}};
      end else if (rst_n === 1'b1) begin
        if (l0100OlO[0] === 1'b1)
          pl_input_reg <= O0l1OO11;
        else if (l0100OlO[0] !== 1'b0)
          pl_input_reg <= (pl_input_reg ^ O0l1OO11 & {(sig_width+exp_width + 8) +1 {1'bx}}) ^ pl_input_reg;
        for (l11l0Ol1=1; l11l0Ol1<=stages-1; l11l0Ol1=l11l0Ol1+1) begin
          if (l0100OlO[l11l0Ol1-1+REG_IN] === 1'b1)
            OI0O1OI0[l11l0Ol1] <= OI0O1OI0[l11l0Ol1-1];
          else if (l0100OlO[l11l0Ol1-1+REG_IN] !== 1'b0)
            OI0O1OI0[l11l0Ol1] <= (OI0O1OI0[l11l0Ol1] ^ OI0O1OI0[l11l0Ol1-1] & {(sig_width+exp_width + 8) +1 {1'bx}}) ^ OI0O1OI0[l11l0Ol1];
        end
        if (l0100OlO[(((stages-1+out_reg<1) ? 1 : stages-1+out_reg)-1)] === 1'b1)
          pl_output_reg <= OI0O1OI0[stages-1];
        else if (l0100OlO[(((stages-1+out_reg<1) ? 1 : stages-1+out_reg)-1)] !== 1'b0)
          pl_output_reg <= (pl_output_reg ^ OI0O1OI0[stages-1] & {(sig_width+exp_width + 8) +1 {1'bx}}) ^ pl_output_reg;
      end else begin
        pl_input_reg <= {(sig_width+exp_width + 8) +1 {1'bx}};
        for (l11l0Ol1=1; l11l0Ol1<=stages-1; l11l0Ol1=l11l0Ol1+1) begin
          OI0O1OI0[l11l0Ol1] <= {(sig_width+exp_width + 8) +1 {1'bx}};
        end
        pl_output_reg <= {(sig_width+exp_width + 8) +1 {1'bx}};
      end
    end
  end else begin
    always @ (posedge clk) begin : PROC_pl_registers
      integer l11l0Ol1;

      if (rst_n === 1'b0) begin
        pl_input_reg <= {(sig_width+exp_width + 8) +1 {1'b0}};
        for (l11l0Ol1=1; l11l0Ol1<=stages-1; l11l0Ol1=l11l0Ol1+1) begin
          OI0O1OI0[l11l0Ol1] <= {(sig_width+exp_width + 8) +1 {1'b0}};
        end
        pl_output_reg <= {(sig_width+exp_width + 8) +1 {1'b0}};
      end else if (rst_n === 1'b1) begin
        if (l0100OlO[0] === 1'b1)
          pl_input_reg <= O0l1OO11;
        else if (l0100OlO[0] !== 1'b0)
          pl_input_reg <= (pl_input_reg ^ O0l1OO11 & {(sig_width+exp_width + 8) +1 {1'bx}}) ^ pl_input_reg;
        for (l11l0Ol1=1; l11l0Ol1<=stages-1; l11l0Ol1=l11l0Ol1+1) begin
          if (l0100OlO[l11l0Ol1-1+REG_IN] === 1'b1)
            OI0O1OI0[l11l0Ol1] <= OI0O1OI0[l11l0Ol1-1];
          else if (l0100OlO[l11l0Ol1-1+REG_IN] !== 1'b0)
            OI0O1OI0[l11l0Ol1] <= (OI0O1OI0[l11l0Ol1] ^ OI0O1OI0[l11l0Ol1-1] & {(sig_width+exp_width + 8) +1 {1'bx}}) ^ OI0O1OI0[l11l0Ol1];
        end
        if (l0100OlO[(((stages-1+out_reg<1) ? 1 : stages-1+out_reg)-1)] === 1'b1)
          pl_output_reg <= OI0O1OI0[stages-1];
        else if (l0100OlO[(((stages-1+out_reg<1) ? 1 : stages-1+out_reg)-1)] !== 1'b0)
          pl_output_reg <= (pl_output_reg ^ OI0O1OI0[stages-1] & {(sig_width+exp_width + 8) +1 {1'bx}}) ^ pl_output_reg;
      end else begin
        pl_input_reg <= {(sig_width+exp_width + 8) +1 {1'bx}};
        for (l11l0Ol1=1; l11l0Ol1<=stages-1; l11l0Ol1=l11l0Ol1+1) begin
          OI0O1OI0[l11l0Ol1] <= {(sig_width+exp_width + 8) +1 {1'bx}};
        end
        pl_output_reg <= {(sig_width+exp_width + 8) +1 {1'bx}};
      end
    end
  end
endgenerate

  assign O11lOOO1 = (in_reg+stages+out_reg == 1) ? O0l1OO11 :
                                     (out_reg == 1) ? pl_output_reg :
                                                       OI0O1OI0[stages-1];



generate
  if (rst_mode==0) begin : DW_lO10lOO1
    DW_lp_pipe_mgr #((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1), id_width) 
      U_PIPE_MGR (
              .clk(clk),
              .rst_n(rst_n),
              .init_n(1'b1),
              .launch(l11Ol0O0),
              .launch_id(lO10OO00),
              .accept_n(OIOl1I1O),
              .arrive(IO111llO),
              .arrive_id(OO0OOOOI),
              .pipe_en_bus(lOIIlIIl),
              .pipe_full(l000111I),
              .pipe_ovf(OIlI001I),
              .push_out_n(OOl1O1l1),
              .pipe_census(ll001l10)
              );
  end else begin : DW_O1100l0I
    DW_lp_pipe_mgr #((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1), id_width) 
      U_PIPE_MGR (
              .clk(clk),
              .rst_n(1'b1),
              .init_n(rst_n),
              .launch(l11Ol0O0),
              .launch_id(lO10OO00),
              .accept_n(OIOl1I1O),
              .arrive(IO111llO),
              .arrive_id(OO0OOOOI),
              .pipe_en_bus(lOIIlIIl),
              .pipe_full(l000111I),
              .pipe_ovf(OIlI001I),
              .push_out_n(OOl1O1l1),
              .pipe_census(ll001l10)
              );
  end
endgenerate

assign l101I11l         = l11Ol0O0;
assign OIIl10OO      = lO10OO00;
assign O11IOOlI    = {(((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1){1'b1}};
assign O1OIOOI1      = OIOl1I1O;
assign O1OOOI00  = O1OIOOI1 && l101I11l;
assign llIOl1Ol     = ~(~OIOl1I1O && l11Ol0O0);
assign IO001110    = {(((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>256)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4096)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16384)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32768)?16:15):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8192)?14:13)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>1024)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2048)?12:11):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>512)?10:9))):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>64)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>128)?8:7):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32)?6:5)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8)?4:3):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2)?2:1))))){1'b0}};

assign arrive_id        = ((in_reg+stages+out_reg) > 1) ? (no_pm ? O0IIO1Il: OO0OOOOI) : OIIl10OO;
assign OI1OI1I1  = ((in_reg+stages+out_reg) > 1) ? (no_pm ? {(((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1){launch}} : lOIIlIIl) : O11IOOlI;
assign pipe_full        =   no_pm ? 1'b0 : ((in_reg+stages+out_reg) > 1) ? l000111I     : O1OIOOI1;
assign pipe_ovf         =   no_pm ? 1'b0 : ((in_reg+stages+out_reg) > 1) ? OIlI001I      : OlIOIOII;

assign arrive           =   no_pm ? 1'b0 : ((in_reg+stages+out_reg) > 1) ? IO111llO        : l101I11l;
assign push_out_n       =   no_pm ? 1'b0 : ((in_reg+stages+out_reg) > 1) ? OOl1O1l1    : llIOl1Ol;
assign pipe_census      =   no_pm ? 1'b0 : ((in_reg+stages+out_reg) > 1) ? ll001l10   : IO001110;

generate
  if (in_reg == 1) begin : DW_I1011OlI
    always @(OI1OI1I1) begin : O1I110IO_PROC
      reg [31:0] l11l0Ol1;
      for (l11l0Ol1=1; l11l0Ol1< (((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1); l11l0Ol1=l11l0Ol1+1) begin
        l0100OlO[l11l0Ol1-1] = OI1OI1I1[l11l0Ol1];
      end 
    end  
  end else begin : DW_I110I1Ol
    always @(OI1OI1I1) begin : O1I110IO_PROC
      l0100OlO = OI1OI1I1;
    end  // O1I110IO_PROC
  end
endgenerate   

generate
  if (rst_mode==0) begin : DW_IOl0O10O
    always @ (posedge clk or negedge rst_n) begin : posedge_registers_PROC
      if (rst_n === 1'b0) begin
        OlIOIOII     <= 1'b0;
      end else if (rst_n === 1'b1) begin
        OlIOIOII     <= O1OOOI00;
      end else begin
        OlIOIOII     <= 1'bx;
      end
    end
  end else begin : DW_O0IO110O
    always @ (posedge clk) begin : posedge_registers_PROC
      if (rst_n === 1'b0) begin
        OlIOIOII     <= 1'b0;
      end else if (rst_n === 1'b1) begin
        OlIOIOII     <= O1OOOI00;
      end else begin
        OlIOIOII     <= 1'bx;
      end
    end
  end
endgenerate

  assign z      = O11lOOO1[sig_width+exp_width+8 : 8];
  assign status = O11lOOO1[7:0] ^ 8'b00000001;


  //-------------------------------------------------------------------------
  // Parameter legality check
  //-------------------------------------------------------------------------
  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
  
    if ( (sig_width < 3) || (sig_width > 253) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter sig_width (legal range: 3 to 253)",
	sig_width );
    end
  
    if ( (exp_width < 3) || (exp_width > 31) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter exp_width (legal range: 3 to 31)",
	exp_width );
    end
  
    if ( (ieee_compliance < 0) || (ieee_compliance > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter ieee_compliance (legal range: 0 to 1)",
	ieee_compliance );
    end
  
    if ( (faithful_round < 0) || (faithful_round > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter faithful_round (legal range: 0 to 1)",
	faithful_round );
    end
  
    if ( (id_width < 1) || (id_width > 1024) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter id_width (legal range: 1 to 1024)",
	id_width );
    end
  
    if ( (stages < 1) || (stages > 1022) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter stages (legal range: 1 to 1022)",
	stages );
    end
  
    if ( (id_width < 1) || (id_width > 1024) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter id_width (legal range: 1 to 1024)",
	id_width );
    end
  
    if ( (stages < 1) || (stages > 1022) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter stages (legal range: 1 to 1022)",
	stages );
    end
  
    if ( (in_reg < 0) || (in_reg > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter in_reg (legal range: 0 to 1)",
	in_reg );
    end
  
    if ( (out_reg < 0) || (out_reg > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter out_reg (legal range: 0 to 1)",
	out_reg );
    end
  
    if ( (no_pm < 0) || (no_pm > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter no_pm (legal range: 0 to 1)",
	no_pm );
    end
  
    if ( (rst_mode < 0) || (rst_mode > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter rst_mode (legal range: 0 to 1)",
	rst_mode );
    end
  
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 


  
`ifndef DW_DISABLE_CLK_MONITOR
`ifndef DW_SUPPRESS_WARN
  always @ (clk) begin : monitor_clk 
    if ( (clk !== 1'b0) && (clk !== 1'b1) && ($time > 0) )
      $display ("WARNING: %m:\n at time = %0t: Detected unknown value, %b, on clk input.", $time, clk);
    end // monitor_clk 
`endif
`endif

// synopsys translate_on
endmodule
