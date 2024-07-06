`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2024 14:01:08
// Design Name: 
// Module Name: Hazard_Unit
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


module Hazard_Unit(
                output  [1:0] FRWRD_A_E_o, FRWRD_B_E_o,
                output        STALL_o, FLUSH_o,  
                input         REGWRT_M_i, REGWRT_W_i, rst_i,
                input   [1:0] RSLTSRC_E_i, PC_SRC_E_i,
                input   [4:0] RS1_E_i, RS2_E_i, RD1_D_i, RD2_D_i, RD_E_i,
                input   [4:0] RDW_i, RDM_i 
    );
    
    assign FRWRD_A_E_o = (rst_i == 1'b0) ? 2'b00 :
                         (REGWRT_M_i==1'b1 & (RDM_i != 5'd0) & (RDM_i == RS1_E_i)) ? 2'b10 :
                         (REGWRT_W_i==1'b1 & (RDW_i != 5'd0) & (RDW_i == RS1_E_i)) ? 2'b01 :  2'b00 ;
                         
    
    assign FRWRD_B_E_o = (rst_i == 1'b0) ? 2'b00 :
                         (REGWRT_M_i==1'b1 & (RDM_i != 5'd0) & (RDM_i == RS2_E_i)) ? 2'b10 :
                         (REGWRT_W_i==1'b1 & (RDW_i != 5'd0) & (RDW_i == RS2_E_i)) ? 2'b01 :  2'b00 ;
                         
    assign STALL_o  =  (rst_i == 1'b0) ? 1'b0 : 
                         (((RD1_D_i == RD_E_i) | (RD2_D_i == RD_E_i)) & (RSLTSRC_E_i == 2'd1)) ? 1'b1 : 1'b0 ;
            
    assign FLUSH_o  =  (rst_i == 1'b0) ? 1'b0 : 
                       ((PC_SRC_E_i == 2'd1 | PC_SRC_E_i == 2'd2) ) ? 1'b1 : 1'b0 ;                     
endmodule
