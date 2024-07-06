`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2024 11:32:14
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
        output  [1:0]   JUMP_o,
        output  [2:0]   BRANCH_o,           // CONTROL SIGNAL for BRANCH
        output  [1:0]   RSLT_o,             // CONTROL SIGNAL for WRITE-BACK MUX
        output          MEM_WRT_o,          // CONTROL SIGNAL for DATA-MEMORY WRITE ENABLE
        output          ALU_SRC_o,          // CONTROL SIGNAL for ALU-SOURCE OPERAND 2
        output  [1:0]   IMM_SRC_o,          // CONTROL SIGNAL for IMMEDIATE GENERATOR
        output          REG_WRT_o,          // CONTROL SIGNAL for WRITE ENABLE of REG-FILE
        output  [3:0]   ALU_CTRL_o,         // CONTROL SIGNAL for ALU OPERATION
        
        
        input   [6:0]   OP_CD_i,            // OP CODE INPUT
        input   [2:0]   FUNCT3_i,           // FUNCT-3 INPUT from INSTR-MEM
        input           FUNCT7_i            // 6th BIT of FUNCT-7 FROM INSTR-MEM
    );
    
    // INTERMEDIATE WIRE for BRANCH INSTR
    wire        branch_t;
    
    // BRANCH ASSIGNMENT
    assign branch_t = (OP_CD_i == 7'b1100011) ?  1'b1  :  1'b0 ;
    
    assign BRANCH_o = (branch_t & FUNCT3_i == 3'd0 )? 3'd1 :
                      (branch_t & FUNCT3_i == 3'd1 )? 3'd2 :
                      (branch_t & (FUNCT3_i == 3'd4 | FUNCT3_i == 3'd6) )? 3'd3 : 
                      (branch_t & (FUNCT3_i == 3'd5 | FUNCT3_i == 3'd7) )? 3'd4 : 3'b0;
    
    // JUMP CONTROL 
    assign JUMP_o = (OP_CD_i == 7'b1101111) ? 2'd1 :
                    (OP_CD_i == 7'b1100111) ? 2'd2 : 2'd0;
    
    // PC_MUX CONTROL ASSIGNMENT
    /*assign  PC_SRC_o = (flg_zero_i & branch_t & FUNCT3_i == 3'd0 )? 2'd1 :
                       (!flg_zero_i & branch_t & FUNCT3_i == 3'd1 )? 2'd1 :
                       (flg_neg_i & branch_t & (FUNCT3_i == 3'd4 | FUNCT3_i == 3'd6) )? 2'd1 :
                       ((flg_zero_i | !flg_neg_i) & branch_t & (FUNCT3_i == 3'd5 | FUNCT3_i == 3'd7) )? 2'd1 :
                       (OP_CD_i == 7'b1101111) ? 2'd1  :
                       (OP_CD_i == 7'b1100111) ? 2'd2  :  2'd0 ; */
    
    // REGISTER FILE WRITE CONTROL ASSIGNMENT
    assign REG_WRT_o = ((OP_CD_i == 7'b0000011) | (OP_CD_i == 7'b0110011) | OP_CD_i == 7'b0010011 | (OP_CD_i == 7'b1101111) | (OP_CD_i == 7'b1100111) | OP_CD_i == 7'b0110111 | OP_CD_i == 7'b0010111) ?  1'b1  :  1'b0 ;
    
    // IMMEDIATE GENERATOR CONTROL ASSIGNMENT
    assign IMM_SRC_o = (OP_CD_i == 7'b0010011 | OP_CD_i == 7'b1100111 | OP_CD_i == 7'b00000011) ?  2'b00  : 
                       (OP_CD_i == 7'b1100011) ?  2'b10  : 
                       (OP_CD_i == 7'b1101111) ?  2'b11  : 
                       (OP_CD_i == 7'b0110111 | OP_CD_i == 7'b0010111)?  2'b01 :2'b00 ;
    
    // ALU SOURCE 2 CONTROL ASSIGNMENT                   
    assign ALU_SRC_o = (OP_CD_i == 7'b0000011 ) | (OP_CD_i == 7'b0100011) | (OP_CD_i == 7'b0010011) | (OP_CD_i == 7'b1100111)?  1'b1  : 1'b0 ;
    
    // DATA MEMORY WRITE CONTROL ASSIGNMENT
    assign MEM_WRT_o = (OP_CD_i == 7'b0100011) ?  1'b1  :  1'b0 ;
    
    // WRITE-BACK MUX CONTROL ASSIGNMENT
    assign RSLT_o = (OP_CD_i == 7'b0000011) ?  2'd1  :
                    (OP_CD_i == 7'b1101111) ?  2'd2  : 
                    (OP_CD_i == 7'b0110111 | OP_CD_i == 7'b0010111)? 2'd3 : 2'd0 ;
    
    // ALU OPERATION CONTROL ASSIGNMENT
    assign ALU_CTRL_o =((OP_CD_i == 7'b0110011 ) | (OP_CD_i == 7'b0010011 & FUNCT3_i ==3'd5))? ({FUNCT3_i, FUNCT7_i}) : 
                        (OP_CD_i == 7'b0000011 | OP_CD_i == 7'b1100111)? 4'd0 : 
                        ((OP_CD_i == 7'b1100011)) ? 4'b000_1 : ({FUNCT3_i, 1'b0});         
    
endmodule
