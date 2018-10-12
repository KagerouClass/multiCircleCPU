`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:02:29 06/01/2017 
// Design Name: 
// Module Name:    tempRegister 
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
module tempRegister(data_in, data_out, ctrl);
	input wire[31:0] data_in;
	input ctrl;
	output reg[31:0] data_out;
initial data_out = 0;

	always @ *
	begin
		if(ctrl == 1)
			data_out <= data_in;
		else
			data_out <= data_out;
	end
endmodule
