`timescale 1ns / 1ps

module Inst_Memory(Din,Dout);

input wire [31:0] Din;
output wire [31:0] Dout;

reg [31:0] memdata [511:0];

initial
        begin
            memdata[32'h0] = 32'h00200093;  // ADDI
            memdata[32'h4] = 32'h00300113;
            memdata[32'h8] = 32'h01110193;
            /*
            memdata[32'hc] = 32'h00317233;  // ANDI
            memdata[32'h10] = 32'h003262B3;
            memdata[32'h14] = 32'h0032F333;
            memdata[32'h18] = {12'd4, 5'd6, 3'b111, 5'd7, 7'b0010011};
            memdata[32'h1c] = {12'd3, 5'd7, 3'b110, 5'd5, 7'b0010011};
            memdata[32'h20] = {7'b0000000, 5'd1, 5'd8, 3'b010, 5'd8, 7'b0100011};
            memdata[32'h24] = {7'b0000000, 5'd8, 5'd8, 3'b000, 5'd9, 7'b0100011};
            memdata[32'h28] = {7'b0000000, 5'd8, 5'd5, 3'b001, 5'd10, 7'b0100011};
            memdata[32'h2c] = 32'h0010F093;
            memdata[32'h30] = 32'hF7208773; // ADDI $4 = 5
            memdata[32'h34] = 32'h00208093;
            memdata[32'h38] = 32'hFFF08093;
            memdata[32'h3c] = 32'hFE209EE3;
            memdata[32'h40] =  {12'hfff, 5'd2, 3'b000, 5'd2, 7'b0010011};
            memdata[32'h44]    = {7'b1111111, 5'd1, 5'd2, 3'b100, 5'b11101, 7'b1100011};
            */
        end
       
assign Dout =  memdata[Din];

endmodule

/*
00310093
00108233
004082A

*/