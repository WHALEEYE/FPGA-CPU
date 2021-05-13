`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/20 11:07:20
// Design Name: 
// Module Name: controller_sim
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

module control32_sim(
    );
        // input
        reg[5:0]   Opcode = 6'b000000;            
        reg[5:0]   Function_opcode  = 6'b100000;     
        // output
        wire       Jr;
        wire       RegDST;
        wire       ALUSrc;            
        wire       MemtoReg;
        wire       RegWrite;
        wire       MemWrite;
        wire       Branch;
        wire       nBranch;
        wire       Jmp;
        wire       Jal;
        wire       I_format;
        wire       Sftmd;
        wire[1:0]  ALUOp;
        
    control32 Uctrl(.Opcode(Opcode),.Function_opcode(Function_opcode),
                    .Jr(Jr),.RegDST(RegDST),.ALUSrc(ALUSrc),
                    .MemtoReg(MemtoReg),.RegWrite(RegWrite),
                    .MemWrite(MemWrite),.Branch(Branch),
                    .nBranch(nBranch),.Jmp(Jmp),.Jal(Jal),.I_format(I_format),
                    .Sftmd(Sftmd),.ALUOp(ALUOp));
    initial begin
end
endmodule
