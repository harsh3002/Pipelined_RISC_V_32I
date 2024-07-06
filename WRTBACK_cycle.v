`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2024 17:12:52
// Design Name: 
// Module Name: WRTBACK_cycle
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


module WRTBACK_cycle(
                output [31:0] RSLT_W_o,
                
                input  [1:0]  RSLTSRC_W_i,
                input  [31:0] RD_DATA_W_i,
                input  [31:0] ALURSLT_W_i,
                input  [31:0] IMM_W_i,
                input  [31:0] PCPLUS4_W_i
    );
    
    
             MUX_DATA_REG dt_reg_mux_inst(
                        .MUX_i0(ALURSLT_W_i),
                        .MUX_i1(RD_DATA_W_i),
                        .MUX_i2(PCPLUS4_W_i),
                        .MUX_i3(IMM_W_i),
                        .sel_i(RSLTSRC_W_i),
                        .MUX_o(RSLT_W_o)
    );
    
endmodule
