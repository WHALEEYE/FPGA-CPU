`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/26 00:01:27
// Design Name: 
// Module Name: Decoder_sim
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


module idcode32_sim( );
    // input 
    reg[31:0]  Instruction;
    reg[31:0]  read_data;
    reg[31:0]  ALU_result;
    reg        Jal; 
    reg        RegWrite;
    reg        MemtoReg;
    reg        RegDst;
    reg        clock,reset;
    reg[31:0]  opcplus4;      // from ifetch link_address
    // output
    wire[31:0] read_data_1;
    wire[31:0] read_data_2;
    wire[31:0] imme_extend;

Idecode32 idecoder_uut1(
        .read_data_1(read_data_1),
        .read_data_2(read_data_2),
        .Instruction(Instruction),
        .read_data(read_data),
        .ALU_result(ALU_result),
        .Jal(Jal),
        .RegWrite(RegWrite),
        .MemtoReg(MemtoReg),
        .RegDst(RegDst),
        .imme_extend(imme_extend),
        .clock(clock),
        .reset(reset),
        .opcplus4(opcplus4));
    
    Idecode32 Uid(.read_data_1(read_data_1),.read_data_2(read_data_2),.Instruction(Instruction),.read_data(read_data),.ALU_result(ALU_result),
                     .Jal(Jal),.RegWrite(RegWrite),.MemtoReg(MemtoReg),.RegDst(RegDst),.imme_extend(imme_extend),.clock(clock),.reset(reset),
                     .opcplus4(opcplus4));

    initial begin
end
endmodule
