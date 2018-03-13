`timescale 1ns / 1ps

module reg_file(
	input wire clk,
	input wire reg_write_signal,
	input wire [4:0] Dir_R1, Dir_R2, Dir_write,
	input wire [31:0] Write_Data,
	input wire reset,
	
	output reg [31:0] Rs1,
	output reg [31:0] Rs2
    );

	parameter Width = 32;
	parameter N = 32;
	
	reg [Width-1:0] register_file [0:N-1];
	
//-----------------------------	
// Inicialización de los registros
	
	integer i;
	initial begin
	   for (i = 0; i <= 31; i=i+1) begin // Ciclo for para inicializar cada espacio de memoria
            register_file[i]=0;
       end
	end

//-----------------------------------------------	
// Lógica de lectura y escritura de los registros	
	
	always @(*) begin
           Rs1 = register_file[Dir_R1];
           Rs2 = register_file[Dir_R2];
    end
	      
    always @(negedge clk) begin
        if(reg_write_signal)
            register_file[Dir_write] = Write_Data;
    end
    
    always @(posedge reset) begin
          for (i = 0; i <= 31; i=i+1) begin     // Ciclo for para inicializar cada espacio de memoria
                register_file[i] = 0;
          end      
    end
    
endmodule
