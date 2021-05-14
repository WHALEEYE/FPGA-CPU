`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 17:38:18
// Design Name: 
// Module Name: IO
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


module MemOrIO(ioRead, ioWrite, io_rdata, r_wdata, r_rdata, write_data, output_mode, LEDCtrl, SwitchCtrl, TubeCtrl);
    //from decoder
    input ioRead; // read IO, from control32
    input ioWrite; // write IO, from control32
    input output_mode;
    //from decoder
    input[31:0] r_rdata; // data read from idecode32(register file)
    output[31:0] r_wdata; // data to idecode32(register file)
    //IO
    input[31:0] io_rdata; // data read from io,16 bits
    output[31:0] write_data; // data to I/O
    output reg LEDCtrl; // LED Chip Select
    output reg TubeCtrl;
    output SwitchCtrl; // Switch Chip Select

    assign r_wdata = (ioRead == 1) ? io_rdata : 32'h0000_0000;
    assign write_data = (ioWrite == 1) ? r_rdata : 32'hZZZZ_ZZZZ;

    // Chip select signal of Led and Switch are all active high;
    assign SwitchCtrl = ioRead;  
    always @* begin
        if(output_mode == 2'b01) begin
            LEDCtrl = ioWrite;
            TubeCtrl = 1'b0;
        end
        else if(output_mode == 2'b10) begin
            TubeCtrl = ioWrite;
            LEDCtrl = 1'b0;
        end
    end
endmodule