`timescale 1ns / 1ps
module alu (
input [7:0] op_a,
input [7:0] op_b,
input [3:0] alu_op,
output reg [7:0] res,
output reg [7:0] ext_res,
output reg cb_out
);
parameter ALU_NOP = 4'b0000;
parameter ALU_ADD = 4'b0001;
parameter ALU_SUB = 4'b0010;
parameter ALU_MUL = 4'b0011;
parameter ALU_LSL = 4'b0100;
parameter ALU_LSR = 4'b0101;
parameter ALU_CIR = 4'b0110;
parameter ALU_CIL = 4'b0111;
parameter ALU_ASR = 4'b1000;
parameter ALU_AND = 4'b1001;
parameter ALU_XOR = 4'b1010;
parameter ALU_CMP = 4'b1011;
parameter ALU_INC = 4'b1100;
parameter ALU_DEC = 4'b1101;
parameter ALU_PASS_B = 4'b1110;
wire [8:0] add_tmp;
assign add_tmp = {1'b0, op_a} + {1'b0, op_b};
always @(*) begin
res = 8'b0;
ext_res = 8'b0;
case (alu_op)
ALU_ADD: begin
res = add_tmp[7:0];
cb_out = add_tmp[8];
end
ALU_SUB: begin
res = op_a - op_b;
cb_out = (op_b > op_a);
end
ALU_MUL: begin
{ext_res, res} = op_a * op_b;
end
ALU_LSL: begin
res = op_a << 1;
end
ALU_LSR: begin
  res = op_a >> 1;
end
ALU_CIR: begin
res = {op_a[0], op_a[7:1]};
end
ALU_CIL: begin
res = {op_a[6:0], op_a[7]};
end
ALU_ASR: begin
res = {op_a[7], op_a[7:1]};
end
ALU_AND: begin
res = op_a & op_b;
end
ALU_XOR: begin
res = op_a ^ op_b;
end
ALU_CMP: begin
res = op_a;
cb_out = (op_a < op_b);
end
ALU_INC: begin
res = op_a + 1;
cb_out = (op_a == 8'b11111111);
end
ALU_DEC: begin
res = op_a - 1;
cb_out = (op_a == 8'b00000000);
end
ALU_PASS_B: begin
res = op_b;
end
default: begin
res = op_a;
ext_res = 8'bx;
cb_out = 1'bx;
end
endcase
end
endmodule
