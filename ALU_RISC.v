`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2024 17:20:41
// Design Name: 
// Module Name: ALU_RISC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: This ALU is designed for 32 bit operations which includes 
//                      10 main operations : 
//                      1) ADDITION
//                      2) SUBTRACTION
//                      3) BITWISE AND(&)
//                      4) BITWISE OR(|)
//                      5) SET LESS THAN(slt)
//                      6) SET LESS THAN[UNSIGNED]
//                      7) BITWISE XOR 
//                      8) SHIFT LEFT LOGICAL
//                      9) SHIFT RIGHT LOGICAL
//                     10) SHIFT RIGHT ARIHTEMATIC
//////////////////////////////////////////////////////////////////////////////////


module ALU_RISC #( parameter D_WIDTH = 32)   // Declaring parameters e.g. Width of data, Width of ALU control signal.
  
  // Declaration of INPUT and OUTPUT Ports.
   (output [D_WIDTH-1:0]    result_o,       // OUTPUT
   
   // FLAGS Declaration 
    output                  flg_zero_o,
    output                  flg_neg_o,
    
    // INPUTS and CONTROL signals
    input  [D_WIDTH-1:0]    oprnd1_i,
    input  [D_WIDTH-1:0]    oprnd2_i,
    input  [3:0]            alu_ctrl_i   
    );
     
    reg [D_WIDTH-1:0]   result_temp; 
     
    always@(*) begin
        case(alu_ctrl_i) 
                4'b000_0 : result_temp = oprnd1_i + oprnd2_i ;                                  //Result of ADDITION
                4'b000_1 : result_temp = oprnd1_i - oprnd2_i ;                                  //Result of SUBTRACTION
                4'b001_0 : result_temp = oprnd1_i << oprnd2_i ;                                 //Result of LOGICAL LEFT SHIFT operation
                4'b010_0 : result_temp = (oprnd1_i[31] > oprnd2_i[31])? 1'b1 : 
                                         (oprnd1_i[31] < oprnd2_i[31])? 1'b0 :
                                         (oprnd1_i[30:0] < oprnd2_i[30:0])? 1'b1 : 1'b0 ;       //Result of SLT operation
                4'b011_0 : result_temp = (oprnd1_i < oprnd2_i) ;                                //Result of SLT operation(unsigned)
                4'b100_0 : result_temp = oprnd1_i ^ oprnd2_i ;                                  //Store XOR result
                4'b101_0 : result_temp = oprnd1_i >> oprnd2_i ;                                 //Result of LOGICAL RIGHT SHIFT operation
                4'b101_1 : result_temp = oprnd1_i >>> oprnd2_i ;                                //Result of ARITHEMATIC RIGHT SHIFT operation
                4'b110_0 : result_temp = oprnd1_i | oprnd2_i ;                                  //Store OR result
                4'b111_0 : result_temp = oprnd1_i & oprnd2_i ;                                  // Store AND result 
                default         : result_temp = result_temp ;
        endcase
    end 
     
     
     //Calculation of STATUS FLAGS   
     //ZERO Flag              
     assign flg_zero_o = &(~result_o);   
     // NEGATIVE Flag
     assign flg_neg_o = (oprnd1_i < oprnd2_i) ;
     
     // ASSIGNING RESULT
     assign result_o = result_temp ;
   
     
endmodule
