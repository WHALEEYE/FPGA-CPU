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


module Ifetc32(Addr_result, read_data_1, Branch, nBranch, Jmp, Jal, Jr, Zero, clock, reset, Pause, IF_ena, renew, addr_pointer, imem_write_data, Instruction, branch_base_addr, link_addr);
// input
// from ALU
input       [31:0]        Addr_result;            // the calculated address from ALU
input                     Zero;                   // while Zero is 1, it means the ALUresult is zero

input       [31:0]        read_data_1;            // the address of instruction used by jr instruction
input                     Branch;
input                     nBranch;
input                     Jmp;
input                     Jal;
input                     Jr;
input                     clock;
input                     reset;                  //1'b1 is 'reset' enable, 1'b0 means 'reset' disable. while 'reset' enable, the value of PC is set as 32'h0000_0000
input                     Pause;
input                     IF_ena;

// uart input
input wire                renew;
input wire  [31:0]        imem_write_data;
input wire  [31:0]        addr_pointer;

// output
output      [31:0]        Instruction;
output      [31:0]        branch_base_addr;       // (pc+4) to ALU which is used by branch type instruction
output      [31:0]        link_addr;              // (pc+4) to decoder which is used by jal

//Calculate PC
reg         [31:0]        PC;
reg         [31:0]        Next_PC;
wire                      branch_ctr;

wire                      clkn;
assign clkn = ~clock;

wire        [31:0]        instmem_addr;
assign instmem_addr = (renew == 1) ? addr_pointer : (PC >> 2);

always @*
begin
    if (Pause)
    begin
    end
    else if((Branch && Zero) || (nBranch && !Zero))
        Next_PC = Addr_result * 4;
    else if(Jr)
        Next_PC = read_data_1 * 4;
    else
        Next_PC = PC + 32'h0000_0004;
end

assign branch_base_addr = PC + 32'h0000_0004;
assign link_addr = (PC + 32'h0000_0004) / 4;

always @(posedge clock or posedge reset or posedge renew)
begin
    if (reset | renew)
    begin
        PC <= 32'h0000_0000;
    end
    else if (IF_ena)
    begin
        if (Pause)
        begin
        end
        else if (Jal || Jmp)
            PC <= {4'b0000, Instruction[25:0], 2'b00};
        else
            PC <= Next_PC;
    end
end

IRAM instmem(
         .clka(clkn),
         .wea(renew),
         .addra(instmem_addr),
         .dina(imem_write_data),
         .douta(Instruction)
     );

endmodule
