`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/20 11:06:53
// Design Name: 
// Module Name: controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// O
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control32(Opcode, Function_opcode, Jr, RegDST, ALUSrc, MemtoReg, RegWrite,
                    MemWrite, Branch, nBranch, Jmp, Jal, I_format, Sftmd, ALUOp);
    input[5:0]  Opcode;
    input[5:0]  Function_opcode;
    output  Jr;
    output  RegDST;
    output  ALUSrc;
    output  MemtoReg;
    output  Jmp;
    output  Jal;
    output  Branch;
    output  nBranch;
    output  RegWrite;
    output  MemWrite;
    output  I_format;
    output  Sftmd;
    output[1:0]  ALUOp;

    wire R_format;


    assign Jr = ((Opcode == 6'b00_0000) && (Function_opcode == 6'b00_1000)) ? 1'b1 : 1'b0;
    assign Jmp = (Opcode == 6'b00_0010) ? 1'b1 : 1'b0;
    assign Jal = (Opcode == 6'b00_0011) ? 1'b1 : 1'b0;
    assign Branch = (Opcode == 6'b00_0100) ? 1'b1 : 1'b0;
    assign nBranch = (Opcode == 6'b00_0101) ? 1'b1 : 1'b0;
    assign R_format = (Opcode == 6'b00_0000) ? 1'b1 : 1'b0;
    assign RegDST = R_format;
    assign MemtoReg = (Opcode == 6'b10_0011) ? 1'b1 : 1'b0;
    assign RegWrite = ((R_format || Opcode == 6'b10_0011 || Opcode == 6'b00_0011 || I_format) && !(R_format && Function_opcode == 6'b00_1000)) ? 1'b1 : 1'b0;
    assign MemWrite = (Opcode == 6'b10_1011) ? 1'b1 : 1'b0;
    assign ALUSrc = (I_format || Opcode == 6'b10_0011 || Opcode == 6'b10_1011) ? 1'b1 : 1'b0;
    assign I_format = (Opcode[5:3] == 3'b001) ? 1'b1 : 1'b0;
    assign Sftmd = (((Function_opcode == 6'b00_0000) || (Function_opcode == 6'b00_0100) 
                    || (Function_opcode == 6'b00_0010) || (Function_opcode == 6'b00_0110) 
                    || (Function_opcode == 6'b00_0011) || (Function_opcode == 6'b00_0111))
                    && R_format) ? 1'b1 : 1'b0;
    assign ALUOp = {(R_format || I_format), (Branch || nBranch)};

endmodule
