`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/12 21:26:23
// Design Name:
// Module Name: CPU
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


module CPU(io_input, io_output, LEDCtrl, SwitchCtrl, TubeCtrl, clkin, reset);
input             clkin;
input   [31:0]    io_input;
input             reset;
output  [31:0]    io_output;
output            LEDCtrl, SwitchCtrl, TubeCtrl;

//module clock
wire              clock;

//module IO
//output
wire    [31:0]    io_write_data, io_read_data;

//module ifetch
//output
wire    [31:0]    Instruction, branch_base_addr, link_addr;

//module control
//output
wire              Jr, RegDST, ALUSrc, MemtoReg, RegWrite, MemWrite, Branch, nBranch, Jmp, Jal, I_format, Sftmd;
wire    [1:0]     ALUOp;
//input
wire    [5:0]     Opcode, Function_opcode;
assign Opcode = Instruction[31:26];
assign Function_opcode = Instruction[5:0];

//module Decoder
//output
wire              read_data_1, read_data_2;
wire              Pause;
wire              IORead, IOWrite, output_mode;

//module ALU
//output
wire              Zero;
wire    [31:0]    Addr_result, ALU_result, imme_extend;
//input
wire    [4:0]     Shamt;
assign Shamt = Instruction[10:6];

//module RAM
//output
wire    [31:0]    read_data;

Clock cpu_clk(clkin, clock);
MemOrIO cpu_io(IORead, IOWrite, io_input, io_write_data, io_read_data, io_output, output_mode, LEDCtrl, SwitchCtrl, TubeCtrl);

Ifetc32 cpu_ifetch(Instruction, branch_base_addr, Addr_result, read_data_1, Branch, nBranch, Jmp, Jal, Jr, Zero, clock, reset, link_addr, Pause);

control32 cpu_ctrl(Opcode, Function_opcode, Jr, RegDST, ALUSrc, MemtoReg, RegWrite,
                   MemWrite, Branch, nBranch, Jmp, Jal, I_format, Sftmd, ALUOp);

Idecode32 cpu_decoder(read_data_1, read_data_2, Instruction, read_data, ALU_result, Jal, RegWrite, MemtoReg, RegDST,
                      imme_extend, clock, reset, link_addr, io_write_data, io_read_data, output_mode, IORead, IOWrite, Pause);

Executs32 cpu_alu(read_data_1, read_data_2, imme_extend, Function_opcode, Opcode, ALUOp,
                  Shamt, ALUSrc, I_format, Zero, Sftmd, ALU_result, Addr_result, branch_base_addr, Jr);

dmemory32 cpu_ram(read_data, ALU_result, read_data_2, MemWrite, clock);

endmodule
