`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:16:26 12/02/2013 
// Design Name: 
// Module Name:    draw_ball 
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
module draw_ball(
	input clk,
    input hcount,
    input vcount,
    input blank,
	 input x,
	 input y,
	 input[1:0] ball_state,
    output reg[23:0] pixel
    );
	 
	 wire[11:0] map_addr;//memory address in color map
	 wire[3:0] table_addr;//memory address in color table
	 wire[23:0] prepixel;
	 
	 //get map address
	 get_map_address gma(.clk(clk),.hcount(hcount),.vcount(vcount),.blank(blank),
						.x(x),.y(y),.addr(map_addr));
	 
	 //get table address
	 ball_color_map map(.clka(clk),.addra(map_addr),.douta(table_addr));
	 
	 //get table entry
	 ball_color_table ctable(.clka(clk),.addra(table_addr),.douta(prepixel));
	 
	 always @(posedge clk) begin
		if (ball_state == 0) pixel <= prepixel;
		else pixel <= 24'd0;
	 end
	 
	 


endmodule
