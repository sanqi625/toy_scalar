# Toy Scalar based trap

- 基于trap版本的 single issue-In order-core 的调试

## Verision

- trap-1.0

## Status

- Trap 通路测试通过

## core arch with trap

![image](https://github.com/fliibs/toy_scalar/blob/dev-dbg-core/diagram/trap.png)

## Folder

- rtl

这里面存放了所有的rtl。这里面的makefile已经过时，不再维护。

- rv_isa_test

这里面放了一个cmake，用来构建一个并行测试的makefile。使用的测试例是预先编译好存放在lserver上的测试向量。这个cmake会抓取目标目录下的所有测试，构建一个ctest。在这个目录下执行cmake -b build后，会将makefile生成在build目录下。进入build目录执行ctest -j64，会并行执行所有rv官方开源的指令集测试。目前cmake只抓取I和M指令的测试。

这些测试是将一段代码放在rtl上进行运行，如果这段代码能够运行成功（即正常退出）,那么我们就认为这个case pass,目前还没有加入和simulator的逐条指令运行结果比对.

- jtag_dpi

jtag package generate C源代码

- openocd

openocd的运行配置文件和log

## Makefile

- make compile_jtag

编译jtag dpi c code

- make compile_rtl

编译RTL

- make run

RTL和DPI联合仿真

- make trap

仿真测试ecall

- make intr

仿真测试中断

- make dhry

使用编译好的simv跑dhrystone测试，这个测试使用的itcm和dtcm数据，都是预先编译好存在lserver的特定目录下的。因此只能在lserver上运行。

- make cm

跑coremark，其它同上。

- make verdi

看最近一次dhrystone或coremark的波形。

## SPU

- 增加SPU,统一处理非CSR读写的system instruciton
- 处理所有system return instruciton：include MRET/SRET/DRET
- 处理WFI、NOP（还未实现）指令
- 处理sfence.vma / sfence.inval等sfence指令（未实现）

## RTU

- RTU用于处理来自CSR/ALU/LSU/SPU的待提交指令以及trap，完成reg file update
- commit处理当前的retire instruction，记录current pc以及对core的change flow控制
- trap处理trap信息和debug信息

## SRAM

| ID  | Name            | Start Addr   | Size         | End Addr    |
|-----|-----------------|--------------|--------------|-------------|
| 0   | Debug           | 0x0000_0000  | 0x1000_0000  | 0x1000_0000 |
| 3   | ITCM            | 0x8000_0000  | 0x2000_0000  | 0x9FFF_FFFF |
| 4   | DTCM            | 0xA000_0000  | 0x2000_0000  | 0xBFFF_FFFF |
| 5   | Host            | 0xC000_0000  | 0x0000_1000  | 0xC000_0FFF |
| 6   | Uart            | 0xC000_1000  | 0x0000_1000  | 0xC000_1FFF |


## Trap handler

### Trap Cause Code 

| Interrupt - bit[31]| ID -bit[30:0] | Cause                            | Description/Exception cause from        | Implemention in trap handler |
|--------------------|---------------|----------------------------------|-----------------------------------------|------------------------------|
| *Interrupt                                                                                                                                      |
| 1                  | 0             | Reserved                         |                                         | ---                          |
| 1                  | 1             | Supervisor software interrupt    |                                         | No                           |
| 1                  | 2             | Reserved                         |                                         | ---                          |
| 1                  | 3             | Machine software interrupt       |                                         | No                           |
| 1                  | 4             | Reserved                         |                                         | ---                          |
| 1                  | 5             | Supervisor timer interrupt       |                                         | No                           |
| 1                  | 6             | Reserved                         |                                         | ---                          |
| 1                  | 7             | Machine timer interrupt          |                                         | No                           |
| 1                  | 8             | Reserved                         |                                         | ---                          |
| 1                  | 9             | Supervisor external interrupt    |                                         | No                           |
| 1                  | 10            | Reserved                         |                                         | ---                          |
| 1                  | 11            | Machine external interrupt       |                                         | Yes                          |
| 1                  | 12 ~ 15       | Reserved                         |                                         | ---                          |
| 1                  | * >=16        |                                  | Designated for platform use             | ---                          |
| 1                  | 16            | Debug halt req (ADD)             | DM trigger core into debug mode         | Yes(Debug mode implemention) |
| *Exception                                                                                                                                     |
| 0                  | 0             | Instruction address misaligned   | LSU                                     | No                           |
| 0                  | 1             | Instruction access fault         | Fetch-MMU                               | No                           |
| 0                  | 2             | Illegal instruction              | Decode                                  | Yes                          |
| 0                  | 3             | Breakpoint                       | CSR. M-mode exception / D-mode trigger  | Yes                          |
| 0                  | 4             | Load address misaligned          | LSU                                     | No                           |
| 0                  | 5             | Load access fault                | LSU-MMU                                 | No                           |
| 0                  | 6             | Store/AMO address misaligned     | LSU                                     | No                           |
| 0                  | 7             | Store/AMO access fault           | LSU-MMU                                 | No                           |
| 0                  | 8             | Environment call from U-mode     | CSR                                     | No                           |
| 0                  | 9             | Environment call from S-mode     | CSR                                     | No                           |
| 0                  | 10            | Reserved                         | ---                                     | ---                          |
| 0                  | 11            | Environment call from M-mode     | CSR                                     | Yes                          |
| 0                  | 12            | Instruction page fault           | Fetch-MMU                               | No                           |
| 0                  | 13            | Load page fault                  | LSU-MMU                                 | No                           |
| 0                  | 14            | Reserved                         | ---                                     | ---                          |
| 0                  | 15            | Store/AMO page fault             | LSU-MMU                                 | No                           |
| 0                  | 16 ~ 23       | Reserved                         | ---                                     | ---                          |
| 0                  | *24-31        | Designated for custom use        |                                         |                              |

### Exception

- 目前支持ecall的异常处理，打印ecall信息，并在退出时将mepc指向下条指令
- 目前支持ebreak的异常处理，进入exception或进入debug mode
- 目前支持illegal instruction处理，打印出错指令的PC和指令内容，并退出仿真
- 目前支持ecall/ebreak/illegal inst的trap处理函数

### Interrupt

- 目前支持硬件machine mode interrupt处理，软件处理仅作为hint打印中断信息
- 支持直通中断，不支持矢量中断
- 不支持中断嵌套（二级中断）
- 支持machine mode下External/Software/Timer中断
- 支持debug halt req interrupt 跳转debug mode处理


## 后续可能需要实现的Trap feature

- exception优先级

