`timescale 1ns / 1ps

module ctrl_unit(
	input wire [6:0]op,
	input wire [2:0]funct,
	output reg [1:0] MEM_Ctrl,
	output reg [0:0] RegWriteD, Sel_Inmediato, ALUSrcD, BranchD,
	output reg [2:0] ALUControlD
    );
            
    
    //////////////
    //// DECO ////
    //////////////
    
        // RegWriteD: Señal de escritura de banco de registros 
        // Sel_Inmediato: 
        // BranchD: señal que determina si la instrucción es tipo Branch
         
    //////////////     
    //// EXE  ////
    //////////////
    
        // ALUSrcD: Mux de EXE, escoge entre inmediato y registro en EXE
        // ALUControl: 3 bits para escoger la operación de la ALU
    
    //////////////
    //// MEM  ////    
    //////////////
        
        // MEM_Ctrl: Señal de control de la memoria (2 bits) {MSB: Enable,  LSB: write o read }
	
	always @(*)begin

		// DECO
		RegWriteD = (op == 7'b0110011) || (op == 7'b0010011);
		Sel_Inmediato = (op == 7'b0100011);

		if (op==7'b1100011)
		    BranchD = 1'b1;
		else
		    BranchD = 1'b0;

		// EXE
		ALUControlD = funct;
		ALUSrcD = (op == 7'b0010011) || (op == 7'b0100011);

		// MEM
	 	if (op == 7'b0100011)
	    		MEM_Ctrl = 2'b11;
		else 
	    		MEM_Ctrl = 2'b00;

	end
endmodule
