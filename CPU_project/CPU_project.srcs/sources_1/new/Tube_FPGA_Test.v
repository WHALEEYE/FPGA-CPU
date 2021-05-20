`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/19 22:28:53
// Design Name:
// Module Name: Tube_FPGA_Test
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


module Tube_FPGA_Test(clkin, rst, bit, seg);
output        [7:0]           seg;
output        [7:0]           bit;
input                         rst;
input                         clkin;
wire          [31:0]          input_num;

assign input_num = 32'd630063;

Tube Tube_Test(
         .clk(clkin),
         .rst(rst),
         .input_num(input_num),
         .DIG(bit),
         .Y(seg)
     );

endmodule
