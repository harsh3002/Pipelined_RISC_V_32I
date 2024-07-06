`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2024 22:38:32
// Design Name: 
// Module Name: MUX3_1
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


module MUX3_1(
    input [31:0] A,
    input [31:0] B,
    input [31:0] C,
    output[31:0] MUX_o,
    input [1:0] SEL_i
    );
    
    assign MUX_o = (SEL_i == 2'd0) ? A : (SEL_i == 2'd1) ? B : (SEL_i == 2'd2) ? C : 31'd0 ;
endmodule
