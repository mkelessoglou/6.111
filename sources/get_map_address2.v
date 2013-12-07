`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:01:22 12/07/2013 
// Design Name: 
// Module Name:    get_map_address2 
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
module get_map_address2(
    input clk,
    input[10:0] hcount,
    input[9:0] vcount,
    input blank,
    input[15:0] x,
    input[15:0] y,
    output reg[11:0] addr
    );
	 

	 wire outofbounds;
	 
	 reg[15:0] fulladdr;
	 
	 
	 parameter xoffset = 16'd35;
	 parameter yoffset = 16'd25;
	 
	 

		//determines whether current pixel is within object sprite
		assign outofbounds = (blank) 
									||((hcount < x) && hcount < x - xoffset+2)
									||(hcount > x && hcount > x + xoffset-2)
									||(vcount < y && vcount < y - yoffset+2)
									||(vcount > y && vcount > y + yoffset-2); 

	 
	 always @(posedge clk) begin
		if (outofbounds) begin
			fulladdr <= 0;
		end else begin
			fulladdr <= (vcount + yoffset - y)*70 + (hcount + xoffset - x);
		end
		addr <= fulladdr[11:0];
	 end
	 




endmodule