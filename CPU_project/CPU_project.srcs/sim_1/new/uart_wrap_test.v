`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/18 13:26:49
// Design Name: 
// Module Name: uart_wrap_test
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


module uart_wrap_test(reset, clock, din, imem_write_data, addr_pointer);
input                   reset;
input                   clock;
input                   din;
output reg  [31:0]      imem_write_data;
output reg  [31:0]      addr_pointer;
wire        [7:0]       dout;
reg         [31:0]      buffer;
wire                    dout_vld;
reg                     init;
reg         [1:0]       counter;

uart_read_Test urt(reset, clock, din, dout, dout_vld);

always @(posedge dout_vld or posedge reset)
begin
    if(reset)
    begin
        addr_pointer <= 32'd0;
        buffer <= 32'd0;
        init <= 1'b1;
        counter <= 1'b0;
        imem_write_data = 32'd0;
    end
    else
    begin
        case (counter)
            2'b00:
            begin
                counter <= 2'b01;
                buffer[31:24] <= dout;

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
                if (init)
                    init = 1'b0;
                else
                    addr_pointer = addr_pointer + 1;
                buffer[7:0] = dout;
                imem_write_data = buffer;
                counter <= 2'b00;
            end
        endcase
    end
end

endmodule


