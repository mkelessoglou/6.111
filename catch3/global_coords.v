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
    input rel_glove1x,
    input rel_glove1y,
    input rel_glove2x,
    input rel_glove2y,
    input[5:0] dist,//in meters
    input right_hand1,
    input right_hand2,
	 input testright,
	 input testleft,
	 input testup,
	 input testdown,
	 input testright2,
	 input testleft2,
	 input testup2,
	 input testdown2,
    output reg[15:0] glob_glove1x,
    output reg[15:0] glob_glove1y,
    output reg[15:0] glob_glove2x,
    output reg[15:0] glob_glove2y
    );
	 
	 //all distances except for dist are in millimeters; dist is in meters
	 
	 
	 reg[17:0] update_counter; //210937
	 
	 ////////////////////////////////////////
	 //
	 //button inputs until we get input from hand-tracking
	 initial glob_glove1x = 16'd2000;
	 initial glob_glove1y = 16'd2000;
	 initial glob_glove2x = 16'd8000;
	 initial glob_glove2y = 16'd2000;
	 always @(posedge clk) begin

		if (update_counter == 0) begin
			glob_glove1x <= glob_glove1x + (testright-testleft)*15;
			glob_glove1y <= glob_glove1y + (testup-testdown)*15;
			glob_glove2x <= glob_glove2x + (testright2-testleft2)*15;
			glob_glove2y <= glob_glove2y + (testup2-testdown2)*15;
			update_counter <= 210937;
		end else begin
			glob_glove1x <= glob_glove1x;
			glob_glove1y <= glob_glove1y;
			glob_glove2x <= glob_glove2x;
			glob_glove2y <= glob_glove2y;
			update_counter <= update_counter-1;
		end
	 end
	 //////////////////////////////////////////


endmodule
