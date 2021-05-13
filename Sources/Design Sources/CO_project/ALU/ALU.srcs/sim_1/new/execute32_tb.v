`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/12 13:45:33
// Design Name: 
// Module Name: execute32_tb
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


module execute32_Itype_tb();
    reg[31:0]  Read_data_1;
    reg[31:0]  Read_data_2;
    reg[31:0]  Imme_extend;
    reg[5:0]   Function_opcode; 
    reg[5:0]   opcode;
    reg[1:0]   ALUOp;
    reg[4:0]   Shamt;
    reg        Sftmd;
    reg        ALUSrc;
    reg        I_format;
    reg        Jr;
    reg[31:0]  PC_plus_4;  //from ifetch's branch_base_addr
    // output
    wire       Zero;       //In ALU,Zero is determined by ALU_output_mux, not ALU_Result
    wire[31:0] ALU_Result;
    wire[31:0] Addr_Result;            

    
    Executs32 Uexe(.Read_data_1(Read_data_1),.Read_data_2(Read_data_2),.Imme_extend(Imme_extend),.Function_opcode(Function_opcode),.opcode(opcode),.ALUOp(ALUOp),
                    .Shamt(Shamt),.ALUSrc(ALUSrc),.I_format(I_format),.Zero(Zero),.Sftmd(Sftmd),.ALU_Result(ALU_Result),.Addr_Result(Addr_Result),.PC_plus_4(PC_plus_4),
                    .Jr(Jr));
    initial begin
end
endmodule
