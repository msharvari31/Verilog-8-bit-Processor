`timescale 1ns / 1ps
module control_unit (
input clk,
input rst,
input [7:0] instr,
input cb_in,
output reg rf_we,
output reg [3:0] alu_op,
output reg pc_load,
output reg pc_inc,
output reg acc_we,
output reg ext_we,
output reg cb_we,
output reg halt
);
parameter OP_NOP = 8'b00000000;
parameter OP_LSL_ACC = 8'b00000001;
parameter OP_LSR_ACC = 8'b00000010;
parameter OP_CIR_ACC = 8'b00000011;
parameter OP_CIL_ACC = 8'b00000100;
parameter OP_ASR_ACC = 8'b00000101;
parameter OP_INC_ACC = 8'b00000110;
parameter OP_DEC_ACC = 8'b00000111;
parameter OP_HLT = 8'b11111111;
parameter OP4_ADD_RI = 4'b0001;
parameter OP4_SUB_RI = 4'b0010;
parameter OP4_MUL_RI = 4'b0011;
parameter OP4_AND_RI = 4'b0101;
parameter OP4_XRA_RI = 4'b0110;
parameter OP4_CMP_RI = 4'b0111;
parameter OP4_BR = 4'b1000;
parameter OP4_MOV_ACC_RI = 4'b1001;
parameter OP4_MOV_RI_ACC = 4'b1010;
parameter OP4_RET = 4'b1011;
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
wire [3:0] op4 = instr[7:4];
always @(*) begin
rf_we = 1'b0;
alu_op = ALU_NOP;
pc_load = 1'b0;
pc_inc = 1'b0;
acc_we = 1'b0;
ext_we = 1'b0;
cb_we = 1'b0;
halt = 1'b0;
case (instr)
OP_NOP:
pc_inc = 1'b1;
OP_LSL_ACC: begin
alu_op = ALU_LSL;
acc_we = 1'b1;
pc_inc = 1'b1;
end
OP_LSR_ACC: begin
alu_op = ALU_LSR;
acc_we = 1'b1;
pc_inc = 1'b1;
end
OP_CIR_ACC: begin
alu_op = ALU_CIR;
acc_we = 1'b1;
pc_inc = 1'b1;
end
OP_CIL_ACC: begin
alu_op = ALU_CIL;
acc_we = 1'b1;
pc_inc = 1'b1;
end
OP_ASR_ACC: begin
alu_op = ALU_ASR;
acc_we = 1'b1;
pc_inc = 1'b1;
end
OP_INC_ACC: begin
alu_op = ALU_INC;
acc_we = 1'b1;
cb_we = 1'b1;
pc_inc = 1'b1;
end
OP_DEC_ACC: begin
alu_op = ALU_DEC;
acc_we = 1'b1;
cb_we = 1'b1;
pc_inc = 1'b1;
end
OP_HLT: begin
halt = 1'b1;
pc_inc = 1'b0;
end
default: begin
case (op4)
OP4_ADD_RI: begin
alu_op = ALU_ADD;
acc_we = 1'b1;
cb_we = 1'b1;
pc_inc = 1'b1;
end
OP4_SUB_RI: begin
alu_op = ALU_SUB;
acc_we = 1'b1;
cb_we = 1'b1;
pc_inc = 1'b1;
end
OP4_MUL_RI: begin
alu_op = ALU_MUL;
acc_we = 1'b1;
ext_we = 1'b1;
pc_inc = 1'b1;
end
OP4_AND_RI: begin
alu_op = ALU_AND;
acc_we = 1'b1;
  pc_inc = 1'b1;
end
OP4_XRA_RI: begin
alu_op = ALU_XOR;
acc_we = 1'b1;
pc_inc = 1'b1;
end
OP4_CMP_RI: begin
alu_op = ALU_CMP;
cb_we = 1'b1;
pc_inc = 1'b1;
end
OP4_BR: begin
if (cb_in == 1'b1) begin
pc_load = 1'b1;
pc_inc = 1'b0;
end else begin
pc_load = 1'b0;
pc_inc = 1'b1;
end
end
OP4_MOV_ACC_RI: begin
alu_op = ALU_PASS_B;
acc_we = 1'b1;
pc_inc = 1'b1;
end
OP4_MOV_RI_ACC: begin
rf_we = 1'b1;
pc_inc = 1'b1;
end
OP4_RET: begin
pc_load = 1'b1;
pc_inc = 1'b0;
end
default:
pc_inc = 1'b1;
endcase
end
endcase
if (halt)
pc_inc = 1'b0;
end
endmodule
