`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2024 18:14:20
// Design Name: 
// Module Name: PIPELINE_RISCV_top
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


module PIPELINE_RISCV_top(
    input clk_i,
    input rst_i
    );
    
    // INTERMEDIATE WIRE Declaration
    wire    [31:0]  INSTRF_top, PCF_top, PCD_top, PCPLUS4D_top, PCPLUS4F_top, PCPLUS4E_top, PCTARGETE_top, RD1D_top, RD2D_top, RD2E_top, IMMD_top, IMME_top, ALURSLTE_top ;
    wire    [1:0]   PCSRCE_top, JMPD_top, RSLTSRCD_top, RSLTSRCE_top, RSLTSRCM_top, FLUSH_top ; 
    wire    [2:0]   BRANCHD_top;
    wire    [3:0]   ALUCTRLD_top;
    wire    [4:0]   RDD_top, RDE_top, RDM_top, FRWRDA_top, FRWRDB_top, RS1E_top, RS2E_top, RD2_H_top, RD1_H_top ;
    wire            REGWRTD_top, REGWRTM_top, REGWRTE_top, MEMWRTD_top, MEMWRTE_top, ALUSRCD_top, STALL_top ;
    wire    [31:0]  RD_DATAM_top, IMM_M_top, PCPLUS4M_top, ALURSLTM_top, RSLTW_top ;
    
    
    //MODULE INSTANTIATION
        FETCH_CYCLE  fetch_inst(
                    .INSTR_D_o(INSTRF_top),
                    .PC_D_o(PCF_top), 
                    .PC_plus4_D_o(PCPLUS4F_top),
                    .ALU_PC_E_i(ALURSLTE_top), 
                    .PC_TARGET_E_i(PCTARGETE_top),
                    .PC_SRC_E_i(PCSRCE_top),
                    .ENA_H_i(STALL_top),
                    .CLR_H_i(FLUSH_top),
                    .clk_i(clk_i), 
                    .rst_i(rst_i)
    );
    
        DECODE_cycle    decode_inst(
                    .RD_E_o(RDD_top),
                    .REGWRT_E_o(REGWRTD_top),
                    .JUMP_E_o(JMPD_top),
                    .BRANCH_E_o(BRANCHD_top),
                    .RSLTSRC_E_o(RSLTSRCD_top),
                    .MEMWRT_E_o(MEMWRTD_top),
                    .ALUCTRL_E_o(ALUCTRLD_top),
                    .ALUSRC_E_o(ALUSRCD_top),
                    .RD1_E_o(RD1D_top),
                    .RS1_E_o(RS1E_top),
                    .RS2_E_o(RS2E_top),
                    .RD2_E_o(RD2D_top),
                    .RD1_H_o(RD1_H_top),
                    .RD2_H_o(RD2_H_top),
                    .PC_E_o(PCD_top),
                    .IMM_E_o(IMMD_top),
                    .PCPLUS4_E_o(PCPLUS4D_top),
        
                    .clk_i(clk_i), 
                    .rst_i(rst_i), 
                    .ENA_H_i(STALL_top),
                    .CLR_H_i(FLUSH_top),
                    .REG_WRT_E_i(REGWRTM_top),
                    .INSTR_D_i(INSTRF_top), 
                    .PC_D_i(PCF_top), 
                    .PCPLUS4_D_i(PCPLUS4F_top), 
                    .RESLT_DATA_W_i(RSLTW_top),
                    .RESLT_ADDR_W_i(RDM_top)
    );
        
            Hazard_Unit  hazard_inst (
                        .STALL_o(STALL_top),
                        .FLUSH_o(FLUSH_top),
                        .FRWRD_A_E_o(FRWRDA_top), 
                        .FRWRD_B_E_o(FRWRDB_top),
                        .RSLTSRC_E_i(RSLTSRCD_top),
                        .PC_SRC_E_i(PCSRCE_top),
                        .RD1_D_i(RD1_H_top),
                        .RD2_D_i(RD2_H_top),
                        .RD_E_i(RDD_top),
                        .REGWRT_M_i(REGWRTE_top), 
                        .REGWRT_W_i(REGWRTM_top), 
                        .rst_i(rst_i),
                        .RS1_E_i(RS1E_top), 
                        .RS2_E_i(RS2E_top),
                        .RDW_i(RDM_top), 
                        .RDM_i(RDE_top) 
    );
    
    
            EXECUTE_cycle   exe_inst(
                        .REGWRT_M_o(REGWRTE_top),
                        .RSLTSRC_M_o(RSLTSRCE_top),
                        .MEMWRT_M_o(MEMWRTE_top),
                        .ALURSLT_M_o(ALURSLTE_top), 
                        .PCTARGET_E_o(PCTARGETE_top),
                        .RD2_M_o(RD2E_top),
                        .PCPLUS4_M_o(PCPLUS4E_top),
                        .PCSRC_E_o(PCSRCE_top),
                        .RD_M_o(RDE_top),
                        .IMM_M_o(IMME_top),
        
                        .REGWRT_E_i(REGWRTD_top),
                        .RD_E_i(RDD_top),
                        .JUMP_E_i(JMPD_top),
                        .BRANCH_E_i(BRANCHD_top),
                        .RSLTSRC_E_i(RSLTSRCD_top),
                        .MEMWRT_E_i(MEMWRTD_top),
                        .ALUCTRL_E_i(ALUCTRLD_top),
                        .ALUSRC_E_i(ALUSRCD_top),
                        .RD1_E_i(RD1D_top), 
                        .RD2_E_i(RD2D_top),
                        .FRWRDA_E_i(FRWRDA_top),
                        .FRWRDB_E_i(FRWRDB_top),
                        .RSLT_W_i(RSLTW_top), 
                        .IMM_E_i(IMMD_top), 
                        .PC_E_i(PCD_top), 
                        .PCPLUS4_E_i(PCPLUS4D_top),
                        .clk_i(clk_i) , 
                        .rst_i(rst_i)
                    );
                    
             
             MEMORY_cycle   mem_inst(
                        .REGWRT_W_o(REGWRTM_top),
                        .RSLTSRC_W_o(RSLTSRCM_top),
                        .RD_DATA_W_o(RD_DATAM_top),
                        .IMM_W_o(IMM_M_top),
                        .PCPLUS4_W_o(PCPLUS4M_top),
                        .RDM_W_o(RDM_top),
                        .ALURSLT_W_o(ALURSLTM_top),
            
                        .clk_i(clk_i), 
                        .rst_i(rst_i),
                        .REGWRT_M_i(REGWRTE_top),
                        .RSLTSRC_M_i(RSLTSRCE_top),
                        .MEMWRT_M_i(MEMWRTE_top),
                        .ALURSLT_M_i(ALURSLTE_top),
                        .RD2_M_i(RD2E_top),
                        .IMM_M_i(IMME_top),
                        .PCPLUS4_M_i(PCPLUS4E_top),
                        .RD_M_i(RDE_top)
    );
             
             
             WRTBACK_cycle  wrt_back_inst(
                        .RSLT_W_o(RSLTW_top),
                
                        .RSLTSRC_W_i(RSLTSRCM_top),
                        .RD_DATA_W_i(RD_DATAM_top),
                        .ALURSLT_W_i(ALURSLTM_top),
                        .IMM_W_i(IMM_M_top),
                        .PCPLUS4_W_i(PCPLUS4M_top)
    );
             
endmodule
