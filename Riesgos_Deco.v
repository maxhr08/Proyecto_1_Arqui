`timescale 1ns / 1ps

module Riesgos_Deco(
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd_EXE,
    input [4:0] rd_MEM,
    
    output reg Sel_Rs1D,
    output reg Sel_Rs2D,
    output reg [1:0] Sel_Comp_Rs1D,
    output reg [1:0] Sel_Comp_Rs2D    
    );
    
    
    always @* begin
    
        // MUX Rs1_out
        if (rd_MEM == rs1)
            Sel_Rs1D = 1'b1;
        else
            Sel_Rs1D = 1'b0;
        
        // MUX Rs2_out
        if (rd_MEM == rs2)
            Sel_Rs2D = 1'b1;
        else
            Sel_Rs2D = 1'b0;
    
        // MUX Comparador Rs1                 
        if (rd_MEM == rs1)
            Sel_Comp_Rs1D = 2'b10;
            
        else if (rd_EXE == rs1)
            Sel_Comp_Rs1D = 2'b01;
        
        else 
            Sel_Comp_Rs1D = 2'b00;
        
        // MUX Comparador Rs2
        if (rd_MEM == rs2)
            Sel_Comp_Rs2D = 2'b10;
            
        else if (rd_EXE == rs2)
            Sel_Comp_Rs2D = 2'b01;
        
        else 
            Sel_Comp_Rs2D = 2'b00;
                    
    end
    
endmodule
