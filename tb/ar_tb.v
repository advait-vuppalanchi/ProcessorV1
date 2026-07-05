`timescale 1ns/1ps

module ar_reg_tb;

    reg clk, Lar, Rar, Ear;
    reg [7:0] alu_out;
    wire  [7:0] bus;

    ar_reg my_ar(
        .clk(clk),
        .Ear(Ear),
        .Lar(Lar),
        .Rar(Rar),
        .alu_out(alu_out),
        .bus(bus)
    );

    always #5 clk = ~clk;

    reg [7:0] expected;

    initial begin
        $dumpfile("sim/ar_reg.vcd");
        $dumpvars(0, ar_reg_tb);

        clk=0;
        Ear=0;
        Lar=0;
        Rar=0;
        alu_out=0;

        //checking reset
        expected=8'd0;
        Rar=1;
        #10
        Rar=0;
        Ear=1;
        #1;
        if(bus==expected) $display("Pass: Reset works");
        else $display("Fail: Reset: bus=%d expected=%d", bus, expected);
        Ear=0;

        //checking Load
        alu_out = 8'd76;
        expected = 8'd76;
        Lar=1;
        #10;
        Lar=0;
        Ear=1;
        #1;
        if(bus==expected) $display("Pass: Loaded %d",bus);
        else $display("Fail: load -  bus=%d expected=%d", bus, expected);
        Ear=0;

        //load again
        alu_out = 8'd212;
        expected = 8'd212;
        Lar=1;
        #10;
        Lar=0;
        Ear=1;
        #1;
        if(bus==expected) $display("Pass: Loaded %d",bus);
        else $display("Fail: load -  bus=%d expected=%d", bus, expected);
        Ear=0;

        //reset again
        expected=8'd0;
        Rar=1;
        #10
        Rar=0;
        Ear=1;
        #1;
        if(bus==expected) $display("Pass: Reset works again");
        else $display("Fail: Reset: bus=%d expected=%d", bus, expected);
        Ear=0;

        $finish;
    end
endmodule