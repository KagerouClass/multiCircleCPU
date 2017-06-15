`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:44:44 06/14/2017 
// Design Name: 
// Module Name:    Top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Top(input wire clk, input wire rst, input wire [31:0] input_address, output wire [31:0] output_data);
wire PCWriteCond;
wire PCWrite;
wire IorD;
wire MemRead;
wire MemWrite;
wire MemToReg;
wire IRWrite;
wire [1:0] PCSource;
wire [1:0] ALUop;
wire ALUSrcA;
wire [1:0] ALUSrcB;
wire RegWrite;
wire RegDst;

//////////PC-part////////////
wire [31:0] finalSelectResult;
wire [31:0] PCToIorD;
wire [31:0] ALUOutResult;
wire ALUZero;
wire ALUZP;
wire PCCtrl;
wire IorDMUXToMenmory;
and u1(ALUZP, PCWriteCond, ALUZero);
or  u2(PCCtrl, ALUZP, PCWrite);

tempRegister PC(.data_in(finalSelectResult), .data_out(PCToIorD), .ctrl(PCCtrl));
mux2_1       IorDMUX(.A(PCToIorD), .B(ALUOutResult), .Ctrl(IorD), .S(IorDMUXToMenmory));

////////Instruction Memory Part////////
wire [31:0] instr;
wire [31:0] MDROut;
wire [31:0] IROut;
wire [31:0] Wdata;
Memory       Instruction(.clka(clk), .rsta(rst) , .wea(MemWrite),
              .addra(IorDMUXToMenmory), .dina(Wdata), .douta(instr));
tempRegister IR(.data_in(instr), .data_out(IROut), .ctrl(IRWrite));
tempRegister MDR(.data_in(instr), .data_out(MDROut), .ctrl(1'b1));

/////////between Instruction and Register////////////
wire [5:0] IRMUXOut;
wire [31:0] MDRMUXOut;
mux2_1       IRMUX(.A(IROut[20:16]), .B(IROut[15:11]), .Ctrl(RegDst), .S(IRMUXOut));
mux2_1       MDRMUX(.A(MDROut), .B(ALUOutResult), .Ctrl(MemToReg), .S(MDRMUXOut));

/////////Register Part//////////////////
wire [31:0] Rdata1;
wire [31:0] Rdata2;
wire [31:0] extendOut;
wire [31:0] shiftToMUX4_1;
register_file r1(.clk(clk), .rst(rst), .reg_R_addr_A(IROut[25:21]),
                 .reg_R_addr_B(IROut[20:16]), .reg_R_addr_C(input_address),
					  .reg_W_addr(IRMUXOut),  .wdata(MDRMUXOut), .reg_we(RegWrite),
					  .rdata_A(Rdata1), .rdata_B(Rdata2), .rdata_C(output_data));
single_signext signExtend(.i_16(IROut[15:0]), .o_32(extendOut));
leftShift2Bits leftShift(.data_in(extendOut), .data_out(shiftToMUX4_1));

wire [31:0] AToMux2_1;
tempRegister A(.data_in(Rdata1), .data_out(AToMux2_1), .ctrl(1'b1));
tempRegister B(.data_in(Rdata2), .data_out(Wdata), .ctrl(1'b1));

wire [31:0] shiftToCombine;
wire [31:0] combineTpMux4_1;
leftShift2Bits leftShift1(.data_in(IROut), .data_out(shiftToCombine));
combine        combine2Part(.ip1(PCToIorD[31:28]), .ip2(shiftToCombine), .jdata(combineTpMux4_1));
///////////ALU Part////////////////////
wire [31:0] ALUInA;
wire [31:0] ALUInB;
mux2_1      ALUMUXA(.A(PCToIorD), .B(AToMux2_1), .Ctrl(ALUSrcA), .S(ALUInA));
mux4_1      ALUMUXB(.A(Wdata), .B(3'b100), .C(extendOut), .D(shiftToMUX4_1), .Ctrl(ALUSrcB), .S(ALUInB));

wire [2:0] ALU_operation;
wire [31:0] res;
wire [31:0] resOut;
ALUctrl     ALUcontrol(.aluop(ALUop), .ALU_operation(ALU_operation), .inst(IROut[5:0]));
ALU         ALUpart(.A(ALUInA), .B(ALUInB), .ALU_operation(ALU_operation), .res(res), .zero(ALUZero), .overflow());

tempRegister ALUout(.data_in(res), .data_out(resOut), .ctrl(1'b1));
mux4_1       finalMUX(.A(res), .B(resOut), .C(combineTpMux4_1), .D(), .Ctrl(PCSource), .S(finalSelectResult));

////////////CPU Ctrl//////////////////
CPU_ctrl    CPU(.clk(clk), .rst(rst), .inst(IROut[31:26]), 
					 .RegDst(RegDst), .RegWrite(RegWrite),
					 .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB),
					 .ALUop(ALUop), .PCSource(PCSource),
					 .PCWriteCond(PCWriteCond), .PCWrite(PCWrite),
					 .lorD(lorD), .MemRead(MemRead),
					 .MemWrite(MemWrite), .MemtoReg(MemtoReg),
					 .IRWrite(IRWrite));
endmodule
