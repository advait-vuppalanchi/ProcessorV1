module alu (
    input  [7:0] a,
    input  [7:0] b,
    input  [2:0] sel,
    output reg [7:0] out
);
parameter ADD   = 3'd0;
parameter SUB   = 3'd1;
parameter AND   = 3'd2;
parameter OR    = 3'd3;
parameter XOR   = 3'd4;
parameter PASS0 = 3'd5;
parameter CMP   = 3'd6;

always @(*) begin
    case (sel)
        ADD:   out = a + b;
        SUB:   out = a - b;
        AND:   out = a & b;
        OR:    out = a | b;
        XOR:   out = a ^ b;
        PASS0: out = a;
        CMP:   out = a - b;
        default: out = 8'd0;
    endcase
end
endmodule