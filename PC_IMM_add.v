`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2024 17:42:05
// Design Name: 
// Module Name: PC_IMM_add
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


module PC_IMM_add(
    input [31:0] PC_in,
    input [31:0] IMM_in,
    output [31:0] PC_out
    );
    
    assign PC_out = PC_in + IMM_in ;
    
endmodule
