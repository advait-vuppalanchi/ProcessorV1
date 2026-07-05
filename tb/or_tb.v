`timescale 1ns/1ps

module or_reg_tb;
    reg clk, Eor, Lor, Ror;
    reg tb_bus_drive;
    reg [7:0] tb_data;
    wire [7:0] bus;
    wire [7:0] or_to_alu;

    assign bus = tb_bus_drive? tb_data : 8'bz;

    or_reg my_or(
        .clk(clk),
        .Eor(Eor),
        .Ror(Ror),
        .Lor(Lor),
        .or_to_alu(or_to_alu),
        .bus(bus)
    );

    always #5 clk = ~clk;

    reg [7:0] expected;

    initial begin
        $dumpfile("sim/or_reg.vcd");
        $dumpvars(0, or_reg_tb);

        clk=0;
        Eor=0;
        Ror=0;
        Lor=0;
        tb_bus_drive=0;
        tb_data=0;

        //reset test
        expected=8'd0;
        Ror=1;
        #10;
        Ror=0;
        if(or_to_alu==expected) $display("Pass: Reset works");
        else $display("Fail: Reset - Expected: %d  Got: %d",expected, or_to_alu);

        //load
        expected=8'd55;
        tb_data=expected;
        tb_bus_drive=1;
        Lor=1;
        #10;
        Lor=0;
        tb_bus_drive=0;
        if(or_to_alu==expected) $display("Pass: Loaded %d",or_to_alu);
        else $display("Fail: Expected: %d  Got: %d", expected, or_to_alu);

        //load again
        expected=8'd250;
        tb_data=expected;
        tb_bus_drive=1;
        Lor=1;
        #10;
        Lor=0;
        tb_bus_drive=0;
        if(or_to_alu==expected) $display("Pass: Loaded %d",or_to_alu);
        else $display("Fail: Expected: %d  Got: %d", expected, or_to_alu);

        //checking bus output
        Eor=1;
        #1;
        if(bus==expected) $display("Pass: Bus output correct");
        else $display("Fail: Expected: %d  Got: %d", expected, bus);
        Eor=0;

        //reset again
        expected = 8'd0;
        Ror=1;
        #10;
        Ror=0;
        if(or_to_alu==expected) $display("Pass: Reset works again");
        else $display("Fail: Reset - Expected: %d  Got: %d",expected, or_to_alu);

        $finish;
    end
endmodule