`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 17:59:29
// Design Name: 
// Module Name: MemOrIO_tb
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


module MemOrIO_tb();
    reg ioRead,ioWrite;
    reg[31:0] r_rdata;
    reg[15:0] io_rdata;
    wire LEDCtrl,SwitchCtrl;
    wire [31:0] r_wdata,write_data;
    MemOrIO uIO(ioRead, ioWrite, io_rdata, r_wdata, r_rdata, write_data, LEDCtrl, SwitchCtrl);
    initial begin // r_rdata -> m_wdata(write_data)
        io_rdata = 32'hffff; 
        r_rdata = 32'h0f0f_0f0f; 
        {ioRead,ioWrite}= 2'b00;
        #10 {ioRead,ioWrite}= 2'b01; // r_rdata -> io_wdata(write_data)
        #10 {ioRead,ioWrite}= 2'b00; // m_rdata -> r_wdata
        #10 {ioRead,ioWrite}= 2'b10; // io_rdata -> r_wdata(write_data)
        #10 $finish;
    end
endmodule