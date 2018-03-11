`timescale 1ns / 1ps

module alu(
	input wire [2:0]ALUControlE,
	input wire [0:0]ALUSrcE, sel_1, sel_2,
	input wire [11:0]SignImmE,
	input wire [31:0]RD1, RD2, alu_MEM,
	
	output reg [31:0]alu_out
    );
	
	reg [31:0]R1, R2;
	
	always @(*)begin
		if(sel_1)
			R1=alu_MEM;
		else
			R1=RD1;
		
		if(sel_2)
			R2=alu_MEM;
		else
			R2=RD2;
		
		if(ALUSrcE)
			case(ALUControlE)
				3'b111: alu_out=R1&SignImmE;  //AND
				3'b110: alu_out=R1|SignImmE;  //OR
				3'b000: alu_out=R1+SignImmE;  //add
			endcase
		else
			case(ALUControlE)
				3'b111: alu_out=R1&R2;  //AND
				3'b110: alu_out=R1|R2;  //OR
				3'b000: alu_out=R1+R2;  //add
			endcase
	end

endmodule
