`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.05.2024 07:46:58
// Design Name: 
// Module Name: PC_NEXT
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


module PC_NEXT(
    input [31:0] PC_i,
    input [31:0] PC_temp,
    output [31:0] PC_NXT_o
    );
    
    assign PC_NXT_o = PC_i + PC_temp;
endmodule
