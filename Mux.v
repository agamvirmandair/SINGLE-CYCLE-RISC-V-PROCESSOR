`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2024 10:16:54 AM
// Design Name: 
// Module Name: mux21
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


module mux21(
    input S,
    input [31:0] D1,
    input[31:0] D2,
    output [31:0] Y
    );
    assign Y = (S == 1'b0) ? D1:
               (S == 1'b1) ? D2:
               32'bx;
    
endmodule