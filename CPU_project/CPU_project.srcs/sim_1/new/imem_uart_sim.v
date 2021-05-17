`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/17 17:48:09
// Design Name:
// Module Name: imem_uart_sim
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


module imem_uart_sim();
reg                    clk;
reg                    rst;
reg        [7:0]       dout;
reg                    dout_vld;
wire       [31:0]      imem_write_data;
wire       [31:0]      imem_read_data;
wire       [31:0]      current_addr;
wire       [1:0]       counter;
wire                   ena;
wire                   init;

Imem_test it(.clk(clk),
             .rst(rst),
             .dout(dout),
             .dout_vld(dout_vld),
             .imem_write_data(imem_write_data),
             .imem_read_data(imem_read_data),
             .current_addr(current_addr),
             .counter(counter),
             .ena(ena),
             .init(init)
            );

always
begin
    #2 clk = ~clk;
end

initial
begin
    clk = 1'b1;
    rst = 1'b1;
    dout_vld = 1'b0;
    dout = 8'd0;
    #4 rst = ~rst;
    #200 dout = 8'b10010010;
    #1 dout_vld = 1'b1;
    #1 dout_vld = 1'b0;
    #200 dout = 8'b11111111;
    #1 dout_vld = 1'b1;
    #1 dout_vld = 1'b0;
    #200 dout = 8'b00000000;
    #1 dout_vld = 1'b1;
    #1 dout_vld = 1'b0;
    #200 dout = 8'b11111111;
    #1 dout_vld = 1'b1;
    #1 dout_vld = 1'b0;
    #200 dout = 8'b11111111;
    #1 dout_vld = 1'b1;
    #1 dout_vld = 1'b0;
    #200 dout = 8'b00000000;
    #1 dout_vld = 1'b1;
    #1 dout_vld = 1'b0;
    #200 dout = 8'b11111111;
    #1 dout_vld = 1'b1;
    #1 dout_vld = 1'b0;
    #200 dout = 8'b10010010;
    #1 dout_vld = 1'b1;
    #1 dout_vld = 1'b0;
    #200 dout = 8'b10010010;
    #1 dout_vld = 1'b1;
    #1 dout_vld = 1'b0;
    #200 $finish(0);
end

endmodule
