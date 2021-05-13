`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/25 11:38:21
// Design Name: 
// Module Name: RAM_sim
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

module RAM_sim();
   // input
reg[31:0] address;
reg[31:0] write_data;
reg  Memwrite;
reg  clock;    
// output
wire[31:0] read_data;

dmemory32 Uram(.read_data(read_data),.address(address),.write_data(write_data),.Memwrite(Memwrite),.clock(clock));

initial begin
clock = 1'b0;
Memwrite = 1'b0;
address = 32'h0000_0000;
write_data = 32'ha000_0000;

end

always begin
    #10 clock = ~clock;
end 
always begin
    #20 address <= address + 32'h0000_0004;
end  

/*initial begin
    #200
    writeData = 32'ha000_00f5;
    memWrite = 1'b1;
    #200
    memWrite = 1'b0;
end*/
endmodule
