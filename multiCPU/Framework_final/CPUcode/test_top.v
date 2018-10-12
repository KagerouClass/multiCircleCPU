`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:29:11 06/15/2017
// Design Name:   Top
// Module Name:   D:/ISEprogram/Exp05/2017.06.15/multiCPU2/CPUcode/test_top.v
// Project Name:  multiCPU2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_top;

	// Inputs
	reg clk;
	reg rst;
	reg [31:0] input_address;

	// Outputs
	wire [31:0] output_data;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.rst(rst), 
		.input_address(input_address), 
		.output_data(output_data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		input_address = 1;
		
		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
      input_address = 1;
		// Add stimulus here
	end
   always begin
		#50;
		clk = ~clk;
	end      
endmodule

