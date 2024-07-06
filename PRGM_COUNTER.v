`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2024 18:56:58
// Design Name: 
// Module Name: PRGM_COUNTER
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


module PRGM_COUNTER(
        output reg  [31:0]   PC_o,              // PC Output Indicating address of INSTRUCTION in INSTRUCTION MEMORY       
        input           clk_i, rst_i,           // CLOCK and RESET input (POSITVE TRIGGERED CLK  &  ACTIVE LOW RESET)
        input           ENA_H_i,
        input  [31:0]   PC_NXT_i                // COUNTER input FROM PC_ADDER
    );
    
    // SYNCHRONIZING the INSTRUCTION with CLOCK
        always@(posedge clk_i) begin
            if(!rst_i) 
                PC_o <= 32'h00000000;
            else 
                if(!ENA_H_i)
                    PC_o <= PC_NXT_i;
        end
    
endmodule
