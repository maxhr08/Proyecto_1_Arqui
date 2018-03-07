`timescale 1ns / 1ps

module ID_EX(
	input wire clk,
	input wire [4:0]A3_idex_in,
	input wire [31:0]RD1_idex_in, RD2_idex_in,
	input wire [31:0]SignImmD,

	output reg [31:0]RD1_idex_out, RD2_idex_out,
	output reg [4:0]A3_idex_out,
	output reg [31:0]SignImmE,
	
	//control
	input wire RegWriteD, ALUSrcD,
	input wire [1:0]MEM_CtrlD,
	input wire [2:0]ALUControlD,
	input wire [2:0]funct3_idex_in,
	
	output reg RegWriteE, ALUSrcE,
	output reg [1:0]MEM_CtrlE,
	output reg [2:0]ALUControlE, funct3_idex_out
    );
	
	always @(posedge clk)begin
		A3_idex_out=A3_idex_in;
		RD1_idex_out=RD1_idex_in;
		RD2_idex_out=RD2_idex_in;
		SignImmE=SignImmD;
		funct3_idex_out=funct3_idex_in;
		
		MEM_CtrlE=MEM_CtrlD;
		RegWriteE=RegWriteD;
		ALUSrcE=ALUSrcD;
		ALUControlE=ALUControlD;
	end

endmodule
