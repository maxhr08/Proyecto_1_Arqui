`timescale 1ns / 1ps


module fetch(clk,instruction,pc4,beq,sel,reset);

input clk;
input [31:0] beq;
input sel;
input reset;

output [31:0] instruction;
output [31:0] pc4;

wire [31:0] out_add;
wire [31:0] next_pc;
wire [31:0] pc_out;
wire [31:0] Dout;

//////////////////////////   
//////////////////////////

mux_pc U1(
    //INPUT//
        .pc_4(out_add),
        .beq(beq),
        .sel(sel),
        
    //OUTPUT//  
        .next_pc(next_pc)
);

//////////////////////////   
//////////////////////////

PC U2(
    //INPUT//
        .in(next_pc),
        .clk(clk),
        .reset(reset),
        
    //OUTPUT// 
        .pc_out(pc_out)
);

//////////////////////////   
//////////////////////////

Inst_Memory U3(
    //INPUT// 
        .Din(pc_out),
    
    //OUTPUT// 
        .Dout(Dout)
);

//////////////////////////   
//////////////////////////

add U4(
    //INPUT// 
        .in_add(pc_out),
    
    //OUTPUT// 
        .out_add(out_add)
);

//////////////////////////   
//////////////////////////

pipe1 U6(
    //INPUT//
        .in_inst(Dout),
        .clk(clk),
        .in_pc4(out_add),
        .reset(reset),
        
    //OUTPUT//
        .out_inst(instruction),
        .out_pc4(pc4)
        
);

//////////////////////////   
//////////////////////////

endmodule
