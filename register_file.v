`timescale 1ns / 1ps
module register_file (
input clk,
input rst,
input [3:0] r_adr,
input [3:0] w_adr,
input [7:0] w_data,
input we,
output [7:0] r_data
);
reg [7:0] regs [0:15];
assign r_data = regs[r_adr];
integer i;
always @(posedge clk or posedge rst) begin
if (rst)
for (i = 0; i < 16; i = i + 1)
regs[i] <= i;
else if (we)
regs[w_adr] <= w_data;
end
endmodule
