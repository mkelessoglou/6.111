`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:32:42 11/21/2013 
// Design Name: 
// Module Name:    ballSM 
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
module ballSM(
    input clk,
    input reset,
    input[15:0] glove1x,
    input[15:0] glove1y,
    input[15:0] glove2x,
    input[15:0] glove2y,
    input glove1closed,
    input glove2closed,
    output reg[1:0] ball_state,//0 if ball is in the air,
									 //1 if held by glove1, 2 if held by glove2
    output reg[15:0] ballx,
	 output reg[15:0] bally
    );
	 
	 parameter updatesPerSec = 120;
	 
	 //All distances in the inputs and outputs are in millimeters
	 
	 //Ball's velocity in millimeters/second
	 signed reg[15:0] ballvelx;
	 signed reg[15:0] ballvely;
	 
	 //This signal dictates when velocity and position are updated
	 reg update;
	 reg[17:0] update_counter;
	 
	 //These variables keep track of past positions of the ball to determine
	//	 its velocity
	 reg[15:0] pastposx;
	 reg[15:0] pastposy;
	 
	 //These keep track of whether the glove has recently been opened
	 reg glove1opened;
	 reg glove2opened;
	 reg[7:0] glove_counter;

	 
	 always @(posedge clk) begin
		if (glove_counter == 0) begin
			glove1opened <= ~glove1closed;
			glove2opened <= ~glove2closed;
			glove_counter <= updatesPerSec/2;
		end
		if (update_counter == 0) begin
			update <= 1;
			update_counter <= 225000;//120Hz must be same as updatesPerSec
			glove_counter <= glove_counter - 1;
		end else begin
			update <= 0;
			update_counter <= update_counter - 1;
		end
		//if reset is asserted and the ball is in the air, it appears
		//in one of the gloves if either of them is closed
		if (reset) begin
			if (ball_state == 0) begin
				if (glove1closed) begin
					ball_state <= 1;
					ball_x <= glove1x;
					pastposx <= glove1x;
					ball_y <= glove1y;
					pastposy <= glove1y;
					ballvelx <= 0;
					ballvely <= 0;
				end else if (glove2closed) begin
					ball_state <= 2;
					ball_x <= glove2x;
					pastposx <= glove1x;
					ball_y <= glove2y;
					pastposy <= glove1y;
					ballvelx <= 0;
					ballvely <= 0;
				end
			end
		end else begin
			if (update) begin
				pastposx <= ball_x;
				pastposy <= ball_y;
				ballvelx <= (ball_x - pastposx)*UpdatesPerSec;
				ballvely <= (ball_x - pastposx)*UpdatesPerSec;
			end
			case (ball_state)
				0:
					//physics happens
				1:
					ball_x <= glove1x;
					ball_y <= glove1y;
					if (glove1closed) ball_state <= 1;
					else ball_state <= 0;
				2:
					ball_x <= glove2x;
					ball_y <= glove2y;
					if (glove2closed) ball_state <= 2;
					else ball_state <= 0;
				default:
					ball_x <= ball_x;
					ball_y <= ball_y;
			endcase
		end
	 end


endmodule
