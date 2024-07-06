`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2024 17:37:06
// Design Name: 
// Module Name: FETCH_CYCLE
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


module FETCH_CYCLE(
        output [31:0]   INSTR_D_o, PC_D_o, PC_plus4_D_o,
        input  [31:0]   ALU_PC_E_i, PC_TARGET_E_i,
        input  [1:0]    PC_SRC_E_i, 
        input           ENA_H_i, CLR_H_i,
        input           clk_i, rst_i
    );
    
    
    wire [31:0] PC_plus4_fch_temp, PC_SRC_o_fch, PC_o_fch, INSTR_o_fch ;
    reg  [31:0] INSTR_reg_temp, PC_reg_temp, PC_plus4_reg_temp ;
    
    PC_SRC_mux PC_MUX_inst (
            .PC_o(PC_SRC_o_fch),                         
            .PC_IMM_i(PC_TARGET_E_i),
            .PC_i(PC_plus4_fch_temp),
            .ALU_OUT_i(ALU_PC_E_i),    
            .PC_SRC_i(PC_SRC_E_i)
    );
    
    PRGM_COUNTER pc_inst(
             .PC_o(PC_o_fch),                
             .clk_i(clk_i),
             .ENA_H_i(ENA_H_i),
             .rst_i(rst_i),           
             .PC_NXT_i(PC_SRC_o_fch)
    );
    
    INSTR_Mem instr_mem_inst(
            .RD_INSTR_o(INSTR_o_fch),         
            .ADDR_i(PC_o_fch),             
            .rst_i(rst_i)
    );
    
    PC_NEXT pc_nxt_inst(
            .PC_i(PC_o_fch),
            .PC_temp(32'd4),
            .PC_NXT_o(PC_plus4_fch_temp)
    );
    
    
    always@(posedge clk_i, negedge rst_i) begin
            if(!rst_i | CLR_H_i) begin
                INSTR_reg_temp <= 32'h0;
                PC_reg_temp    <= 32'h0;
                PC_plus4_reg_temp <= 32'h0;
            end
            else begin
                if(!ENA_H_i) begin
                    INSTR_reg_temp <= INSTR_o_fch ;
                    PC_reg_temp    <= PC_o_fch ;
                    PC_plus4_reg_temp <= PC_plus4_fch_temp ;
                end
            end            
    end
    
    assign INSTR_D_o = INSTR_reg_temp ;
    assign PC_D_o    = PC_reg_temp ;
    assign PC_plus4_D_o = PC_plus4_reg_temp ;
    
endmodule
