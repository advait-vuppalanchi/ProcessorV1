`timescale 1ns/1ps

module pc_tb;

    reg clk, reset, Epc, Lpc, Ipc;
    reg [7:0] bus_in;
    wire [7:0] bus_out;

    pc my_pc(
        .clk(clk),
        .reset(reset),
        .Epc(Epc),
        .Lpc(Lpc),
        .Ipc(Ipc),
        .bus_in(bus_in),
        .bus_out(bus_out)
    );

    always #5 clk = ~clk;

    reg [7:0] expected;
    initial begin
        $dumpfile("sim/pc.vcd");
        $dumpvars(0, pc_tb);

        clk=0;
        reset=1;
        Epc = 0;
        Lpc = 0;
        Ipc = 0;
        bus_in = 0;
        expected = 0;

        #10;
        reset=0;
        Epc=1;
        #1
        if(bus_out==expected) $display("Pass: pc=%d, reset works!",bus_out);
        else $display("Fail: reset failed pc=%d",bus_out);

        Epc=0;
        Ipc=1;
        expected=1;
        #10;
        Ipc=0;
        Epc=1;
        #1;
        if(bus_out==expected) $display("Pass: pc=%d, increment works!",bus_out);
        else $display("Fail: pc=%d (expected: %d), increment failed",bus_out,expected);

        Epc=0;
        Ipc=1;
        expected=2;
        #10;
        Ipc=0;
        Epc=1;
        #1;
        if(bus_out==expected) $display("Pass: pc=%d, increment works!",bus_out);
        else $display("Fail: pc=%d (expected: %d), increment failed",bus_out,expected);

        Epc=0;
        bus_in=8'd55;
        Lpc=1;
        expected=55;
        #10;
        Lpc=0;
        Epc=1;
        #1;
        if(bus_out==expected) $display("Pass: pc=%d, load works!",bus_out);
        else $display("Fail: pc=%d (expected: %d), load failed",bus_out,expected);

        Epc=0;
        Ipc=1;
        expected=56;
        #10;
        Ipc=0;
        Epc=1;
        #1;
        if(bus_out==expected) $display("Pass: pc=%d, increment after load works!",bus_out);
        else $display("Fail: pc=%d (expected: %d), increment after load failed",bus_out,expected);

        $finish;
    end

endmodule