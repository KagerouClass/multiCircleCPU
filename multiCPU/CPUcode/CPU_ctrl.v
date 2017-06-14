`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:24:10 06/01/2017 
// Design Name: 
// Module Name:    CPU_ctrl 
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
module CPU_ctrl(clk,rst,inst,RegDst,RegWrite,
ALUSrcA,ALUSrcB,ALUop,PCSource,PCWriteCond,PCWrite,lorD,MemRead,MemWrite,MemtoReg,IRWrite
    );
input wire clk;
input wire [5:0] inst;
input wire rst;
output wire RegDst,RegWrite,ALUSrcA,PCWriteCond,PCWrite,lorD,MemRead,MemWrite,MemtoReg,IRWrite;
output wire [1:0] ALUSrcB;
output wire [1:0] ALUop;
output wire [1:0] PCSource;
reg [3:0] state;
reg [3:0] nextstate;

initial begin
state <= 4'b0000;
nextstate <= 4'b0000;
end

always @(posedge clk or posedge rst)
begin
state <= rst? 4'b0000 : nextstate;
end

always @*
begin
case (state)
0:nextstate = 1;
1:case (inst)
	6'b000000:nextstate = 6;
	6'b100011:nextstate = 2;
	6'b101011:nextstate = 2;
	6'b000100:nextstate = 8;
	6'b000010:nextstate = 9;
endcase
2:case (inst)
	6'b100011:nextstate = 3;
	6'b101011:nextstate = 5;
endcase
3:nextstate = 4;
5:nextstate = 4;
6:nextstate = 7;
default:nextstate = 0;
endcase
end

assign MemRead = (state == 0 || state == 3)? 1 : 0;
assign MemWrite = (state == 5)? 1 : 0;
assign IRWrite = (state == 0)? 1 : 0;
assign PCWrite = (state == 0 || state == 9)? 1 : 0;
assign RegWrite = (state == 7 || state == 4)? 1 : 0;
assign ALUop[0] = (state == 8)? 1 : 0;
assign ALUop[1] = (state == 6)? 1 : 0;
assign ALUSrcA = (state == 2 || state == 6 || state == 8)? 1 : 0;
assign ALUSrcB[0] = (state == 0 || state == 1)? 1 : 0;
assign ALUSrcB[1] = (state == 1 || state == 2)? 1 : 0;
assign lorD = (state == 3 || state == 5)? 1 : 0;
assign PCSource = (state == 9)? 2'b10 : (state == 8)? 2'b01 : 2'b00;
assign PCWriteCond = (state == 8)? 1 : 0;
assign MemtoReg = (state == 4)? 1 : 0;
assign RegDst = (state == 7)? 1 : 0;

endmodule
