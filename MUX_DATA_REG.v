`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.06.2024 18:43:19
// Design Name: 
// Module Name: MUX_DATA_REG
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


module MUX_DATA_REG(

    input [31:0] MUX_i0,
    input [31:0] MUX_i1,
    input [31:0] MUX_i2,
    input [31:0] MUX_i3,
    input [1:0]  sel_i,
    output [31:0] MUX_o
    );
    
    
        assign MUX_o = (sel_i == 2'd1) ? MUX_i1 : 
                       (sel_i == 2'd2) ? MUX_i2 : 
                       (sel_i == 2'd3) ? MUX_i3 : MUX_i0;
endmodule
