`timescale 1ns / 1ps


module TOP(
    input clk,
    input global_reset
    
    );
   


////////////////////////////////////////////////////
////                FETCH                       ////
////////////////////////////////////////////////////
                                                  //
                                                  //
    wire [31:0]beq_dir_salto;                     //
    wire sel_Select_PC;                           //
                                                  //
///Wires del PIPE IF_ID///                        //
                                                  //
    wire [31:0]in_inst_IF_ID;                     //
    wire [31:0]pc4_IF_ID;                         //
                                                  //
    wire [31:0]out_inst_IF_ID;                    //
    wire [31:0]out_pc4_IF_ID;                     //
                                                  //
////////////////////////////////////////////////////
////                 DECO                       ////
////////////////////////////////////////////////////
                                                  //      
    wire [31:0]RS1_RD1_idex_in;                   //
    wire [31:0]RS2_RD2_idex_in;                   //
    wire [31:0]inmediato_SignImmD;                //
                                                  //
////Senales de Control////                        //
    wire RegWriteD,                               //
         ALUSrcD;                                 //
    wire [2:0]ALUControlD;                        //
    wire [1:0]Mem_CtrlD;                          //
    
                                                  //
///Wires del PIPE ID_EX///                        //
    wire [31:0]RD1_idex_out_RD1;                  //
    wire [31:0]RD2_idex_out_RD2;                  //
    wire [31:0]A3_idex_out_A3_exmem_in;           //
    wire [31:0]SignImmE;                          //
                                                  //
////////////////////////////////////////////////////
////                 EXE                        ////
////////////////////////////////////////////////////
                                                  //
    wire [31:0]alu_out_alu_exmem_in;   
    wire [4:0]RD1AddrE_RD1AddrEXE;                 //
    wire [4:0]RD2AddrE_RD2AddrEXE;                 //
                                                  //
////Senales de Control////                        //
    wire RegWriteE,                               //       
         ALUSrcE;                                 //
    wire [2:0]ALUControlE;                        //
    wire [1:0]Mem_CtrlE;                          //                                //
    
///Wires del PIPE EXE_MEM///                      // 
    wire [2:0]funct3_idex_funct3_exmem_in;        //
                                                  //
////////////////////////////////////////////////////
////                 MEM                        ////
////////////////////////////////////////////////////  
                                                  //
    wire [31:0] alu_exmem_out_Address;            //
    wire [31:0] RD2_exmem_out_RD2;                //
    wire [4:0] A3_exmem_out_A3_memwb_in;          //
    wire [2:0] funct_3_exmem_out_funct3;          //
                                                  //
////Senales de Control////                        //
                                                  //
    wire RegWriteM;
    wire [1:0]Mem_CtrlM;                          //
                                                  //                          // 
///Wires del PIPE EXE_MEM///                      //
                                                  //
////////////////////////////////////////////////////
////                  WB                        ////
////////////////////////////////////////////////////
    
    wire [31:0]WB_out_write_data;
    wire [4:0]A3_memwb_out_write_reg;
    
    wire [31:0]alu_memwb_out_write_data;
                                                  //
////Senales de Control////                        //
    wire RegWriteW;                               //
                                                  //
////////////////////////////////////////////////////
////////////////////////////////////////////////////






////////////////////////////////////////////////////
////                FETCH                       ////
////////////////////////////////////////////////////
                                                  //
    fetch fetch(                                  //
        //INPUT//                                 //
            .clk(clk),                        //
            .beq(beq_dir_salto),                  //
            .sel(sel_Select_PC),                  //
            .reset(global_reset),                 //
                                                  //
        //OUTPUT//                                //
            .instruction(in_inst_IF_ID),          //
            .pc4(pc4_IF_ID)                       //
    );                                            // 
                                                  //
////INSTANCIA DE IF_ID////                        //
                                                  //
    IF_ID IF_ID(                                  //
        //INPUT//                                 //
            .clk(clk),                        //
            .in_inst(in_inst_IF_ID),              //
            .in_pc4(pc4_IF_ID),                   //
            .reset(global_reset),                 //
                                                  //
        //INPUT//                                 //
            .out_inst(out_inst_IF_ID),            //
            .out_pc4(out_pc4_IF_ID)               //
    );                                            //
                                                  //
                                                  //
////////////////////////////////////////////////////
////                DECO                        ////
////////////////////////////////////////////////////

   

    Decode Decode(
    //INPUT//
        .clk(clk),
        .PCmas4(out_pc4_IF_ID),        
        .instruccion(out_inst_IF_ID),  
        .reg_write_signal(RegWriteW),    
        .write_reg(A3_memwb_out_write_reg),      
        .write_data(alu_memwb_out_write_data),
        .reset(global_reset),
        .dato_EXE(alu_out_alu_exmem_in),      // Dato de adelantamiento desde EXE
        .dato_MEM(alu_exmem_out_Address),      // Dato de adelantamiento desde MEM 
        .dir_Rd_EXE(A3_idex_out_A3_exmem_in),     // Dirección de Rd en EXE
        .dir_Rd_MEM(A3_exmem_out_A3_memwb_in), 
        
    //OUTPUT//
        .Select_PC(sel_Select_PC),    
        .Rs1(RS1_RD1_idex_in),          
        .Rs2(RS2_RD2_idex_in),          
        .inmediato(inmediato_SignImmD),    
        .dir_salto(beq_dir_salto),
             
        .RegWriteD(RegWriteD),
        .ALUSrcD(ALUSrcD),
        .ALUControlD(ALUControlD),
        .MEM_Ctrl(Mem_CtrlD)         
               
    );

    
//////INSTANCIA DE ID_EX////
        
        ID_EX ID_EX(
            //INPUT//
                .clk(clk),
                .A3_idex_in(out_inst_IF_ID[11:7]),        
                .RD1_idex_in(RS1_RD1_idex_in),  
                .RD2_idex_in(RS2_RD2_idex_in),    
                .SignImmD(inmediato_SignImmD),      
                .RD1AddrD(out_inst_IF_ID[19:15]),
                .RD2AddrD(out_inst_IF_ID[24:20]),    
                        
            //OUTPUT//
                .RD1_idex_out(RD1_idex_out_RD1),              
                .RD2_idex_out(RD2_idex_out_RD2),     
                .A3_idex_out(A3_idex_out_A3_exmem_in),          
                .SignImmE(SignImmE),          
                .RD1AddrE(RD1AddrE_RD1AddrEXE),    //X
                .RD2AddrE(RD2AddrE_RD2AddrEXE),    //Y
               
             //control
                //INPUT//
                 .RegWriteD(RegWriteD),
                 .ALUSrcD(ALUSrcD),
                 .ALUControlD(ALUControlD),
                 .funct3_idex_in(out_inst_IF_ID[14:12]),
                 .MEM_CtrlD(Mem_CtrlD),
                 
                //OUTPUT//
                 .RegWriteE(RegWriteE),
                 .ALUSrcE(ALUSrcE),
                 .ALUControlE(ALUControlE),
                 .funct3_idex_out(funct3_idex_funct3_exmem_in),
                 .MEM_CtrlE(Mem_CtrlE)
                
        );

    
////////////////////////////////////////////////////
////                 EXE                        ////
////////////////////////////////////////////////////

    EXE EXE(
            //INPUT//
                .ALUControlE(ALUControlE),
                .ALUSrcE(ALUSrcE),
                .SignImmE(SignImmE),
                
                .RD1(RD1_idex_out_RD1), 
                .RD2(RD2_idex_out_RD2),
                .RD1Addr(RD1AddrE_RD1AddrEXE), //X
                .RD2Addr(RD2AddrE_RD2AddrEXE), //Y
                .RDAddr(A3_exmem_out_A3_memwb_in),
                .alu_MEM(alu_exmem_out_Address),
                
            //OUTPUT//
                .alu_out(alu_out_alu_exmem_in)
    );
    
////INSTANCIA DE EX_MEM////

    EX_MEM EX_MEM(
            //INPUT//
                .clk(clk),
                .alu_exmem_in(alu_out_alu_exmem_in),
                .RD2_exmem_in(RD2_idex_out_RD2),
                .A3_exmem_in(A3_idex_out_A3_exmem_in),
                
            //OUTPUT//    
                .alu_exmem_out(alu_exmem_out_Address), 
                .RD2_exmem_out(RD2_exmem_out_RD2),
                .A3_exmem_out(A3_exmem_out_A3_memwb_in),
            
            //control
                .RegWriteE(RegWriteE),
                .MEM_CtrlE(Mem_CtrlE),
                .funct3_exmem_in(funct3_idex_funct3_exmem_in),
                
                .RegWriteM(RegWriteM),
                .MEM_CtrlM(Mem_CtrlM),
                .funct3_exmem_out(funct_3_exmem_out_funct3)
    
    );
    
////////////////////////////////////////////////////
////                MEM                         ////
////////////////////////////////////////////////////
    
    MEM MEM(
        //INPUT//
            .Address(alu_exmem_out_Address),
            .RD2_EXEMEM_out(RD2_exmem_out_RD2),
            .Mem_Control(Mem_CtrlM),
            .clk(clk),
            .funct3(funct_3_exmem_out_funct3),
            
        //OUTPUT//    
            .Read_Data()
    );
    
////INSTANCIA DE MEM_WB////
    
   MEM_WB MEM_WB(
        //INPUT//
            .clk(clk),
            .alu_memwb_in(alu_exmem_out_Address),
            .A3_memwb_in(A3_exmem_out_A3_memwb_in),
            
        //OUTPUT//
            .alu_memwb_out(alu_memwb_out_write_data),
            .A3_memwb_out(A3_memwb_out_write_reg),
            
        //control
            //INPUT//
                .RegWriteM(RegWriteM),
                
            //OUTPUT//
                .RegWriteW(RegWriteW)        

    );

////////////////////////////////////////////////////
////                  WB                        ////
////////////////////////////////////////////////////  


////////////////////////////////////////////////////
////////////////////////////////////////////////////


endmodule