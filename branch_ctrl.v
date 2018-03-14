`timescale 1ns / 1ps
	
module branch_ctrl(
    input wire [0:0]BranchD,
    input wire [2:0]funct,
    input wire [31:0]RD1, RD2,
    output reg [0:0]PCSrcD
    );
    
    always @(*) begin
        
        if (funct == 3'b000) begin
            if (RD1 == RD2)
                PCSrcD = BranchD;
            else 
                PCSrcD = 1'b0;
        end
        
        else if (funct == 3'b001) begin
            if (RD1 != RD2)
                PCSrcD = BranchD;
            else 
                PCSrcD = 1'b0;
        end
        
        else if (funct == 3'b100) begin
            if (RD1 < RD2)
                PCSrcD = BranchD;
            else 
                PCSrcD = 1'b0;
        end
        
        else begin
            PCSrcD = 1'b0;
        end
    end
/*	
	always @(*)begin
		PCSrcD=BranchD && (((funct==3'b000) && (RD1==RD2)) || ((funct==3'b001) && (RD1!=RD2)) || ((funct==3'b100) && (RD1<RD2)));
	end
*/
endmodule