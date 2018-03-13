`timescale 1ns / 1ps

module ID_EX(
	input wire clk,
	input wire [4:0]A3_idex_in,
	input wire [31:0]RD1_idex_in, RD2_idex_in,
	input wire [31:0]SignImmD,
	input wire [4:0]RD1AddrD, RD2AddrD,

	output reg [31:0]RD1_idex_out, RD2_idex_out,
	output reg [4:0]A3_idex_out,
	output reg [31:0]SignImmE,
	output reg [4:0]RD1AddrE, RD2AddrE,
	
	//control
	input wire RegWriteD, MemtoRegD, MemWriteD, ALUSrcD,
	input wire [2:0]ALUControlD,
	input wire [2:0]funct3_idex_in,
	
	output reg RegWriteE, MemtoRegE, MemWriteE, ALUSrcE,
	output reg [2:0]ALUControlE, funct3_idex_out
    );
	
	always @(posedge clk)begin
		A3_idex_out = A3_idex_in;
		RD1_idex_out = RD1_idex_in;
		RD2_idex_out = RD2_idex_in;
		SignImmE = SignImmD;
		funct3_idex_out = funct3_idex_in;
		RD1AddrE = RD1AddrD;
		RD2AddrE = RD2AddrD;
		
		MemWriteE=MemWriteD;
		RegWriteE=RegWriteD;
		MemtoRegE=MemtoRegD;
		ALUSrcE=ALUSrcD;
		ALUControlE=ALUControlD;
	end

endmodule
