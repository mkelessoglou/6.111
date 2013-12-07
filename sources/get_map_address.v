`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:36:56 12/02/2013 
// Design Name: 
// Module Name:    get_map_address 
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
module get_map_address(
    input clk,
    input[10:0] hcount,
    input[9:0] vcount,
    input blank,
    input[15:0] x,
    input[15:0] y,
    output reg[11:0] addr
    );
	 

	 wire outofbounds1;
	 wire outofbounds2;
	 wire outofbounds3;
	 wire outofbounds4;
	 reg outofbounds;
	 
	 reg[15:0] fulladdr;
	 
	 reg[15:0] dx;
	 reg[15:0] dy;
	 
	 
	 parameter xoffset = 16'd35;
	 parameter yoffset = 16'd25;
	 
	 

		//determines whether current pixel is within object sprite 
		assign outofbounds1 = ((hcount < x) && hcount < x - xoffset+1);
		assign outofbounds2 = (hcount > x && hcount > x + xoffset-1);
		assign outofbounds3 = (vcount < y && vcount < y - yoffset+1);
		assign outofbounds4 = (vcount > y && vcount > y + yoffset-1); 

	 
	 always @(posedge clk) begin
		outofbounds <= blank || outofbounds1 || outofbounds2 || outofbounds3 || outofbounds4;
		dx <= (hcount + xoffset - x);
		dy <= (vcount + yoffset - y)*70;
		if (outofbounds) begin
			fulladdr <= 0;
		end else begin
			fulladdr <=  dy + dx;
		end
		addr <= fulladdr[11:0];
	 end
	 




endmodule
