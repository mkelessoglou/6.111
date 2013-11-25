`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:28:53 11/21/2013 
// Design Name: 
// Module Name:    global_coords 
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
//This module takes in relative positions of the gloves and converts them
// to global coordinates
//The 0 x coordinate is 2 meters left of the leftmost glove (as seen on the screen)
//The 0 y coordinate is approximating ground
//For this to be accurate, the cameras' height and distance to the players must be
// close to constant
module global_coords(
    input clk,
    input rel_glove1_x,
    input rel_glove1_y,
    input rel_glove2_x,
    input rel_glove2_y,
    input dist,//in meters
    input right_hand1,
    input right_hand2,
    output glob_glove1_x,
    output glob_glove1_y,
    output glob_glove2_x,
    output glob_glove2_y
    );
	 
	 //all distances except for dist are in millimeters; dist is in meters


endmodule
