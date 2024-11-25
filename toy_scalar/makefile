RTL_COMPILE_OUTPUT 	= $(TOY_SCALAR_PATH)/work/rtl_compile
SIM_FILELIST 		= $(TOY_SCALAR_PATH)/rtl/sim.f
#VCS_INC 			= /tools/software/synopsys/vcs/T-2022.06/linux64/include
VCS_INC 			= /home/liuyunqi/software/vcs_2016/linux64/include

.PHONY: compile lint

compile_jtag:
	g++ -I$(VCS_INC) -I $(TOY_SCALAR_PATH)/jtag_dpi/common/tcp_server $(TOY_SCALAR_PATH)/jtag_dpi/common/tcp_server/tcp_server.c  $(TOY_SCALAR_PATH)/jtag_dpi/jtagdpi/jtagdpi.c -fPIC -shared -o jtag.so

compile_rtl:
	mkdir -p $(RTL_COMPILE_OUTPUT)
	cd $(RTL_COMPILE_OUTPUT) ;vcs -kdb -lca -full64 -debug_access -sverilog -f $(SIM_FILELIST) -CFLAGS -DVCS +lint=PCWM +lint=TFIPC-L +define+TOY_SIM +define+DEBUG_ROM_TEST -l cmp.log -timescale=1ns/1ps

compile_dbg_rtl:
	mkdir -p $(RTL_COMPILE_OUTPUT)
	cd $(RTL_COMPILE_OUTPUT) ;vcs -kdb -full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -debug_access -sverilog -f $(SIM_FILELIST) -CFLAGS -DVCS +lint=PCWM +lint=TFIPC-L +define+TOY_SIM +define+OPEN_LISTEN +define+DEBUG_ROM_TEST -l cmp.log -lca -timescale=1ns/1ps

run:
	${RTL_COMPILE_OUTPUT}/simv +ROM_HEX=/home/liuyunqi/jiaoyd/baremetal_hello_world/test/debug/build/rv_asm/debug.itcm.hex +HEX=/home/liuyunqi/jiaoyd/baremetal_hello_world/test/interrupt/build/toy_bm/interrupt.itcm.hex +DATA_HEX=/home/liuyunqi/jiaoyd/baremetal_hello_world/test/interrupt/build/toy_bm/interrupt.dtcm.hex +TIMEOUT=100000000 +WAVE +PC=pc_trace.log +OPEN_LISTEN +DBG -sv_lib jtag

trap:
	${RTL_COMPILE_OUTPUT}/simv +ROM_HEX=/home/liuyunqi/jiaoyd/baremetal_hello_world/test/debug/build/rv_asm/debug.itcm.hex +HEX=/home/liuyunqi/jiaoyd/csr_baremental/test/trap/build/toy_bm/trap.itcm.hex +DATA_HEX=/home/liuyunqi/jiaoyd/csr_baremental/test/trap/build/toy_bm/trap.dtcm.hex +TIMEOUT=200000 +WAVE +PC=pc_trace.log

intr:
	${RTL_COMPILE_OUTPUT}/simv +HEX=/data/usr/jiaoyd/csr_baremental/test/interrupt/build/toy_bm/interrupt.itcm.hex +DATA_HEX=/data/usr/jiaoyd/csr_baremental/test/interrupt/build/toy_bm/interrupt.dtcm.hex +TIMEOUT=200000 +WAVE +PC=pc_trace.log

hello_world:
	${RTL_COMPILE_OUTPUT}/simv +HEX=/home/liuyunqi/jiaoyd/baremetal_hello_world/test/hello/build/toy_bm/hello.itcm.hex +DATA_HEX=/home/liuyunqi/jiaoyd/baremetal_hello_world/test/hello/build/toy_bm/hello.dtcm.hex +TIMEOUT=200000 +WAVE +PC=pc_trace.log

lint:
	fde -file $(TOY_SCALAR_PATH)/qc/lint.tcl -flow lint

led:
	${RTL_COMPILE_OUTPUT}/simv +HEX=/home/liuyunqi/jiaoyd/led/led_0725/toy_bm/led.itcm.hex +DATA_HEX=/home/liuyunqi/jiaoyd/led/led_0725/toy_bm/led.dtcm.hex +TIMEOUT=200000 +WAVE +PC=pc_trace.log 

dhry:
	${RTL_COMPILE_OUTPUT}/simv +HEX=/home/liuyunqi/jiaoyd/baremetal_hello_world/benchmarks/build/toy_bm/dhrystone.itcm.hex +DATA_HEX=/home/liuyunqi/jiaoyd/baremetal_hello_world/benchmarks/build/toy_bm/dhrystone.dtcm.hex +TIMEOUT=200000 +WAVE +PC=pc_trace.log 

dhry_test_nop:
	${RTL_COMPILE_OUTPUT}/simv +HEX=/home/liuyunqi/jiaoyd/dhry/dhry_0808/dhrystone.itcm.hex +DATA_HEX=/home/liuyunqi/jiaoyd/dhry/dhry_0808/dhrystone.dtcm.hex +TIMEOUT=1000000 +WAVE +PC=pc_trace.log 

dhry_cmp:
	${RTL_COMPILE_OUTPUT}/simv +HEX=/home/liuyunqi/jiaoyd/dhry/dhry_cmp/dhrystone.itcm.hex +DATA_HEX=/home/liuyunqi/jiaoyd/dhry/dhry_cmp/dhrystone.dtcm.hex +TIMEOUT=1000000 +WAVE +PC=pc_trace.log 

cm:
	${RTL_COMPILE_OUTPUT}/simv +HEX=/home/liuyunqi/jiaoyd/led/coremark/coremark.itcm.hex +DATA_HEX=/home/liuyunqi/jiaoyd/led/coremark/coremark.dtcm.hex  +TIMEOUT=200000 +WAVE +PC=pc_trace.log 

print:
	${RTL_COMPILE_OUTPUT}/simv +HEX=/home/liuyunqi/jiaoyd/test_print/test_print.itcm.hex +DATA_HEX=/home/liuyunqi/jiaoyd/test_print/test_print.dtcm.hex +TIMEOUT=200000 +WAVE +PC=pc_trace.log 

verdi:
	verdi -sv -f $(SIM_FILELIST) -ssf wave.fsdb -dbdir $(RTL_COMPILE_OUTPUT)/simv.daidir
dhry_test:
	${RTL_COMPILE_OUTPUT}/simv +HEX=/data/usr/qijiahuan/baremetal_hello_world/test/hello/build/toy_bm/hello.itcm.hex +DATA_HEX=/data/usr/qijiahuan/baremetal_hello_world/test/hello/build/toy_bm/hello.dtcm.hex +TIMEOUT=200000 +WAVE +PC=pc_trace.log
