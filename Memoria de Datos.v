`timescale 1ns / 1ps


module Memoria_de_Datos(
    
    input [31:0]Addr,
    input [31:0]Write_Data,
    input RWenable,
    input RWset,
    input [2:0]funct3,
    input clk,
    
    output wire [31:0]Read_Data_Cbl
    
    );
    //PREGUNTA!!! => La memoria es de 1kB, pero el Addr es de 32bits, o sea que puede direccionar 4GB
    
    reg	[7:0] Memory_Cell_0	[1023:0];
    reg	[7:0] Memory_Cell_1	[1023:0];
    reg	[7:0] Memory_Cell_2	[1023:0];
    reg	[7:0] Memory_Cell_3	[1023:0];
    
    reg [31:0]Read_Data;
    
    always @(~clk)begin
    if(RWset && RWenable)
        case(funct3)
            3'b000: Memory_Cell_0[Addr[9:0]] = Write_Data[7:0];
            
            3'b001:
            begin
                Memory_Cell_0[Addr[9:0]] = Write_Data[7:0];
                Memory_Cell_1[Addr[9:0]] = Write_Data[15:8];
            end
               
            3'b010:
            begin
                Memory_Cell_0[Addr[9:0]] = Write_Data[7:0];
                Memory_Cell_1[Addr[9:0]] = Write_Data[15:8];
                Memory_Cell_2[Addr[9:0]] = Write_Data[23:16];
                Memory_Cell_3[Addr[9:0]] = Write_Data[31:24];
            end
            
            default:
            begin
                Memory_Cell_0[Addr] = 8'b00000000;
                Memory_Cell_1[Addr] = 8'b00000000;
                Memory_Cell_2[Addr] = 8'b00000000;
                Memory_Cell_3[Addr] = 8'b00000000;
            end
            
        endcase
    end
    
    always @(clk)begin
        if(~RWset && RWenable)
            Read_Data <= {Memory_Cell_3[Addr[9:0]], Memory_Cell_2[Addr[9:0]], Memory_Cell_1[Addr[9:0]], Memory_Cell_0[Addr[9:0]]};
    end
    
    assign Read_Data_Cbl = Read_Data;
    
endmodule
