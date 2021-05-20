`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/19 22:52:03
// Design Name:
// Module Name: Tube_Sim
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


module Tube_Sim();
wire          [7:0]           seg;
wire          [7:0]           bit;
reg                           rst;
reg                           clkin;
wire          [31:0]          input_num;

assign input_num = 32'd630063;

Tube_Test Tt(
              .clk(clkin),
              .rst(rst),
              .input_num(input_num),
              .DIG(bit),
              .Y(seg)
          );

initial
begin
    rst = 1'b1;
    clkin = 1'b0;
    #3 rst = 1'b0;
    #100 $finish(0);
end

always
begin
    #2 clkin = ~clkin;
end

endmodule
