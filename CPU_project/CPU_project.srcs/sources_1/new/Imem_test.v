`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/17 17:04:05
// Design Name:
// Module Name: Imem_test
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


module Imem_test(
           input                    clk,
           input                    rst,
           input        [7:0]       dout,
           input                    dout_vld,
           output       [31:0]      imem_write_data,
           output       [31:0]      imem_read_data,
           output       [31:0]      current_addr,
           output reg   [1:0]       counter,
           output                   ena,
           output reg               init
       );

reg write_ena;
reg [31:0] addr_pointer;
reg [31:0] buffer;
assign ena = write_ena;
assign current_addr = addr_pointer;
assign imem_write_data = buffer;
wire clkn = ~clk;

always @(posedge dout_vld or posedge rst)
begin
    if(rst)
    begin
        addr_pointer <= 32'd0;
        write_ena <= 1'b0;
        buffer <= 32'd0;
        init <= 1'b1;
        counter <= 1'b0;
    end
    else
    begin
        case (counter)
            2'b00:
            begin
                counter <= 2'b01;
                buffer[31:24] <= dout;
                write_ena <= 1'b0;
                if (init)
                    init <= 1'b0;
                else
                    addr_pointer <= addr_pointer + 1;
            end
            2'b01:
            begin
                buffer[23:16] <= dout;
                counter <= 2'b10;
            end
            2'b10:
            begin
                buffer[15:8] <= dout;
                counter <= 2'b11;
            end
            2'b11:
            begin
                buffer[7:0] <= dout;
                write_ena <= 1'b1;
                counter <= 2'b00;
            end
        endcase
    end
end

IRAM insram(
        .clka(clkn),
        .wea(ena),
        .addra(current_addr),
        .dina(imem_write_data),
        .douta(imem_read_data)
    );

endmodule
