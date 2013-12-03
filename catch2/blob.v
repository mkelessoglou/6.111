`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:22:43 11/26/2013 
// Design Name: 
// Module Name:    blob 
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
module blob #(parameter WIDTH = 16, HEIGHT = 16)(
	input [10:0] x,hcount,
	input [9:0] y,vcount,
	input [23:0] color,
	output reg [23:0] pixel);

	always @(*) begin
		if ((hcount >= x && hcount < (x+WIDTH)) && (vcount >= y && vcount < y+HEIGHT))
			pixel = color;
		else pixel = 24'b0;
	end

endmodule
