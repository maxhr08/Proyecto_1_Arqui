`timescale 1ns / 1ps

module EXE(
	input wire [2:0]ALUControlE,
	input wire ALUSrcE,
	input wire [31:0]SignImmE,
	input wire [31:0]RD1, RD2,
	
	output reg [31:0]alu_out
    );

	always @(*)begin
		if(ALUSrcE)
			case(ALUControlE)
				3'b111: alu_out=RD1&SignImmE;  //AND
				3'b110: alu_out=RD1|SignImmE;  //OR
				3'b000: alu_out=RD1+SignImmE;  //add
			endcase
		else
			case(ALUControlE)
				3'b111: alu_out=RD1&RD2;  //AND
				3'b110: alu_out=RD1|RD2;  //OR
				3'b000: alu_out=RD1+RD2;  //add
			endcase
	end

endmodule
