`timescale 1ns / 1ps

module EXE(
	input wire [2:0]ALUControlE,
	input wire ALUSrcE,
	input wire [31:0]SignImmE,
	input wire [31:0]RD1, RD2,
	input wire [4:0]RD1Addr, RD2Addr,
	input wire [4:0]RDAddr,
	input wire [31:0]alu_MEM,
	
	output wire [31:0]alu_out
    );
    
    wire sel_1, sel_2;
    
	alu alu(
	   	.ALUControlE(ALUControlE),
        .ALUSrcE(ALUSrcE), 
        .sel_1(sel_1), 
        .sel_2(sel_2),
        .SignImmE(SignImmE),
        .RD1(RD1), 
        .RD2(RD2), 
        .alu_MEM(alu_MEM),
        
        .alu_out(alu_out)
	);
	
	BP_ctrl BP_ctrl(
	   .RD1Addr(RD1Addr), 
	   .RD2Addr(RD2Addr), 
	   .RDAddr(RDAddr),
	   
       .sel_1(sel_1), 
       .sel_2(sel_2)
	);
	
endmodule
