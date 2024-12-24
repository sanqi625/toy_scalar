# Toy Scalar based external debug

- 基于dev-fetch版本的 single issue-In order-core 的调试

## Verision

- Debug-0.8

## Status

- Debug core与DM之间的通路测试通过

## Debug sys arch

![image](https://github.com/fliibs/toy_scalar/blob/dev-dbg-core/diagram/debug_sys.png)

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


## SRAM

| ID  | Name            | Start Addr   | Size         | End Addr    |
|-----|-----------------|--------------|--------------|-------------|
| 0   | Debug           | 0x0000_0000  | 0x1000_0000  | 0x1000_0000 |
| 3   | ITCM            | 0x8000_0000  | 0x2000_0000  | 0x9FFF_FFFF |
| 4   | DTCM            | 0xA000_0000  | 0x2000_0000  | 0xBFFF_FFFF |
| 5   | Host            | 0xC000_0000  | 0x0000_1000  | 0xC000_0FFF |
| 6   | Uart            | 0xC000_1000  | 0x0000_1000  | 0xC000_1FFF |

## Debug Memory Map

| Name            | Addr         | End Addr    | Description                            |
|-----------------|--------------|-------------|----------------------------------------|
| Unused          | 0x0000_0000  | 0x0000_03ff | Reserve                                |               
| DEBUG_DATA_REG  | 0x0000_0400  |             | DMI write/read data                    |
| HALTED_REG      | 0x0000_0404  |             | hart halted state                      |
| GOING_REG       | 0x0000_0408  |             | hart going state                       |
| RESUME_REG      | 0x0000_040c  |             | hart resume state                      |
| EXCEPTION_REG   | 0x0000_0410  |             | hart exception state                   |
| Unused          | 0x0000_0414  | 0x0000_ffff | Reserve                                | 
|*Debug ROM       | 0x0001_0000  | 0x0001_ffff | debug loop instruction(Read only)      |
| Debug base      | 0x0001_0000  |             | debug rom begin address                |
| Debug loop      | 0x0001_0030  |             | debug park loop address                |
| Debug exception | 0x0001_0010  |             | debug exception handler address        |
|*Debug RAM       | 0x0002_0000  | 0x0002_ffff | command and program buffer (Read only) |
| Debug command   | 0x0002_0000  | 0x0002_0008 | abstract commmand address(Three inst)  |
| Debug progbuff  | 0x0002_8000  | 0x0002_ffff | program buffer address                 |

- 分配debug地址空间范围为0000_0000 ~ 1000_0000
- debug state ram (R/W) : 用于debug loop的状态控制，包括5种状态寄存器，halted/going/resume/exception/data
- debug command pc（0x0002_0004）跳转到debug progbuf pc(0x0002_8000)的offset为0x7fd07,跳转指令为jal x0,0x7fd0706f

## Debug support spec 0.3 

- 支持基于riscv debug spec-0.3
- 支持外部中断触发（haltreq）、step、ebreak三种方式进入debug mode
- 支持Execution Based hardware implementation
- 支持标准JTAG协议
- 支持debug ROM执行debug loop
- 支持debug RAM执行JTAG下载的指令
- 支持debug HALTED/RESUME/GOING/EXCEPTION Reg state控制当前的debug core状态
- 支持debug mode下Exception处理
- 支持dret指令退出debug mode
- 支持system bus access memory，支持通过system bus down code

## Debug mode Exception / Machine mode exception

- Debug mode exception主要出现在Illegal instruction / Ebreak的处理。
- Machine mode 下的exception处理保持正常的trap handler处理方式
- Debug mode 下的exception处理不会跳入trap_handler中，仅进入debug loop exception handler。并同时告知debugger此时引发exception。

## Ebreak

- Non-debug mode 状态下，ebreak指令实现正常的异常跳转，目前支持ebreak进入debug mode。
- Debug mode状态下，ebreak指令表示当前的debug指令执行结束，需要跳转至debug loop中。

## Debug step

- 支持debug single step
- 支持step过程中出现exception处理，保存exception现场，在下次跳回running状态时执行trap handler

## openocd 调试

- opocd -f opocd.cfg -d4 -l ocd.log

- 查看端口占用；netstat -tuln | grep LISTE
- 查看端口进程：lsof -i :端口号
- 杀死进程： kill -9 进程ID

## GDB 调试

- 启动GDB后链接openocd： target remote localhost:3333
- 按照monitor命令控制core
    1、file xxx.elf ： gdb read elf symbols
    2、load
    3、info registers: 打印出所有寄存器的值（处理scratch register）
    4、monotor halt: 发出haltreq
    5、monitor step：step命令
    6、info all-registers :查看包括CSR的所有寄存器

## 后续可能需要实现的Debug feature

- multi-core debug
- dm resethaltreq实现hart进入halted

## VIVADO batch mode cfg

- vivado -mode batch -source /path/to/run_vivado.tcl
