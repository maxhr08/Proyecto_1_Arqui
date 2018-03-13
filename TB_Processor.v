`timescale 1ns / 1ps

module TB_Processor();

reg clk;
reg global_reset;

TOP TOP(
    .clk(clk),
    .global_reset(global_reset)
    );
    
    initial begin
        #200
        clk = 1'b0;             // Inicialización de señales
        global_reset = 1'b0;
        
        #10
        global_reset = 1'b1;           // Reseteo de registros
        repeat(4) #10 clk = ~clk;
        
        global_reset = 1'b0;           // Inicio del sistema, con la inicialización previa de registros
        forever #10 clk = ~clk; // Generación "perpetua" de la señal de reloj
    end
    
    always@(posedge clk) 
      $monitor("%b", TOP.Decode.reg_file.register_file[1]);
    
    initial begin
        #800                    // Tiempo de espera inicial para el sistema
        $finish;    
    end
            
endmodule