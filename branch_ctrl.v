`timescale 1ns / 1ps
	
module branch_ctrl(
	input wire [0:0]BranchD,
	input wire [2:0]funct,
	input wire [31:0]RD1, RD2,
	output reg [0:0]PCSrcD
    );
	
	always @(*)begin
		PCSrcD=BranchD && (((funct==3'b000) && (RD1==RD2)) || ((funct==3'b001) && (RD1!=RD2)) || ((funct==3'b100) && (RD1<RD2)));
	end

endmodule