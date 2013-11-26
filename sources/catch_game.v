`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:46:47 11/03/2013 
// Design Name: 
// Module Name:    catch_game 
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
module catch_game (
   input vclock,	// 27MHz clock
   input reset,		// 1 to initialize module
   input glove1closed,
	input glove2closed,
	input rel_glove1x,
	input rel_glove1y,
	input rel_glove2x,
	input rel_glove2y,
	input [5:0] dist,
	input can_catch1,
	input can_catch2,
	input right_hand1,
	input right_hand2,
   input [10:0] hcount,	// horizontal index of current pixel (0..1023)
   input [9:0] 	vcount, // vertical index of current pixel (0..767)
   input hsync,		// XVGA horizontal sync signal (active low)
   input vsync,		// XVGA vertical sync signal (active low)
   input blank,		// XVGA blanking (1 means output black pixel)
 	
   output phsync,	// pong game's horizontal sync
   output pvsync,	// pong game's vertical sync
   output pblank,	// pong game's blanking
   output [23:0] pixel	// pong game's pixel  // r=23:16, g=15:8, b=7:0 
   );



	reg[15:0] glove1x;
	reg[15:0] glove1y;
	reg[15:0] glove2x;
	reg[15:0] glove2y;
	
	reg[1:0] ball_state;
	reg[15:0] ball_x;
	reg[15:0] ball_y;
	
	reg[10:0] ballpixelx;
	reg[9:0] ballpixely;
	reg[10:0] glove1pixelx;
	reg[9:0] glove1pixely;
	reg[10:0] glove2pixelx;
	reg[9:0] glove2pixely;
	
	reg[23:0] ballpixel;
	reg[23:0] glove1pixel;
	reg[23:0] glove2pixel;
	
	
	global_coords gc(.clk(vclock),
			.rel_glove1x(rel_glove1x),.rel_glove1y(rel_glove1y),
			.rel_glove2x(rel_glove2x),.rel_glove2y(rel_glove2y),
			.dist(dist),.right_hand1(right_hand1),.right_hand2(right_hand2),
			.glob_glove1x(glove1x),.glob_glove1y(glove1y),
			.glob_glove2x(glove2x),.glob_glove2y(glove2y));
	
	ballSM bsm(.clk(vclock),.reset(reset),
			.glove1x(glove1x),.glove1y(glove1y),
			.glove2x(glove2x),.glove2y(glove2y),
			.glove1closed(glove1closed),.glove2closed(glove2closed),
			.can_catch1(can_catch1),.can_catch2(can_catch2),
			.dist(dist),.ball_state(ball_state),
			.ball_x(ball_x),.ball_y(ball_y));
	
	
	coords_to_pixel bpc(.x_coord(ball_x),.y_coord(ball_y),
			.dist(dist),
			.pixel_x(ballpixelx),.pixel_y(ballpixely));
			
	coords_to_pixel g1pc(.x_coord(glove1x),.y_coord(glove1y),
			.dist(dist),
			.pixel_x(glove1pixelx),.pixel_y(glove1pixely));
			
	coords_to_pixel g2pc(.x_coord(glove2x),.y_coord(glove2y),
			.dist(dist),
			.pixel_x(glove2pixelx),.pixel_y(glove2pixely));
	
	
	blob bblob(.x(ballpixelx),.hcount(hcount),
			.y(ballpixely),.vcount(vcount),
			.color({8'hFF,16'b0}),
			.pixel(ballpixel));
	
	blob g1blob(.x(glove1pixelx),.hcount(hcount),
			.y(glove1pixely),.vcount(vcount),
			.color({16'b0,8'hFF}),
			.pixel(glove1pixel));
			
	blob g2blob(.x(glove2pixelx),.hcount(hcount),
			.y(glove2pixely),.vcount(vcount),
			.color({16'b0,8'hFF}),
			.pixel(glove2pixel));
			
	

   wire [2:0] checkerboard;
	
   // REPLACE ME! The code below just generates a color checkerboard
   // using 64 pixel by 64 pixel squares.
   
   assign phsync = hsync;
   assign pvsync = vsync;
   assign pblank = blank;
   assign checkerboard = hcount[8:6] + vcount[8:6];

   // here we use three bits from hcount and vcount to generate the \
   // checkerboard

   assign pixel = ballpixel | glove1pixel | glove2pixel;
     
endmodule

