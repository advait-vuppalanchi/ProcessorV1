`timescale 1ns/1ps

module regs_tb;

    reg clk, Erg, Lrg;
    reg [2:0] Srg;
    reg [7:0] bus_in;
    wire [7:0] bus_out;

    regs my_reg(
        .clk(clk),
        .Erg(Erg),
        .Lrg(Lrg),
        .Srg(Srg),
        .bus_in(bus_in),
        .bus_out(bus_out)
    );

    always #5 clk = ~clk;

    reg [7:0] expected;
    initial begin
        $dumpfile("sim/regs.vcd");
        $dumpvars(0, regs_tb);

        clk=0;
        Erg=0;
        Lrg=0;
        Srg=0;
        bus_in=0;

        //6 in R7
        expected=8'd6;
        bus_in = 8'd6;
        Srg = 3'd7;
        Lrg = 1'b1;
        #10
        Lrg=0;
        Erg=1;
        #1;
        if(bus_out==expected) $display("Pass: R7=%d",bus_out);
        else $display("Fail: R7=%d Expected:%d",bus_out,expected);
        Erg=0;

        //100 in R3
        expected=8'd100;
        bus_in = 8'd100;
        Srg = 3'd3;
        Lrg = 1'b1;
        #10
        Lrg=0;
        Erg=1;
        #1;
        if(bus_out==expected) $display("Pass: R3=%d",bus_out);
        else $display("Fail: R3=%d Expected:%d",bus_out,expected);
        Erg=0;

        //69 in R3
        expected=8'd69;
        bus_in = 8'd69;
        Srg = 3'd3;
        Lrg = 1'b1;
        #10
        Lrg=0;
        Erg=1;
        #1;
        if(bus_out==expected) $display("Pass: R3=%d",bus_out);
        else $display("Fail: R3=%d Expected:%d",bus_out,expected);
        Erg=0;

        $finish;
    end

endmodule