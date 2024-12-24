# Toy Scalar Soc

- 搭建基于toy scalar的SOC，用于板级调试和SOC级验证

## Verision

- Soc-0.2

## Status

- Soc通路搭建完成
- 板级测试流水灯通过
- 板级控制MCYCLE寄存器控制流水灯灭通过
- 板级控制外部中断触发通过

## Soc arch

![image](https://github.com/fliibs/toy_scalar/blob/toy_soc/diagram/toy_soc.png)

## Memory

| ID  | Name            | Start Addr   | Size         | End Addr    |
|-----|-----------------|--------------|--------------|-------------|
| 0   | Debug           | 0x0000_0000  | 0x1000_0000  | 0x1000_0000 |
| 3   | ITCM            | 0x8000_0000  | 0x2000_0000  | 0x9FFF_FFFF |
| 4   | DTCM            | 0xA000_0000  | 0x2000_0000  | 0xBFFF_FFFF |
| 5   | Host            | 0xC000_0000  | 0x0000_1000  | 0xC000_0FFF |
| 6   | Uart            | 0xC000_1000  | 0x0000_1000  | 0xC000_1FFF |
| 6   | Gpio            | 0xC000_2000  | 0x0000_1000  | 0xC000_2FFF |

## Soc 板级调试流程

- 板级流水灯测试 --- PASS

- 版级toy soc通过read MCYCLE register控制流水灯测试 --- PASS

- 板级外部中断测试 --- PASS

- 板级uart测试，调试串口

- 板级JTAG测试方案

    - Jtag串口调试
    - gdb-openocd-jlink-board调试
    - 板级debug测试-下载代码elf文件测试
    - 板级debug测试-读写core寄存器测试
    - 板级debug测试-single step测试