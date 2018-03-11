`timescale 1ns / 1ps

/*
	Mux_Comparacion:

	Este módulo obtiene 3 entradas de 32 bits y selecciona uno hacia la salida.
	Específicamente, se utiliza para escoger el dato que entrará a la unidad de comparación (Deco, Exe o Mem), con el fin de corregir el riesgo de datos debido a la implementación por etapas del procesador.

*/

module Mux_Comparacion(
	input [31:0] Rs_Deco,		// Dato en DECO
	input [31:0] Rs_Exe,		// Dato en EXE
	input [31:0] Rs_Mem,		// Dato en MEM
	input [1:0] Sel_Rs,			// Selector del MUX
	output reg [31:0] Op_Comp	// Operando a comparar
	);	
	
	always @(*) begin
		case (Sel_Rs)
			2'b00	: Op_Comp <= Rs_Deco;
			2'b01	: Op_Comp <= Rs_Exe;
			2'b10	: Op_Comp <= Rs_Mem;
			default	: Op_Comp <= Rs_Deco;
		endcase
	end

endmodule