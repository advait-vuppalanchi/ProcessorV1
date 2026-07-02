alu:
	iverilog -o sim/alu_sim rtl/alu.v tb/alu_tb.v
	vvp sim/alu_sim

wave_alu:
	gtkwave sim/alu.vcd