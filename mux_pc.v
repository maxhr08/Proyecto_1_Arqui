`timescale 1ns / 1ps

module mux_pc(pc_4,beq,next_pc,sel);
input wire [31:0] pc_4;
input wire [31:0] beq;
output [31:0] next_pc;
input sel;

reg [31:0] next_pc;


always @(pc_4,beq,sel)
begin
    case(sel)
        1'b0:next_pc = pc_4;
        1'b1:next_pc = beq;
     endcase   
end

endmodule
