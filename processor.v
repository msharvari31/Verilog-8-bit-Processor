`timescale 1ns / 1ps
module processor_top (
input clk,
input rst,
output halt_out
);
wire [4:0] pc_adr;
wire [7:0] instr;
wire [3:0] rf_adr;
wire [4:0] br_adr;
wire [7:0] rf_data;
wire [7:0] alu_res;
wire [7:0] alu_ext;
wire [3:0] alu_op_s;
wire alu_cb;
wire rf_we_s;
wire pc_load_s;
wire pc_inc_s;
wire acc_we_s;
wire ext_we_s;
wire cb_we_s;
wire halt_s;
reg [7:0] acc;
reg [7:0] ext;
reg cb;
program_counter pc0 (
.clk(clk),
.rst(rst),
.load(pc_load_s),
.inc(pc_inc_s),
.adr_in(br_adr),
.pc(pc_adr)
);
memory mem0 (
.adr(pc_adr),
.instr(instr)
);
assign rf_adr = instr[3:0];
register_file rf0 (
.clk(clk),
.rst(rst),
.r_adr(rf_adr),
.w_adr(rf_adr),
.w_data(acc),
.we(rf_we_s),
.r_data(rf_data)
);
alu alu0 (
.op_a(acc),
.op_b(rf_data),
.alu_op(alu_op_s),
.res(alu_res),
.ext_res(alu_ext),
.cb_out(alu_cb)
);
assign br_adr = instr[3:0];
control_unit cu0 (
.clk(clk),
.rst(rst),
.instr(instr),
.cb_in(cb),
.rf_we(rf_we_s),
.alu_op(alu_op_s),
.pc_load(pc_load_s),
.pc_inc(pc_inc_s),
.acc_we(acc_we_s),
.ext_we(ext_we_s),
.cb_we(cb_we_s),
.halt(halt_s)
);
always @(posedge clk or posedge rst) begin
if (rst) begin
acc <= 8'b0;
ext <= 8'b0;
cb <= 1'b0;
end else begin
if (acc_we_s)
acc <= alu_res;
if (ext_we_s)
ext <= alu_ext;
if (cb_we_s)
cb <= alu_cb;
end
end
assign halt_out = halt_s;
endmodule
