`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2024 20:59:18
// Design Name: 
// Module Name: PC_SRC_CTRL
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


module PC_SRC_CTRL(
            output [1:0] PC_SRC_o,
            input  [2:0] BRANCH_i,
            input  [1:0] JUMP_i,
            input        flg_zero_i, flg_neg_i
    );
    
    assign PC_SRC_o = (flg_zero_i & BRANCH_i == 3'd1 )? 2'd1 :
                       (!flg_zero_i & BRANCH_i == 3'd2 )? 2'd1 :
                       (flg_neg_i & BRANCH_i == 3'd3 )? 2'd1 :
                       ((flg_zero_i | !flg_neg_i) & BRANCH_i == 3'd4 )? 2'd1 :
                       (JUMP_i == 2'd1 ) ? 2'd1  :
                       (JUMP_i == 2'd2 ) ? 2'd2  :  2'd0 ; 
    
endmodule
