`timescale 1ns / 1ps


module MEM(
    input [31:0]Address,
    input [31:0]RD2_EXEMEM_out,
    input [1:0]Mem_Control,
    input clk,
    input [2:0]funct3,
        
    output [31:0]Read_Data
    );
    
    Memoria_de_Datos Memoria_de_Datos(
        .Addr(Address),
        .Write_Data(RD2_EXEMEM_out),
        .RWenable(Mem_Control[0]),
        .RWset(Mem_Control[1]),
        .funct3(funct3),
        .clk(clk),
        .Read_Data_Cbl(Read_Data)    
    );
    
endmodule
