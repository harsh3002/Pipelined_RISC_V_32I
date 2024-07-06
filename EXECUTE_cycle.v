`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2024 21:07:12
// Design Name: 
// Module Name: EXECUTE_cycle
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


module EXECUTE_cycle(
        output          REGWRT_M_o,
        output  [1:0]   RSLTSRC_M_o, 
        output          MEMWRT_M_o,
        output  [31:0]  ALURSLT_M_o, PCTARGET_E_o,
        output  [31:0]  RD2_M_o,
        output  [31:0]  PCPLUS4_M_o,
        output  [1:0]   PCSRC_E_o,
        output  [4:0]   RD_M_o,
        output  [31:0]  IMM_M_o,
        
        input          REGWRT_E_i,
        input  [4:0]   RD_E_i,
        input  [1:0]   JUMP_E_i,
        input  [2:0]   BRANCH_E_i,
        input  [1:0]   RSLTSRC_E_i, FRWRDA_E_i, FRWRDB_E_i,
        input          MEMWRT_E_i,
        input  [3:0]   ALUCTRL_E_i,
        input          ALUSRC_E_i,
        input  [31:0]  RD1_E_i, RD2_E_i, IMM_E_i, PC_E_i, PCPLUS4_E_i, RSLT_W_i,
        input          clk_i , rst_i
    );
    
    reg         REGWRT_reg, MEMWRT_reg;
    reg [1:0]   RSLTSRC_reg;
    reg [4:0]   RD_reg ;
    reg [31:0]  ALURSLT_reg, RD2_reg, PCPLUS4_reg, IMM_reg ;
    wire        flg_zero_t, flg_neg_t ;
    wire [31:0] rslt_alu_t, rd2_t, oprnd1_t, oprnd2_t ;
    
    
    MUX3_1  oprnd1_inst(
                .A(RD1_E_i),
                .B(RSLT_W_i),
                .C(ALURSLT_M_o),
                .MUX_o(oprnd1_t),
                .SEL_i(FRWRDA_E_i)
    );
    
    MUX3_1  oprnd2_inst(
                .A(RD2_E_i),
                .B(RSLT_W_i),
                .C(ALURSLT_M_o),
                .MUX_o(oprnd2_t),
                .SEL_i(FRWRDB_E_i)
    );
    
    PC_SRC_CTRL  pcsrc_inst(
             .PC_SRC_o(PCSRC_E_o),
             .BRANCH_i(BRANCH_E_i),
             .JUMP_i(JUMP_E_i),
             .flg_zero_i(flg_zero_t), 
             .flg_neg_i(flg_neg_t)
    );
    
    
    ALU_RISC  alu_inst
   (            .result_o(rslt_alu_t),      
                .flg_zero_o(flg_zero_t),
                .flg_neg_o(flg_neg_t),
                .oprnd1_i(oprnd1_t),
                .oprnd2_i(rd2_t),
                .alu_ctrl_i(ALUCTRL_E_i)
    );
    
    MUX  alumux_inst(
                 .MUX_i0(oprnd2_t),
                 .MUX_i1(IMM_E_i),
                 .sel_i(ALUSRC_E_i),
                 .MUX_o(rd2_t)
    );
    
    PC_IMM_add  pc_imm_inst(
                 .PC_in(PC_E_i),
                 .IMM_in(IMM_E_i),
                 .PC_out(PCTARGET_E_o)
    );
    
    always@(posedge clk_i, negedge rst_i) begin
    
            if(!rst_i) begin
                  RD2_reg <= 32'b0 ; 
                  PCPLUS4_reg <= 32'b0 ;
                  RSLTSRC_reg <= 2'b0 ; 
                  MEMWRT_reg <= 1'b0 ; 
                  REGWRT_reg <= 1'b0 ;
                  RD_reg <= 5'b0 ;
                  ALURSLT_reg <= 32'b0 ;
                  IMM_reg <= 32'b0 ;
            end
            else begin
                  ALURSLT_reg <= rslt_alu_t ;
                  RD2_reg <= rd2_t ; 
                  PCPLUS4_reg <= PCPLUS4_E_i ;
                  RSLTSRC_reg <= RSLTSRC_E_i ; 
                  MEMWRT_reg <= MEMWRT_E_i ; 
                  REGWRT_reg <= REGWRT_E_i ;
                  RD_reg <= RD_E_i ;
                  IMM_reg  <= IMM_E_i ;
            end
    
    end
    
    assign REGWRT_M_o = REGWRT_reg ;
    assign MEMWRT_M_o = MEMWRT_reg ;
    assign RSLTSRC_M_o = RSLTSRC_reg ;
    assign ALURSLT_M_o = ALURSLT_reg ;
    assign RD2_M_o = RD2_reg ;
    assign PCPLUS4_M_o = PCPLUS4_reg ;
    assign RD_M_o = RD_reg ;
    assign IMM_M_o = IMM_reg ;
    
endmodule
