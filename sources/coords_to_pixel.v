`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:00:23 11/25/2013 
// Design Name: 
// Module Name:    coords_to_pixel 
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
//takes in absolute coordinates of an object and returns its pixel coordinates
//scaling is such that the full 1024 pixels represent the smallest power of 
// 2 in 1.024 meters that is greater than dist+3
module coords_to_pixel(
    input[15:0] x_coord,//in mm
    input[15:0] y_coord,//in mm
    input[5:0] dist,//in meters
    output reg[10:0] pixel_x,
    output reg[9:0] pixel_y
    );
	 
	 wire[6:0] maxdist;
	 //negative coords or coords greater than maxdist will not be on screen
	 assign maxdist = dist + 3;
	 
	 reg[2:0] powerOf2;
	 
	 
	 
	 always @(*) begin
		if (maxdist < 4) powerOf2 = 2;
		else if (maxdist < 8) powerOf2 = 3;
		else if (maxdist < 16) powerOf2 = 4;
		else if (maxdist < 32) powerOf2 = 5;
		else powerOf2 = 6;
		//multiply by 1024 (number of pixels) and divide by 1024 for mm's per 1.024m
		//so do nothing
		assign pixel_x = x_coord >> powerOf2;
		assign pixel_y = 767 - (y_coord >> powerOf2);
	 end


endmodule
