`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/18 13:24:17
// Design Name:
// Module Name: uart_wrap_sim
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


module uart_wrap_sim();
reg reset;
reg clock;
reg din;
wire [31:0] imem_write_data;
wire [31:0] addr_pointer;

uart_wrap_test uwt(reset, clock, din, imem_write_data, addr_pointer);

initial
begin
    reset = 1'b1;
    clock = 1'b1;
    din = 1'b0;
    #3 reset = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b1;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b1;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;

    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b0;
    #24 din = 1'b1;
    #24 din = 1'b1;
    #24 din = 1'b0;
    #24 din = 1'b1;

    #40 $finish(0);
end

always
begin
    #2 clock = ~clock;
end
endmodule
