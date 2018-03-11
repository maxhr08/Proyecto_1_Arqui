`timescale 1ns / 1ps

// Módulo de decodificación del procesador. Este módulo toma los 32 bits de la instrucción y decodifica los datos. 
    // Se obtienen los datos de los registros a leer y los códigos de operación van a un submódulo de "Control", el
    // cual genera las señales de control necesarias por todas las etapas (selectores de MUX, operación de ALU, etc.)        

module Decode(
    input clk,                  // Reloj del procesador
    input [31:0] PCmas4,        // PC + 4, donde PC es el valor de contador cuando la instrucción estaba en FETCH
    input [31:0] instruccion,   // Instrucción de 32 bits. Direcciones de registros de lectura y escritura, código de operación, función e inmediato.
    input reg_write_signal,     // Señal de escritura en banco de registros, proveniente de WB
    input [4:0] write_reg,      // Código de registro que se quiere sobreescribir
    input [31:0] write_data,    // Datos que se quieren guardar en el registro de escritura
    input reset,
    
    output Select_PC,           // Selecciona la dirección de la siguiente instrucción, ya sea PC+4 o la dirección del salto
    output [31:0] Rs1,          // Datos del registro RD1
    output [31:0] Rs2,          // Datos del registro RD2
    output [31:0] inmediato,    // Inmediato de saldia (tipo I o tipo S)
    output [31:0] dir_salto,    // Dirección de salto (PC + 4 + BranchAddress)
    output RegWriteD, ALUSrcD,  
    output [2:0] ALUControlD,
    output [1:0] MEM_Ctrl
    );
       
    wire [11:0] imm_I_type = instruccion [31:20];                       // Inmediato de la instrucción I
    wire [11:0] imm_S_type = {instruccion[31:25], instruccion[11:7]};   // Inmediato de la instrucción S
    
// El siguiente wire representa el Branch Address, el cual es el inmediato de la instrucción tipo B con las siguientes modificaciones:
// Se le realiza una extensión de signo y un shift left, lo que implica tomar el bit 31 de la instrucción 18 veces, y poner dos ceros a la derecha del inmediato.   
    
    wire [31:0] BranchAddress = {{19{instruccion[31]}}, instruccion[7], instruccion[30:25], instruccion[11:8],2'b0}; 
    
// Luego, para obtener la dirección de salto, se suma PC+4+BranchAddress
    
    assign dir_salto = PCmas4 + BranchAddress; // Dirección de salto de una instrucción de tipo Branch
    
//---------------------------------
//       BANCO DE REGISTROS         Instancia del banco de registros
//---------------------------------
                                    
    reg_file reg_file(     
        .clk(clk),
        .reg_write_signal(reg_write_signal),
        .Dir_R1(instruccion[19:15]), 
        .Dir_R2(instruccion[24:20]), 
        .Dir_write(write_reg),
        .Write_Data(write_data),
        .reset(reset),
        
        .Rs1(Rs1),
        .Rs2(Rs2)
        );
    
//----------------------------
//        MUX de Datos          Selección del inmediato (I o S)
//---------------------------- 
        
    reg [11:0] inmediato_sin_extender;
    assign inmediato = {{20{instruccion[31]}}, inmediato_sin_extender}; // Este es el inmediato final con extensión de signo que saldrá del módulo de DECO
    wire seleccion_MUX_inmediato;
    
                               
    always @(*) begin
        case(seleccion_MUX_inmediato)
            1'b0: inmediato_sin_extender <= imm_I_type;
            1'b1: inmediato_sin_extender <= imm_S_type;
        endcase
    end                          
    
//-----------------------------
//       UNIDAD DE CONTROL      Instancia de la unidad de control
//-----------------------------
    
    wire BranchD;
    
    ctrl_unit ctrl_unit(
       	.op(instruccion[6:0]),
        .funct(instruccion[14:12]),
        
        .MEM_Ctrl(MEM_Ctrl),
        .RegWriteD(RegWriteD),
        .Sel_Inmediato(seleccion_MUX_inmediato),
        .ALUSrcD(ALUSrcD),
        .BranchD(BranchD),
        .ALUControlD(ALUControlD)
    );    
    
//-----------------------------
//         BRANCH CONTROL      Instancia del control de Branches
//-----------------------------
        
    branch_ctrl banch_ctrl(
        .BranchD(BranchD),
        .funct(instruccion[14:12]),
        .RD1(Rs1), 
        .RD2(Rs2),
        .PCSrcD(Select_PC)
        );
    
endmodule
