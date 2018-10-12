`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:05:27 06/16/2017 
// Design Name: 
// Module Name:    mux2_1_1 
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
module mux2_1_1(A, B, Ctrl, S);	input  wire Ctrl;	input  wire A;
	input  wire B;	output wire S;	assign S = (Ctrl == 1'b0) ? A : B;endmodule
