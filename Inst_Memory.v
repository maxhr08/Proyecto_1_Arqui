`timescale 1ns / 1ps

module Inst_Memory(Din,Dout);

input wire [31:0] Din;
output wire [31:0] Dout;

reg [31:0] memdata [511:0];

initial
        begin
            memdata[32'h0] = 32'h00900093;  // ADDI
            memdata[32'h4] = 32'h00000000;
            memdata[32'h8] = 32'h00000000;
            memdata[32'hc] = 32'h00a0e113;  // ANDI
            memdata[32'h10] = 32'h00000000;
            memdata[32'h14] = 32'h00000000;
            memdata[32'h18] = 32'h00e17193; // ANDI
            memdata[32'h1c] = 32'h00000000;
            memdata[32'h20] = 32'h00000000;
            memdata[32'h24] = 32'h00500293; // ADDI $5 = 5
            memdata[32'h28] = 32'h00000000;
            memdata[32'h2c] = 32'h00000000;
            memdata[32'h30] = 32'h00500213; // ADDI $4 = 5
            memdata[32'h34] = 32'h00000000;
            memdata[32'h38] = 32'h00000000;
            memdata[32'h3c] = 32'h00000000;
            memdata[32'h40] = 32'h00000000;
            memdata[32'h44] = 32'h00000000;
            memdata[32'h48] = 32'hFC428EE3; // BEQ $4 y $5 
            memdata[32'h4c] = 32'h00000000;
            memdata[32'h50] = 32'h00000000;
            memdata[32'h54] = 32'h0;
            memdata[32'h58] = 32'h0;
            memdata[32'h5c] = 32'h0;
        end
       
assign Dout =  memdata[Din];

endmodule

/*
00310093
00108233
004082A

*/