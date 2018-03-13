`timescale 1ns / 1ps

module pc_4(in_pc4,clk,reset,out_pc4);

input wire [31:0] in_pc4;  
input wire clk;
input reset;
output reg [31:0] out_pc4;

reg [31:0] auxiliar;

always @(posedge clk)
       begin
        auxiliar = in_pc4;
       end
       
always @*
begin
 if(reset == 0)
       begin
            out_pc4 = auxiliar;
       end
    else 
       begin
            out_pc4 = 32'h0;
       end
end
//assign out_pc4=auxiliar;

//always @*
//     begin
//       if (reset == 1)
//        begin
//            auxiliar = 32'h0;
//        end
//      end
//
//always @(posedge clk)
//        begin 
//	       auxiliar = in_pc4;
//        end
endmodule
