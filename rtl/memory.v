module memory(
    input clk,
    input rd,
    input wr,
    input [7:0] MARaddr,
    inout [7:0] bus
);

reg [7:0] mem [0:255];

initial $readmemh("programs/test.hex", mem); //filling the memory with instructions

assign bus = rd? mem[addr] : 8'bz;

always @(negedge clk) begin
    if(wr) mem[addr] <= bus;
end
