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
	 
	 //All distances in the inputs and outputs are in millimeters
	 
	 //Ball's velocity in millimeters/second
	 reg[15:0] ballvelx;
	 reg[15:0] ballvely;
	 
	 //This signal dictates when velocity and position are updated
	 reg update;
	 reg[17:0] update_counter;
	 
	 always @(posedge clk) begin
		//if reset is asserted and the ball is in the air, it appears
		//in one of the gloves if either of them is closed
		if (update_counter == 0) begin
			update <= 1;
			update_counter <= 225000;//120Hz
		end else begin
			update <= 0;
			update_counter <= update_counter - 1;
		end
		if (reset) begin
			if (ball_state == 0) begin
				if (glove1closed) begin
					ball_state <= 1;
					ball_x <= glove1x;
					ball_y <= glove1y;
				end else if (glove2closed) begin
					ball_state <= 2;
					ball_x <= glove2x;
					ball_y <= glove2y;
				end
			end
		end else begin
			case (ball_state)
				0:
					//physics happens
				1:
					ball_x <= glove1x;
					ball_y <= glove1y;
				2:
					ball_x <= glove2x;
					ball_y <= glove2y;
				default:
					ball_x <= ballx;
					ball_y <= bally;
			endcase
		end
	 end


endmodule
