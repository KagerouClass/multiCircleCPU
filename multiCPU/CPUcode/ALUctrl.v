`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:13:51 06/01/2017 
// Design Name: 
// Module Name:    ALUctrl 
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
module ALUctrl(aluop, ALU_operation, inst);
input wire [1:0]aluop;
input wire [5:0]inst;
output reg [2:0]ALU_operation;
	always @* begin
	case(inst[5:0])
				6'b100000:ALU_operation=010;//add
				6'b100010:ALU_operation=110;//sub
				6'b100100:ALU_operation=000;//and
				6'b100101:ALU_operation=001;//or
				6'b101010:ALU_operation=111;//slt
				6'b100111:ALU_operation=100;//r:~(A|B)
			default:ALU_operation=3'bx;
	endcase
	if (aluop==2'b00) ALU_operation=010;
	if (aluop==2'b01) ALU_operation=110;
end

endmodule
