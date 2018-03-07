`timescale 1ns / 1ps

module WB(
    input sel,
    input [31:0]Read_Data,
    input [31:0]alu_out,
    
    output [31:0]WB_out 
    );
    
    reg [31:0]WB_out_reg;
    
    always @(sel or Read_Data or alu_out)
        begin
            case(sel)
                1'b0: WB_out_reg = Read_Data;
                1'b1: WB_out_reg = alu_out;
            endcase
        end

    assign WB_out = WB_out_reg;
    
    
endmodule
