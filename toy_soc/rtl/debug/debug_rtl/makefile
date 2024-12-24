RTL_COMPILE_OUTPUT 	= $(DEBUG_SCALAR_PATH)/work/rtl_compile
SIM_FILELIST 		= $(DEBUG_SCALAR_PATH)/debug.f

.PHONY: compile lint

compile:
	mkdir -p $(RTL_COMPILE_OUTPUT)
	cd $(RTL_COMPILE_OUTPUT) ;vcs -kdb -full64 -debug_access -sverilog -f $(SIM_FILELIST) +lint=PCWM +lint=TFIPC-L +define+DEBUG_SIM

lint:
	fde -file $(DEBUG_SCALAR_PATH)/qc/lint.tcl -flow lint

verdi:
	verdi -sv -f $(SIM_FILELIST) -ssf wave.fsdb -dbdir /home/jiaoyadi/core/debug/work/rtl_compile/simv.daidir
