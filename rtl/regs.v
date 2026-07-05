module regs(
    input clk,
    input Erg,
    input Lrg,
    input [2:0] Srg,
    inout [7:0] bus
);
    reg [7:0] regs [0:7];

    assign bus = Erg? regs[Srg] : 8'bz;

    always @(negedge clk) begin
        if(Lrg) regs[Srg] <= bus;
    end

endmodule