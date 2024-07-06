`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2024 19:20:24
// Design Name: 
// Module Name: DATA_Mem
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


module DATA_Mem(
    input         clk_i,                // CLOCK INPUT
    input         rst_i,                // RESET INPUT
    input  [31:0] WRT_DATA_i,           // DATA WRITE INPUT
    input  [31:0] ADDR_i,               // READ ADDRESS INPUT
    input         WRT_ENA_i,            // WRITE ENABLE CONTROL
    output [31:0] RD_DATA_o             // OUTPUT READ DATA
    );
    
    // DECLARING MEMORY 
    reg [31:0]  data_mem  [31:0] ;
    
    // ASSIGNING READ DATA OUTPUT
    assign RD_DATA_o = (rst_i == 1'b0) ?  32'h00000000  :  data_mem[ADDR_i] ;
    
    // SYNCHRONOUS DATA WRITE OPERATION
    always@(posedge clk_i) begin
       /*if(!rst_i) begin                               // RESETTING THE MEMORY
            data_mem[0] <= 32'h00000000 ; 
            data_mem[1] <= 32'h00000000 ;
            data_mem[2] <= 32'h00000000 ;
            data_mem[3] <= 32'h00000000 ;
            data_mem[4] <= 32'h00000000 ;
            data_mem[5] <= 32'h00000000 ;
            data_mem[6] <= 32'h00000000 ;
            data_mem[7] <= 32'h00000000 ;
            data_mem[8] <= 32'h00000000 ;
            data_mem[9] <= 32'h00000000 ;
            data_mem[10] <= 32'h00000000 ;
            data_mem[11] <= 32'h00000000 ;
            data_mem[12] <= 32'h00000000 ;
            data_mem[13] <= 32'h00000000 ;
            data_mem[14] <= 32'h00000000 ;
            data_mem[15] <= 32'h00000000 ;
            data_mem[16] <= 32'h00000000 ;
            data_mem[17] <= 32'h00000000 ;
            data_mem[18] <= 32'h00000000 ;
            data_mem[19] <= 32'h00000000 ;
            data_mem[20] <= 32'h00000000 ;
            data_mem[21] <= 32'h00000000 ;
            data_mem[22] <= 32'h00000000 ;
            data_mem[23] <= 32'h00000000 ;
            data_mem[24] <= 32'h00000000 ;
            data_mem[25] <= 32'h00000000 ;
            data_mem[26] <= 32'h00000000 ;
            data_mem[27] <= 32'h00000000 ;
            data_mem[28] <= 32'h00000000 ;
            data_mem[29] <= 32'h00000000 ;
            data_mem[30] <= 32'h00000000 ;
            data_mem[31] <= 32'h00000000 ;
        end
        else */ 
            if(WRT_ENA_i)                                   //WRITE OPERATION 
                data_mem[ADDR_i] <= WRT_DATA_i ;
       
    end
    
    // RANDOM INITIALISATION for SIMULATION based VERIFICATION
    initial begin
            data_mem[6] <= 32'h00000007;
                      data_mem[3] <= 32'h00000000;
            data_mem[1] <= 32'h00000000;
  
    end
    
    
endmodule
