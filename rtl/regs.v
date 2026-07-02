module regs(
    input clk,
    input Erg,
    input Lrg,
    input [2:0] Srg,
    input [7:0] bus_in,
    output [7:0] bus_out
);
    reg [7:0] regs [0:7];

    assign bus_out = Erg? regs[Srg] : 8'bz;

    always @(negedge clk) begin
        if(Lrg) regs[Srg] <= bus_in;
    end

endmodule