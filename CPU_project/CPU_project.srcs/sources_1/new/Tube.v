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

module Tube_Show(rst, clk, input_num, seg_en, seg_out);
input                   rst;
input                   clk;
input       [31:0]      input_num;
output reg  [7: 0]      seg_en;
output reg  [7: 0]      seg_out;

reg         [2: 0]      scan_cnt;
reg         [3:0]       num_r [0:7];

always @(posedge clk or posedge rst)
begin
    if(rst) begin
        num_r[7] <= 4'b0;
        num_r[6] <= 4'b0;
        num_r[5] <= 4'b0;
        num_r[4] <= 4'b0;
        num_r[3] <= 4'b0;
        num_r[2] <= 4'b0;
        num_r[1] <= 4'b0;
        num_r[0] <= 4'b0;
    end
    else begin
        num_r[7] <= (input_num / 32'd10000000) % 10;
        num_r[6] <= (input_num / 32'd1000000) % 10;
        num_r[5] <= (input_num / 32'd100000) % 10;
        num_r[4] <= (input_num / 32'd10000) % 10;
        num_r[3] <= (input_num / 32'd1000) % 10;
        num_r[2] <= (input_num / 32'd100) % 10;
        num_r[1] <= (input_num / 32'd10) % 10;
        num_r[0] <= (input_num / 32'd1) % 10;
    end
end

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
        3'b000: begin
            case (num_r[7])
                4'b0000 :   seg_out <= 8'b1100_0000;
                4'b0001 :   seg_out <= 8'b1111_1001;
                4'b0010 :   seg_out <= 8'b1010_0100;
                4'b0011 :   seg_out <= 8'b1011_0000;
                4'b0100 :   seg_out <= 8'b1001_1001;
                4'b0101 :   seg_out <= 8'b1001_0010;
                4'b0110 :   seg_out <= 8'b1000_0010;
                4'b0111 :   seg_out <= 8'b1101_1000;
                4'b1000 :   seg_out <= 8'b1000_0000;
                4'b1001 :   seg_out <= 8'b1001_1000;
                default :   seg_out <= 8'b1100_0000;
            endcase
        end
        3'b001 : begin
            case (num_r[6])
                4'b0000 :   seg_out <= 8'b1100_0000;
                4'b0001 :   seg_out <= 8'b1111_1001;
                4'b0010 :   seg_out <= 8'b1010_0100;
                4'b0011 :   seg_out <= 8'b1011_0000;
                4'b0100 :   seg_out <= 8'b1001_1001;
                4'b0101 :   seg_out <= 8'b1001_0010;
                4'b0110 :   seg_out <= 8'b1000_0010;
                4'b0111 :   seg_out <= 8'b1101_1000;
                4'b1000 :   seg_out <= 8'b1000_0000;
                4'b1001 :   seg_out <= 8'b1001_1000;
                default :   seg_out <= 8'b1100_0000;
            endcase
        end
        3'b010 : begin
            case (num_r[5])
                4'b0000 :   seg_out <= 8'b1100_0000;
                4'b0001 :   seg_out <= 8'b1111_1001;
                4'b0010 :   seg_out <= 8'b1010_0100;
                4'b0011 :   seg_out <= 8'b1011_0000;
                4'b0100 :   seg_out <= 8'b1001_1001;
                4'b0101 :   seg_out <= 8'b1001_0010;
                4'b0110 :   seg_out <= 8'b1000_0010;
                4'b0111 :   seg_out <= 8'b1101_1000;
                4'b1000 :   seg_out <= 8'b1000_0000;
                4'b1001 :   seg_out <= 8'b1001_1000;
                default :   seg_out <= 8'b1100_0000;
            endcase
        end
        3'b011 : begin
            case (num_r[4])
                4'b0000 :   seg_out <= 8'b1100_0000;
                4'b0001 :   seg_out <= 8'b1111_1001;
                4'b0010 :   seg_out <= 8'b1010_0100;
                4'b0011 :   seg_out <= 8'b1011_0000;
                4'b0100 :   seg_out <= 8'b1001_1001;
                4'b0101 :   seg_out <= 8'b1001_0010;
                4'b0110 :   seg_out <= 8'b1000_0010;
                4'b0111 :   seg_out <= 8'b1101_1000;
                4'b1000 :   seg_out <= 8'b1000_0000;
                4'b1001 :   seg_out <= 8'b1001_1000;
                default :   seg_out <= 8'b1100_0000;
            endcase
        end
        3'b100 : begin
            case (num_r[3])
                4'b0000 :   seg_out <= 8'b1100_0000;
                4'b0001 :   seg_out <= 8'b1111_1001;
                4'b0010 :   seg_out <= 8'b1010_0100;
                4'b0011 :   seg_out <= 8'b1011_0000;
                4'b0100 :   seg_out <= 8'b1001_1001;
                4'b0101 :   seg_out <= 8'b1001_0010;
                4'b0110 :   seg_out <= 8'b1000_0010;
                4'b0111 :   seg_out <= 8'b1101_1000;
                4'b1000 :   seg_out <= 8'b1000_0000;
                4'b1001 :   seg_out <= 8'b1001_1000;
                default :   seg_out <= 8'b1100_0000;
            endcase
        end
        3'b101 : begin
            case (num_r[2])
                4'b0000 :   seg_out <= 8'b1100_0000;
                4'b0001 :   seg_out <= 8'b1111_1001;
                4'b0010 :   seg_out <= 8'b1010_0100;
                4'b0011 :   seg_out <= 8'b1011_0000;
                4'b0100 :   seg_out <= 8'b1001_1001;
                4'b0101 :   seg_out <= 8'b1001_0010;
                4'b0110 :   seg_out <= 8'b1000_0010;
                4'b0111 :   seg_out <= 8'b1101_1000;
                4'b1000 :   seg_out <= 8'b1000_0000;
                4'b1001 :   seg_out <= 8'b1001_1000;
                default :   seg_out <= 8'b1100_0000;
            endcase
        end
        3'b110 : begin
            case (num_r[1])
                4'b0000 :   seg_out <= 8'b1100_0000;
                4'b0001 :   seg_out <= 8'b1111_1001;
                4'b0010 :   seg_out <= 8'b1010_0100;
                4'b0011 :   seg_out <= 8'b1011_0000;
                4'b0100 :   seg_out <= 8'b1001_1001;
                4'b0101 :   seg_out <= 8'b1001_0010;
                4'b0110 :   seg_out <= 8'b1000_0010;
                4'b0111 :   seg_out <= 8'b1101_1000;
                4'b1000 :   seg_out <= 8'b1000_0000;
                4'b1001 :   seg_out <= 8'b1001_1000;
                default :   seg_out <= 8'b1100_0000;
            endcase
        end
        3'b111 : begin
            case (num_r[0])
                4'b0000 :   seg_out <= 8'b1100_0000;
                4'b0001 :   seg_out <= 8'b1111_1001;
                4'b0010 :   seg_out <= 8'b1010_0100;
                4'b0011 :   seg_out <= 8'b1011_0000;
                4'b0100 :   seg_out <= 8'b1001_1001;
                4'b0101 :   seg_out <= 8'b1001_0010;
                4'b0110 :   seg_out <= 8'b1000_0010;
                4'b0111 :   seg_out <= 8'b1101_1000;
                4'b1000 :   seg_out <= 8'b1000_0000;
                4'b1001 :   seg_out <= 8'b1001_1000;
                default :   seg_out <= 8'b1100_0000;
            endcase
        end
    endcase
end
endmodule
