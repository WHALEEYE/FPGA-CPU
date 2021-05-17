`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/17 16:29:28
// Design Name:
// Module Name: uart_sim
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


module uart_sim();
reg clk;
reg rst;
reg din;
wire [7:0] dout;
wire dout_vld;

uart_read uread(
              .rst(rst),
              .clk(clk),
              .din(din),
              .dout(dout),
              .dout_vld(dout_vld)
          );

initial
begin
    clk = 1'b1;
    rst = 1'b1;
    din = 1'b1;
    #5 rst = ~rst;
    #3 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b1;

    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #40 $finish(0);
end

always
begin
    #2 clk = ~clk;
end
endmodule

