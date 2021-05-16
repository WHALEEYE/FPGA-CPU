`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/04/13 11:58:57
// Design Name:
// Module Name: dmemory32
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


module dmemory32(address, write_data, Memwrite, MEM_ena, clock, read_data);
input               clock;
input   [31:0]      address;
input   [31:0]      write_data;
input               Memwrite;
input               MEM_ena;
output  [31:0]      read_data;

wire                clk;
wire                ena;
assign ena = MEM_ena & Memwrite;

RAM ram(
        .clka(clock),
        .wea(ena),
        .addra(address[15:2]),
        .dina(write_data),
        .douta(read_data)
    );
endmodule
