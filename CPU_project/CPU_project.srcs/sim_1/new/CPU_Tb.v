`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/15 12:19:12
// Design Name:
// Module Name: CPU_Tb
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


module CPU_Tb();
reg             clkin;
reg   [31:0]    io_input;
reg             reset;
wire  [31:0]    io_output;
wire            LEDCtrl, SwitchCtrl, TubeCtrl;

CPU test_CPU(io_input, io_output, LEDCtrl, SwitchCtrl, TubeCtrl, clkin, reset);

initial begin
    clkin = 1'b1;
    reset = 1'b1;
end

always begin
    #2 clkin = ~clkin;
end
endmodule
