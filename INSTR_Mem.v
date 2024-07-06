`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2024 18:50:02
// Design Name: 
// Module Name: INSTR_Mem
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


module INSTR_Mem(
        output  [31:0]  RD_INSTR_o,         // MACHINE LEVEL INSTRUCTION OUTPUT
        input   [31:0]  ADDR_i,             // INPUT address of INSTRUCTION from PC
        input           rst_i               // RESET sginal
    );
        
        // DECLARING the INSTRUCTION MEMORY
        reg [31:0] instr_mem  [31:0] ;
        

        
        // ASSIGNING  the MACHINE INSTRUCTION to OUT signal
        assign RD_INSTR_o = (rst_i == 1'b0) ?  32'h00000000  :  instr_mem[ADDR_i] ;       
        




    // ASSIGNING random INPUT VALUES for SIMULATION based VERIFICATION
    initial begin
    
            //$readmemh("memfile.hex",instr_mem) ;
            instr_mem[0] <= /*32'h00500293;*//* 32'h00500213*/ 32'h0032A383 ;
            instr_mem[4] <= /*32'h00300313 ;*/ /*32'h00300293*/ 32'h00338433;
            instr_mem[8] <= /*32'h006283B3 ;*/ /*32'h00200193*/ 32'h00736133 ;
           // instr_mem[12] <= 32'h00400113 ;
            instr_mem[12] <= /*32'h00002403 ;*/ /*32'h00520433*/ 32'h402381B3  ;
           // instr_mem[16] <= /*32'h00100493 ;*/ 32'h40340133 ;
            //instr_mem[20] <= /*32'h00940533 ;*/ 32'h008364B3 ;
            //instr_mem[24] <= 32'h002473B3 ;
            /*
            instr_mem[4] <= 32'h12345297;
            instr_mem[16] <= 32'habcd1234;
            instr_mem[40] <= 32'hef123456; */
    end
    
endmodule
