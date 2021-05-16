`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/05/15 12:19:12
// Design Name:
// Module Name: CPU_Tb
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


module CPU_Tb();
reg     [31:0]    io_input;
reg               reset;
wire    [31:0]    io_output;
wire              LEDCtrl, TubeCtrl;

//module clock
reg               clock;
reg     [1:0]     main_counter;

//module ifetch
//output
wire    [31:0]    Instruction, branch_base_addr, link_addr;

//module control
//output
wire              Jr, RegDST, ALUSrc, MemtoReg, RegWrite, MemWrite, Branch, nBranch, Jmp, Jal, I_format, Sftmd;
wire    [1:0]     ALUOp;
//input
wire    [5:0]     Opcode, Function_opcode;
assign Opcode = Instruction[31:26];
assign Function_opcode = Instruction[5:0];

//module Decoder
//output
wire    [31:0]    read_data_1, read_data_2, imme_extend;
wire              syscall;
wire              Pause;

//module ALU
//output
wire              Zero;
wire    [31:0]    Addr_result, ALU_result;
//input
wire    [4:0]     Shamt;
assign Shamt = Instruction[10:6];

//module RAM
//output
wire    [31:0]    read_data;

wire    [31:0]    test_reg;

wire              IF_ena, ID_ena, MEM_ena, WB_ena;
assign IF_ena = (main_counter == 2'b00) ? 1'b1 : 1'b0;
assign ID_ena = (main_counter == 2'b01) ? 1'b1 : 1'b0;
assign MEM_ena = (main_counter == 2'b10) ? 1'b1 : 1'b0;
assign WB_ena = (main_counter == 2'b11) ? 1'b1 : 1'b0;

always @(negedge clock or posedge reset)
begin
    if(reset)
    begin
        main_counter <= 2'b00;
    end
    else
    begin
        case (main_counter)
            2'b00:
                main_counter <= 2'b01;
            2'b01:
            begin
                if (syscall)
                    main_counter <= 2'b00;
                else if (MemWrite)
                    main_counter <= 2'b10;
                else if (RegWrite)
                    main_counter <= 2'b11;
                else
                    main_counter <= 2'b00;
            end
            2'b10:
            begin
                if (RegWrite)
                    main_counter <= 2'b11;
                else
                    main_counter <= 2'b00;
            end
            2'b11:
                main_counter <= 2'b00;
        endcase
    end
end


Ifetc32 cpu_ifetch(
            .Addr_result(Addr_result),
            .read_data_1(read_data_1),
            .Branch(Branch),
            .nBranch(nBranch),
            .Jmp(Jmp),
            .Jal(Jal),
            .Jr(Jr),
            .Zero(Zero),
            .clock(clock),
            .reset(reset),
            .Pause(Pause),
            .IF_ena(IF_ena),
            .Instruction(Instruction),
            .branch_base_addr(branch_base_addr),
            .link_addr(link_addr)
        );

control32 cpu_ctrl(
              .Opcode(Opcode),
              .Function_opcode(Function_opcode),
              .Jr(Jr),
              .RegDST(RegDST),
              .ALUSrc(ALUSrc),
              .MemtoReg(MemtoReg),
              .RegWrite(RegWrite),
              .MemWrite(MemWrite),
              .Branch(Branch),
              .nBranch(nBranch),
              .Jmp(Jmp),
              .Jal(Jal),
              .I_format(I_format),
              .Sftmd(Sftmd),
              .ALUOp(ALUOp)
          );

Idecode32_Test cpu_decoder(
                   .read_data_1(read_data_1),
                   .read_data_2(read_data_2),
                   .Instruction(Instruction),
                   .read_data(read_data),
                   .ALU_result(ALU_result),
                   .Jal(Jal),
                   .RegWrite(RegWrite),
                   .MemtoReg(MemtoReg),
                   .RegDST(RegDST),
                   .imme_extend(imme_extend),
                   .clock(clock),
                   .reset(reset),
                   .opcplus4(link_addr),
                   .ID_ena(ID_ena),
                   .WB_ena(WB_ena),
                   .io_input(io_input),
                   .io_output(io_output),
                   .Pause(Pause),
                   .TubeCtrl(TubeCtrl),
                   .LEDCtrl(LEDCtrl),
                   .syscall(syscall),
                   .test_reg(test_reg)
               );

Executs32 cpu_alu(
              .read_data_1(read_data_1),
              .read_data_2(read_data_2),
              .imme_extend(imme_extend),
              .Function_opcode(Function_opcode),
              .opcode(Opcode),
              .ALUOp(ALUOp),
              .Shamt(Shamt),
              .PC_plus_4(branch_base_addr),
              .ALUSrc(ALUSrc),
              .I_format(I_format),
              .Zero(Zero),
              .Sftmd(Sftmd),
              .ALU_Result(ALU_result),
              .Addr_Result(Addr_result),
              .Jr(Jr)
          );

dmemory32 cpu_ram(
              .address(ALU_result),
              .write_data(read_data_2),
              .Memwrite(MemWrite),
              .MEM_ena(MEM_ena),
              .clock(clock),
              .read_data(read_data)
          );


initial
begin
    io_input = 32'b10100000000000001111111111111101;
    clock = 1'b1;
    reset = 1'b1;
    #5 reset = 1'b0;
    #400 $finish(0);
end

always
begin
    #2 clock = ~clock;
end
endmodule
