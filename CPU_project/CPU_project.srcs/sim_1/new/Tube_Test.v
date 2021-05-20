`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/19 22:54:04
// Design Name:
// Module Name: Tube_Test
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


module Tube_Test(clk, rst, input_num, DIG, Y);
input rst, clk;
input wire [31:0] input_num;
output [7:0] DIG;   //bit
output [7:0] Y;     //seg

reg [6:0] Y_r;
reg [7:0] DIG_r;
reg [2:0] scan_cnt;

wire [3:0] num_r [0:7];
reg [6:0] tube_r [0:9];

assign num_r[7] = (input_num / 32'd10000000) % 10;
assign num_r[6] = (input_num / 32'd1000000) % 10;
assign num_r[5] = (input_num / 32'd100000) % 10;
assign num_r[4] = (input_num / 32'd10000) % 10;
assign num_r[3] = (input_num / 32'd1000) % 10;
assign num_r[2] = (input_num / 32'd100) % 10;
assign num_r[1] = (input_num / 32'd10) % 10;
assign num_r[0] = (input_num / 32'd1) % 10;

assign Y = {1'b1, {~Y_r}};
assign DIG = {~DIG_r};

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        scan_cnt <= 0;
        Y_r <= 7'b0;
        DIG_r <= 8'b0;
        tube_r[0] <= 7'b0111111;
        tube_r[1] <= 7'b0000110;
        tube_r[2] <= 7'b1011011;
        tube_r[3] <= 7'b1001111;
        tube_r[4] <= 7'b1100110;
        tube_r[5] <= 7'b1101101;
        tube_r[6] <= 7'b1111101;
        tube_r[7] <= 7'b0100111;
        tube_r[8] <= 7'b1111111;
        tube_r[9] <= 7'b1100111;
    end
    else
    begin
        case(scan_cnt)
            3'b000, 3'b001, 3'b010, 3'b011, 3'b100, 3'b101, 3'b110:
                scan_cnt <= scan_cnt + 1;
            3'b111:
                scan_cnt <= 3'b000;
        endcase
    end
end

always @(scan_cnt)
begin
    case(scan_cnt)
        3'b000:
            DIG_r <= 8'b0000_0001;
        3'b001:
            DIG_r <= 8'b0000_0010;
        3'b010:
            DIG_r <= 8'b0000_0100;
        3'b011:
            DIG_r <= 8'b0000_1000;
        3'b100:
            DIG_r <= 8'b0001_0000;
        3'b101:
            DIG_r <= 8'b0010_0000;
        3'b110:
            DIG_r <= 8'b0100_0000;
        3'b111:
            DIG_r <= 8'b1000_0000;
        default:
            DIG_r <= 8'b0000_0000;
    endcase
end

always @(scan_cnt)
begin
    case(scan_cnt)
        3'b000:
            Y_r <= tube_r[num_r[0]];
        3'b001:
            Y_r <= tube_r[num_r[1]];
        3'b010:
            Y_r <= tube_r[num_r[2]];
        3'b011:
            Y_r <= tube_r[num_r[3]];
        3'b100:
            Y_r <= tube_r[num_r[4]];
        3'b101:
            Y_r <= tube_r[num_r[5]];
        3'b110:
            Y_r <= tube_r[num_r[6]];
        3'b111:
            Y_r <= tube_r[num_r[7]];
        default:
            Y_r <= 7'b000_0000;
    endcase
end
endmodule

