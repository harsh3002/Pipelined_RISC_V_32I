`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2024 19:01:22
// Design Name: 
// Module Name: REG_File
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


module REG_File(
        output  [31:0]  RD_DATA1_o,             //  DATA from SOURCE REG 1
        output  [31:0]  RD_DATA2_o,             //  DATA from SOURCE REG 2
        output reg [31:0]  WRT_MEM_o,
        
        input   [31:0]  WRT_DATA_i,             // DATA to WRITE into the DESTINATION REGISTER
        input   [4:0]   RD_ADDR1_i,             // ADDRESS of SOURCE 1
        input   [4:0]   RD_ADDR2_i,             // ADDRESS of SOURCE 2
        input   [4:0]   WRT_ADDR_i,             // ADDRESS of DESTINATION REG
        input           WRT_ENA_i,              // ENABLE control signal to WRITE data into the REGISTER FILE
        input           clk_i, rst_i            // CLOCK & RESET signal
    );
    
    
    // DECLARING the REGISTER FILE
    reg [31:0] reg_file_mem [31:0] ;
    
    always@(negedge clk_i) begin
       /* if(!rst_i) begin                          // RESETTING the FILE 
            reg_file_mem[0] <= 32'h00000000 ; 
            reg_file_mem[1] <= 32'h00000000 ;
            reg_file_mem[2] <= 32'h00000000 ;
            reg_file_mem[3] <= 32'h00000000 ;
            reg_file_mem[4] <= 32'h00000000 ;
            reg_file_mem[5] <= 32'h00000000 ;
            reg_file_mem[6] <= 32'h00000000 ;
            reg_file_mem[7] <= 32'h00000000 ;
            reg_file_mem[8] <= 32'h00000000 ;
            reg_file_mem[9] <= 32'h00000000 ;
            reg_file_mem[10] <= 32'h00000000 ;
            reg_file_mem[11] <= 32'h00000000 ;
            reg_file_mem[12] <= 32'h00000000 ;
            reg_file_mem[13] <= 32'h00000000 ;
            reg_file_mem[14] <= 32'h00000000 ;
            reg_file_mem[15] <= 32'h00000000 ;
            reg_file_mem[16] <= 32'h00000000 ;
            reg_file_mem[17] <= 32'h00000000 ;
            reg_file_mem[18] <= 32'h00000000 ;
            reg_file_mem[19] <= 32'h00000000 ;
            reg_file_mem[20] <= 32'h00000000 ;
            reg_file_mem[21] <= 32'h00000000 ;
            reg_file_mem[22] <= 32'h00000000 ;
            reg_file_mem[23] <= 32'h00000000 ;
            reg_file_mem[24] <= 32'h00000000 ;
            reg_file_mem[25] <= 32'h00000000 ;
            reg_file_mem[26] <= 32'h00000000 ;
            reg_file_mem[27] <= 32'h00000000 ;
            reg_file_mem[28] <= 32'h00000000 ;
            reg_file_mem[29] <= 32'h00000000 ;
            reg_file_mem[30] <= 32'h00000000 ;
            reg_file_mem[31] <= 32'h00000000 ;                                  
        end */
      
            if(WRT_ENA_i & (WRT_ADDR_i != 5'h00))
                reg_file_mem[WRT_ADDR_i] = WRT_DATA_i ;
        
        WRT_MEM_o = reg_file_mem[WRT_ADDR_i] ;
    end
    
   
    
    // ASSIGNING DATA FROM REG FILE TO OUTPUT LINES
    assign RD_DATA1_o = (rst_i == 1'b0) ?  32'h00000000  :  reg_file_mem[RD_ADDR1_i] ;
    assign RD_DATA2_o = (rst_i == 1'b0) ?  32'h00000000  :  reg_file_mem[RD_ADDR2_i] ;
    
    // RANDOM VALUES FOR SIM- BASED VERIFICATION
    initial begin
            reg_file_mem[0] <= 32'd0 ;
            reg_file_mem[6] <= 32'd6 ;
            reg_file_mem[3] <= 32'd3 ;
            reg_file_mem[2] <= 32'h00000002;
            reg_file_mem[5] <= 32'h00000003;
            reg_file_mem[7] <= 32'h00000000;
            reg_file_mem[8] <= 32'h00000000;
            reg_file_mem[9] <= 32'h00000000;
            reg_file_mem[10] <= 32'h00000000;
    end
    
endmodule
