`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:09:18 06/01/2017 
// Design Name: 
// Module Name:    leftShift2Bits 
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
module leftShift2Bits(data_in, data_out);
	input wire[31:0] data_in;
	output wire[31:0] data_out;
	assign data_out = data_in << 2;

endmodule
