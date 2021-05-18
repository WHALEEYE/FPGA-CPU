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


module cpu_wrap(clkin, reset, renew, din, tube_out, senario2, mode, number_in, led_out, tube_bit_select, tube_seg_select);
input               clkin;
input               reset;
input               renew;
input               din;
input               tube_out;
input               senario2;
input   [2:0]       mode;
input   [15:0]      number_in;
output  [15:0]      led_out;
output  [7:0]       tube_bit_select;
output  [7:0]       tube_seg_select;

wire    [31:0]      io_input;
wire    [31:0]      io_output;
wire                led_reset;
wire                tube_reset;

assign tube_reset = reset | ~tube_out;
assign led_reset = reset | tube_out;

assign io_input = {senario2, 12'b0000_0000_0000, mode, number_in};
assign led_out = led_reset ? 16'b0000_0000_0000_00000 : io_output[15:0];

CPU test_cpu(
        .io_input(io_input),
        .clkin(clkin),
        .reset(reset),
        .renew(renew),
        .din(din),
        .io_output(io_output)
    );

Tube tube_parser(
         .clkin(clkin),
         .rst(tube_reset),
         .input_num(io_output),
         .DIG(tube_bit_select),
         .Y(tube_seg_select)
     );


endmodule
