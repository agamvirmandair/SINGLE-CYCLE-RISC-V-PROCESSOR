`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2024 02:32:04 PM
// Design Name: 
// Module Name: Controller
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

module Controller (
Opcode ,
ALUSrc , MemtoReg , RegWrite , MemRead , MemWrite ,
ALUOp
);

input [6:0] Opcode;
output reg ALUSrc;
output reg MemtoReg;
output reg RegWrite;
output reg MemRead;
output reg MemWrite;
output reg [1:0] ALUOp;

always @(*)
begin
    case (Opcode)
    7'b0110011: 
    begin
        ALUSrc = 1'b0;
        MemtoReg = 1'b0;
        RegWrite = 1'b1;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        ALUOp = 2'b10;
    end
   7'b0010011: 
    begin
        ALUSrc = 1'b1;
        MemtoReg = 1'b0;
        RegWrite = 1'b1;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        ALUOp = 2'b00;
    end
    7'b0000011: 
    begin
        ALUSrc = 1'b1;
        MemtoReg = 1'b1;
        RegWrite = 1'b1;
        MemRead = 1'b1;
        MemWrite = 1'b0;
        ALUOp = 2'b01;
    end
    7'b0100011: 
    begin
        ALUSrc = 1'b1;
        MemtoReg = 1'b0;
        RegWrite = 1'b0;
        MemRead = 1'b0;
        MemWrite = 1'b1;
        ALUOp = 2'b01;
    end
    endcase
end
endmodule // Controller
