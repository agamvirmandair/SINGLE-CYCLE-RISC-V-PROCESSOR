`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2024 10:29:58 PM
// Design Name: 
// Module Name: Datapath
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
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2024 10:29:58 PM
// Design Name: 
// Module Name: Datapath
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

module data_path #(
parameter PC_W = 8 , // Program Counter
parameter INS_W = 32 , // Instruction Width
parameter RF_ADDRESS = 5 , // Register File Address
parameter DATA_W = 32 , // Data WriteData
parameter DM_ADDRESS = 9 , // Data Memory Address
parameter ALU_CC_W = 4 // ALU Control Code Width
)(
input clk , // CLK in Datapath figure
input reset , // Reset in Datapath figure
input reg_write , // RegWrite in Datapath figure
input mem2reg , // MemtoReg in Datapath figure
input alu_src , // ALUSrc in Datapath figure
input mem_write , // MemWrite in Datapath Figure
input mem_read , // MemRead in Datapath Figure
input [ ALU_CC_W -1:0] alu_cc , // ALUCC in Datapath Figure
output [6:0] opcode , // opcode in Datapath Figure
output [6:0] funct7 , // Funct7 in Datapath Figure
output [2:0] funct3 , // Funct3 in Datapath Figure
output [ DATA_W -1:0] alu_result // Datapath_Result in Datapath Figure
);

wire [PC_W-1:0] program_counter_input;
wire [PC_W-1:0] program_counter_output;
wire [INS_W-1:0] instruction_output;
wire [DATA_W-1:0] Mux1_result;
wire carry_dp;
wire overflow_dp;
wire zero_dp;
wire [DATA_W-1:0] data_mem_output;
wire [RF_ADDRESS-1:0] rd_rg_wrt_wire;
wire [RF_ADDRESS-1:0] rd_rg_addr_wire1;
wire [RF_ADDRESS-1:0] rd_rg_addr_wire2;
wire [DM_ADDRESS-1:0] address;
wire [DATA_W-1:0] rd_rg_data1;
wire [DATA_W-1:0] rd_rg_data2;
wire [DATA_W-1:0] Immout;
wire [DATA_W-1:0] Mux2_result;

    
// Program Counter
FlipFlop pc(
    .clk(clk), 
    .reset(reset), 
    .d(program_counter_input), 
    .q(program_counter_output)
);

assign program_counter_input = program_counter_output + 8'b00000100;

// Instruction Memory
InstMem inst_mem(
    .addr(program_counter_output), 
    .instruction(instruction_output)
);

// Instruction fields extraction
assign rd_rg_wrt_wire = instruction_output[11:7];
assign rd_rg_addr_wire1 = instruction_output[19:15];
assign rd_rg_addr_wire2 = instruction_output[24:20];
assign funct7 = instruction_output[31:25];
assign funct3 = instruction_output[14:12];
assign opcode = instruction_output[6:0];
assign address = alu_result[8:0];

mux21 firstmux(
    .S(alu_src),
    .D1(rd_rg_data2),
    .D2(Immout),
    .Y(Mux1_result)
);

mux21 secondmux(
    .S(mem2reg),
    .D1(alu_result),
    .D2(data_mem_output),
    .Y(Mux2_result)
);


ImmGen imm_gen(
    .InstCode(instruction_output), 
    .ImmOut(Immout)
);

ALU_32 alu(
    .A_in(rd_rg_data1), 
    .B_in(Mux1_result), 
    .Carry_Out(carry_dp), 
    .Overflow(overflow_dp), 
    .Zero(zero_dp), 
    .ALU_Sel(alu_cc), 
    .ALU_Out(alu_result)
);

// Data Memory
DataMem data_mem(
    .MemRead(mem_read), 
    .MemWrite(mem_write), 
    .addr(address), 
    .write_data(rd_rg_data2), 
    .read_data(data_mem_output)
);

RegFile reg_file(
    .clk(clk), 
    .reset(reset), 
    .rg_wrt_en(reg_write), 
    .rg_wrt_addr(rd_rg_wrt_wire), 
    .rg_rd_addr1(rd_rg_addr_wire1), 
    .rg_rd_addr2(rd_rg_addr_wire2), 
    .rg_wrt_data(Mux2_result), 
    .rg_rd_data1(rd_rg_data1), 
    .rg_rd_data2(rd_rg_data2)
);

endmodule