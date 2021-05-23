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


module cpu_wrap(clkin, reset, renew, din, tube_output, led_output, senario2, mode, number_in, led_out_sig, seg_en, seg_out);
input               clkin;
input               reset;
input               renew;
input               din;
input               tube_output;
input               led_output;
input               senario2;
input   [2:0]       mode;
input   [15:0]      number_in;
output  [16:0]      led_out_sig;
output  [7:0]       seg_en;
output  [7:0]       seg_out;

wire    [31:0]      io_input;
wire    [31:0]      io_output;
wire                div_clk;

wire    [7:0]       seg_en_orig;
wire    [7:0]       seg_out_orig;

assign io_input = {senario2, 12'b0000_0000_0000, mode, number_in};
assign led_out_sig = (led_output & ~reset) ? io_output[16:0] : 17'b0_0000_0000_0000_00000;
assign seg_en = (tube_output & ~reset) ? seg_en_orig : 8'b1111_1111;
assign seg_out = (tube_output & ~reset) ? seg_out_orig : 8'b1111_1111;

CPU cpu_core(
        .io_input(io_input),
        .clkin(clkin),
        .reset(reset),
        .renew(renew),
        .din(din),
        .io_output(io_output)
    );

Tube_Show ts(
              .rst(reset),
              .clk(div_clk),
              .input_num(io_output),
              .seg_en(seg_en_orig),
              .seg_out(seg_out_orig)
          );

Frequency_Divider fd(
                      .rst(reset),
                      .clk(clkin),
                      .clk_out(div_clk)
                  );


endmodule
