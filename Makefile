alu:
	iverilog -o sim/alu_sim rtl/alu.v tb/alu_tb.v
	vvp sim/alu_sim

wave_alu:
	gtkwave sim/alu.vcd

regs:
	iverilog -o sim/regs_sim rtl/regs.v tb/regs_tb.v
	vvp sim/regs_sim

wave_regs:
	gtkwave sim/regs.vcd

pc:
	iverilog -o sim/pc_sim rtl/pc.v tb/pc_tb.v
	vvp sim/pc_sim

wave_pc:
	gtkwave sim/pc.vcd