`timescale 1ns / 1ps

module EX_MEM(
	input wire clk,
	input wire [31:0]alu_exmem_in, RD2_exmem_in,
	input wire [4:0]A3_exmem_in,
	
	
	output reg [31:0]alu_exmem_out, RD2_exmem_out,
	output reg [4:0]A3_exmem_out,
	
	//control
	input wire RegWriteE, MemtoRegE, MemWriteE,
	input wire [2:0]funct3_exmem_in,
	
	output reg RegWriteM, MemtoRegM, MemWriteM,
	output reg [2:0]funct3_exmem_out
    );

	always @(posedge clk)begin
		alu_exmem_out=alu_exmem_in;
		A3_exmem_out=A3_exmem_in;
		RD2_exmem_out=RD2_exmem_in;
		funct3_exmem_out=funct3_exmem_in;
		
		RegWriteM=RegWriteE;
		MemtoRegM=MemtoRegE;
		MemWriteM=MemWriteE;
	end

endmodule
