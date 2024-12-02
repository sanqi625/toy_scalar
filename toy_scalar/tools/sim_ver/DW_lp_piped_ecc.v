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
// AUTHOR:    Doug Lee       2/6/09
//
// VERSION:   Verilog Simulation Model
//
// DesignWare_version: e4f658eb
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
// ABSTRACT: Low Power Pipelined Modified Hamming Code Error Correction/Detection Simulation Model 
//
//           This module supports data widths up to 8178 using
//           14 check bits
//
//
//  Parameters:     Valid Values    Description
//  ==========      ============    =============
//  data_width       8 to 8178      default: 8
//                                  Width of 'datain' and 'dataout'
//
//  chk_width         5 to 14       default: 5
//                                  Width of 'chkin', 'chkout', and 'syndout'
//
//   rw_mode           0 or 1       default: 1
//                                  Read or write mode
//                                    0 => read mode
//                                    1 => write mode
//
//   op_iso_mode      0 to 4        default: 0
//                                  Type of operand isolation
//                                    If 'in_reg' is '1', this parameter is ignored...effectively set to '1'.
//                                    0 => Follow intent defined by Power Compiler user setting
//                                    1 => no operand isolation
//                                    2 => 'and' gate isolaton
//                                    3 => 'or' gate isolation
//                                    4 => preferred isolation style: 'and' gate
//
//   id_width        1 to 1024      default: 1
//                                  Launch identifier width
//
//   in_reg           0 to 1        default: 0
//                                  Input register control
//                                    0 => no input register
//                                    1 => include input register
//
//   stages          1 to 1022      default: 4
//                                  Number of logic stages in the pipeline
//
//   out_reg          0 to 1        default: 0
//                                  Output register control
//                                    0 => no output register
//                                    1 => include output register
//
//   no_pm            0 to 1        default: 1
//                                  Pipeline management usage
//                                    0 => Use pipeline management
//                                    1 => Do not use pipeline management - launch input
//                                          becomes global register enable to block
//
//   rst_mode         0 to 1        default: 0
//                                  Control asynchronous or synchronous reset 
//                                  behavior of rst_n
//                                    0 => asynchronous reset
//                                    1 => synchronous reset 
//
//
//  Ports        Size    Direction    Description
//  =====        ====    =========    ===========
//  clk          1 bit     Input      Clock Input
//  rst_n        1 bit     Input      Reset Input, Active Low
//
//  datain       M bits    Input      Input data bus
//  chkin        N bits    Input      Input check bits bus
//
//  err_detect   1 bit     Output     Any error flag (active high)
//  err_multiple 1 bit     Output     Multiple bit error flag (active high)
//  dataout      M bits    Output     Output data bus
//  chkout       N bits    Output     Output check bits bus
//  syndout      N bits    Output     Output error syndrome bus
//
//  launch       1 bit     Input      Active High Control input to launch data into pipe
//  launch_id    Q bits    Input      ID tag for operation being launched
//  pipe_full    1 bit     Output     Status Flag indicating no slot for a new launch
//  pipe_ovf     1 bit     Output     Status Flag indicating pipe overflow
//
//  accept_n     1 bit     Input      Flow Control Input, Active Low
//  arrive       1 bit     Output     Product available output 
//  arrive_id    Q bits    Output     ID tag for product that has arrived
//  push_out_n   1 bit     Output     Active Low Output used with FIFO
//  pipe_census  R bits    Output     Output bus indicating the number
//                                   of pipeline register levels currently occupied
//
//     Note: M is the value of "data_width" parameter
//     Note: N is the value of "chk_width" parameter
//     Note: Q is the value of "id_width" parameter
//     Note: R is equal to the larger of '1' or ceil(log2(in_reg+stages+out_reg))
//
//
//-----------------------------------------------------------------------------
// Modified:
//     LMSU 02/17/15  Updated to eliminate derived internal clock and reset signals
//     RJK  10/07/15  Updated for compatibility with VCS NLP feature
//     RJK  07/14/17  Updated UPF specific code (STAR 9001217597)
//     RJK  07/24/19  Updated to eliminate lint warnings (STAR 9001489004)
//     RJK  11/10/21  Update to UPF support method to resolve errors with
//                      large width operation (STAR 3754297)
//
////////////////////////////////////////////////////////////////////////////////
module DW_lp_piped_ecc(
        clk,            // Clock input
        rst_n,          // Reset

        datain,         // Input data bus
        chkin,          // Input check bits bus (for read or scrub)

        err_detect,     // Any error flag (active high)
        err_multiple,   // Multiple bit error flag (active high)
        dataout,        // Output data bus
        chkout,         // Output check bits bus
        syndout,        // Output error syndrome bus

        launch,         // Launch data into pipe input
        launch_id,      // ID tag of data launched input
        pipe_full,      // Pipe slots full output (used for flow control)
        pipe_ovf,       // Pipe overflow output

        accept_n,       // Take product input (flow control)
        arrive,         // Data arrival output
        arrive_id,      // ID tag of arrival product output
        push_out_n,     // Active low output used when FIFO follows
        pipe_census     // Pipe stages occupied count output
        );

parameter integer data_width = 8;  // RANGE 1 to 8178
parameter integer chk_width = 5;   // RANGE 5 to 14
parameter integer rw_mode = 1;     // RANGE 0 to 1
parameter integer op_iso_mode = 0; // RANGE 0 to 4
parameter integer id_width = 1;    // RANGE 1 to 1024
parameter integer in_reg = 0;      // RANGE 0 to 1
parameter integer stages = 4;      // RANGE 1 to 1022
parameter integer out_reg = 0;     // RANGE 0 to 1
parameter integer no_pm = 1;       // RANGE 0 to 1
parameter integer rst_mode = 0;    // RANGE 0 to 1




input                          clk;         // Clock Input
input                          rst_n;       // Reset
input  [data_width-1:0]        datain;        // Data input
input  [chk_width-1:0]         chkin;         // Check bits input

output                         err_detect;    // Error detect output
output                         err_multiple;  // Multiple errors detected output
output [data_width-1:0]        dataout;       // Data output
output [chk_width-1:0]         chkout;        // Check bits output
output [chk_width-1:0]         syndout;       // Syndrome output

input                          launch;      // Launch data into pipe
input  [id_width-1:0]          launch_id;   // ID tag of data launched
output                         pipe_full;   // Pipe slots full (used for flow control)
output                         pipe_ovf;    // Pipe overflow

input                          accept_n;    // Take product (flow control)
output                         arrive;      // Product arrival
output [id_width-1:0]          arrive_id;   // ID tag of arrival product
output                         push_out_n;  // Active low output used when FIFO follows

output [(((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>256)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4096)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16384)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32768)?16:15):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8192)?14:13)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>1024)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2048)?12:11):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>512)?10:9))):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>64)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>128)?8:7):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32)?6:5)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8)?4:3):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2)?2:1)))))-1:0]       pipe_census; // Pipe Stages Occupied Output

// synopsys translate_off

wire  [data_width-1:0]           O00IlO0I;
wire  [chk_width-1:0]            IOOI1O00;
wire                             O0lI0O1O;
wire  [id_width-1:0]             O10O0O10;
wire                             I1O0O1O1;

wire  [data_width-1:0]           O1110110;
wire  [data_width-1:0]           OOOl1101;
wire  [chk_width-1:0]            O1II11O1;
wire  [chk_width-1:0]            OII1OOl0;

wire  [data_width-1:0]           O01I11IO;
wire  [chk_width-1:0]            I01OO00O;
wire  [data_width-1:0]           O001IOl1;
wire  [chk_width-1:0]            I101OO10;

wire  [data_width-1:0]           I01ll0OO;
wire  [chk_width-1:0]            Ol0I0lO1;
wire  [chk_width-1:0]            I10IO1Ol;
wire                             OI1l0l00;
wire                             O010010O;

wire  [data_width-1:0]           lO00l00I;
wire  [chk_width-1:0]            I0O11O11;
wire  [chk_width-1:0]            O0llOO1O;
wire                             IO1lO0l0;
wire                             II000OOO;

wire  [(((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)-1:0]     I10O110O;
wire                             IO100O1I;
reg   [(((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)-1:0]     O00l0I1O;

wire                             OOOOlIO1;
wire                             O10l0O0O;
wire                             O010lO10;
wire  [id_width-1:0]             OOO1O1OO;
wire                             I1O001OO;
wire  [(((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)-1:0]     IOO11O11;
wire  [(((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>256)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4096)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16384)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32768)?16:15):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8192)?14:13)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>1024)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2048)?12:11):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>512)?10:9))):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>64)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>128)?8:7):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32)?6:5)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8)?4:3):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2)?2:1)))))-1:0]          OO1lIIO1;

wire                             O00101I1;
wire                             O1O1IlO0;
reg                              l1I101lO;
wire                             OO1IOO00;
wire  [id_width-1:0]             I10l1lO0;
wire                             O0O1011l;
wire  [(((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)-1:0]     l0OOl11l;
wire  [(((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>256)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4096)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16384)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32768)?16:15):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8192)?14:13)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>1024)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2048)?12:11):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>512)?10:9))):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>64)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>128)?8:7):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32)?6:5)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8)?4:3):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2)?2:1)))))-1:0]          I0IOIl1O;

wire  [id_width-1:0]             IIO10010;
localparam [0:0] OOO0Ol0O = rw_mode;
localparam [chk_width-1:0] OlI0OIOI = {chk_width{1'b0}};


  assign O00IlO0I     = (datain | (datain ^ datain));
  assign IOOI1O00      = (chkin | (chkin ^ chkin));
  assign O0lI0O1O     = (launch | (launch ^ launch));
  assign O10O0O10  = (launch_id | (launch_id ^ launch_id));
  assign I1O0O1O1   = (accept_n | (accept_n ^ accept_n));


generate if (rw_mode == 0) begin : DW_O0110101
  integer OI0000O0;

  DW_ecc #(data_width, chk_width, 1) U_1(
		.gen(OOO0Ol0O),
		.correct_n(OOO0Ol0O),
		.datain(OOOl1101),
		.chkin(OII1OOl0),

		.err_detect(OI1l0l00),
		.err_multpl(O010010O),
		.dataout(I01ll0OO),
		.chkout(I10IO1Ol) );

  always @ ( I10IO1Ol ) begin : mk_ord_PROD_PROC
    reg [chk_width-1:0] OIOOl10l;
    integer lO00O01l;

    lO00O01l = 0;
    OIOOl10l = {{chk_width-1{1'b0}}, 1'b1};

    while ( (OIOOl10l != {chk_width{1'b0}}) && (lO00O01l == 0) ) begin
      if ( OIOOl10l == I10IO1Ol ) begin
        lO00O01l = 1;
      end

      OIOOl10l = OIOOl10l << 1; 
    end

    OI0000O0 = lO00O01l;
  end

  assign Ol0I0lO1 = (OI0000O0 != 1)? OII1OOl0 :  I10IO1Ol ^ OII1OOl0;
  end else begin : DW_II0lOI0l
  wire I01OI0I1;
  wire O1OI0OIO;
  DW_ecc #(data_width, chk_width, 0) U_1(
		.gen(OOO0Ol0O),
		.correct_n(OOO0Ol0O),
		.datain(O1110110),
		.chkin(OlI0OIOI),

		.err_detect(I01OI0I1),
		.err_multpl(O1OI0OIO),
		.dataout(O01I11IO),
		.chkout(I01OO00O) );

  end
endgenerate


reg   [(data_width+chk_width)-1 : 0]     OO0l10O0;
reg   [(data_width+chk_width)-1 : 0]     I0O1O01I [0 : ((stages-1+out_reg < 1)? 0 : (stages+out_reg-2))];




generate
  if (rst_mode==0) begin
    always @ (posedge clk or negedge rst_n) begin : PROC_pl_in_registers_wr_mode
      integer lOO11O0O;

      if (rst_n === 1'b0) begin
        OO0l10O0 <= {(data_width+chk_width){1'b0}};
      end else if (rst_n === 1'b1) begin
        if (IO100O1I === 1'b1)
          OO0l10O0<= {O00IlO0I, IOOI1O00};
        else if (IO100O1I !== 1'b0)
          OO0l10O0 <= ((OO0l10O0 ^ {O00IlO0I, IOOI1O00}) & {(data_width+chk_width){1'bx}}) ^ OO0l10O0;
      end else begin
        OO0l10O0 <= {(data_width+chk_width){1'bx}};
      end
    end
  end else begin
    always @ (posedge clk) begin : PROC_pl_in_registers_wr_mode
      integer lOO11O0O;

      if (rst_n === 1'b0) begin
        OO0l10O0 <= {(data_width+chk_width){1'b0}};
      end else if (rst_n === 1'b1) begin
        if (IO100O1I === 1'b1)
          OO0l10O0<= {O00IlO0I, IOOI1O00};
        else if (IO100O1I !== 1'b0)
          OO0l10O0 <= ((OO0l10O0 ^ {O00IlO0I, IOOI1O00}) & {(data_width+chk_width){1'bx}}) ^ OO0l10O0;
      end else begin
        OO0l10O0 <= {(data_width+chk_width){1'bx}};
      end
    end
  end
endgenerate


  assign {O1110110, O1II11O1} = (in_reg == 0)? {O00IlO0I, IOOI1O00} : OO0l10O0;




generate
  if (rst_mode==0) begin
    always @ (posedge clk or negedge rst_n) begin : PROC_pl_registers_wr_mode
      integer lOO11O0O;

      if (rst_n === 1'b0) begin
        for (lOO11O0O=0 ; lOO11O0O <= ((stages-1+out_reg < 1)? 0 : (stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          I0O1O01I[lOO11O0O] <= {(data_width+chk_width){1'b0}};
        end
      end else if (rst_n === 1'b1) begin
        for (lOO11O0O=0 ; lOO11O0O <= ((stages-1+out_reg < 1)? 0 : (stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          if (O00l0I1O[lOO11O0O] === 1'b1)
            I0O1O01I[lOO11O0O] <= (lOO11O0O == 0)? {O01I11IO, I01OO00O} : I0O1O01I[lOO11O0O-1];
          else if (O00l0I1O[lOO11O0O] !== 1'b0)
            I0O1O01I[lOO11O0O] <= ((I0O1O01I[lOO11O0O] ^ ((lOO11O0O == 0)? {O01I11IO, I01OO00O} : I0O1O01I[lOO11O0O-1]))
          		      & {(data_width+chk_width){1'bx}}) ^ I0O1O01I[lOO11O0O];
        end
      end else begin
        for (lOO11O0O=0 ; lOO11O0O <= ((stages-1+out_reg < 1)? 0 : (stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          I0O1O01I[lOO11O0O] <= {(data_width+chk_width){1'bx}};
        end
      end
    end
  end else begin
    always @ (posedge clk) begin : PROC_pl_registers_wr_mode
      integer lOO11O0O;

      if (rst_n === 1'b0) begin
        for (lOO11O0O=0 ; lOO11O0O <= ((stages-1+out_reg < 1)? 0 : (stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          I0O1O01I[lOO11O0O] <= {(data_width+chk_width){1'b0}};
        end
      end else if (rst_n === 1'b1) begin
        for (lOO11O0O=0 ; lOO11O0O <= ((stages-1+out_reg < 1)? 0 : (stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          if (O00l0I1O[lOO11O0O] === 1'b1)
            I0O1O01I[lOO11O0O] <= (lOO11O0O == 0)? {O01I11IO, I01OO00O} : I0O1O01I[lOO11O0O-1];
          else if (O00l0I1O[lOO11O0O] !== 1'b0)
            I0O1O01I[lOO11O0O] <= ((I0O1O01I[lOO11O0O] ^ ((lOO11O0O == 0)? {O01I11IO, I01OO00O} : I0O1O01I[lOO11O0O-1]))
          		      & {(data_width+chk_width){1'bx}}) ^ I0O1O01I[lOO11O0O];
        end
      end else begin
        for (lOO11O0O=0 ; lOO11O0O <= ((stages-1+out_reg < 1)? 0 : (stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          I0O1O01I[lOO11O0O] <= {(data_width+chk_width){1'bx}};
        end
      end
    end
  end
endgenerate

  assign {O001IOl1, I101OO10} = (stages+out_reg == 1)? {O01I11IO, I01OO00O} : I0O1O01I[((stages-1+out_reg < 1)? 0 : (stages+out_reg-2))];


reg   [(data_width+chk_width)-1 : 0]     O0OlI001;
reg   [(data_width+(chk_width*2)+2)-1 : 0]     O10I1O11 [0 : ((stages-1+out_reg < 1)? 0 : (stages+out_reg-2))];




generate
  if (rst_mode==0) begin
    always @ (posedge clk or negedge rst_n) begin : PROC_pl_in_registers_rd_mode
      integer lOO11O0O;

      if (rst_n === 1'b0) begin
        O0OlI001 <= {(data_width+chk_width){1'b0}};
      end else if (rst_n === 1'b1) begin
        if (IO100O1I === 1'b1)
          O0OlI001<= {O00IlO0I, IOOI1O00};
        else if (IO100O1I !== 1'b0)
          O0OlI001 <= ((O0OlI001 ^ {O00IlO0I, IOOI1O00}) & {(data_width+chk_width){1'bx}}) ^ O0OlI001;
      end else begin
        O0OlI001 <= {(data_width+chk_width){1'bx}};
      end
    end
  end else begin
    always @ (posedge clk) begin : PROC_pl_in_registers_rd_mode
      integer lOO11O0O;

      if (rst_n === 1'b0) begin
        O0OlI001 <= {(data_width+chk_width){1'b0}};
      end else if (rst_n === 1'b1) begin
        if (IO100O1I === 1'b1)
          O0OlI001<= {O00IlO0I, IOOI1O00};
        else if (IO100O1I !== 1'b0)
          O0OlI001 <= ((O0OlI001 ^ {O00IlO0I, IOOI1O00}) & {(data_width+chk_width){1'bx}}) ^ O0OlI001;
      end else begin
        O0OlI001 <= {(data_width+chk_width){1'bx}};
      end
    end
  end
endgenerate


  assign {OOOl1101, OII1OOl0} = (in_reg == 0)? {O00IlO0I, IOOI1O00} : O0OlI001;




generate
  if (rst_mode==0) begin
    always @ (posedge clk or negedge rst_n) begin : PROC_pl_registers_rd_mode
      integer lOO11O0O;

      if (rst_n === 1'b0) begin
        for (lOO11O0O=0 ; lOO11O0O <= ((stages-1+out_reg < 1)? 0 : (stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          O10I1O11[lOO11O0O] <= {(data_width+(chk_width*2)+2){1'b0}};
        end
      end else if (rst_n === 1'b1) begin
        for (lOO11O0O=0 ; lOO11O0O <= ((stages-1+out_reg < 1)? 0 : (stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          if (O00l0I1O[lOO11O0O] === 1'b1)
            O10I1O11[lOO11O0O] <= (lOO11O0O == 0)? {I01ll0OO, Ol0I0lO1, I10IO1Ol, OI1l0l00, O010010O} : O10I1O11[lOO11O0O-1];
          else if (O00l0I1O[lOO11O0O] !== 1'b0)
            O10I1O11[lOO11O0O] <= ((O10I1O11[lOO11O0O] ^ ((lOO11O0O == 0)? {I01ll0OO, Ol0I0lO1, I10IO1Ol, OI1l0l00, O010010O} : O10I1O11[lOO11O0O-1]))
          		      & {(data_width+(chk_width*2)+2){1'bx}}) ^ O10I1O11[lOO11O0O];
        end
      end else begin
        for (lOO11O0O=0 ; lOO11O0O <= ((stages-1+out_reg < 1)? 0 : (stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          O10I1O11[lOO11O0O] <= {(data_width+(chk_width*2)+2){1'bx}};
        end
      end
    end
  end else begin
    always @ (posedge clk) begin : PROC_pl_registers_rd_mode
      integer lOO11O0O;

      if (rst_n === 1'b0) begin
        for (lOO11O0O=0 ; lOO11O0O <= ((stages-1+out_reg < 1)? 0 : (stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          O10I1O11[lOO11O0O] <= {(data_width+(chk_width*2)+2){1'b0}};
        end
      end else if (rst_n === 1'b1) begin
        for (lOO11O0O=0 ; lOO11O0O <= ((stages-1+out_reg < 1)? 0 : (stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          if (O00l0I1O[lOO11O0O] === 1'b1)
            O10I1O11[lOO11O0O] <= (lOO11O0O == 0)? {I01ll0OO, Ol0I0lO1, I10IO1Ol, OI1l0l00, O010010O} : O10I1O11[lOO11O0O-1];
          else if (O00l0I1O[lOO11O0O] !== 1'b0)
            O10I1O11[lOO11O0O] <= ((O10I1O11[lOO11O0O] ^ ((lOO11O0O == 0)? {I01ll0OO, Ol0I0lO1, I10IO1Ol, OI1l0l00, O010010O} : O10I1O11[lOO11O0O-1]))
          		      & {(data_width+(chk_width*2)+2){1'bx}}) ^ O10I1O11[lOO11O0O];
        end
      end else begin
        for (lOO11O0O=0 ; lOO11O0O <= ((stages-1+out_reg < 1)? 0 : (stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          O10I1O11[lOO11O0O] <= {(data_width+(chk_width*2)+2){1'bx}};
        end
      end
    end
  end
endgenerate

  assign {lO00l00I, I0O11O11, O0llOO1O, IO1lO0l0, II000OOO} = (stages+out_reg == 1)? {I01ll0OO, Ol0I0lO1, I10IO1Ol, OI1l0l00, O010010O} : O10I1O11[((stages-1+out_reg < 1)? 0 : (stages+out_reg-2))];



reg   [id_width-1 : 0]     OOl01I1O [0 : ((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2))];





generate
  if (rst_mode==0) begin
    always @ (posedge clk or negedge rst_n) begin : PROC_pl_registers_id
      integer lOO11O0O;

      if (rst_n === 1'b0) begin
        for (lOO11O0O=0 ; lOO11O0O <= ((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          OOl01I1O[lOO11O0O] <= {id_width{1'b0}};
        end
      end else if (rst_n === 1'b1) begin
        for (lOO11O0O=0 ; lOO11O0O <= ((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          if (I10O110O[lOO11O0O] === 1'b1)
            OOl01I1O[lOO11O0O] <= (lOO11O0O == 0)? O10O0O10 : OOl01I1O[lOO11O0O-1];
          else if (I10O110O[lOO11O0O] !== 1'b0)
            OOl01I1O[lOO11O0O] <= ((OOl01I1O[lOO11O0O] ^ ((lOO11O0O == 0)? O10O0O10 : OOl01I1O[lOO11O0O-1]))
          		      & {id_width{1'bx}}) ^ OOl01I1O[lOO11O0O];
        end
      end else begin
        for (lOO11O0O=0 ; lOO11O0O <= ((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          OOl01I1O[lOO11O0O] <= {id_width{1'bx}};
        end
      end
    end
  end else begin
    always @ (posedge clk) begin : PROC_pl_registers_id
      integer lOO11O0O;

      if (rst_n === 1'b0) begin
        for (lOO11O0O=0 ; lOO11O0O <= ((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          OOl01I1O[lOO11O0O] <= {id_width{1'b0}};
        end
      end else if (rst_n === 1'b1) begin
        for (lOO11O0O=0 ; lOO11O0O <= ((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          if (I10O110O[lOO11O0O] === 1'b1)
            OOl01I1O[lOO11O0O] <= (lOO11O0O == 0)? O10O0O10 : OOl01I1O[lOO11O0O-1];
          else if (I10O110O[lOO11O0O] !== 1'b0)
            OOl01I1O[lOO11O0O] <= ((OOl01I1O[lOO11O0O] ^ ((lOO11O0O == 0)? O10O0O10 : OOl01I1O[lOO11O0O-1]))
          		      & {id_width{1'bx}}) ^ OOl01I1O[lOO11O0O];
        end
      end else begin
        for (lOO11O0O=0 ; lOO11O0O <= ((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2)) ; lOO11O0O=lOO11O0O+1) begin
          OOl01I1O[lOO11O0O] <= {id_width{1'bx}};
        end
      end
    end
  end
endgenerate

  assign IIO10010 = (in_reg+stages+out_reg == 1)? O10O0O10 : OOl01I1O[((in_reg+stages-1+out_reg < 1)? 0 : (in_reg+stages+out_reg-2))];




generate
  if (rst_mode==0) begin : DW_OO11lOO1
    DW_lp_pipe_mgr #((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1), id_width) U_PIPE_MGR (
                     .clk(clk),
                     .rst_n(rst_n),
                     .init_n(1'b1),
                     .launch(O0lI0O1O),
                     .launch_id(O10O0O10),
                     .accept_n(I1O0O1O1),
                     .arrive(O010lO10),
                     .arrive_id(OOO1O1OO),
                     .pipe_en_bus(IOO11O11),
                     .pipe_full(OOOOlIO1),
                     .pipe_ovf(O10l0O0O),
                     .push_out_n(I1O001OO),
                     .pipe_census(OO1lIIO1)
                     );
  end else begin : DW_Ol101l0O
    DW_lp_pipe_mgr #((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1), id_width) U_PIPE_MGR (
                     .clk(clk),
                     .rst_n(1'b1),
                     .init_n(rst_n),
                     .launch(O0lI0O1O),
                     .launch_id(O10O0O10),
                     .accept_n(I1O0O1O1),
                     .arrive(O010lO10),
                     .arrive_id(OOO1O1OO),
                     .pipe_en_bus(IOO11O11),
                     .pipe_full(OOOOlIO1),
                     .pipe_ovf(O10l0O0O),
                     .push_out_n(I1O001OO),
                     .pipe_census(OO1lIIO1)
                     );
  end
endgenerate

assign OO1IOO00         = O0lI0O1O;
assign I10l1lO0      = O10O0O10;
assign l0OOl11l    = {(((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1){1'b0}};
assign O00101I1      = I1O0O1O1;
assign O1O1IlO0  = O00101I1 && OO1IOO00;
assign O0O1011l     = ~(~I1O0O1O1 && O0lI0O1O);
assign I0IOIl1O    = {(((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>256)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4096)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16384)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32768)?16:15):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8192)?14:13)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>1024)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2048)?12:11):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>512)?10:9))):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>64)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>128)?8:7):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32)?6:5)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8)?4:3):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2)?2:1))))){1'b0}};


assign arrive           = no_pm ? 1'b0 : ((in_reg+stages+out_reg) > 1) ? O010lO10 : OO1IOO00;
assign arrive_id        = ((in_reg+stages+out_reg) > 1) ? (no_pm ? IIO10010          : OOO1O1OO  ) : I10l1lO0;
assign I10O110O  = ((in_reg+stages+out_reg) > 1) ? (no_pm ? {(((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1){launch}} : IOO11O11) : l0OOl11l;
assign pipe_full        = no_pm ? 1'b0 : ((in_reg+stages+out_reg) > 1) ? OOOOlIO1 : O00101I1;
assign pipe_ovf         = no_pm ? 1'b0 : ((in_reg+stages+out_reg) > 1) ? O10l0O0O : l1I101lO;
assign push_out_n       = no_pm ? 1'b0 : ((in_reg+stages+out_reg) > 1) ? I1O001OO : O0O1011l;
assign pipe_census      = no_pm ? {(((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>256)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4096)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16384)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32768)?16:15):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8192)?14:13)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>1024)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2048)?12:11):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>512)?10:9))):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>16)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>64)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>128)?8:7):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>32)?6:5)):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>4)?((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>8)?4:3):((((((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1)+1)>2)?2:1))))){1'b0}} : ((in_reg+stages+out_reg) > 1) ? OO1lIIO1 : I0IOIl1O;

assign IO100O1I = I10O110O[0];

  always @(I10O110O) begin : out_en_bus_in_reg1_PROC
    integer lOO11O0O;

    if  (in_reg == 1) begin
      O00l0I1O[0] = 1'b0;
      for (lOO11O0O=1; lOO11O0O<(((in_reg+(stages-1)+out_reg) >= 1) ? (in_reg+(stages-1)+out_reg) : 1); lOO11O0O=lOO11O0O+1) begin
        O00l0I1O[lOO11O0O-1] = I10O110O[lOO11O0O];
      end
    end else begin
      O00l0I1O = I10O110O;
    end
  end


generate
  if (rst_mode==0) begin : DW_Il00OOI0
    always @ (posedge clk or negedge rst_n) begin : posedge_registers_PROC
      if (rst_n === 1'b0) begin
        l1I101lO     <= 1'b0;
      end else if (rst_n === 1'b1) begin
        l1I101lO     <= O1O1IlO0;
      end else begin
        l1I101lO     <= 1'bx;
      end
    end
  end else begin : DW_OO1O11lO
    always @ (posedge clk) begin : posedge_registers_PROC
      if (rst_n === 1'b0) begin
        l1I101lO     <= 1'b0;
      end else if (rst_n === 1'b1) begin
        l1I101lO     <= O1O1IlO0;
      end else begin
        l1I101lO     <= 1'bx;
      end
    end
  end
endgenerate


  assign dataout      = ((in_reg==0) && (stages==1) && (out_reg==0) && (no_pm == 0) && (launch==1'b0)) ? 
                          {data_width{1'bx}} : 
                          (rw_mode==0) ? lO00l00I: O001IOl1;

  assign chkout       = ((in_reg==0) && (stages==1) && (out_reg==0) && (no_pm == 0) && (launch==1'b0)) ? 
                          {chk_width{1'bx}} : 
                          (rw_mode==0) ? I0O11O11: I101OO10;

  assign syndout      = ((in_reg==0) && (stages==1) && (out_reg==0) && (no_pm == 0) && (launch==1'b0)) ? 
                          {chk_width{1'bx}} : 
                          (rw_mode==0) ? O0llOO1O: {chk_width{1'b0}};

  assign err_detect   = ((in_reg==0) && (stages==1) && (out_reg==0) && (no_pm == 0) && (launch==1'b0)) ? 
                          1'bx : 
                          (rw_mode==0) ? IO1lO0l0: 1'b0;

  assign err_multiple = ((in_reg==0) && (stages==1) && (out_reg==0) && (no_pm == 0) && (launch==1'b0)) ? 
                          1'bx : 
                          (rw_mode==0) ? II000OOO: 1'b0;

  //-------------------------------------------------------------------------
  // Parameter legality check
  //-------------------------------------------------------------------------
  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
  
    if ( (data_width < 8) || (data_width > 8178) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter data_width (legal range: 8 to 8178)",
	data_width );
    end
  
    if ( (chk_width < 5) || (chk_width > 14) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter chk_width (legal range: 5 to 14)",
	chk_width );
    end
  
    if ( (rw_mode < 0) || (rw_mode > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter rw_mode (legal range: 0 to 1)",
	rw_mode );
    end
  
    if ( (op_iso_mode < 0) || (op_iso_mode > 4) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter op_iso_mode (legal range: 0 to 4)",
	op_iso_mode );
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
