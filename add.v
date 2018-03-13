`timescale 1ns / 1ps

module add(in_add,out_add);

input wire [31:0] in_add;
output wire [31:0] out_add;

assign out_add = in_add +4;

endmodule
