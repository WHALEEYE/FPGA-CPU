`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/26 00:00:49
// Design Name: 
// Module Name: Decoder
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


module Idecode32(read_data_1, read_data_2, Instruction, read_data, ALU_result, Jal, RegWrite, MemtoReg, RegDst, 
imme_extend, clock, reset, opcplus4, io_write_data, io_read_data, output_mode, IORead, IOWrite, TheWorld);
// input 
input[31:0]  Instruction;
input[31:0]  read_data;
input[31:0]  ALU_result;
input[31:0]  io_write_data;
input        Jal;           // 0 : data from alu, write to rt/rd 1 : data from pc+4, write to $ra
input        RegWrite;      // write in register
input        MemtoReg;      // 1 : read data 0 : alu result
input        RegDst;        // 0 : rt 1 : rd
input        clock,reset;   //
input[31:0]  opcplus4;      // from ifetch link_address
// output
output reg[31:0] read_data_1;
output reg[31:0] read_data_2;
output reg[31:0] imme_extend;
output reg[31:0] io_read_data;
output reg[1:0] output_mode;
output reg IORead; // 1 indicates I/O read
output reg IOWrite; // 1 indicates I/O write
output reg TheWorld; // 1s stop

// decode the instruction
wire[5:0] opcode;
wire[4:0] rs;
wire[4:0] rt;
wire[4:0] rd;
wire[4:0] shamt;
wire[4:0] funct; 
wire[15:0] immediate;

assign opcode = Instruction[31:26];
assign rs = Instruction[25:21];
assign rt = Instruction[20:16];
assign rd = Instruction[15:11];
assign shamt = Instruction[10:6];
assign funct = Instruction[5:0];
assign immediate = Instruction[15:0];
//assign address = Instruction[25:0];

// Register file
reg[31:0] Registers [0:31];
wire[4:0] readR_1;
wire[4:0] readR_2;
wire[4:0] writeR;
wire[31:0] writeD;
reg[31:0] counter;

assign readR_1 = rs;
assign readR_2 = rt;
assign writeR = (Jal == 0) ? ((RegDst == 0) ? rt : rd) : 5'b1_1111;
assign writeD = (Jal == 0) ? ((MemtoReg == 0) ? ALU_result : read_data) : opcplus4;

always @(negedge clock or posedge reset)
begin
    if(Instruction == 32'hffff_ffff) begin
        if(Registers[2] == 32'd5) begin
            Registers[2] <= io_write_data;
        end
        else if(Registers[2] == 32'd88) begin
            output_mode <= 2'b01;
            io_read_data <= Registers[4];
        end
        else if(Registers[2] == 32'd5) begin
            output_mode <= 2'b10;
            io_read_data <= Registers[4];
        end
    end
end

always @(posedge clock or posedge reset)
begin
    if(reset) begin
        Registers[0] <= 32'h00000000;
        Registers[1] <= 32'h00000000;
        Registers[2] <= 32'h00000000;
        Registers[3] <= 32'h00000000;
        Registers[4] <= 32'h00000000;
        Registers[5] <= 32'h00000000;
        Registers[6] <= 32'h00000000;
        Registers[7] <= 32'h00000000;
        Registers[8] <= 32'h00000000;
        Registers[9] <= 32'h00000000;
        Registers[10] <= 32'h00000000;
        Registers[11] <= 32'h00000000;
        Registers[12] <= 32'h00000000;
        Registers[13] <= 32'h00000000;
        Registers[14] <= 32'h00000000;
        Registers[15] <= 32'h00000000;
        Registers[16] <= 32'h00000000;
        Registers[17] <= 32'h00000000;
        Registers[18] <= 32'h00000000;
        Registers[19] <= 32'h00000000;
        Registers[20] <= 32'h00000000;
        Registers[21] <= 32'h00000000;
        Registers[22] <= 32'h00000000;
        Registers[23] <= 32'h00000000;
        Registers[24] <= 32'h00000000;
        Registers[25] <= 32'h00000000;
        Registers[26] <= 32'h00000000;
        Registers[27] <= 32'h00000000;
        Registers[28] <= 32'h00000000;
        Registers[29] <= 32'h00000000;
        Registers[30] <= 32'h00000000;
        Registers[31] <= 32'h00000000;
        read_data_1 <= 32'h00000000;
        read_data_2 <= 32'h00000000;
        io_read_data <= 32'h00000000;
        imme_extend <= 32'h00000000;
    end
    else begin
        if(Instruction == 32'hffff_ffff) begin
            if(Registers[2] == 32'd5) begin
                IORead <= 1'b1;
                IOWrite <= 1'b0;
            end
            else if(Registers[2] == 32'd88) begin
                IORead <= 1'b0;
                IOWrite <= 1'b1;
            end
            else if(Registers[2] == 32'd5) begin
                IORead <= 1'b0;
                IOWrite <= 1'b1;
            end
            else if(Registers[2] == 32'd111) begin
                //the world 1s
                IORead <= 1'b0;
                IOWrite <= 1'b0;
                if(counter == 32'h015e_f3c0) begin
                    TheWorld <= 1'b0;
                    counter <= 32'h0000_0000;
                end
                else begin
                    TheWorld <= 1'b1;
                    counter <= counter + 1'b1;
                end
            end
            else begin
                IORead = 1'b0;
                IOWrite = 1'b0;
                TheWorld = 1'b0;
                io_read_data <= 32'h0000000;
                output_mode <= 2'b00;
            end
        end
        else begin
            IORead = 1'b0;
            IOWrite = 1'b0;
            TheWorld = 1'b0;
            io_read_data <= 32'h0000000;
            output_mode <= 2'b00;
            
            imme_extend <= {{16{immediate[15]}}, immediate[15:0]};
            read_data_1 <= Registers[rs];
            read_data_2 <= Registers[rt];
            if(RegWrite) begin
                Registers[writeR] <= writeD;
            end
        end
    end
end
endmodule
