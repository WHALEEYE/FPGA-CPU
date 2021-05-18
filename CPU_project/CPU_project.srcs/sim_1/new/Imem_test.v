`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/17 17:04:05
// Design Name:
// Module Name: Imem_test
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


module Imem_test(
           input                    clk,
           input                    rst,
           output       [31:0]      imem_write_data,
           output       [31:0]      imem_read_data
       );

wire            ena;
wire    [31:0]  addr_pointer;
wire clkn = ~clk;
assign ena = 1'b1;

uart_wrap_test urtest(reset, clock, din, imem_write_data, addr_pointer); // need to move outside

IRAM insram(
         .clka(clkn),
         .wea(ena),
         .addra(addr_pointer),
         .dina(imem_write_data),
         .douta(imem_read_data)
     );

endmodule
