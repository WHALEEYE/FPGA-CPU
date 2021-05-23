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


module dmemory32(address, write_data, Memwrite, MEM_ena, clock, read_data, renew, uart_addr, uart_data);
input               clock;
input   [31:0]      address;
input   [31:0]      write_data;
input               Memwrite;
input               MEM_ena;
input               renew;
input   [31:0]      uart_data;
input   [31:0]      uart_addr;
output  [31:0]      read_data;

wire                clk;
wire                ena;
wire    [31:0]      dmem_write_addr;
wire    [31:0]      dmem_write_data;
wire                dmem_ena;
assign dmem_write_addr = renew ? uart_addr : address[15:2];
assign dmem_write_data = renew ? uart_data : write_data;
assign ena = MEM_ena & Memwrite;
assign dmem_ena = renew ? 1'b1 : ena;

RAM ram(
        .clka(clock),
        .wea(dmem_ena),
        .addra(dmem_write_addr),
        .dina(dmem_write_data),
        .douta(read_data)
    );
endmodule
