`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2024 11:45:51
// Design Name: 
// Module Name: DECODE_cycle
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


module DECODE_cycle(
        output  [4:0]   RD_E_o,
        output          REGWRT_E_o,
        output  [1:0]   JUMP_E_o,
        output  [2:0]   BRANCH_E_o,
        output  [1:0]   RSLTSRC_E_o,
        output          MEMWRT_E_o,
        output  [3:0]   ALUCTRL_E_o,
        output          ALUSRC_E_o,
        output  [31:0]  RD1_E_o,
        output  [31:0]  RD2_E_o,
        output  [4:0]  RS1_E_o, RD1_H_o,
        output  [4:0]  RS2_E_o, RD2_H_o,
        output  [31:0]  PC_E_o,
        output  [31:0]  IMM_E_o,
        output  [31:0]  PCPLUS4_E_o,
        
        input           clk_i, rst_i, REG_WRT_E_i, ENA_H_i, CLR_H_i,
        input   [31:0]  INSTR_D_i, PC_D_i, PCPLUS4_D_i, RESLT_DATA_W_i,
        input   [4:0]   RESLT_ADDR_W_i
    );
    
    wire [31:0] rd1_t, rd2_t, immgen_t ;
    wire [1:0] rslt_t, jump_t, immsrc_t;
    wire       alusrc_t ;
    wire [4:0] rd_t, rd_addr1_t, rd_addr2_t ;
    wire        memwrt_t, regwrt_t ;
    wire [3:0] aluctrl_t ;
    wire [6:0] op_code_t, fucnt7_t ;
    wire [2:0] funct3_t, branch_t ;
    
    reg  [31:0] RD1_reg , RD2_reg, IMMGEN_reg, PC_reg, PCPLUS4_reg ;
    reg  [1:0]  RSLTSRC_reg, JUMP_reg ;
    reg  [2:0]  BRANCH_reg ;
    reg         MEMWRT_reg, REGWRT_reg, ALUSRC_reg ;
    reg  [3:0]  ALUCTRL_reg ;
    reg  [4:0]  RD_reg, RS1_reg, RS2_reg ;
    
    assign op_code_t = INSTR_D_i[6:0] ;
    assign funct3_t = INSTR_D_i[14:12] ;
    assign funct7_t = INSTR_D_i[30] ;
    assign rd_t     = INSTR_D_i[11:7] ;
    
    Control_Unit ctrl_unit_inst(
                  .JUMP_o(jump_t),
                  .BRANCH_o(branch_t),
                  .RSLT_o(rslt_t),             // CONTROL SIGNAL for WRITE-BACK MUX
                  .MEM_WRT_o(memwrt_t),          // CONTROL SIGNAL for DATA-MEMORY WRITE ENABLE
                  .ALU_SRC_o(alusrc_t),          // CONTROL SIGNAL for ALU-SOURCE OPERAND 2
                  .IMM_SRC_o(immsrc_t),          // CONTROL SIGNAL for IMMEDIATE GENERATOR
                  .REG_WRT_o(regwrt_t),          // CONTROL SIGNAL for WRITE ENABLE of REG-FILE
                  .ALU_CTRL_o(aluctrl_t),         // CONTROL SIGNAL for ALU OPERATION
                  .OP_CD_i(op_code_t),            // OP CODE INPUT
                  .FUNCT3_i(funct3_t),           // FUNCT-3 INPUT from INSTR-MEM
                  .FUNCT7_i(funct7_t) 
     );
    
    
    assign rd_addr1_t = INSTR_D_i[19:15] ;
    assign rd_addr2_t = INSTR_D_i[24:20] ;
    
    REG_File reg_file_inst(
                .RD_DATA1_o(rd1_t),             //  DATA from SOURCE REG 1
                .RD_DATA2_o(rd2_t),             //  DATA from SOURCE REG 2
                .WRT_DATA_i(RESLT_DATA_W_i),             // DATA to WRITE into the DESTINATION REGISTER
                .RD_ADDR1_i(rd_addr1_t),             // ADDRESS of SOURCE 1
                .RD_ADDR2_i(rd_addr2_t),             // ADDRESS of SOURCE 2
                .WRT_ADDR_i(RESLT_ADDR_W_i),             // ADDRESS of DESTINATION REG
                .WRT_ENA_i(REG_WRT_E_i),              // ENABLE control signal to WRITE data into the REGISTER FILE
                .clk_i(clk_i),
                .rst_i(rst_i)
    );
    
    
    IMMEDIATE_GEN imm_gen_inst(
                .INSTR_i(INSTR_D_i),          // INPUT INSTRUCTION
                .IMM_SRC(immsrc_t),          // CONTROL signal from CONTROL UNIT
                .PC_i(PC_D_i),             // PROGRAM COUNTER input 
                .EXTND_IMM_o(immgen_t)
    );
    
    
    always@(posedge clk_i , negedge rst_i) begin
            if(!rst_i | ENA_H_i | CLR_H_i) begin
                  RD1_reg <= 32'b0 ;
                  RD2_reg <= 32'b0 ; 
                  IMMGEN_reg <= 32'b0 ; 
                  PC_reg <= 32'b0 ; 
                  PCPLUS4_reg <= 32'b0 ;
                  RSLTSRC_reg <= 2'b0 ; 
                  JUMP_reg <= 2'b0 ; 
                  BRANCH_reg <= 2'b0 ;  
                  MEMWRT_reg <= 1'b0 ; 
                  REGWRT_reg <= 1'b0 ;
                  ALUCTRL_reg <= 4'b0 ;
                  ALUSRC_reg <= 1'b0;
                  RD_reg <= 5'b0 ;
                  RS1_reg <= 5'b0 ;
                  RS2_reg <= 5'b0 ;
            end
            else begin
                 
                  RD1_reg <= rd1_t ;
                  RD2_reg <= rd2_t ;
                  IMMGEN_reg <= immgen_t ;
                  PC_reg <= PC_D_i ;
                  PCPLUS4_reg <= PCPLUS4_D_i ;
                  RSLTSRC_reg <= rslt_t ;
                  JUMP_reg <= jump_t ;
                  BRANCH_reg <= branch_t ;
                  MEMWRT_reg <= memwrt_t ;
                  REGWRT_reg <= regwrt_t ;
                  ALUCTRL_reg <= aluctrl_t ;
                  ALUSRC_reg <= alusrc_t ;
                  RD_reg <= rd_t ;
                  RS1_reg <= INSTR_D_i[19:15] ;
                  RS2_reg <= INSTR_D_i[24:20] ;
                
            end    
    end
    
          assign  REGWRT_E_o = REGWRT_reg ;
          assign  JUMP_E_o   = JUMP_reg ;
          assign  BRANCH_E_o = BRANCH_reg ;
          assign  RSLTSRC_E_o = RSLTSRC_reg ;
          assign  MEMWRT_E_o = MEMWRT_reg ;
          assign  ALUCTRL_E_o = ALUCTRL_reg ;
          assign  ALUSRC_E_o = ALUSRC_reg ;
          assign  RD1_E_o = RD1_reg ;
          assign  RD2_E_o = RD2_reg ;
          assign  PC_E_o  = PC_reg ;
          assign  IMM_E_o = IMMGEN_reg ;
          assign  PCPLUS4_E_o = PCPLUS4_reg ;
          assign  RD_E_o  =  RD_reg ;
          assign  RS1_E_o = RS1_reg ;
          assign  RS2_E_o = RS2_reg ;
          assign  RD1_H_o = rd_addr1_t ;
          assign  RD2_H_o = rd_addr2_t ;
endmodule
