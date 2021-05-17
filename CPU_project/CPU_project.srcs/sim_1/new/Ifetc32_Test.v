`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/17 23:24:05
// Design Name:
// Module Name: Ifetc32_Test
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


module Ifetc32(PC,Next_PC,Addr_result, read_data_1, Branch, nBranch, Jmp, Jal, Jr, Zero, clock, reset, Pause, IF_ena, renew, dout, dout_vld, Instruction, branch_base_addr, link_addr, ena, instmem_addr, imem_write_data, init, buffer,counter,write_ena,addr_pointer);
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
input                     renew;
input       [7:0]         dout;
input                     dout_vld;


// output
output      [31:0]        Instruction;
output      [31:0]        branch_base_addr;       // (pc+4) to ALU which is used by branch type instruction
output      [31:0]        link_addr;              // (pc+4) to decoder which is used by jal

//Calculate PC
output reg         [31:0]        PC;
output reg         [31:0]        Next_PC;
wire                      branch_ctr;

wire                      clkn;
assign clkn = ~clock;

// The data used in uart
output reg         [1:0]         counter;
output reg                       write_ena;
output reg         [31:0]        addr_pointer;
output reg         [31:0]        buffer;
output      [31:0]        instmem_addr;
output reg                init;
output ena;
output  [31:0] imem_write_data;
assign ena = write_ena;
assign imem_write_data = buffer;
assign instmem_addr = renew ? addr_pointer : (PC >> 2);

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

always @(posedge clock or negedge renew)
begin
    if(~renew)
    begin
        addr_pointer <= 32'h0000_0000;
        write_ena <= 1'b0;
        buffer <= 32'h0000_0000;
        init <= 1'b1;
        counter <= 1'b0;
    end
end

always @(posedge dout_vld or posedge reset)
begin
    if(reset)
    begin
        addr_pointer <= 32'd0;
        write_ena <= 1'b0;
        buffer <= 32'd0;
        init <= 1'b1;
        counter <= 1'b0;
    end
    else if (renew)
    begin
        case (counter)
            2'b00:
            begin
                counter <= 2'b01;
                buffer[31:24] <= dout;
                write_ena <= 1'b0;
                if (init)
                    init <= 1'b0;
                else
                    addr_pointer <= addr_pointer + 1;
            end
            2'b01:
            begin
                buffer[23:16] <= dout;
                counter <= 2'b10;
            end
            2'b10:
            begin
                buffer[15:8] <= dout;
                counter <= 2'b11;
            end
            2'b11:
            begin
                buffer[7:0] <= dout;
                write_ena <= 1'b1;
                counter <= 2'b00;
            end
        endcase
    end
end

IRAM instmem(
         .clka(clkn),
         .wea(ena),
         .addra(instmem_addr),
         .dina(imem_write_data),
         .douta(Instruction)
     );

endmodule
