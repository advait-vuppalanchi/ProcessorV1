module pc(
    input clk,
    input reset,
    input Epc,
    input Lpc,
    input Ipc,
    input [7:0] bus_in,
    output [7:0] bus_out
);

    reg [7:0] prog_count;

    assign bus_out = Epc ? prog_count : 8'bz;

    always @(negedge clk or posedge reset) begin
        if(reset) prog_count <= 8'b0;
        else if(Lpc) prog_count <= bus_in;
        else if(Ipc) prog_count <= prog_count + 8'd1;
    end

endmodule