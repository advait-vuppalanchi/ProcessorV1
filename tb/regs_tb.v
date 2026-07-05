`timescale 1ns/1ps

module regs_tb;

    reg clk, Erg, Lrg;
    reg [2:0] Srg;
    reg tb_bus_drive;
    reg [7:0] tb_data;
    wire [7:0] bus;

    regs my_reg(
        .clk(clk),
        .Erg(Erg),
        .Lrg(Lrg),
        .Srg(Srg),
        .bus(bus)
    );

    assign bus = tb_bus_drive ? tb_data : 8'bz;

    always #5 clk = ~clk;

    reg [7:0] expected;

    initial begin
        $dumpfile("sim/regs.vcd");
        $dumpvars(0, regs_tb);

        clk = 0;
        Erg = 0;
        Lrg = 0;
        Srg = 0;
        tb_bus_drive = 0;
        tb_data = 0;

        //6 in R7
        expected = 8'd6;
        tb_data = expected;
        tb_bus_drive = 1;
        Srg = 3'd7;
        Lrg = 1;
        @(negedge clk);
        Lrg = 0;
        tb_bus_drive = 0;
        Erg = 1;
        #1;
        if(bus == expected) $display("Pass: R7=%d", bus);
        else $display("Fail: R7 - Expected: %d  Got: %d", expected, bus);
        Erg = 0;

        //100 in R3
        expected = 8'd100;
        tb_data = expected;
        tb_bus_drive = 1;
        Srg = 3'd3;
        Lrg = 1;
        #10
        Lrg = 0;
        tb_bus_drive = 0;
        Erg = 1;
        #1;
        if(bus == expected) $display("Pass: R3=%d", bus);
        else $display("Fail: R3 - Expected: %d  Got: %d", expected, bus);
        Erg = 0;

        //69 in R3
        expected = 8'd69;
        tb_data = expected;
        tb_bus_drive = 1;
        Srg = 3'd3;
        Lrg = 1;
        #10
        Lrg = 0;
        tb_bus_drive = 0;
        Erg = 1;
        #1;
        if(bus == expected) $display("Pass: R3=%d", bus);
        else $display("Fail: R3 - Expected: %d  Got: %d", expected, bus);
        Erg = 0;

        $finish;
    end

endmodule