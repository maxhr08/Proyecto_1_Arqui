`timescale 1ns / 1ps

module PC(pc_out,in,clk,reset);

input wire [31:0] in;  
input wire clk;
input wire reset;

output reg [31:0] pc_out;

reg [31:0] auxiliar;

always @(negedge clk)
       begin
        auxiliar = in;
       end
       
always @*
begin
 if(reset == 0)
       begin
            pc_out = auxiliar;
       end
    else 
       begin
            pc_out = 32'h0;
       end
end
endmodule

