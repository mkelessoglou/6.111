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
   input vclock,	// 65MHz clock
   input reset,		// 1 to initialize module
   input up,		// 1 when paddle should move up
   input down,  	// 1 when paddle should move down
   input [3:0] pspeed,  // puck speed in pixels/tick 
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

   wire [2:0] checkerboard;
	
   // REPLACE ME! The code below just generates a color checkerboard
   // using 64 pixel by 64 pixel squares.
   
   assign phsync = hsync;
   assign pvsync = vsync;
   assign pblank = blank;
   assign checkerboard = hcount[8:6] + vcount[8:6];

   // here we use three bits from hcount and vcount to generate the \
   // checkerboard

   assign pixel = {{8{checkerboard[2]}}, {8{checkerboard[1]}}, {8{checkerboard[0]}}} ;
     
endmodule

