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
	 input can_catch1,
	 input can_catch2,
	 input[5:0] dist,
    output reg[1:0] ball_state,//0 if ball is in the air,
									 //1 if held by glove1, 2 if held by glove2
    output reg[15:0] ball_x,
	 output reg[15:0] ball_y
    );
	 
	 
	 
	 parameter updatesPerSec = 128;
	 parameter tolerance = 50; //within how many mms a catch can be made
	 parameter ballRadius = 50;
	 
	 //All distances in the inputs and outputs are in millimeters
	 
	 //Ball's velocity in millimeters/second
	 reg [15:0] ballvelx;
	 reg [15:0] ballvely;
	 reg ballvelxdir;//0 means right (positive x vel)
	 reg ballvelydir;//0 means up (positive y vel)
	 
	 
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
	 reg glove1edge;
	 reg glove2edge;
	 
	 //These keep track of whether the ball is close enough to a glove to get caught
	 wire closeToGlove1;
	 wire closeToGlove2;
	 
	 
	 wire[15:0] mmdist;
	 
	 
	 //This keeps track of whether the ball is touching the floor or a wall
	 wire ballAtEdge; 
	 

		assign mmdist = {10'b0,dist}*1000;
		 assign closeToGlove1 = 
			((ball_x > glove1x && ball_x - glove1x < tolerance)
			|| (ball_x < glove1x && glove1x - ball_x < tolerance)) &&
			((ball_y > glove1y && ball_y - glove1y < tolerance)
			|| (ball_y < glove1y && glove1y - ball_y < tolerance));
		 assign closeToGlove2 =
			((ball_x > glove2x && ball_x - glove2x < tolerance)
			|| (ball_x < glove2x && glove2x - ball_x < tolerance)) &&
			((ball_y > glove2y && ball_y - glove2y < tolerance)
			|| (ball_y < glove2y && glove2y - ball_y < tolerance));
		 assign ballAtEdge =
			(ball_x < ballRadius + 5) || (ball_x > mmdist + 4000 - ballRadius)
			|| (ball_y < ballRadius + 5);


	 
	 always @(posedge clk) begin
		glove1opened <= ~glove1closed;
		glove2opened <= ~glove2closed;
		glove1edge <= glove1closed && glove1opened;
		glove2edge <= glove2closed && glove2opened;
		if (update_counter == 0) begin
			update <= 1;
			update_counter <= 210937;//128Hz must be same as updatesPerSec
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
				if (ball_state > 0) begin
					if (ball_x > pastposx)begin
						ballvelx <= (ball_x - pastposx)*updatesPerSec;
						ballvelxdir <= 0;
					end else begin
						ballvelx <= (pastposx - ball_x)*updatesPerSec;
						ballvelxdir <= 1;
					end
					if (ball_y > pastposy)begin
						ballvely <= (ball_y - pastposy)*updatesPerSec;
						ballvelydir <= 0;
					end else begin
						ballvely <= (pastposy - ball_y)*updatesPerSec;
						ballvelydir <= 1;
					end
				end else begin
					ballvelx <= ballvelx; //no air resistance
					if (ballvelydir == 0) begin
					//77 = g*DeltaT = 9806 mm/s^2 * (1/128 s)
						if (ballvely >= 77) ballvely <= ballvely - 77;
						else begin
							ballvelydir <= 1;
							ballvely <= 77 - ballvely;
						end
					end else begin
						if (ballvely <= 16'hFFFF - 16'd77) ballvely <= ballvely + 77;
						else ballvely <= 16'hFFFF;
					end
				end
			end
			case (ball_state)
				0: 
				begin
					if (update) begin
						if (ballAtEdge) begin
							ball_x <= ball_x;
							ball_y <= ball_y;
						end else begin
						//DeltaX = v*DeltaT
							if (~ballvelxdir) ball_x <= ball_x + (ballvelx / updatesPerSec);
							else ball_x <= ball_x - (ballvelx / updatesPerSec);
							if (~ballvelydir) ball_y <= ball_y + (ballvely / updatesPerSec);
							else begin
								if (ball_y > (ballvely / updatesPerSec)) ball_y <= ball_y - (ballvely / updatesPerSec);
								else ball_y <= 5;
							end
						end
					end
					if (glove1edge && can_catch1 && closeToGlove1) ball_state <= 1;
					else if (glove2edge && can_catch2 && closeToGlove2) ball_state <= 2;
					else ball_state <= 0;
				end
				1:
				begin
					ball_x <= glove1x;
					ball_y <= glove1y;
					if (glove1closed) ball_state <= 1;
					else ball_state <= 0;
				end
				2:
				begin
					ball_x <= glove2x;
					ball_y <= glove2y;
					if (glove2closed) ball_state <= 2;
					else ball_state <= 0;
				end
				default:
				begin
					ball_x <= ball_x;
					ball_y <= ball_y;
				end
			endcase
		end
	 end
	 
	 //for testing purposes
	 initial ball_state = 0;
	 initial ball_x = 16'd4000;
	 initial ball_y = 16'd2000;
	 initial ballvelx = 1000;
	 initial ballvely = 1000;
	 initial ballvelxdir = 0;
	 initial ballvelydir = 0;


endmodule
