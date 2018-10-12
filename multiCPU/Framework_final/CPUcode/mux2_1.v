`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:58:05 06/01/2017 
// Design Name: 
// Module Name:    mux2_1 
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
module mux2_1(A, B, Ctrl, S);	input  wire Ctrl;	input  wire [31:0] A;
	input  wire [31:0] B;	output wire [31:0] S;	assign S = (Ctrl == 1'b0) ? A : B;endmodule