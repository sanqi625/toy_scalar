////////////////////////////////////////////////////////////////////////////////
//
//       This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Synopsys Inc.
//     In the event of publication, the following notice is applicable:
//
//                    (C) COPYRIGHT 2007 - 2022 SYNOPSYS INC.
//                           ALL RIGHTS RESERVED
//
//       The entire notice above must be reproduced on all authorized
//     copies.
//
// AUTHOR:    Doug Lee       6/6/07
//
// VERSION:   Verilog Simulation Model
//
// DesignWare_version: a7b5f66e
// DesignWare_release: T-2022.03-DWBB_202203.2
//
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
// ABSTRACT: Simulation model for Low Power Single-clock FIFO Controller with Caching and Dynamic Flags
//
//           This FIFO controller is designed to interface to synchronous
//           dual port synchronous RAMs.  It contains word caching (I0OO0IIl
//           interface) and status flags that are dynamically configured.
//
//
//      Parameters     Valid Values   Description
//      ==========     ============   ===========
//      width           1 to 4096     default: 8
//                                    Width of data to/from RAM
//
//      depth         4 to 268435456  default: 8
//                                    Depth of the FIFO (includes RAM, cache, and write re-timing stage)
//
//      mem_mode         0 to 7       default: 3
//                                    Defines where and how many re-timing stages used in RAM:
//                                      0 => no pre or post retiming
//                                      1 => RAM data out (post) re-timing
//                                      2 => RAM read address (pre) re-timing
//                                      3 => RAM data out and read address re-timing
//                                      4 => RAM write interface (pre) re-timing
//                                      5 => RAM write interface and RAM data out re-timing
//                                      6 => RAM write interface and read address re-timing
//                                      7 => RAM write interface, read address, and read address re-timing
//
//      arch_type        0 to 4       default: 1
//                                    Datapath architecture configuration
//                                      0 => no input re-timing, no pre-fetch cache
//                                      1 => no input re-timing, pre-fetch pipeline cache
//                                      2 => input re-timing, pre-fetch pipeline cache
//                                      3 => no input re-timing, pre-fetch register file cache
//                                      4 => input re-timing, pre-fetch register file cache
//
//      af_from_top      0 or 1       default: 1
//                                    Almost full level input (af_level) usage
//                                      0 => the af_level input value represents the minimum
//                                           number of valid FIFO entries at which the almost_full
//                                           output starts being asserted
//                                      1 => the af_level input value represents the maximum number
//                                           of unfilled FIFO entries at which the almost_full
//                                           output starts being asserted
//
//      ram_re_ext       0 or 1       default: 0
//                                    Determines the charateristic of the ram_re_n signal to RAM
//                                      0 => Single-cycle pulse of ram_re_n at the read event to RAM
//                                      1 => Extend assertion of ram_re_n while read event active in RAM
//
//      err_mode         0 or 1       default: 0
//                                    Error Reporting Behavior
//                                      0 => sticky error flag
//                                      1 => dynamic error flag
//
//
//
//      Inputs           Size       Description
//      ======           ====       ===========
//      clk                1        Clock
//      rst_n              1        Asynchronous reset (active low)
//      init_n             1        Synchronous reset (active low)
//      ae_level           N        Almost empty threshold setting (for the almost_empty output)
//      af_level           N        Almost full threshold setting (for the almost_full output)
//      level_change       1        Almost empty and/or almost full level is being changed (active high pulse)
//      push_n             1        Push request (active low)
//      data_in            M        Data input
//      pop_n              1        Pop request (active low)
//      rd_data            M        Data read from RAM
//
//
//      Outputs          Size       Description
//      =======          ====       ===========
//      ram_we_n           1        Write enable to RAM (active low)
//      wr_addr            P        Write address to RAM (registered)
//      wr_data            M        Data written to RAM
//      ram_re_n           1        Read enable to RAM (active low)
//      rd_addr            P        Read address to RAM (registered)
//      data_out           M        Data output
//      word_cnt           N        FIFO word count
//      empty              1        FIFO empty flag
//      almost_empty       1        Almost empty flag (determined by ae_level input)
//      half_full          1        Half full flag
//      almost_full        1        Almost full flag (determined by af_level input)
//      full               1        Full flag
//      error              1        Error flag (overrun or underrun)
//
//
//           Note: M is equal to the "width" parameter
//
//           Note: N is based on "depth":
//                   N = ceil(log2(depth+1))
//
//           Note: P is ceil(log2(O0lOI0O1)) (see Note immediately below about "O0lOI0O1")
//
//           Note: "O0lOI0O1" is not a parameter but is based on parameter
//                 "depth", "mem_mode", and "arch_type":
//
//                  If arch_type is '0', then:
//                       O0lOI0O1 = depth.
//                  If arch_type is '1' or '3', then:
//                       O0lOI0O1 = depth-1 when mem_mode = 0
//                       O0lOI0O1 = depth-2 when mem_mode = 1, 2, 4, or 6
//                       O0lOI0O1 = depth-3 when mem_mode = 3, 5, or 7
//                  If arch_type is '2' or '4', then:
//                       O0lOI0O1 = depth-2 when mem_mode = 0
//                       O0lOI0O1 = depth-3 when mem_mode = 1, 2, 4, or 6
//                       O0lOI0O1 = depth-4 when mem_mode = 3, 5, or 7
//
//
// MODIFIED:
//          DLL - 2/3/11
//          Added parameter legality checking for illegal value combinations
//          of arch_type and mem_mode.
//          This fix addresses STAR#9000446050.
//
//          Also, general clean up to remove some lint warnings.
//
////////////////////////////////////////////////////////////////////////////////
module DW_lp_fifoctl_1c_df (
        clk,
        rst_n,
        init_n,
        ae_level,
        af_level,
        level_change,
        push_n,
        data_in,
        pop_n,
        rd_data,

        ram_we_n,
        wr_addr,
        wr_data,
        ram_re_n,
        rd_addr,
        data_out,

        word_cnt,
        empty,
        almost_empty,
        half_full,
        almost_full,
        full,
        error
        );

parameter integer width       = 8;    // RANGE 1 to 4096
parameter integer depth       = 8;    // RANGE 4 to 268435456
parameter integer mem_mode    = 3;    // RANGE 0 to 7
parameter integer arch_type   = 1;    // RANGE 0 to 4
parameter integer af_from_top = 1;    // RANGE 0 to 1
parameter integer ram_re_ext  = 0;    // RANGE 0 to 1
parameter integer err_mode    = 0;    // RANGE 0 to 1
   

`define DW_I001O11O     ((mem_mode==0) ? 1 : (((mem_mode==3)||(mem_mode==5)||(mem_mode==7)) ? 3 : 2))
`define DW_llO00llI             ((arch_type==0) ? depth : ((arch_type==1) || (arch_type==3)) ? (depth - `DW_I001O11O) : (depth - 1 - `DW_I001O11O))
`define DW_I1II0OO1          `DW_llO00llI-1
`define DW_O110lOl1        ((`DW_llO00llI>65536)?((`DW_llO00llI>16777216)?((`DW_llO00llI>268435456)?((`DW_llO00llI>536870912)?30:29):((`DW_llO00llI>67108864)?((`DW_llO00llI>134217728)?28:27):((`DW_llO00llI>33554432)?26:25))):((`DW_llO00llI>1048576)?((`DW_llO00llI>4194304)?((`DW_llO00llI>8388608)?24:23):((`DW_llO00llI>2097152)?22:21)):((`DW_llO00llI>262144)?((`DW_llO00llI>524288)?20:19):((`DW_llO00llI>131072)?18:17)))):((`DW_llO00llI>256)?((`DW_llO00llI>4096)?((`DW_llO00llI>16384)?((`DW_llO00llI>32768)?16:15):((`DW_llO00llI>8192)?14:13)):((`DW_llO00llI>1024)?((`DW_llO00llI>2048)?12:11):((`DW_llO00llI>512)?10:9))):((`DW_llO00llI>16)?((`DW_llO00llI>64)?((`DW_llO00llI>128)?8:7):((`DW_llO00llI>32)?6:5)):((`DW_llO00llI>4)?((`DW_llO00llI>8)?4:3):((`DW_llO00llI>2)?2:1)))))
`define DW_I1I01O1I         ((`DW_llO00llI+1>65536)?((`DW_llO00llI+1>16777216)?((`DW_llO00llI+1>268435456)?((`DW_llO00llI+1>536870912)?30:29):((`DW_llO00llI+1>67108864)?((`DW_llO00llI+1>134217728)?28:27):((`DW_llO00llI+1>33554432)?26:25))):((`DW_llO00llI+1>1048576)?((`DW_llO00llI+1>4194304)?((`DW_llO00llI+1>8388608)?24:23):((`DW_llO00llI+1>2097152)?22:21)):((`DW_llO00llI+1>262144)?((`DW_llO00llI+1>524288)?20:19):((`DW_llO00llI+1>131072)?18:17)))):((`DW_llO00llI+1>256)?((`DW_llO00llI+1>4096)?((`DW_llO00llI+1>16384)?((`DW_llO00llI+1>32768)?16:15):((`DW_llO00llI+1>8192)?14:13)):((`DW_llO00llI+1>1024)?((`DW_llO00llI+1>2048)?12:11):((`DW_llO00llI+1>512)?10:9))):((`DW_llO00llI+1>16)?((`DW_llO00llI+1>64)?((`DW_llO00llI+1>128)?8:7):((`DW_llO00llI+1>32)?6:5)):((`DW_llO00llI+1>4)?((`DW_llO00llI+1>8)?4:3):((`DW_llO00llI+1>2)?2:1)))))
`define DW_O0I10OIO            ((depth>65536)?((depth>16777216)?((depth>268435456)?((depth>536870912)?30:29):((depth>67108864)?((depth>134217728)?28:27):((depth>33554432)?26:25))):((depth>1048576)?((depth>4194304)?((depth>8388608)?24:23):((depth>2097152)?22:21)):((depth>262144)?((depth>524288)?20:19):((depth>131072)?18:17)))):((depth>256)?((depth>4096)?((depth>16384)?((depth>32768)?16:15):((depth>8192)?14:13)):((depth>1024)?((depth>2048)?12:11):((depth>512)?10:9))):((depth>16)?((depth>64)?((depth>128)?8:7):((depth>32)?6:5)):((depth>4)?((depth>8)?4:3):((depth>2)?2:1)))))
`define DW_OlII0OO1             ((depth+1>65536)?((depth+1>16777216)?((depth+1>268435456)?((depth+1>536870912)?30:29):((depth+1>67108864)?((depth+1>134217728)?28:27):((depth+1>33554432)?26:25))):((depth+1>1048576)?((depth+1>4194304)?((depth+1>8388608)?24:23):((depth+1>2097152)?22:21)):((depth+1>262144)?((depth+1>524288)?20:19):((depth+1>131072)?18:17)))):((depth+1>256)?((depth+1>4096)?((depth+1>16384)?((depth+1>32768)?16:15):((depth+1>8192)?14:13)):((depth+1>1024)?((depth+1>2048)?12:11):((depth+1>512)?10:9))):((depth+1>16)?((depth+1>64)?((depth+1>128)?8:7):((depth+1>32)?6:5)):((depth+1>4)?((depth+1>8)?4:3):((depth+1>2)?2:1)))))
`define DW_O10Ol011                ((`DW_llO00llI > 1) ? ((`DW_llO00llI == (1 << (`DW_I1I01O1I-1))) ? 1 : 0) : 0)

input                            clk;           // Clock
input                            rst_n;         // Asynchronous Reset (active low)
input                            init_n;        // Synchronous Reset (active low)
input  [`DW_OlII0OO1-1:0]       ae_level;      // FIFO almost empty threshold setting
input  [`DW_OlII0OO1-1:0]       af_level;      // FIFO almost full threshold setting
input                            level_change;  // Almost empty and/or almost full level is being changed (active high pulse)
input                            push_n;        // Push request (active low)
input  [width-1:0]               data_in;       // Input data
input                            pop_n;         // Pop request (active low)
input  [width-1:0]               rd_data;       // Read data from RAM

output                           ram_we_n;      // write enable to RAM (active low)
output [`DW_O110lOl1-1:0]  wr_addr;       // write address to RAM
output [width-1:0]               wr_data;       // write data to RAM
output                           ram_re_n;      // read enable to RAM (active low)
output [`DW_O110lOl1-1:0]  rd_addr;       // read address to RAM
output [width-1:0]               data_out;      // FIFO output data
output [`DW_OlII0OO1-1:0]       word_cnt;      // RAM only word count
output                           empty;         // FIFO Empty Flag
output                           almost_empty;  // FIFO Almost Empty Flag
output                           half_full;     // FIFO Half Full Flag
output                           almost_full;   // FIFO Almost Full Flag
output                           full;          // FIFO Full Flag
output                           error;         // Error Flag

// synopsys translate_off

// Parameter checking
  
 
  initial begin : parameter_check
    integer param_err_flg;

    param_err_flg = 0;
    
  
    if ( (width < 1) || (width > 4096 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter width (legal range: 1 to 4096 )",
	width );
    end
  
    if ( (depth < 4) || (depth > 268435456 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter depth (legal range: 4 to 268435456 )",
	depth );
    end
  
    if ( (mem_mode < 0) || (mem_mode > 7 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter mem_mode (legal range: 0 to 7 )",
	mem_mode );
    end
  
    if ( (arch_type < 0) || (arch_type > 4 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter arch_type (legal range: 0 to 4 )",
	arch_type );
    end
  
    if ( (af_from_top < 0) || (af_from_top > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter af_from_top (legal range: 0 to 1)",
	af_from_top );
    end
  
    if ( (ram_re_ext < 0) || (ram_re_ext > 1) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter ram_re_ext (legal range: 0 to 1)",
	ram_re_ext );
    end
  
    if ( (err_mode < 0) || (err_mode > 1 ) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m :\n  Invalid value (%d) for parameter err_mode (legal range: 0 to 1 )",
	err_mode );
    end
  
    if ( (arch_type===0 && mem_mode!==0) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m : Invalid parameter combination: when arch_type=0, mem_mode must be 0" );
    end
  
    if ( (arch_type>=3 && mem_mode==0) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m : Invalid parameter combination: when mem_mode=0, arch_type can only be 0, 1, or 2" );
    end
  
    if ( (`DW_llO00llI<2) ) begin
      param_err_flg = 1;
      $display(
	"ERROR: %m : Invalid parameter combination of arch_type and mem_mode settings causes depth of RAM to be < 2" );
    end
  
    if ( param_err_flg == 1) begin
      $display(
        "%m :\n  Simulation aborted due to invalid parameter value(s)");
      $finish;
    end

  end // parameter_check 




wire                             OO1l1lI1;
wire                             I1l10lOl;

wire                             O010OO0O;
wire                             O1OOO1l0;
reg                              almost_empty;
wire                             II0OI00O;
reg                              almost_full;

wire  [width-1:0]                IO10O1Ol;
reg   [width-1:0]                OI01O00O;
wire  [`DW_O110lOl1-1:0]   OOlOllOO;
wire  [`DW_O0I10OIO-1:0]       IIlOl1OO;
reg   [`DW_O0I10OIO-1:0]       l100O001;
wire  [`DW_O0I10OIO-1:0]       O11O1OOO;
reg   [`DW_O0I10OIO-1:0]       OIOIOOOl;
reg   [`DW_O0I10OIO-1:0]       II1111OI;
wire  [`DW_O0I10OIO-1:0]       l1001lIO;
wire  [`DW_O0I10OIO-1:0]       I0ll01O0;
wire                             I10O0IOl;
reg   [`DW_O0I10OIO-1:0]       l1OOI000 [0:2];
reg   [`DW_O0I10OIO-1:0]       O1l0O011 [0:2];

wire                             I0OO0IIl;
wire                             l1O0O01O;
wire                             I1100ll0;
wire                             I0IIO0I1;

wire  [`DW_O110lOl1:0]     IOOI11O0;
reg   [`DW_O110lOl1:0]     O1OO0OI1;
wire  [`DW_O110lOl1-1:0]   I01ll0O1;
reg   [`DW_O110lOl1-1:0]   O0O1O1l1;
wire  [`DW_O110lOl1:0]     IllO1O00;
reg   [`DW_O110lOl1:0]     O0l00I11;
 
wire  [width-1:0]                wr_data;
wire  [width-1:0]                IO0IO1O0;
reg   [width-1:0]                O01l0010;

wire                             OOO01111;
reg                              Ol11lOOO;
reg   [`DW_OlII0OO1-1:0]        O10I1O1l;
reg   [`DW_OlII0OO1-1:0]        IlOI1O1l;

wire                             lO1OO01O;
wire  [`DW_OlII0OO1-1:0]        OlII10O1;
reg   [`DW_OlII0OO1-1:0]        word_cnt;

wire                             l01O0OO1;
reg                              I0O101Ol;
wire                             l1O01100;
wire                             lll000Il;
wire                             O01l10lI;
wire                             IOO00OlO;
wire  [width-1:0]                O010I0Ol;
wire  [`DW_O0I10OIO-1:0]       lO1OO1Ol;

wire                             OI1lO1I0;
reg                              OO0O11OO;
wire                             I10I10O1;
reg                              OO0Ol11I;
wire                             OOIO10O1;           
reg   [1:0]                      I11O0O00;
wire  [1:0]                      IlOO00OI;

wire                             l0OlOI0O;              // RAM read enable initiated
wire                             ram_re_n;            // RAM read enable to RAM
reg   [2:0]                      Ol0l01I0;
wire  [2:0]                      OI10O0l0;
reg   [width-1:0]                O01III00 [0:2];
reg   [width-1:0]                l0OOO01I [0:2];

reg                              O01lI10I;
wire                             l0llI101;
wire                             lI1I1O0O;
wire                             OOO111OI;
reg   [`DW_O110lOl1:0]     OO11IOO0;

wire                             Il1Ol00O;

wire                             l0OOOl0O;
reg                              error;              // error flag
wire                             O00II10O;

wire                             O0IO10O1;
wire                             OOl00001;
wire                             OI1l111O;

wire [1:0]                       I011lOOO;
wire                             OIOOOlOO;
wire                             OI0O011O;

wire [2:0]                       O1lI001O;
wire                             OOOOlO11;
wire                             II00I10I;

wire [1:0]                       l1l0OllO;
wire                             O100000O;
wire                             ll000l0I;

wire [2:0]                       OI010l01;
wire                             lOO1lO01;
wire                             Il0OI111;

wire [1:0]                       OOO0O00O;
wire                             O1O0lIOI;
wire                             I010I0Ol;

wire [2:0]                       I10O1l10;
wire                             O0000O1I;
wire                             O1I0I0l1;

wire [`DW_O0I10OIO-1:0]        O000OO1l;
wire                             I1OOO0OO;


  assign OO1l1lI1  = ~push_n & (~full | (full && ~pop_n));
  assign I0OO0IIl         = ~pop_n & ~empty;

  assign IO0IO1O0     = (OO1l1lI1) ? (data_in | data_in) : O01l0010;
  assign O11O1OOO      = (OO1l1lI1) ? l100O001 : OIOIOOOl;

  assign IIlOl1OO         = OO1l1lI1 ? (l100O001 == depth[`DW_O0I10OIO-1:0]-{{`DW_O0I10OIO-1{1'b0}},1'b1}) ? {`DW_O0I10OIO{1'b0}} : l100O001+{{`DW_O0I10OIO-1{1'b0}},1'b1} : l100O001;

  assign l01O0OO1             = ~|word_cnt | ((word_cnt === 1) & ~pop_n);
  assign l1O01100  = l01O0OO1 & OO1l1lI1;
  assign lll000Il         = OO0O11OO & ~I0O101Ol;
  assign IOO00OlO                = (l1O01100) ? OO1l1lI1 : (lll000Il & (~full | (full & ~pop_n)));
  assign O010I0Ol         = (l1O01100) ? (data_in | data_in) : O01l0010;
  assign lO1OO1Ol          = (l1O01100) ? l100O001 : OIOIOOOl;

  assign OI1lO1I0           = ((full & pop_n) ? OO0O11OO : OO1l1lI1) && ((arch_type % 2) === 0);
  assign O01l10lI    = OI1lO1I0 & ~l1O01100;


  assign I1l10lOl  = (((arch_type % 2) == 1) ? ~push_n : IOO00OlO) && (~full || ~pop_n);

  assign OOO01111              = ~l1O0O01O;
  assign ram_we_n                  = (arch_type == 0) ? 
                                       (push_n | (full & pop_n)) : 
                                       ((mem_mode == 2) || (mem_mode == 3)) ? Ol11lOOO : OOO01111;

  assign IO10O1Ol      = ((arch_type == 0) || ((arch_type % 2) == 1)) ? (data_in | data_in) : O010I0Ol;
  assign l1001lIO       = ((arch_type == 0) || ((arch_type % 2) == 1)) ? l100O001 : lO1OO1Ol;
  assign I10I10O1     = (mem_mode >= 4) ? ~ram_we_n : 1'b0;

  assign I0ll01O0 = ((mem_mode==2) | (mem_mode==3)) ? II1111OI : l1001lIO;

DW_ram_r_w_2c_dff #(`DW_O0I10OIO, `DW_llO00llI, `DW_O110lOl1, mem_mode, 1) U_TAG_DIR (
            .clk_w(clk),
            .rst_w_n(rst_n),
            .init_w_n(init_n),
            .en_w_n(ram_we_n),
            .addr_w(wr_addr),
            .data_w(I0ll01O0),
            .clk_r(clk),
            .rst_r_n(rst_n),
            .init_r_n(init_n),
            .en_r_n(~OOIO10O1),
            .addr_r(OOlOllOO),
            .data_r_a(I1OOO0OO),
            .data_r(O000OO1l)
            );


  assign I1100ll0  = ((mem_mode == 2) || (mem_mode == 3)) ? ~OOO01111 : ~ram_we_n;
  assign IOOI11O0 = (I1100ll0 === 1'b1) ? ((`DW_O10Ol011 == 1) ? O1OO0OI1 + {{`DW_O110lOl1+1-1{1'b0}},1'b1} :
                         (O1OO0OI1[`DW_O110lOl1-1:0] == `DW_I1II0OO1) ?
                           {~O1OO0OI1[`DW_O110lOl1], {`DW_O110lOl1{1'b0}}} :
                             O1OO0OI1 + {{`DW_O110lOl1+1-1{1'b0}},1'b1}) : 
                         (I1100ll0 === 1'b0) ? O1OO0OI1 : {`DW_O110lOl1+1{1'bX}};

  assign I01ll0O1 = O1OO0OI1[`DW_O110lOl1-1:0];

  assign l0llI101   = (O0l00I11 == O1OO0OI1);

  assign lI1I1O0O  = (O0l00I11 == OO11IOO0);
  assign OOO111OI       = l0llI101 || lI1I1O0O;

  assign Il1Ol00O    = (mem_mode == 4) ? OOO111OI : ((mem_mode >= 5) ? lI1I1O0O : l0llI101);

  always @(I1100ll0 or OOIO10O1 or IlOI1O1l) begin : a1000_PROC
    if (I1100ll0 && !OOIO10O1)
      O10I1O1l = IlOI1O1l + 1;
    else if (!I1100ll0 && OOIO10O1)
      O10I1O1l = IlOI1O1l - 1;
    else
      O10I1O1l = IlOI1O1l; 
  end

  assign lO1OO01O = (push_n && !pop_n && !empty) || (pop_n && !push_n && !full) ||
                             (!push_n && !pop_n && empty);
  assign OlII10O1   = (lO1OO01O === 1'b1) ?
                             (arch_type == 0) ? 
                               O10I1O1l :
                               O01l10lI + O10I1O1l + IlOO00OI[1] + IlOO00OI[0] + OI10O0l0[2] + OI10O0l0[1] + OI10O0l0[0] :
                            (lO1OO01O === 1'b0) ? word_cnt : {`DW_OlII0OO1{1'bX}};


    assign O0IO10O1 = ~Il1Ol00O |
			I1l10lOl |
			~I0OO0IIl & Ol0l01I0[0];

    assign OOl00001 = I1l10lOl & ~Il1Ol00O |
			I1l10lOl & ~I0OO0IIl & Ol0l01I0[0];

    assign OI1l111O = I0OO0IIl & ~Il1Ol00O;


    assign I011lOOO[1] = I1l10lOl & Il1Ol00O & I11O0O00[0] |
			I1l10lOl & Il1Ol00O & Ol0l01I0[1] |
			~I0OO0IIl & I11O0O00[0] |
			~I0OO0IIl & Ol0l01I0[1] |
			I1l10lOl & ~I0OO0IIl & Ol0l01I0[0];

    assign I011lOOO[0] = I1l10lOl |
			I11O0O00[0] |
			Ol0l01I0[1] |
			~I0OO0IIl & Ol0l01I0[0];

    assign OIOOOlOO = I1l10lOl & ~Il1Ol00O |
			I1l10lOl & ~I0OO0IIl & I11O0O00[0] |
			I1l10lOl & ~I0OO0IIl & Ol0l01I0[1];

    assign OI0O011O = I0OO0IIl & ~Il1Ol00O;


    assign O1lI001O[2] = I1l10lOl & I0OO0IIl & Il1Ol00O & I11O0O00[1] |
			~I0OO0IIl & Ol0l01I0[2] |
			~I0OO0IIl & I11O0O00[0] & Ol0l01I0[1] |
			I1l10lOl & Il1Ol00O & Ol0l01I0[2] |
			I1l10lOl & ~I0OO0IIl & ~I11O0O00[1] & I11O0O00[0] |
			I1l10lOl & Il1Ol00O & I11O0O00[0] & Ol0l01I0[1] |
			I1l10lOl & ~I0OO0IIl & ~I11O0O00[1] & Ol0l01I0[1];

    assign O1lI001O[1] = Ol0l01I0[2] |
			I11O0O00[0] & Ol0l01I0[1] |
			I1l10lOl & ~I11O0O00[1] & I11O0O00[0] |
			I1l10lOl & ~I0OO0IIl & Ol0l01I0[0] |
			~I0OO0IIl & I11O0O00[0] |
			I1l10lOl & ~I11O0O00[1] & Ol0l01I0[1] |
			~I0OO0IIl & Ol0l01I0[1];

    assign O1lI001O[0] = I11O0O00[0] |
			I1l10lOl |
			Ol0l01I0[1] |
			~I0OO0IIl & Ol0l01I0[0];

    assign OOOOlO11 = I1l10lOl & ~I0OO0IIl & Ol0l01I0[2] |
			I1l10lOl & ~Il1Ol00O |
			I1l10lOl & ~I0OO0IIl & I11O0O00[1] |
			I1l10lOl & ~I0OO0IIl & I11O0O00[0] & Ol0l01I0[1];

    assign II00I10I = I0OO0IIl & ~Il1Ol00O;



    assign l1l0OllO[1] = I1l10lOl & ~OO0Ol11I & ~Il1Ol00O |
			I1l10lOl & ~I0OO0IIl & Ol0l01I0[0] |
			I1l10lOl & ~OO0Ol11I & Ol0l01I0[1] |
			~I0OO0IIl & ~Il1Ol00O |
			~Il1Ol00O & Ol0l01I0[1] |
			~I0OO0IIl & Ol0l01I0[1];

    assign l1l0OllO[0] = I1l10lOl & ~OO0Ol11I |
			~I0OO0IIl & Ol0l01I0[0] |
			~Il1Ol00O |
			Ol0l01I0[1];

    assign O100000O = I1l10lOl & OO0Ol11I & Ol0l01I0[0] |
			I1l10lOl & ~I0OO0IIl & ~Il1Ol00O |
			I1l10lOl & ~I0OO0IIl & Ol0l01I0[1] |
			I1l10lOl & ~Il1Ol00O & Ol0l01I0[1];

    assign ll000l0I = ~Il1Ol00O & ~Ol0l01I0[1] |
			I0OO0IIl & ~Il1Ol00O;


    assign OI010l01[2] = ~I0OO0IIl & Ol0l01I0[2] & ~Ol0l01I0[1] |
			I1l10lOl & I0OO0IIl & ~OO0Ol11I & ~Il1Ol00O & ~Ol0l01I0[1] |
			I1l10lOl & ~OO0Ol11I & Il1Ol00O & Ol0l01I0[2] |
			~I0OO0IIl & ~I11O0O00[0] & Ol0l01I0[2] |
			I1l10lOl & I0OO0IIl & ~OO0Ol11I & ~Il1Ol00O & ~I11O0O00[0] & ~Ol0l01I0[2] |
			~I0OO0IIl & I11O0O00[0] & ~Ol0l01I0[2] & Ol0l01I0[1] |
			I1l10lOl & ~I0OO0IIl & Il1Ol00O & I11O0O00[0] |
			I1l10lOl & ~OO0Ol11I & Il1Ol00O & I11O0O00[0] & Ol0l01I0[1] |
			I1l10lOl & ~I0OO0IIl & Il1Ol00O & Ol0l01I0[1];

    assign OI010l01[1] = Ol0l01I0[2] & ~Ol0l01I0[1] |
			~I0OO0IIl & ~Ol0l01I0[2] & Ol0l01I0[1] |
			~I0OO0IIl & I11O0O00[0] & ~Ol0l01I0[1] |
			I1l10lOl & ~I0OO0IIl & ~Ol0l01I0[2] & Ol0l01I0[0] |
			~I11O0O00[0] & Ol0l01I0[2] |
			I1l10lOl & Il1Ol00O & I11O0O00[0] |
			I11O0O00[0] & ~Ol0l01I0[2] & Ol0l01I0[1] |
			I1l10lOl & Il1Ol00O & Ol0l01I0[1];

    assign OI010l01[0] = I1l10lOl & ~Ol0l01I0[1] |
			~I11O0O00[0] & Ol0l01I0[1] |
			~Ol0l01I0[2] & Ol0l01I0[1] |
			I11O0O00[0] & ~Ol0l01I0[1] |
			~I0OO0IIl & ~Ol0l01I0[2] & Ol0l01I0[0];

    assign lOO1lO01 = I1l10lOl & OO0Ol11I & ~I11O0O00[0] |
			I1l10lOl & ~I0OO0IIl & I11O0O00[0] & ~Ol0l01I0[2] & Ol0l01I0[1] |
			I1l10lOl & ~I0OO0IIl & ~Il1Ol00O & ~Ol0l01I0[2] |
			I1l10lOl & OO0Ol11I & ~Ol0l01I0[2] |
			I1l10lOl & ~I0OO0IIl & Il1Ol00O & Ol0l01I0[2] |
			I1l10lOl & ~Il1Ol00O & ~I11O0O00[0] & Ol0l01I0[2] |
			I1l10lOl & ~Il1Ol00O & I11O0O00[0] & ~Ol0l01I0[2] & Ol0l01I0[1];

    assign Il0OI111 = ~Il1Ol00O & ~Ol0l01I0[1] |
                        I0OO0IIl & ~Il1Ol00O & ~I11O0O00[0] |
                        ~Il1Ol00O & ~I11O0O00[0] & ~Ol0l01I0[2] |
                        I0OO0IIl & ~Il1Ol00O & ~Ol0l01I0[2];




    assign OOO0O00O[1] = I1l10lOl & ~OO0Ol11I & Il1Ol00O & I11O0O00[0] |
			I1l10lOl & ~OO0Ol11I & Il1Ol00O & Ol0l01I0[1] |
			~I0OO0IIl & I11O0O00[0] |
			~I0OO0IIl & Ol0l01I0[1] |
			I1l10lOl & ~I0OO0IIl & Ol0l01I0[0];

    assign OOO0O00O[0] = I1l10lOl |
			I11O0O00[0] |
			Ol0l01I0[1] |
			~I0OO0IIl & Ol0l01I0[0];

    assign O1O0lIOI = I1l10lOl & ~Il1Ol00O |
			I1l10lOl & ~I0OO0IIl & I11O0O00[0] |
			I1l10lOl & OO0Ol11I |
			I1l10lOl & ~I0OO0IIl & Ol0l01I0[1];

    assign I010I0Ol = I0OO0IIl & ~Il1Ol00O |
			I0OO0IIl & OO0Ol11I;
    assign I10O1l10[2] = I1l10lOl & I0OO0IIl & ~OO0Ol11I & Il1Ol00O & I11O0O00[1] |
			I1l10lOl & ~OO0Ol11I & Il1Ol00O & Ol0l01I0[2] |
			~I0OO0IIl & Ol0l01I0[2] |
			~I0OO0IIl & I11O0O00[0] & Ol0l01I0[1] |
			I1l10lOl & ~I0OO0IIl & ~OO0Ol11I & Il1Ol00O & ~I11O0O00[1] & I11O0O00[0] |
			I1l10lOl & ~OO0Ol11I & Il1Ol00O & I11O0O00[0] & Ol0l01I0[1] |
			I1l10lOl & ~I0OO0IIl & ~OO0Ol11I & ~I11O0O00[1] & Ol0l01I0[1];

    assign I10O1l10[1] = I1l10lOl & ~I0OO0IIl & ~OO0Ol11I & ~I11O0O00[0] & Ol0l01I0[0] |
			~I0OO0IIl & I11O0O00[1] |
			Ol0l01I0[2] |
			I1l10lOl & ~OO0Ol11I & Il1Ol00O & ~I11O0O00[1] & I11O0O00[0] |
			I11O0O00[0] & Ol0l01I0[1] |
			~I0OO0IIl & ~OO0Ol11I & Il1Ol00O & I11O0O00[0] |
			I1l10lOl & ~OO0Ol11I & ~I11O0O00[1] & Ol0l01I0[1] |
			~I0OO0IIl & ~OO0Ol11I & Ol0l01I0[1];

    assign I10O1l10[0] = ~I0OO0IIl & ~OO0Ol11I & ~I11O0O00[0] & Ol0l01I0[0] |
			I1l10lOl & ~OO0Ol11I & ~I11O0O00[0] |
			I11O0O00[1] |
			Ol0l01I0[2] |
			I11O0O00[0] & Ol0l01I0[1] |
			~OO0Ol11I & Il1Ol00O & I11O0O00[0] |
			~OO0Ol11I & Ol0l01I0[1];

    assign O0000O1I = I1l10lOl & ~I0OO0IIl & Ol0l01I0[2] |
			I1l10lOl & ~Il1Ol00O & I11O0O00[1] |
			I1l10lOl & OO0Ol11I & I11O0O00[1] |
			I1l10lOl & ~Il1Ol00O & Ol0l01I0[1] |
			I1l10lOl & OO0Ol11I & Ol0l01I0[2] |
			I1l10lOl & ~I0OO0IIl & I11O0O00[1] |
			I1l10lOl & OO0Ol11I & I11O0O00[0] & Ol0l01I0[1] |
			I1l10lOl & ~I0OO0IIl & I11O0O00[0] & Ol0l01I0[1];

    assign O1I0I0l1 = I0OO0IIl & ~Il1Ol00O & I11O0O00[1] |
			I0OO0IIl & OO0Ol11I & I11O0O00[1] |
			I0OO0IIl & ~Il1Ol00O & Ol0l01I0[1] |
			I0OO0IIl & OO0Ol11I & Ol0l01I0[2] |
			I0OO0IIl & OO0Ol11I & I11O0O00[0] & Ol0l01I0[1];

  assign l1O0O01O     = (arch_type == 0) ? OO1l1lI1 :
                               ((mem_mode == 0) ? OOl00001 :
                                 ((mem_mode == 1) || (mem_mode == 2)) ? OIOOOlOO:
                                   (mem_mode == 3) ? OOOOlO11 :
                                     (mem_mode == 4) ? O100000O :
                                       (mem_mode == 5) ? lOO1lO01 :
                                         (mem_mode == 6) ? O1O0lIOI : O0000O1I);




  assign I0IIO0I1        = (arch_type == 0) ? I0OO0IIl: 
                                ((mem_mode == 0) ? OI1l111O :
                                  ((mem_mode == 1) || (mem_mode == 2)) ? OI0O011O:
                                    (mem_mode == 3) ? II00I10I :
                                      (mem_mode == 4) ? ll000l0I :
                                        (mem_mode == 5) ? Il0OI111 :
                                          (mem_mode == 6) ? I010I0Ol : O1I0I0l1);

  assign IllO1O00 = (I0IIO0I1 === 1'b1) ? ((`DW_O10Ol011 == 1) ? O0l00I11 + {{`DW_O110lOl1+1-1{1'b0}},1'b1} :
                          (O0l00I11[`DW_O110lOl1-1:0] == `DW_I1II0OO1) ?
                            {~O0l00I11[`DW_O110lOl1], {`DW_O110lOl1{1'b0}}} :
                              O0l00I11 + {{`DW_O110lOl1+1-1{1'b0}},1'b1}) : 
                          (I0IIO0I1 === 1'b0) ? O0l00I11 : {`DW_O110lOl1+1{1'bX}};

  assign OOlOllOO = rd_addr;

  assign OOIO10O1 = I0IIO0I1;
  assign IlOO00OI[1] = ((mem_mode==3) || (mem_mode==7)) ? OOIO10O1 : 1'b0;
  assign IlOO00OI[0] = ((mem_mode==3) || (mem_mode==7)) ? I11O0O00[1] : ((mem_mode==1) || (mem_mode==2) || (mem_mode==5) || (mem_mode==6)) ? OOIO10O1 : 1'b0;
   
  assign OI10O0l0 = (mem_mode == 0) ? {2'b00, O0IO10O1} :
                        ((mem_mode == 1) || (mem_mode == 2)) ? {1'b0, I011lOOO} :
                          (mem_mode == 3) ? O1lI001O :
                            (mem_mode == 4) ? {1'b0, l1l0OllO} :
                              (mem_mode == 5) ? OI010l01 :
                                (mem_mode == 6) ? {1'b0, OOO0O00O} :
                                  (mem_mode == 7) ? I10O1l10 : 3'b000;

  assign ram_re_n     = ((mem_mode==0) || (ram_re_ext == 0)) ? ~OOIO10O1 :
                          (((mem_mode==1) || (mem_mode==2) || (mem_mode==4) || (mem_mode==6))) ? ~OOIO10O1 & ~I11O0O00[0] :
                            ~OOIO10O1 & ~I11O0O00[0] & ~I11O0O00[1];

  assign I10O0IOl = ((arch_type % 2) == 0) ? OO0O11OO : 1'b1;

  always @(OI10O0l0 or empty or Il1Ol00O or data_in or OO1l1lI1 or pop_n or Ol0l01I0 or 
           l1001lIO or IO10O1Ol or rd_data or I1OOO0OO or O000OO1l or I10O0IOl) begin : DW_O111001l
    reg  [`DW_O0I10OIO-1:0] III1I010;
  
    III1I010 = O000OO1l;

    if (OI10O0l0[0] === 1'b1) begin
      l0OOO01I[0] = O01III00[0];
      l1OOI000[0]  = O1l0O011[0];
      if (OO1l1lI1 && empty) begin
        l0OOO01I[0] = (data_in | data_in);
        l1OOI000[0]  = l1001lIO;
      end else if (~pop_n) begin
        if (O1l0O011[0] === depth-1) begin
          if ((O1l0O011[1] === 0) && Ol0l01I0[1]) begin
            l0OOO01I[0] = O01III00[1];
            l1OOI000[0]  = O1l0O011[1];
          end else if ((III1I010 === 0) && I1OOO0OO) begin
            l0OOO01I[0] = (rd_data | rd_data);
            l1OOI000[0]  = III1I010;
          end else if (l1001lIO === 0) begin
            l0OOO01I[0] = IO10O1Ol;
            l1OOI000[0]  = l1001lIO;
          end
        end else begin
          if (((O1l0O011[0]+1) === O1l0O011[1]) && Ol0l01I0[1]) begin
            l0OOO01I[0] = O01III00[1];
            l1OOI000[0]  = O1l0O011[1];
          end else if (((O1l0O011[0]+1) === III1I010) && I1OOO0OO) begin
            l0OOO01I[0] = (rd_data | rd_data);
            l1OOI000[0]  = III1I010;
          end else if ((O1l0O011[0]+1) == l1001lIO) begin
            l0OOO01I[0] = IO10O1Ol;
            l1OOI000[0]  = l1001lIO;
          end
        end
      end
    end else if (OI10O0l0[0] === 1'b0) begin
      l0OOO01I[0] = O01III00[0];
      l1OOI000[0]  = O1l0O011[0];
    end else begin
      l0OOO01I[0] = {width{1'bX}};
      l1OOI000[0]  = {`DW_O0I10OIO{1'bX}};
    end
    if (OI10O0l0[1] === 1'b1) begin
      l0OOO01I[1] = O01III00[1];
      l1OOI000[1]  = O1l0O011[1];
      if (~pop_n) begin
        if (O1l0O011[0] === depth-1) begin
          if ((O1l0O011[2] === 1) && Ol0l01I0[2]) begin
            l0OOO01I[1] = O01III00[2];
            l1OOI000[1]  = O1l0O011[2];
          end else if ((III1I010 === 1) && I1OOO0OO) begin
            l0OOO01I[1] = (rd_data | rd_data);
            l1OOI000[1]  = III1I010;
          end else if ((l1001lIO === 1) && (I10O0IOl === 1'b1)) begin
            l0OOO01I[1] = IO10O1Ol;
            l1OOI000[1]  = l1001lIO;
          end
        end else if (O1l0O011[0] === depth-2) begin
          if ((O1l0O011[2] === 0) && Ol0l01I0[2]) begin
            l0OOO01I[1] = O01III00[2];
            l1OOI000[1]  = O1l0O011[2];
          end else if ((III1I010 === 0) && I1OOO0OO) begin
            l0OOO01I[1] = (rd_data | rd_data);
            l1OOI000[1]  = III1I010;
          end else if ((l1001lIO === 0) && (I10O0IOl === 1'b1)) begin
            l0OOO01I[1] = IO10O1Ol;
            l1OOI000[1]  = l1001lIO;
          end
        end else begin
          if (((O1l0O011[0]+2) === O1l0O011[2]) && Ol0l01I0[2]) begin
            l0OOO01I[1] = O01III00[2];
            l1OOI000[1]  = O1l0O011[2];
          end else if (((O1l0O011[0]+2) === III1I010) && I1OOO0OO) begin
            l0OOO01I[1] = (rd_data | rd_data);
            l1OOI000[1]  = III1I010;
          end else if (((O1l0O011[0]+2) == l1001lIO) && (I10O0IOl === 1'b1)) begin
            l0OOO01I[1] = IO10O1Ol;
            l1OOI000[1]  = l1001lIO;
          end
        end
      end else begin
        if (O1l0O011[0] === depth-1) begin
          if ((O1l0O011[2] === 0) && Ol0l01I0[2]) begin
            l0OOO01I[1] = O01III00[2];
            l1OOI000[1]  = O1l0O011[2];
          end else if ((III1I010 === 0) && I1OOO0OO) begin
            l0OOO01I[1] = (rd_data | rd_data);
            l1OOI000[1]  = III1I010;
          end else if ((l1001lIO === 0) && (I10O0IOl === 1'b1)) begin
            l0OOO01I[1] = IO10O1Ol;
            l1OOI000[1]  = l1001lIO;
          end
        end else begin
          if (((O1l0O011[0]+1) === O1l0O011[2]) && Ol0l01I0[2]) begin
            l0OOO01I[1] = O01III00[2];
            l1OOI000[1]  = O1l0O011[2];
          end else if (((O1l0O011[0]+1) === III1I010) && I1OOO0OO) begin
            l0OOO01I[1] = (rd_data | rd_data);
            l1OOI000[1]  = III1I010;
          end else if (((O1l0O011[0]+1) == l1001lIO) && (I10O0IOl === 1'b1)) begin
            l0OOO01I[1] = IO10O1Ol;
            l1OOI000[1]  = l1001lIO;
          end
        end
      end
    end else if (OI10O0l0[1] === 1'b0) begin
      l0OOO01I[1] = O01III00[1];
      l1OOI000[1]  = O1l0O011[1];
    end else begin
      l0OOO01I[1] = {width{1'bX}};
      l1OOI000[1]  = {`DW_O0I10OIO{1'bX}};
    end
    if (OI10O0l0[2] === 1'b1) begin
      l0OOO01I[2] = O01III00[2];
      l1OOI000[2]  = O1l0O011[2];
      if (~pop_n) begin
        if (O1l0O011[0] === depth-1) begin
          if ((III1I010 === 2) && I1OOO0OO) begin
            l0OOO01I[2] = (rd_data | rd_data);
            l1OOI000[2]  = III1I010;
          end else if ((l1001lIO === 2) && (I10O0IOl === 1'b1)) begin
            l0OOO01I[2] = IO10O1Ol;
            l1OOI000[2]  = l1001lIO;
          end
        end else if (O1l0O011[0] === depth-2) begin
          if ((III1I010 === 1) && I1OOO0OO) begin
            l0OOO01I[2] = (rd_data | rd_data);
            l1OOI000[2]  = III1I010;
          end else if ((l1001lIO === 1) && (I10O0IOl === 1'b1)) begin
            l0OOO01I[2] = IO10O1Ol;
            l1OOI000[2]  = l1001lIO;
          end
        end else if (O1l0O011[0] === depth-3) begin
          if ((III1I010 === 0) && I1OOO0OO) begin
            l0OOO01I[2] = (rd_data | rd_data);
            l1OOI000[2]  = III1I010;
          end else if ((l1001lIO === 0) && (I10O0IOl === 1'b1)) begin
            l0OOO01I[2] = IO10O1Ol;
            l1OOI000[2]  = l1001lIO;
          end
        end else begin
          if (((O1l0O011[0]+3) === III1I010) && I1OOO0OO) begin
            l0OOO01I[2] = (rd_data | rd_data);
            l1OOI000[2]  = III1I010;
          end else if (((O1l0O011[0]+3) == l1001lIO) && (I10O0IOl === 1'b1)) begin
            l0OOO01I[2] = IO10O1Ol;
            l1OOI000[2]  = l1001lIO;
          end
        end
      end else begin
        if (O1l0O011[0] === depth-1) begin
          if ((III1I010 === 1) && I1OOO0OO) begin
            l0OOO01I[2] = (rd_data | rd_data);
            l1OOI000[2]  = III1I010;
          end else if ((l1001lIO === 1) && (I10O0IOl === 1'b1)) begin
            l0OOO01I[2] = IO10O1Ol;
            l1OOI000[2]  = l1001lIO;
          end
        end else if (O1l0O011[0] === depth-2) begin
          if ((III1I010 === 0) && I1OOO0OO) begin
            l0OOO01I[2] = (rd_data | rd_data);
            l1OOI000[2]  = III1I010;
          end else if ((l1001lIO === 0) && (I10O0IOl === 1'b1)) begin
            l0OOO01I[2] = IO10O1Ol;
            l1OOI000[2]  = l1001lIO;
          end
        end else begin
          if (((O1l0O011[0]+2) === III1I010) && I1OOO0OO) begin
            l0OOO01I[2] = (rd_data | rd_data);
            l1OOI000[2]  = III1I010;
          end else if (((O1l0O011[0]+2) == l1001lIO) && (I10O0IOl === 1'b1)) begin
            l0OOO01I[2] = IO10O1Ol;
            l1OOI000[2]  = l1001lIO;
          end
        end
      end
    end else if (OI10O0l0[2] === 1'b0) begin
      l0OOO01I[2] = O01III00[2];
      l1OOI000[2]  = O1l0O011[2];
    end else begin
      l0OOO01I[2] = {width{1'bX}};
      l1OOI000[2]  = {`DW_O0I10OIO{1'bX}};
    end
  end

  always @(posedge clk or negedge rst_n) begin : IO00O1I1_PROC
    integer O1OO1I1O, l0IO00O0;
    if (rst_n === 1'b0) begin
      O01l0010      <= {width{1'b0}};
      I0O101Ol  <= 1'b0;
      O0O1O1l1  <= {`DW_O110lOl1{1'b0}};
      OI01O00O  <= {width{1'b0}};
      OIOIOOOl       <= {`DW_O0I10OIO{1'b0}};
      II1111OI   <= {`DW_O0I10OIO{1'b0}};
      O1OO0OI1          <= {`DW_O110lOl1+1{1'b0}};
      O0l00I11          <= {`DW_O110lOl1+1{1'b0}};
      OO11IOO0       <= {`DW_O110lOl1+1{1'b0}};
      error           <= 1'b0;
      OO0O11OO       <= 1'b0;
      OO0Ol11I         <= 1'b0;
      l100O001          <= {`DW_O0I10OIO{1'b0}};
      I11O0O00         <= {2{1'b0}};
      Ol0l01I0           <= {3{1'b0}};
      Ol11lOOO <= 1'b1;
      IlOI1O1l         <= {`DW_OlII0OO1{1'b0}};
      O01lI10I    <= 1'b1;
      word_cnt        <= {`DW_OlII0OO1{1'b0}};
      almost_empty    <= 1'b1;
      almost_full     <= 1'b0;
      for (O1OO1I1O=0; O1OO1I1O<3; O1OO1I1O=O1OO1I1O+1) begin
        O1l0O011[O1OO1I1O] <= {`DW_O0I10OIO{1'bX}};
      end
      for (l0IO00O0=0; l0IO00O0<3; l0IO00O0=l0IO00O0+1) begin
        O01III00[l0IO00O0] <= {width{1'b0}};
      end
    end else if (rst_n === 1'b1) begin
      if (init_n === 1'b0) begin
        O01l0010      <= {width{1'b0}};
        I0O101Ol  <= 1'b0;
        O0O1O1l1  <= {`DW_O110lOl1{1'b0}};
        OI01O00O  <= {width{1'b0}};
        OIOIOOOl       <= {`DW_O0I10OIO{1'b0}};
        II1111OI   <= {`DW_O0I10OIO{1'b0}};
        O1OO0OI1          <= {`DW_O110lOl1+1{1'b0}};
        O0l00I11          <= {`DW_O110lOl1+1{1'b0}};
        OO11IOO0       <= {`DW_O110lOl1+1{1'b0}};
        error           <= 1'b0;
        OO0O11OO       <= 1'b0;
        OO0Ol11I         <= 1'b0;
        l100O001          <= {`DW_O0I10OIO{1'b0}};
        I11O0O00         <= {2{1'b0}};
        Ol0l01I0           <= {3{1'b0}};
        Ol11lOOO <= 1'b1;
        IlOI1O1l         <= {`DW_OlII0OO1{1'b0}};
        O01lI10I    <= 1'b1;
        word_cnt        <= {`DW_OlII0OO1{1'b0}};
        almost_empty    <= 1'b1;
        almost_full     <= 1'b0;
        for (O1OO1I1O=0; O1OO1I1O<3; O1OO1I1O=O1OO1I1O+1) begin
          O1l0O011[O1OO1I1O] <= {`DW_O0I10OIO{1'bX}};
        end
        for (l0IO00O0=0; l0IO00O0<3; l0IO00O0=l0IO00O0+1) begin
          O01III00[l0IO00O0] <= {width{1'b0}};
        end
      end else if (init_n === 1'b1) begin
        O01l0010      <= IO0IO1O0;
        I0O101Ol  <= l1O01100;
        O0O1O1l1      <= I01ll0O1;
        OI01O00O  <= IO10O1Ol;
        OIOIOOOl       <= O11O1OOO;
        II1111OI   <= l1001lIO;
        O1OO0OI1          <= IOOI11O0;
        O0l00I11          <= IllO1O00;
        OO11IOO0       <= O1OO0OI1;
        error           <= O00II10O;
        OO0O11OO       <= OI1lO1I0;
        OO0Ol11I         <= I10I10O1;
        l100O001          <= IIlOl1OO;
        I11O0O00         <= IlOO00OI;
        Ol0l01I0           <= OI10O0l0;
        Ol11lOOO <= OOO01111;
        IlOI1O1l         <= O10I1O1l;
        O01lI10I    <= Il1Ol00O;
        word_cnt        <= OlII10O1;
        almost_empty    <= O1OOO1l0;
        almost_full     <= II0OI00O;
        for (O1OO1I1O=0; O1OO1I1O<3; O1OO1I1O=O1OO1I1O+1) begin
          O1l0O011[O1OO1I1O] <= l1OOI000[O1OO1I1O];
        end
        for (l0IO00O0=0; l0IO00O0<3; l0IO00O0=l0IO00O0+1) begin
          O01III00[l0IO00O0] <= l0OOO01I[l0IO00O0];
        end
      end else begin
        O01l0010      <= {width{1'bX}};
        I0O101Ol  <= 1'bX;
        O0O1O1l1  <= {`DW_O110lOl1{1'bX}};
        OI01O00O  <= {width{1'bX}};
        OIOIOOOl       <= {`DW_O0I10OIO{1'bX}};
        II1111OI   <= {`DW_O0I10OIO{1'bX}};
        O1OO0OI1          <= {`DW_O110lOl1+1{1'bX}};
        O0l00I11          <= {`DW_O110lOl1+1{1'bX}};
        OO11IOO0       <= {`DW_O110lOl1+1{1'bX}};
        error           <= 1'bX;
        OO0O11OO       <= 1'bX;
        OO0Ol11I         <= 1'bX;
        l100O001          <= {`DW_O0I10OIO{1'bX}};
        I11O0O00         <= {2{1'bX}};
        Ol0l01I0           <= {3{1'bX}};
        Ol11lOOO <= 1'bX;
        IlOI1O1l         <= {`DW_OlII0OO1{1'bX}};
        O01lI10I    <= 1'bX;
        word_cnt        <= {`DW_OlII0OO1{1'bX}};
        almost_empty    <= 1'bX;
        almost_full     <= 1'bX;
        for (O1OO1I1O=0; O1OO1I1O<3; O1OO1I1O=O1OO1I1O+1) begin
          O1l0O011[O1OO1I1O] <= {`DW_O0I10OIO{1'bX}};
        end
        for (l0IO00O0=0; l0IO00O0<3; l0IO00O0=l0IO00O0+1) begin
          O01III00[l0IO00O0] <= {width{1'bX}};
        end
      end
    end else begin
      O01l0010      <= {width{1'bX}};
      I0O101Ol  <= 1'bX;
      O0O1O1l1  <= {`DW_O110lOl1{1'bX}};
      OI01O00O  <= {width{1'bX}};
      OIOIOOOl       <= {`DW_O0I10OIO{1'bX}};
      II1111OI   <= {`DW_O0I10OIO{1'bX}};
      O1OO0OI1          <= {`DW_O110lOl1+1{1'bX}};
      O0l00I11          <= {`DW_O110lOl1+1{1'bX}};
      OO11IOO0       <= {`DW_O110lOl1+1{1'bX}};
      error           <= 1'bX;
      OO0O11OO       <= 1'bX;
      OO0Ol11I         <= 1'bX;
      l100O001          <= {`DW_O0I10OIO{1'bX}};
      I11O0O00         <= {2{1'bX}};
      Ol0l01I0           <= {3{1'bX}};
      Ol11lOOO <= 1'bX;
      IlOI1O1l         <= {`DW_OlII0OO1{1'bX}};
      O01lI10I    <= 1'bX;
      word_cnt        <= {`DW_OlII0OO1{1'bX}};
      almost_empty    <= 1'bX;
      almost_full     <= 1'bX;
      for (O1OO1I1O=0; O1OO1I1O<3; O1OO1I1O=O1OO1I1O+1) begin
        O1l0O011[O1OO1I1O] <= {`DW_O0I10OIO{1'bX}};
      end
      for (l0IO00O0=0; l0IO00O0<3; l0IO00O0=l0IO00O0+1) begin
        O01III00[l0IO00O0] <= {width{1'bX}};
      end
    end
  end  // block: IO00O1I1_PROC

  assign wr_addr = ((mem_mode == 2) || (mem_mode == 3)) ? O0O1O1l1 : I01ll0O1;
  assign wr_data = (ram_we_n) ? {width{1'bX}} : ((mem_mode == 2) || (mem_mode == 3)) ? OI01O00O : IO10O1Ol;
  assign rd_addr = O0l00I11[`DW_O110lOl1-1:0];

  assign  l0OOOl0O  = (~push_n & full & pop_n) | (~pop_n & empty);
  assign  O00II10O  = (err_mode == 1) ? l0OOOl0O : (error || l0OOOl0O);

  assign  O010OO0O        = ((push_n !== pop_n) && ((~pop_n && ~empty) || (~push_n && ~full))) ||
                                (~push_n && ~pop_n && empty);
  assign  O1OOO1l0   = (O010OO0O || level_change) ? (OlII10O1 <= ae_level) : 
                                  !(O010OO0O || level_change) ? almost_empty : 1'bX;
  assign  II0OI00O    = (O010OO0O || level_change) ? (OlII10O1 >= ((af_from_top == 0) ? af_level: depth-af_level)) : 
                                  !(O010OO0O || level_change) ? almost_full : 1'bX;
  assign  empty               = ~|word_cnt;
  assign  half_full           = word_cnt >= (depth+1)/2;
  assign  full                = ((word_cnt > 0) && (word_cnt === depth)) ? 1'b1 : ((word_cnt >= 0) && (word_cnt !== depth)) ? 1'b0 : 1'bX;

  assign data_out = (arch_type == 0) ? (rd_data | rd_data) : O01III00[0];


    
`ifndef DW_DISABLE_CLK_MONITOR
`ifndef DW_SUPPRESS_WARN
  always @ (clk) begin : clk_monitor 
    if ( (clk !== 1'b0) && (clk !== 1'b1) && ($time > 0) )
      $display ("WARNING: %m:\n at time = %0t: Detected unknown value, %b, on clk input.", $time, clk);
    end // clk_monitor 
`endif
`endif


// verpp-pragma processing_off
`ifndef SYNTHESIS
 // Only use assertions for simulation
 `ifdef SYSTEMVERILOG
  `ifdef DW_SVA_MODE
    `define DW_LOCAL_SVA_MODE `DW_SVA_MODE
  `else
    // Default to 'error' message reporting
    `define DW_LOCAL_SVA_MODE 2
  `endif  // DW_SVA_MODE
  property DW_re_reset_empty_flags;
  @(posedge rst_n) ((empty == 1'b1) && (almost_empty == 1'b1));
  endproperty

  property DW_long_reset_empty_flags;
  @(posedge clk) (rst_n == 1'b0) |-> ((empty == 1'b1) && (almost_empty == 1'b1));
  endproperty

  property DW_re_reset_full_flags;
  @(posedge rst_n) ((full == 1'b0) && (almost_full == 1'b0) && (half_full == 1'b0));
  endproperty

  property DW_long_reset_full_flags;
  @(posedge clk) (rst_n == 1'b0) |-> ((full == 1'b0) && (almost_full == 1'b0) && (half_full == 1'b0));
  endproperty

  property DW_init_empty_flags;
  @(posedge clk) (init_n == 1'b0) |=> ((empty == 1'b1) && (almost_empty == 1'b1));
  endproperty

  property DW_init_full_flags;
  @(posedge clk) (init_n == 1'b0) |=> ((full == 1'b0) && (almost_full == 1'b0) && (half_full == 1'b0));
  endproperty

  property DW_empty_fifo_based_on_word_cnt;
    @(posedge clk) (word_cnt == 0) |-> (empty == 1'b1);
  endproperty

  property DW_empty_fifo_based_on_cache_state;
    @(posedge clk) (empty == 1'b1) |-> (Ol0l01I0[0] == 1'b0);
  endproperty

  property DW_full_fifo_condition;
    @(posedge clk) (word_cnt == depth) |-> (full == 1'b1);
  endproperty

  property DW_valid_pop;
    @(posedge clk) (pop_n | ~empty);    
  endproperty

  property DW_valid_push;
    @(posedge clk) (push_n | ~full | ~pop_n);    
  endproperty

  property DW_legal_word_cnt;
    @(posedge clk) ((word_cnt >= 0) && (word_cnt <= depth));
  endproperty

  property DW_empty_pop_rd_ptr_no_change;
    @(posedge clk) disable iff (!rst_n || !init_n)
      (~pop_n && empty) |=> (O0l00I11 == $past(O0l00I11));
  endproperty

  property DW_full_push_wr_ptr_no_change;
    @(posedge clk) disable iff (!rst_n || !init_n)
      (~push_n && full && pop_n) |=> (O1OO0OI1 == $past(O1OO0OI1));
  endproperty

  property DW_valid_cache_states;
    @(posedge clk)
      ((mem_mode==0) && (~|Ol0l01I0[2:0] || (~|Ol0l01I0[2:1] && Ol0l01I0[0]))) ||
      (((mem_mode==1) || (mem_mode==2) || (mem_mode==4) || (mem_mode==6)) && (~|Ol0l01I0[2:0] || (~|Ol0l01I0[2:1] && Ol0l01I0[0]) ||
                          (~Ol0l01I0[2] && &Ol0l01I0[1:0]))) ||
      (((mem_mode==3) || (mem_mode==5) || (mem_mode==7)) && (~|Ol0l01I0[2:0] || (~|Ol0l01I0[2:1] && Ol0l01I0[0]) || (~Ol0l01I0[2] && &Ol0l01I0[1:0]) ||
                            (Ol0l01I0[2] && ~Ol0l01I0[1] && Ol0l01I0[0])) || &Ol0l01I0[2:0]);
  endproperty

  always @(posedge rst_n) begin
    if (`DW_LOCAL_SVA_MODE != 0) begin
      DW_SVA_FIFOCTL_RISING_EDGE_RESET_EMPTY_FLAGS_WRONG:
        assert property (DW_re_reset_empty_flags)
        else if (`DW_LOCAL_SVA_MODE == 1) $warning;
        else if (`DW_LOCAL_SVA_MODE == 2) $error;
        else $fatal;

      DW_SVA_FIFOCTL_RISING_EDGE_RESET_FULL_FLAGS_WRONG:
        assert property (DW_re_reset_full_flags)
        else if (`DW_LOCAL_SVA_MODE == 1) $warning;
        else if (`DW_LOCAL_SVA_MODE == 2) $error;
        else $fatal;
    end  // if (`DW_LOCAL_SVA_MODE != 0)
  end  // always @(negedge rst_n or posedge clk)


  always @(posedge clk) begin
    if (`DW_LOCAL_SVA_MODE != 0) begin

      DW_SVA_FIFOCTL_1C_DF_LONG_RESET_EMPTY_FLAGS_WRONG:
        assert property (DW_long_reset_empty_flags)
        else if (`DW_LOCAL_SVA_MODE == 1) $warning;
        else if (`DW_LOCAL_SVA_MODE == 2) $error;
        else $fatal;

      DW_SVA_FIFOCTL_1C_DF_LONG_RESET_FULL_FLAGS_WRONG:
        assert property (DW_long_reset_full_flags)
        else if (`DW_LOCAL_SVA_MODE == 1) $warning;
        else if (`DW_LOCAL_SVA_MODE == 2) $error;
        else $fatal;

      DW_SVA_FIFOCTL_1C_DF_PUSH_OCCURRED_WHILE_FULL_BUT_NO_POP:
        assert property (DW_valid_push)
        else if (`DW_LOCAL_SVA_MODE == 1) $warning;
        else if (`DW_LOCAL_SVA_MODE == 2) $error;
        else $fatal;

      DW_SVA_FIFOCTL_1C_DF_POP_OCCURRED_WHILE_EMPTY:
        assert property (DW_valid_pop)
        else if (`DW_LOCAL_SVA_MODE == 1) $warning;
        else if (`DW_LOCAL_SVA_MODE == 2) $error;
        else $fatal;

      DW_SVA_FIFOCTL_1C_DF_EMPTY_FLAGS_DURING_INIT_WRONG:
        assert property (DW_init_empty_flags)
        else if (`DW_LOCAL_SVA_MODE == 1) $warning;
        else if (`DW_LOCAL_SVA_MODE == 2) $error;
        else $fatal;
    
      DW_SVA_FIFOCTL_1C_DF_FULL_FLAGS_DURING_INIT_WRONG:
        assert property (DW_init_full_flags)
        else if (`DW_LOCAL_SVA_MODE == 1) $warning;
        else if (`DW_LOCAL_SVA_MODE == 2) $error;
        else $fatal;
    
      DW_SVA_FIFOCTL_SHOULD_BE_EMPTY_BASED_ON_WORD_CNT:
        assert property (DW_empty_fifo_based_on_word_cnt)
        else if (`DW_LOCAL_SVA_MODE == 1) $warning;
        else if (`DW_LOCAL_SVA_MODE == 2) $error;
        else $fatal;
    
      DW_SVA_FIFOCTL_SHOULD_BE_EMPTY_BASED_ON_INUSE:
        assert property (DW_empty_fifo_based_on_cache_state)
        else if (`DW_LOCAL_SVA_MODE == 1) $warning;
        else if (`DW_LOCAL_SVA_MODE == 2) $error;
        else $fatal;
    
      DW_SVA_FIFOCTL_SHOULD_BE_FULL:
        assert property (DW_full_fifo_condition)
        else if (`DW_LOCAL_SVA_MODE == 1) $warning;
        else if (`DW_LOCAL_SVA_MODE == 2) $error;
        else $fatal;
    
      DW_SVA_FIFOCTL_PUSH_ERROR_SHOULD_NOT_CHANGE_WR_PTR:
        assert property (DW_full_push_wr_ptr_no_change)
        else if (`DW_LOCAL_SVA_MODE == 1) $warning;
        else if (`DW_LOCAL_SVA_MODE == 2) $error;
        else $fatal;
    
      DW_SVA_FIFOCTL_POP_ERROR_SHOULD_NOT_CHANGE_RD_PTR:
        assert property (DW_empty_pop_rd_ptr_no_change)
        else if (`DW_LOCAL_SVA_MODE == 1) $warning;
        else if (`DW_LOCAL_SVA_MODE == 2) $error;
        else $fatal;
    
      DW_SVA_FIFOCTL_WORD_CNT_OUT_OF_RANGE:
        assert property (DW_legal_word_cnt)
        else if (`DW_LOCAL_SVA_MODE == 1) $warning;
        else if (`DW_LOCAL_SVA_MODE == 2) $error;
        else $fatal;
    
      DW_SVA_FIFOCTL_PREFETCH_CACHE_STATE_INVALID:
        assert property (DW_valid_cache_states)
        else if (`DW_LOCAL_SVA_MODE == 1) $warning;
        else if (`DW_LOCAL_SVA_MODE == 2) $error;
        else $fatal;
    end  // if (`DW_LOCAL_SVA_MODE != 0)
  end  // always @(posedge clk)

//################### End of DWbb_lp_fifoctl_1c_df included assertions ###################

`undef DW_LOCAL_SVA_MODE
 `endif // SYSTEMVERILOG
`endif // SYNTHESIS
// verpp-pragma processing_on


`undef DW_I001O11O 
`undef DW_llO00llI
`undef DW_I1II0OO1   
`undef DW_O110lOl1 
`undef DW_I1I01O1I 
`undef DW_O0I10OIO   
`undef DW_OlII0OO1   
`undef DW_O10Ol011     
// synopsys translate_on
endmodule
