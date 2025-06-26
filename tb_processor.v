`timescale 1ns / 1ps
module tb_processor;
reg clk;
reg rst;
wire halt_out;
processor_top uut (
.clk(clk),
.rst(rst),
.halt_out(halt_out)
);
initial begin
clk = 0;
forever #5 clk = ~clk;
end
initial begin
rst = 1;
#25;
rst = 0;
wait (halt_out == 1);
#20;
$finish;
end
endmodule
