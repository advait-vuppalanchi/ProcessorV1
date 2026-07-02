`timescale 1ns/1ps

module alu_tb;

reg [7:0] a,b;
reg [2:0] sel;
wire [7:0] out;

alu my_alu(
    .a(a),
    .b(b),
    .sel(sel),
    .out(out)
);

task check;
    input [7:0] expected;
    begin
        #1;
        if(out==expected) $display("Pass -- sel=%0d , b=%h , expcted=%h , got=%h",sel,a,b,expected,out);
        else $display("Fail -- sel=%0d , b=%h , expcted=%h , got=%h",sel,a,b,expected,out);
    end
endtask

initial begin
    $dumpfile("sim/alu.vcd");
    $dumpvars(0, alu_tb);

    //ADD
    a=8'd4;b=8'd3;sel=8'd0;check(8'd7);
    a=8'd21;b=8'd4;sel=8'd0;check(8'd25);
    a=8'd250;b=8'd6;sel=8'd0;check(8'd0);

    //SUB
    a=8'd10; b=8'd3;  sel=3'd1; check(8'd7);
    a=8'd5;  b=8'd5;  sel=3'd1; check(8'd0);
    a=8'd3;  b=8'd5;  sel=3'd1; check(8'd254);

    //AND
    a=8'hFF; b=8'h0F; sel=3'd2; check(8'h0F);
    a=8'hAA; b=8'hCC; sel=3'd2; check(8'h88);
    a=8'h55; b=8'hAA; sel=3'd2; check(8'h00);

    //OR
    a=8'hF0; b=8'h0F; sel=3'd3; check(8'hFF);
    a=8'hAA; b=8'h55; sel=3'd3; check(8'hFF);
    a=8'h00; b=8'h81; sel=3'd3; check(8'h81);

    //XOR
    a=8'hAA; b=8'hCC; sel=3'd4; check(8'h66);
    a=8'hFF; b=8'hFF; sel=3'd4; check(8'h00);
    a=8'h55; b=8'hAA; sel=3'd4; check(8'hFF);

    //PASSO
    a=8'h5A; b=8'h00; sel=3'd5; check(8'h5A);
    a=8'hFF; b=8'h12; sel=3'd5; check(8'hFF);
    a=8'h00; b=8'hAB; sel=3'd5; check(8'h00);

    //CMP
    a=8'd9;  b=8'd4;  sel=3'd6; check(8'd5);
    a=8'd7;  b=8'd7;  sel=3'd6; check(8'd0);
    a=8'd2;  b=8'd5;  sel=3'd6; check(8'd253);

    $display("Done");
    $finish;
end
endmodule
