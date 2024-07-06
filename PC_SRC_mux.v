`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2024 17:48:16
// Design Name: 
// Module Name: PC_SRC_mux
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


module PC_SRC_mux(
        output [31:0] PC_o,                         // PC Input to the PROGRAM Counter
        input  [31:0] PC_IMM_i, PC_i, ALU_OUT_i,    // Inputs to the MUX
        input  [1:0]  PC_SRC_i                      // CONTROL Line to select Output
    );
    
    
    // ROUTING the INPUTS and OUTPUT
    assign PC_o = (PC_SRC_i == 2'd1) ? PC_IMM_i :
                  (PC_SRC_i ==2'd2)  ? ALU_OUT_i :  PC_i ;
    
endmodule
