`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:59:39 06/01/2017 
// Design Name: 
// Module Name:    mux4_1 
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
module mux4_1(A, B, C, D, Ctrl, S);
	parameter N = 32;
	input wire [1:0] Ctrl;
	input wire [N-1:0] A, B, C, D;
	output wire [N-1:0] S;
	assign S = Ctrl == 2'b00 ? A :
				  Ctrl == 2'b01 ? B :
				  Ctrl == 2'b10 ? C : D;
endmodule
