`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/27 11:54:44
// Design Name: 
// Module Name: IFetc32
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


module Ifetc32(Instruction,branch_base_addr,Addr_result,Read_data_1,Branch,nBranch,Jmp,Jal,Jr,Zero,clock,reset,link_addr,TheWorld);
    // input
    //from ALU
    input[31:0]  Addr_result;   // the calculated address from ALU
    input        Zero;          // while Zero is 1, it means the ALUresult is zero
    
    input[31:0]  Read_data_1;   // the address of instruction used by jr instruction
    input        Branch;
    input        nBranch;
    input        Jmp;
    input        Jal;
    input        Jr;
    input        clock;
    input        reset;     //1'b1 is 'reset' enable, 1'b0 means 'reset' disable. while 'reset' enable, the value of PC is set as 32'h0000_0000
    input        TheWorld;

    // output
    output[31:0] Instruction;            
    output[31:0] branch_base_addr;      // (pc+4) to ALU which is used by branch type instruction
    output reg[31:0] link_addr;         // (pc+4) to decoder which is used by jal 
    
    //Calculate PC
    reg[31:0] PC, Next_PC;
    wire branch_ctr;

    always @* 
    begin
        if(((Branch == 1) && (Zero == 1 )) || ((nBranch == 1) && (Zero == 0)))
            Next_PC = Addr_result * 4;
        else if(Jr == 1)
            Next_PC = Read_data_1 * 4;
        else if(TheWorld == 1)
            Next_PC = Next_PC;
        else 
            Next_PC = PC + 32'h0000_0004;
    end

    assign branch_base_addr = PC + 32'h0000_0004;

    always @(negedge clock, posedge reset)
    begin
        if(reset)
        begin
            PC <= 32'h0000_0000;
        end
        else
        begin
            if((Jal | Jmp) == 1)
            begin
                link_addr = (PC + 4'b0100) / 4;
                PC <= {4'b0000, Instruction[25:0], 2'b00};
            end
            else if(TheWorld == 1)
            begin
                PC <= PC;
            end
            else
            begin
                PC <= Next_PC;
            end
            //PC <= ((Jal | Jmp) == 0) ? ((Jr == 0) ? ((branch_ctr == 0 ? (branch_base_addr) : (Addr_result * 4))) : (Read_data_1 * 4)) : ({PC[31:28], Instruction[25:0], 2'b00});
            //link_addr = ((Jal | Jmp) == 0) ? link_addr : (PC + 4'b0100) / 4;
        end
    end
    
    prgrom instmem(.clka(clock), .addra(PC/4), .douta(Instruction));

endmodule
