`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/17 11:22:01
// Design Name:
// Module Name: cpu_wrap
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


module cpu_wrap(clkin, reset, test_output);
input               clkin;
input               reset;
output  [15:0]      test_output;
wire    [31:0]      io_input;
wire    [31:0]      io_output;
assign io_input = 32'd0;
assign test_output = io_output[15:0];

CPU test_cpu(
        .io_input(io_input),
        .clkin(clkin),
        .reset(reset),
        .io_output(io_output)
    );
endmodule
