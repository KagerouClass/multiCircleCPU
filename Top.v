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
module Top(input wire clk, input wire rst);
wire PCWriteCond;
wire PCWrite;
wire IorD;
wire MemRead;
wire MemWrite;
wire MemToReg;
wire IRWrite;
wire PCSource;
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
wire [31:0] Wdata;
wire [31:0] instr;
wire [31:0] MDROut;
wire [31:0] IROut;
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
                 .reg_R_addr_B(IROut[20:16]), .reg_R_addr_C(),
					  .reg_W_addr(IRMUXOut),  .wdata(MDRMUXOut), .reg_we(RegWrite),
					  .rdata_A(Rdata1), .rdata_B(Rdata2), .rdata_C());
single_signext signExtend(.i_16(IROut[15:0]), .o_32(extendOut));
leftShift2Bits leftShift(.data_in(extendOut), .data_out(shiftToMUX4_1));
endmodule
