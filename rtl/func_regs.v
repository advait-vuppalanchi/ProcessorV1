module ir_reg(
    input clk, Lir,
    input [7:0] bus_in,
    output reg [7:0] ir_out
);
    always @(negedge clk) if(Lir) ir_out <= bus_in;
endmodule

module ar_reg(
    input clk, Ear, Lar, Rar,
    input [7:0] alu_out,
    output [7:0] bus
);
    reg [7:0] val;

    assign bus = Ear? val : 8'bz;

    always @(negedge clk) begin
        if (Rar) val <= 8'd0; 
        else if(Lar) val <= alu_out;
    end
endmodule

module or_reg(
    input clk, Eor, Ror, Lor,
    output [7:0] or_to_alu,
    inout [7:0] bus
);
    reg [7:0] val;

    always @(negedge clk) begin
        if(Ror) val <= 8'd0;
        else if(Lor) val <= bus;
    end

    assign or_to_alu = val;
    assign bus = Eor? val : 8'bz;
endmodule

module mar_reg(
    input clk, Lmar,
    input [7:0] bus_in,
    output [7:0] mar_out
);
    reg [7:0] val;

    always @(negedge clk) if(Lmar) val <= bus_in;

    assign mar_out = val;
endmodule