`timescale 1ns / 1ps

module inst(in_inst,clk,reset,out_inst);

input wire [31:0] in_inst;  
input wire clk;
input wire reset;
output reg [31:0] out_inst;

reg [31:0] auxiliar;

//assign out_inst=auxiliar;

always @(posedge clk)
       begin
        auxiliar = in_inst;
       end
       
always @*
begin
 if(reset == 0)
       begin
            out_inst = auxiliar;
       end
    else 
       begin
            out_inst = 32'h0;
       end
end
//always @*
//     begin
//       if (reset == 1)
//        begin
//           auxiliar = 32'h0;
//        end
//      end
//
//always @(posedge clk)
//        begin 
//	       auxiliar = in_inst;
//        end
endmodule


