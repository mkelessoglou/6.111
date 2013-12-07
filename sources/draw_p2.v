`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:36:25 12/04/2013 
// Design Name: 
// Module Name:    draw_p2 
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
module draw_p2(
	input clk,
    input[10:0] hcount,
    input[9:0] vcount,
    input blank,
	 input[15:0] x,
	 input[15:0] y,
	 input[1:0] ball_state,
	 input closed,
    output reg[23:0] pixel
    );
	 
	 wire[11:0] map_addr;//memory address in color map
	 reg[11:0] map_addr2;
	 wire[3:0] table_addr;//memory address in color table
	 wire[3:0] table_addrh;
	 wire[3:0] table_addrc;
	 reg[3:0] table_addr2;
	 reg[3:0] table_addrh2;
	 reg[3:0] table_addrc2;
	 wire[23:0] prepixel1;
	 wire[23:0] prepixel2;
	 wire[23:0] prepixel3;
	 
	 //get map address
	 get_map_address gma(.clk(clk),.hcount(hcount),.vcount(vcount),.blank(blank),
						.x(x),.y(y),.addr(map_addr));
	 
	 
	 //get table address
	 open_hand_color_map map(.clka(clk),.addra(map_addr2),.douta(table_addr));
	 holding_ball_color_map hmap(.clka(clk),.addra(map_addr2),.douta(table_addrh));
	 closed_hand_color_map cmap(.clka(clk),.addra(map_addr2),.douta(table_addrc));
	 
	 //get table entry
	 open_hand_color_table ctable(.clka(clk),.addra(table_addr2),.douta(prepixel1));
	 holding_ball_color_table hctable(.clka(clk),.addra(table_addrh2),.douta(prepixel2));
	 closed_hand_color_table cctable(.clka(clk),.addra(table_addrc2),.douta(prepixel3));
	 
	 always @(posedge clk) begin
		map_addr2<=map_addr;
		table_addr2<=table_addr;
		table_addrh2<=table_addrh;
		table_addrc2<=table_addrc;
		if (ball_state == 2) pixel <= prepixel2;
		else if (closed) pixel <= prepixel3;
		else pixel <= prepixel1;
	 end
	 
	 


endmodule
