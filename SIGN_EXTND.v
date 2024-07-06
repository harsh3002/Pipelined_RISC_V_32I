`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.05.2024 07:06:10
// Design Name: 
// Module Name: SIGN_EXTND
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


module IMMEDIATE_GEN(
    input [31:0]  INSTR_i,          // INPUT INSTRUCTION
    input  [1:0]  IMM_SRC,          // CONTROL signal from CONTROL UNIT
    input [31:0]  PC_i,             // PROGRAM COUNTER input 
    output [31:0] EXTND_IMM_o       // OUTPUT IMMEDIATE generated
    );
    
    
    // DECLARING INTERMEDIATE wires for different types of immediates
    wire [31:0]  IMMI_temp ;
    wire [31:0]  IMMJ_temp;
    wire [31:0]  IMMB_temp;
    wire [31:0]  IMMU_temp;
    
    // ASSIGNING I-TYPE IMMEDIATE
    assign IMMI_temp =  (INSTR_i[14:12] == 3'd1 | INSTR_i[14:12] == 3'd5) ? {{26{1'b0}},INSTR_i[24:20]} :
                        (INSTR_i[6:0] == 7'b1100111) ?  {INSTR_i[31], {19{1'b0}},INSTR_i[31:20]} :
                        (INSTR_i[6:0] == 7'b0000011 | INSTR_i[14:12] == 3'd3 | INSTR_i[14:12] == 3'd4 | INSTR_i[14:12] ==3'd6 | INSTR_i[14:12] ==3'd7) ? {{20{1'b0}}, INSTR_i[31:20]} : {INSTR_i[31], {19{1'b0}},INSTR_i[31:20]};

    // ASSIGNING B-TYPE IMMEDIATE
    assign IMMB_temp = (INSTR_i[14:12] == 3'd6 | INSTR_i[14:12] == 3'd7) ?  ({20'b0,INSTR_i[31],INSTR_i[7],INSTR_i[30:25],INSTR_i[11:8]}) : ({INSTR_i[31],19'b0,INSTR_i[31],INSTR_i[7],INSTR_i[30:25],INSTR_i[11:8]});
    
    // ASSIGNING J-TYPE IMMEDIATE
    assign IMMJ_temp = {INSTR_i[31], 11'd0, INSTR_i[19:12], INSTR_i[20], INSTR_i[30:21], 1'b0} ; 
    
    // ASSIGNING U-TYPE IMMEDIATE
    assign IMMU_temp = (INSTR_i[6:0] == 7'b010111)?  ( ({INSTR_i[31], 11'd0, INSTR_i[31:12]} << 12) + PC_i  ) : ({INSTR_i[31], 11'd0, INSTR_i[31:12]} << 12 ) ;
    
    
    // ROUTING the IMMEDIATES to OUTPUT
    assign EXTND_IMM_o = (IMM_SRC == 2'b00) ? IMMI_temp :
                         (IMM_SRC == 2'b10) ? IMMB_temp :
                         (IMM_SRC == 2'b11) ? IMMJ_temp : 
                         (IMM_SRC == 2'b01) ? IMMU_temp : 31'd0 ;
    
 
    
endmodule
