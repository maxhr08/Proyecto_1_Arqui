`timescale 1ns / 1ps

module BP_ctrl(
	input wire [4:0]RD1Addr, RD2Addr, RDAddr,
	output reg sel_1, sel_2
    );
	 
	always @(*)begin
		sel_1 = (RD1Addr==RDAddr);
		sel_2 = (RD2Addr==RDAddr);
	end

endmodule
