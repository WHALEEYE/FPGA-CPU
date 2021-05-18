`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/18 16:00:20
// Design Name:
// Module Name: uart_mem_FPGA_Test
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


module uart_mem_FPGA_Test(clock, reset, din, ena, mem_read, mem_addr);
input               clock;
input               reset;
input               din;
input               ena;
output  [15:0]      mem_read;
output  [2:0]       mem_addr;

wire    [31:0]      imem_write_data;
wire    [31:0]      addr_pointer;
wire    [31:0]      imem_read_data;
wire                clkn;

assign mem_read = imem_read_data[15:0];
assign mem_addr = addr_pointer[2:0];
assign clkn = ~clock;

uart_wrap uwrapIuart_mem_FPGA_Test(
              .reset(reset),
              .clock(clock),
              .din(din),
              .imem_write_data(imem_write_data),
              .addr_pointer(addr_pointer)
          );

IRAM instRAMIuart_mem_FPGA_Test(
         .clka(clkn),
         .wea(ena),
         .addra(addr_pointer),
         .dina(imem_write_data),
         .douta(imem_read_data)
     );

endmodule
