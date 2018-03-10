`timescale 1ns / 1ps

module Inst_Memory(Din,Dout);

input wire [31:0] Din;
output wire [31:0] Dout;

        reg [31:0] memdata [511:0];

initial
        begin
        memdata[32'h0] = 32'h15;
        memdata[32'h4] = 32'h61;
        memdata[32'h8] = 32'h23;
        memdata[32'hc] = 32'h81;
        memdata[32'h10] = 32'h0;
        memdata[32'h14] = 32'h0;
        memdata[32'h18] = 32'h0;
        memdata[32'h1c] = 32'h0;
        end
       
assign Dout =  memdata[Din];
endmodule
