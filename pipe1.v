`timescale 1ns / 1ps

module pipe1(in_inst,in_pc4,clk,out_inst,out_pc4,reset);

input wire [31:0] in_inst;  
input wire [31:0]in_pc4;
input wire clk;
input reset;

output  [31:0] out_inst;
output  [31:0] out_pc4;

inst instruction(.in_inst(in_inst),.reset(reset),.clk(clk),.out_inst(out_inst));
pc_4 pcmas4(.in_pc4(in_pc4),.reset(reset),.clk(clk),.out_pc4(out_pc4));
        
endmodule

