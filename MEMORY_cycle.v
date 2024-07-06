`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2024 16:33:27
// Design Name: 
// Module Name: MEMORY_cycle
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


module MEMORY_cycle(
            output          REGWRT_W_o,
            output  [1:0]   RSLTSRC_W_o,
            output  [31:0]  RD_DATA_W_o,
            output  [31:0]  IMM_W_o,
            output  [31:0]  PCPLUS4_W_o,
            output  [4:0]  RDM_W_o,
            output  [31:0] ALURSLT_W_o,
            
            input           clk_i, rst_i,
            input           REGWRT_M_i,
            input   [1:0]   RSLTSRC_M_i,
            input           MEMWRT_M_i,
            input   [31:0]  ALURSLT_M_i,
            input   [31:0]  RD2_M_i,
            input   [31:0]  IMM_M_i,
            input   [31:0]  PCPLUS4_M_i,
            input   [4:0]  RD_M_i
    );
    
        wire [31:0] rd_data_t ;
        reg  [31:0] RD_DATA_reg, IMM_reg, PCPLUS4_reg, ALURSLT_reg ;
        reg  [1:0]  RSLTSRC_reg ;
        reg         REGWRT_reg ;
        reg  [4:0]  RDM_reg ; 
         
         DATA_Mem  datamem_inst(
                     .clk_i(clk_i),                // CLOCK INPUT
                     .rst_i(rst_i),                // RESET INPUT
                     .WRT_DATA_i(RD2_M_i),           // DATA WRITE INPUT
                     .ADDR_i(ALURSLT_M_i),               // READ ADDRESS INPUT
                     .WRT_ENA_i(MEMWRT_M_i),            // WRITE ENABLE CONTROL
                     .RD_DATA_o(rd_data_t)             // OUTPUT READ DATA
    );   
            
        always@(posedge clk_i, negedge rst_i) begin
        
                if(!rst_i) begin
                        RSLTSRC_reg <= 2'b0 ; 
                        REGWRT_reg <= 1'b0 ;
                        RD_DATA_reg <= 32'b0 ;
                        IMM_reg <= 32'b0 ;
                        PCPLUS4_reg <= 32'b0 ;  
                        RDM_reg <= 32'b0 ; 
                        ALURSLT_reg <= 32'b0; 
                end
                else begin
                        RSLTSRC_reg <= RSLTSRC_M_i ; 
                        REGWRT_reg <= REGWRT_M_i ;
                        RD_DATA_reg <= rd_data_t ;
                        IMM_reg <= IMM_M_i ;
                        PCPLUS4_reg <= PCPLUS4_M_i ;  
                        RDM_reg <= RD_M_i ; 
                        ALURSLT_reg <= ALURSLT_M_i ;
                end
        end
          
          
          assign RSLTSRC_W_o = RSLTSRC_reg ; 
          assign REGWRT_W_o = REGWRT_reg ;
          assign RD_DATA_W_o = RD_DATA_reg ;
          assign IMM_W_o = IMM_reg ;
          assign PCPLUS4_W_o = PCPLUS4_reg ;  
          assign RDM_W_o = RDM_reg ; 
          assign ALURSLT_W_o = ALURSLT_reg ;
endmodule
