`timescale 1ns / 1ps
module program_counter (
input clk,
input rst,
input load,
input inc,
input [4:0] adr_in,
output reg [4:0] pc
);
always @(posedge clk or posedge rst) begin
if (rst)
pc <= 5'b00000;
else begin
if (load)
pc <= adr_in;
else if (inc)
pc <= pc + 1;
end
end
endmodule
