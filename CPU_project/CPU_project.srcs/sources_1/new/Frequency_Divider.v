`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/12/19 10:51:42
// Design Name:
// Module Name: Frequency_Divider
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


module Frequency_Divider(rst, clk, clk_out);
input               rst;
input               clk;
output reg          clk_out;
parameter period = 200000;

reg     [31: 0]     cnt;
always@(posedge clk or posedge rst)
begin
    if (rst)
    begin
        cnt <= 0;
        clk_out <= 0;
    end
    else
    begin
        if (cnt == ((period >> 1) - 1))
        begin
            clk_out <= ~clk_out;
            cnt <= 0;
        end
        else
        begin
            cnt <= cnt + 1;
        end
    end
end
endmodule
