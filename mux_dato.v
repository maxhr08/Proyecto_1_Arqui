`timescale 1ns / 1ps

module mux_dato(
	input wire [31:0]RS1, RS2, alu_out_MEM,
	input wire S_R1, S_R2,
	output reg [31:0]RS1_out, RS2_out
    );
	
	always @(*) begin
		if(S_R1)
			RS1_out=alu_out_MEM;
		else
			RS1_out=RS1;
		
		if(S_R2)
			RS2_out=alu_out_MEM;
		else
			RS2_out=RS2;
	end

endmodule