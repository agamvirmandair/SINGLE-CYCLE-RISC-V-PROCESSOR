`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2024 09:40:03 PM
// Design Name: 
// Module Name: DataMem
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

// Module definition

module DataMem ( MemRead , MemWrite , addr , write_data , read_data );
input MemRead;
input MemWrite;
input [8:0] addr;
input [31:0] write_data;
output reg [31:0] read_data;

reg [31:0] data_memory [127:0];

always @(*)
begin
    if (MemRead)
    begin
        read_data <= data_memory[addr[8:2]];
    end
    else if (MemWrite)
    begin
        data_memory[addr[8:2]] <= write_data;
    end
end
endmodule

