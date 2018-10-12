`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:39:25 06/08/2017 
// Design Name: 
// Module Name:    combine 
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
module combine(ip1, ip2, jdata
    );
input wire [3:0]ip1;
input wire [27:0]ip2;

output wire [31:0]jdata;

assign jdata = {ip1,ip2};

endmodule
