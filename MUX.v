`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2024 21:47:43
// Design Name: 
// Module Name: MUX
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MUX(
    input [31:0] MUX_i0,
    input [31:0] MUX_i1,
    input        sel_i,
    output [31:0] MUX_o
    );
    
    assign MUX_o = sel_i ? MUX_i1 : MUX_i0;
    
endmodule
