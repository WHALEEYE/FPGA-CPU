`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/18 10:48:29
// Design Name:
// Module Name: Tube
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


module Tube(clk, rst, input_num, DIG, Y);
input rst, clk;
input wire [31:0] input_num;
output reg [7:0] DIG;   //bit
output reg [7:0] Y;     //seg

reg [2:0] scan_cnt;

wire [3:0] num_r [0:7];
reg [6:0] tube_r [0:9];

reg clk_out;
parameter period = 200000;
reg[31: 0] cnt;
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

// assign num_r[7] = (input_num / 32'd10000000) % 10;
// assign num_r[6] = (input_num / 32'd1000000) % 10;
// assign num_r[5] = (input_num / 32'd100000) % 10;
// assign num_r[4] = (input_num / 32'd10000) % 10;
// assign num_r[3] = (input_num / 32'd1000) % 10;
// assign num_r[2] = (input_num / 32'd100) % 10;
// assign num_r[1] = (input_num / 32'd10) % 10;
// assign num_r[0] = (input_num / 32'd1) % 10;

always @(posedge clk_out or posedge rst)
begin
    if(rst)
    begin
        scan_cnt <= 0;
        // Y <= 8'b1111_1111;
        // DIG <= 8'b1111_1111;
        // tube_r[0] <= 7'b0111111;
        // tube_r[1] <= 7'b0000110;
        // tube_r[2] <= 7'b1011011;
        // tube_r[3] <= 7'b1001111;
        // tube_r[4] <= 7'b1100110;
        // tube_r[5] <= 7'b1101101;
        // tube_r[6] <= 7'b1111101;
        // tube_r[7] <= 7'b0100111;
        // tube_r[8] <= 7'b1111111;
        // tube_r[9] <= 7'b1100111;
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
    case (scan_cnt)
        3'b000:
            DIG <= 8'b01111111;
        3'b001:
            DIG <= 8'b10111111;
        3'b010:
            DIG <= 8'b11011111;
        3'b011:
            DIG <= 8'b11101111;
        3'b100:
            DIG <= 8'b11110111;
        3'b101:
            DIG <= 8'b11111011;
        3'b110:
            DIG <= 8'b11111101;
        3'b111:
            DIG <= 8'b11111110;
    endcase
end

// always @(scan_cnt)
// begin
//     case(scan_cnt)
//         3'b000:
//             Y_r <= tube_r[num_r[0]];
//         3'b001:
//             Y_r <= tube_r[num_r[1]];
//         3'b010:
//             Y_r <= tube_r[num_r[2]];
//         3'b011:
//             Y_r <= tube_r[num_r[3]];
//         3'b100:
//             Y_r <= tube_r[num_r[4]];
//         3'b101:
//             Y_r <= tube_r[num_r[5]];
//         3'b110:
//             Y_r <= tube_r[num_r[6]];
//         3'b111:
//             Y_r <= tube_r[num_r[7]];
//         default:
//             Y_r <= 7'b000_0000;
//     endcase
// end

always @(scan_cnt)
begin
    case (scan_cnt)
        3'b000:
            Y <= 8'b11111111;
        3'b001:
            Y <= 8'b11111111;
        3'b010:
            Y <= 8'b11000110;
        3'b011:
            Y <= 8'b10010010;
        3'b100:
            Y <= 8'b10000110;
        3'b101:
            Y <= 8'b11111111;
        3'b110:
            Y <= 8'b11111111;
        3'b111:
            Y <= 8'b11111111;
    endcase
end
endmodule
