`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2024 06:11:05 PM
// Design Name: 
// Module Name: processor
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

module processor
(
input clk , reset ,
output [31:0] Result
);

wire [6:0] funct7;
wire [2:0] funct3;
wire [3:0] ALU_CC;
wire [6:0] opcode;
wire [1:0] aluop;
wire memwrite;
wire memtoreg;
wire memread;
wire alusrc;
wire regwrite;

data_path dp(.opcode(opcode), .funct3(funct3), .funct7(funct7), .alu_cc(ALU_CC), .clk(clk), .reset(reset), .alu_result(Result), .mem2reg(memtoreg), .mem_read(memread), .mem_write(memwrite), .alu_src(alusrc), .reg_write(regwrite));
Controller con(.Opcode(opcode), .ALUSrc(alusrc), .RegWrite(regwrite), .MemWrite(memwrite), .MemRead(memread), .MemtoReg(memtoreg), .ALUOp(aluop));
ALUController alucon(.ALUOp(aluop), .Funct3(funct3), .Funct7(funct7), .Operation(ALU_CC));

endmodule // processor
