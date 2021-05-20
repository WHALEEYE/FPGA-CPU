`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/12/19 11:06:33
// Design Name:
// Module Name: Tube_Show
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


module Tube_Show(rst, clk, seg_en, seg_out);
input                   rst;
input                   clk;
output reg  [7: 0]      seg_en;
output reg  [7: 0]      seg_out;

reg         [2: 0]      scan_cnt;

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        scan_cnt <= 0;
    end
    else
    begin
        if (scan_cnt == 3'b111)
        begin
            scan_cnt <= 0;
        end
        else
        begin
            scan_cnt <= scan_cnt + 1;
        end
    end
end

always @(scan_cnt)
begin
    case (scan_cnt)
        3'b000:
            seg_en <= 8'b01111111;
        3'b001:
            seg_en <= 8'b10111111;
        3'b010:
            seg_en <= 8'b11011111;
        3'b011:
            seg_en <= 8'b11101111;
        3'b100:
            seg_en <= 8'b11110111;
        3'b101:
            seg_en <= 8'b11111011;
        3'b110:
            seg_en <= 8'b11111101;
        3'b111:
            seg_en <= 8'b11111110;
    endcase
end

always @(scan_cnt)
begin
    case (scan_cnt)
        3'b000:
            seg_out <= 8'b11111111;
        3'b001:
            seg_out <= 8'b11111111;
        3'b010:
            seg_out <= 8'b11000110;
        3'b011:
            seg_out <= 8'b10010010;
        3'b100:
            seg_out <= 8'b10000110;
        3'b101:
            seg_out <= 8'b11111111;
        3'b110:
            seg_out <= 8'b11111111;
        3'b111:
            seg_out <= 8'b11111111;
    endcase
end
endmodule
