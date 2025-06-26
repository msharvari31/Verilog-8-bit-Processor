`timescale 1ns / 1ps
module memory (
input [4:0] adr,
output reg [7:0] instr
);
reg [7:0] mem [0:31];
initial begin
// All operations
mem[0] = 8'b10010011; // MOV R3 to ACC
mem[1] = 8'b00010110; // ADD R6 to ACC
mem[2] = 8'b00100111; // SUB R7 from ACC
mem[3] = 8'b00110010; // MUL R2 to ACC
mem[4] = 8'b01111010; // CMP ACC with R10
mem[5] = 8'b10001011; // BR to Addr 11
mem[6] = 8'b01011111; // AND ACC with 15
mem[7] = 8'b01101101; // XRA R13 to ACC
mem[8] = 8'b01011001; // AND R9 to ACC
mem[9] = 8'b01111111; // CMP ACC with R15
mem[10] = 8'b10001110; // BR to Addr 14
mem[11] = 8'b00000010; // LSR
mem[12] = 8'b00100001; // SUB R1 from ACC
mem[13] = 8'b10110110; // RET to Addr 6
mem[14] = 8'b00000110; // INC ACC
mem[15] = 8'b00000001; // LSL
mem[16] = 8'b00000010; // LSR
mem[17] = 8'b00000011; // CIR
mem[18] = 8'b00000100; // CIL
mem[19] = 8'b00000101; // ASR
mem[20] = 8'b00000111; // DEC ACC
mem[21] = 8'b10101111; // MOV ACC to R15
// Set ACC to 0
mem[22] = 8'b00000000; // NOP
mem[23] = 8'b10010000; // MOV R0 to ACC
mem[24] = 8'b00000000; // NOP
// (A + B) square
mem[25] = 8'b10010100; // MOV R4 to ACC
mem[26] = 8'b00011001; // ADD R9 to ACC
mem[27] = 8'b10100000; // MOV ACC to R0
mem[28] = 8'b00110000; // MUL R0 to ACC
mem[29] = 8'b10100000; // MOV ACC to R0
mem[30] = 8'b11111111; // HALT
mem[31] = 8'b00000000; // NOP
end
always @(*) begin
instr = mem[adr];
end
endmodule
