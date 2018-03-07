`timescale 1ns / 1ps

module MEM_WB(
	input wire clk,
	input wire [31:0]alu_memwb_in,
	input wire [4:0]A3_memwb_in,
	
	output reg [31:0]alu_memwb_out,
	output reg [4:0]A3_memwb_out,
	
	//control
	input wire RegWriteM,
	output reg RegWriteW
    );

	always @(posedge clk)begin
		alu_memwb_out=alu_memwb_in;
		A3_memwb_out=A3_memwb_in;
		
		RegWriteW=RegWriteM;
		
	end

endmodule
