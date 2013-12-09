`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:41:01 11/03/2013 
// Design Name: 
// Module Name:    catch 
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
module catch(beep, audio_reset_b, ac97_sdata_out, ac97_sdata_in, ac97_synch,
	       ac97_bit_clock,
	       
	       vga_out_red, vga_out_green, vga_out_blue, vga_out_sync_b,
	       vga_out_blank_b, vga_out_pixel_clock, vga_out_hsync,
	       vga_out_vsync,

	       tv_out_ycrcb, tv_out_reset_b, tv_out_clock, tv_out_i2c_clock,
	       tv_out_i2c_data, tv_out_pal_ntsc, tv_out_hsync_b,
	       tv_out_vsync_b, tv_out_blank_b, tv_out_subcar_reset,

	       tv_in_ycrcb, tv_in_data_valid, tv_in_line_clock1,
	       tv_in_line_clock2, tv_in_aef, tv_in_hff, tv_in_aff,
	       tv_in_i2c_clock, tv_in_i2c_data, tv_in_fifo_read,
	       tv_in_fifo_clock, tv_in_iso, tv_in_reset_b, tv_in_clock,

	       ram0_data, ram0_address, ram0_adv_ld, ram0_clk, ram0_cen_b,
	       ram0_ce_b, ram0_oe_b, ram0_we_b, ram0_bwe_b, 

	       ram1_data, ram1_address, ram1_adv_ld, ram1_clk, ram1_cen_b,
	       ram1_ce_b, ram1_oe_b, ram1_we_b, ram1_bwe_b,

	       clock_feedback_out, clock_feedback_in,

	       flash_data, flash_address, flash_ce_b, flash_oe_b, flash_we_b,
	       flash_reset_b, flash_sts, flash_byte_b,

	       rs232_txd, rs232_rxd, rs232_rts, rs232_cts,

	       mouse_clock, mouse_data, keyboard_clock, keyboard_data,

	       clock_27mhz, clock1, clock2,

	       disp_blank, disp_data_out, disp_clock, disp_rs, disp_ce_b,
	       disp_reset_b, disp_data_in,

	       button0, button1, button2, button3, button_enter, button_right,
	       button_left, button_down, button_up,

	       switch,

	       led,
	       
	       user1, user2, user3, user4,
	       
	       daughtercard,

	       systemace_data, systemace_address, systemace_ce_b,
	       systemace_we_b, systemace_oe_b, systemace_irq, systemace_mpbrdy,
	       
	       analyzer1_data, analyzer1_clock,
 	       analyzer2_data, analyzer2_clock,
 	       analyzer3_data, analyzer3_clock,
 	       analyzer4_data, analyzer4_clock);

   output beep, audio_reset_b, ac97_synch, ac97_sdata_out;
   input  ac97_bit_clock, ac97_sdata_in;
   
   output [7:0] vga_out_red, vga_out_green, vga_out_blue;
   output vga_out_sync_b, vga_out_blank_b, vga_out_pixel_clock,
	  vga_out_hsync, vga_out_vsync;

   output [9:0] tv_out_ycrcb;
   output tv_out_reset_b, tv_out_clock, tv_out_i2c_clock, tv_out_i2c_data,
	  tv_out_pal_ntsc, tv_out_hsync_b, tv_out_vsync_b, tv_out_blank_b,
	  tv_out_subcar_reset;
   
   input  [19:0] tv_in_ycrcb;
   input  tv_in_data_valid, tv_in_line_clock1, tv_in_line_clock2, tv_in_aef,
	  tv_in_hff, tv_in_aff;
   output tv_in_i2c_clock, tv_in_fifo_read, tv_in_fifo_clock, tv_in_iso,
	  tv_in_reset_b, tv_in_clock;
   inout  tv_in_i2c_data;
        
   inout  [35:0] ram0_data;
   output [18:0] ram0_address;
   output ram0_adv_ld, ram0_clk, ram0_cen_b, ram0_ce_b, ram0_oe_b, ram0_we_b;
   output [3:0] ram0_bwe_b;
   
   inout  [35:0] ram1_data;
   output [18:0] ram1_address;
   output ram1_adv_ld, ram1_clk, ram1_cen_b, ram1_ce_b, ram1_oe_b, ram1_we_b;
   output [3:0] ram1_bwe_b;

   input  clock_feedback_in;
   output clock_feedback_out;
   
   inout  [15:0] flash_data;
   output [23:0] flash_address;
   output flash_ce_b, flash_oe_b, flash_we_b, flash_reset_b, flash_byte_b;
   input  flash_sts;
   
   output rs232_txd, rs232_rts;
   input  rs232_rxd, rs232_cts;

   input  mouse_clock, mouse_data, keyboard_clock, keyboard_data;

   input  clock_27mhz, clock1, clock2;

   output disp_blank, disp_clock, disp_rs, disp_ce_b, disp_reset_b;  
   input  disp_data_in;
   output  disp_data_out;
   
   input  button0, button1, button2, button3, button_enter, button_right,
	  button_left, button_down, button_up;
   input  [7:0] switch;
   output [7:0] led;

   inout [31:0] user1, user2, user3, user4;
   
   inout [43:0] daughtercard;

   inout  [15:0] systemace_data;
   output [6:0]  systemace_address;
   output systemace_ce_b, systemace_we_b, systemace_oe_b;
   input  systemace_irq, systemace_mpbrdy;

   output [15:0] analyzer1_data, analyzer2_data, analyzer3_data, 
		 analyzer4_data;
   output analyzer1_clock, analyzer2_clock, analyzer3_clock, analyzer4_clock;
   ////////////////////////////////////////////////////////////////////////////
   //
   // I/O Assignments
   //
   ////////////////////////////////////////////////////////////////////////////
   
   // Audio Input and Output
   assign beep= 1'b0;
   /*assign audio_reset_b = 1'b0;
   assign ac97_synch = 1'b0;
   assign ac97_sdata_out = 1'b0;*/
   // ac97_sdata_in is an input

   // Video Output
   assign tv_out_ycrcb = 10'h0;
   assign tv_out_reset_b = 1'b0;
   assign tv_out_clock = 1'b0;
   assign tv_out_i2c_clock = 1'b0;
   assign tv_out_i2c_data = 1'b0;
   assign tv_out_pal_ntsc = 1'b0;
   assign tv_out_hsync_b = 1'b1;
   assign tv_out_vsync_b = 1'b1;
   assign tv_out_blank_b = 1'b1;
   assign tv_out_subcar_reset = 1'b0;
   
   // Video Input
   assign tv_in_i2c_clock = 1'b0;
   assign tv_in_fifo_read = 1'b0;
   assign tv_in_fifo_clock = 1'b0;
   assign tv_in_iso = 1'b0;
   assign tv_in_reset_b = 1'b0;
   assign tv_in_clock = 1'b0;
   assign tv_in_i2c_data = 1'bZ;
   // tv_in_ycrcb, tv_in_data_valid, tv_in_line_clock1, tv_in_line_clock2, 
   // tv_in_aef, tv_in_hff, and tv_in_aff are inputs
   
   // SRAMs
   assign ram0_data = 36'hZ;
   assign ram0_address = 19'h0;
   assign ram0_adv_ld = 1'b0;
   assign ram0_clk = 1'b0;
   assign ram0_cen_b = 1'b1;
   assign ram0_ce_b = 1'b1;
   assign ram0_oe_b = 1'b1;
   assign ram0_we_b = 1'b1;
   assign ram0_bwe_b = 4'hF;
   assign ram1_data = 36'hZ; 
   assign ram1_address = 19'h0;
   assign ram1_adv_ld = 1'b0;
   assign ram1_clk = 1'b0;
   assign ram1_cen_b = 1'b1;
   assign ram1_ce_b = 1'b1;
   assign ram1_oe_b = 1'b1;
   assign ram1_we_b = 1'b1;
   assign ram1_bwe_b = 4'hF;
   assign clock_feedback_out = 1'b0;
   // clock_feedback_in is an input
   
   // Flash ROM
   assign flash_data = 16'hZ;
   assign flash_address = 24'h0;
   assign flash_ce_b = 1'b1;
   assign flash_oe_b = 1'b1;
   assign flash_we_b = 1'b1;
   assign flash_reset_b = 1'b0;
   assign flash_byte_b = 1'b1;
   // flash_sts is an input

   // RS-232 Interface
   assign rs232_txd = 1'b1;
   assign rs232_rts = 1'b1;
   // rs232_rxd and rs232_cts are inputs

   // PS/2 Ports
   // mouse_clock, mouse_data, keyboard_clock, and keyboard_data are inputs

   // LED Displays
/*   assign disp_blank = 1'b1;
   assign disp_clock = 1'b0;
   assign disp_rs = 1'b0;
   assign disp_ce_b = 1'b1;
   assign disp_reset_b = 1'b0;
   assign disp_data_out = 1'b0;*/
   // disp_data_in is an input

   // Buttons, Switches, and Individual LEDs
   //lab3 assign led = 8'hFF;
   // button0, button1, button2, button3, button_enter, button_right,
   // button_left, button_down, button_up, and switches are inputs



   // User I/Os
   assign user1 = 32'hZ;
   assign user2 = 32'hZ;
   assign user3[24] = 0;
   assign user4[29:0] = 30'hZ;

   // Daughtercard Connectors
   assign daughtercard = 44'hZ;

   // SystemACE Microprocessor Port
   assign systemace_data = 16'hZ;
   assign systemace_address = 7'h0;
   assign systemace_ce_b = 1'b1;
   assign systemace_we_b = 1'b1;
   assign systemace_oe_b = 1'b1;
   // systemace_irq and systemace_mpbrdy are inputs

   // Logic Analyzer
   assign analyzer1_data = 16'h0;
   assign analyzer1_clock = 1'b1;
   assign analyzer2_data = 16'h0;
   assign analyzer2_clock = 1'b1;
   assign analyzer3_data = 16'h0;
   assign analyzer3_clock = 1'b1;
   assign analyzer4_data = 16'h0;
   assign analyzer4_clock = 1'b1;
			    
   ////////////////////////////////////////////////////////////////////////////
   //
   // lab3 : a simple pong game
   //
   ////////////////////////////////////////////////////////////////////////////

   // use FPGA's digital clock manager to produce a
   // 65MHz clock (actually 64.8MHz)
   wire clock_65mhz_unbuf,clock_65mhz;
   DCM vclk1(.CLKIN(clock_27mhz),.CLKFX(clock_65mhz_unbuf));
   // synthesis attribute CLKFX_DIVIDE of vclk1 is 10
   // synthesis attribute CLKFX_MULTIPLY of vclk1 is 24
   // synthesis attribute CLK_FEEDBACK of vclk1 is NONE
   // synthesis attribute CLKIN_PERIOD of vclk1 is 37
   BUFG vclk2(.O(clock_65mhz),.I(clock_65mhz_unbuf));

   // power-on reset generation
   wire power_on_reset;    // remain high for first 16 clocks
   SRL16 reset_sr (.D(1'b0), .CLK(clock_65mhz), .Q(power_on_reset),
		   .A0(1'b1), .A1(1'b1), .A2(1'b1), .A3(1'b1));
   defparam reset_sr.INIT = 16'hFFFF;

   // ENTER button is user reset
   wire reset,user_reset;
   debounce db1(.reset(power_on_reset),.clock(clock_65mhz),.noisy(~button_enter),.clean(user_reset));
   assign reset = user_reset | power_on_reset;
   
   // UP and DOWN buttons for pong paddle
   wire up,down;
   debounce db2(.reset(reset),.clock(clock_65mhz),.noisy(~button_up),.clean(up));
   debounce db3(.reset(reset),.clock(clock_65mhz),.noisy(~button_down),.clean(down));

   // generate basic XVGA video signals
   wire [10:0] hcount;
   wire [9:0]  vcount;
   wire hsync,vsync,blank;
   xvga xvga1(.vclock(clock_65mhz),.hcount(hcount),.vcount(vcount),
              .hsync(hsync),.vsync(vsync),.blank(blank));

   // feed XVGA signals to user's pong game
   wire [23:0] pixel;
   wire phsync,pvsync,pblank;
	
	//Matt's stuff/////////////////////////////////////////////////////////
	wire adcClk, canCatch, canCatchClean, openIndex, openRing, open;
 
  wire [7:0] xData;
  wire [7:0] yData;
  wire [7:0] zData;
 
  assign xData = user3[7:0];
  assign yData = user3[15:8];
  assign zData = user3[23:16];
   
  assign openIndex = user4[31];
  assign openRing = user4[30];
 
  assign open = openRing && openIndex;
   
  clk_divide div(.clk(clock_27mhz), .adcClk(adcClk));
  canCatch catcher(.clk(clock_27mhz), .zData(zData), .canCatch(canCatch));
  assign user3[31] = adcClk;
 
  //Debounce can Catch signal to make it more useful
  debounce d0(.reset(0), .clock(clock_27_mhz), .noisy(canCatch), .clean(canCatchClean));
 
  wire [63:0] display;
  assign display = {3'b0, canCatch, 51'h0, open, zData};
  
  // Hex display setup     
  display_16hex display1(.reset(0), .clock_27mhz(clock_27mhz), .data(display),
        .disp_blank(disp_blank), .disp_clock(disp_clock), .disp_rs(disp_rs), .disp_ce_b(disp_ce_b),
        .disp_reset_b(disp_reset_b), .disp_data_out(disp_data_out));

	
	////////////////////////////////////////////////////////
	// signals for the game
	wire glove1closed;
	wire glove2closed;
	wire glove1x; // don't know format of coords yet
	wire glove1y;
	wire glove2x;
	wire glove2y;
	wire[5:0] dist;
	wire can_catch1;
	wire can_catch2;
	wire right_hand1;
	wire right_hand2;
	wire game_reset;
	wire soundtrigger;
	//will eventually be set by switches
	assign dist = 6'd6;
	assign can_catch1=canCatch;
	assign can_catch2=user1[1];
	assign glove1closed=~open;
	assign glove2closed=user1[0];
	assign game_reset = ~button_enter;
	/////////////////////////////////////////////////////////
	
	
   catch_game cg(.vclock(clock_65mhz),.reset(game_reset),
                .glove1closed(glove1closed),.glove2closed(glove2closed),
					 .rel_glove1x(glove1x),.rel_glove1y(glove1y),
					 .rel_glove2x(glove2x),.rel_glove2y(glove2y),
					 .dist(dist),
					 .test0(~button0),.test1(~button1),.test2(~button_right),
					 .can_catch1(can_catch1),.can_catch2(can_catch2),
					 .right_hand1(right_hand1),.right_hand2(right_hand2),
		.hcount(hcount),.vcount(vcount),
					.sound(soundtrigger),
                .hsync(hsync),.vsync(vsync),.blank(blank),
					 .debug(led[0]),
		.phsync(phsync),.pvsync(pvsync),.pblank(pblank),.pixel(pixel));

   // switch[1:0] selects which video generator to use:
   //  00: user's pong game
   //  01: 1 pixel outline of active video area (adjust screen controls)
   //  10: color bars
   reg [23:0] rgb;
   wire border = (hcount==0 | hcount==1023 | vcount==0 | vcount==767);
   
   reg b,hs,vs;
   always @(posedge clock_27mhz) begin
    hs <= phsync;
	 vs <= pvsync;
	 b <= pblank;
	 rgb <= pixel;
   end

   // VGA Output.  In order to meet the setup and hold times of the
   // AD7125, we send it ~clock_65mhz.
   assign vga_out_red = rgb[23:16];
   assign vga_out_green = rgb[15:8];
   assign vga_out_blue = rgb[7:0];
   assign vga_out_sync_b = 1'b1;    // not used
   assign vga_out_blank_b = ~b;
   assign vga_out_pixel_clock = ~clock_65mhz;
   assign vga_out_hsync = hs;
   assign vga_out_vsync = vs;
   
   assign led[7:1] = 7'b1111111;
	
	wire [4:0] volume = 5'b11111;
	
	reg synctrig;
	always @(posedge clock_27mhz) synctrig <= soundtrigger;
	
	sound s1(.clk(clock_27mhz),.trigger(synctrig),.ready(ready),.data(to_ac97_data));
	
	//assign led[1] = canCatch;
	// AC97 driver
   lab5audio a(clock_27mhz, reset, volume, to_ac97_data,ready,
	       audio_reset_b, ac97_sdata_out, ac97_sdata_in,
	       ac97_synch, ac97_bit_clock);

endmodule

module canCatch(input clk, input [7:0] zData, output reg canCatch = 1);
   always @(posedge clk) begin
       if( zData > 8'h47 || zData == 8'h00 || zData == 8'h40) canCatch <= 1;
        else canCatch <= 0;
    end
endmodule

module clk_divide (input clk, output reg adcClk = 0);
  reg [7:0] counter;
 
  always @(posedge clk) begin
     if(counter == 16) begin
        adcClk <= !adcClk;
         counter <= 0;
     end
    else counter <= counter + 1;
  end
endmodule

module display_16hex (reset, clock_27mhz, data,
        disp_blank, disp_clock, disp_rs, disp_ce_b,
        disp_reset_b, disp_data_out);

   input reset, clock_27mhz;    // clock and reset (active high reset)
   input [63:0] data;        // 16 hex nibbles to display
  
   output disp_blank, disp_clock, disp_data_out, disp_rs, disp_ce_b,
      disp_reset_b;
  
   reg disp_data_out, disp_rs, disp_ce_b, disp_reset_b;
  
   ////////////////////////////////////////////////////////////////////////////
   //
   // Display Clock
   //
   // Generate a 500kHz clock for driving the displays.
   //
   ////////////////////////////////////////////////////////////////////////////
  
   reg [4:0] count;
   reg [7:0] reset_count;
   reg clock;
   wire dreset;

   always @(posedge clock_27mhz)
     begin
    if (reset)
      begin
         count = 0;
         clock = 0;
      end
    else if (count == 26)
      begin
         clock = ~clock;
         count = 5'h00;
      end
    else
      count = count+1;
     end
  
   always @(posedge clock_27mhz)
     if (reset)
       reset_count <= 100;
     else
       reset_count <= (reset_count==0) ? 0 : reset_count-1;

   assign dreset = (reset_count != 0);

   assign disp_clock = ~clock;

   ////////////////////////////////////////////////////////////////////////////
   //
   // Display State Machine
   //
   ////////////////////////////////////////////////////////////////////////////
     
   reg [7:0] state;        // FSM state
   reg [9:0] dot_index;        // index to current dot being clocked out
   reg [31:0] control;        // control register
   reg [3:0] char_index;    // index of current character
   reg [39:0] dots;        // dots for a single digit
   reg [3:0] nibble;        // hex nibble of current character
  
   assign disp_blank = 1'b0; // low <= not blanked
  
   always @(posedge clock)
     if (dreset)
       begin
      state <= 0;
      dot_index <= 0;
      control <= 32'h7F7F7F7F;
       end
     else
       casex (state)
     8'h00:
       begin
          // Reset displays
          disp_data_out <= 1'b0;
          disp_rs <= 1'b0; // dot register
          disp_ce_b <= 1'b1;
          disp_reset_b <= 1'b0;        
          dot_index <= 0;
          state <= state+1;
       end
     
     8'h01:
       begin
          // End reset
          disp_reset_b <= 1'b1;
          state <= state+1;
       end
     
     8'h02:
       begin
          // Initialize dot register (set all dots to zero)
          disp_ce_b <= 1'b0;
          disp_data_out <= 1'b0; // dot_index[0];
          if (dot_index == 639)
        state <= state+1;
          else
        dot_index <= dot_index+1;
       end
     
     8'h03:
       begin
          // Latch dot data
          disp_ce_b <= 1'b1;
          dot_index <= 31;        // re-purpose to init ctrl reg
          disp_rs <= 1'b1; // Select the control register
          state <= state+1;
       end
     
     8'h04:
       begin
          // Setup the control register
          disp_ce_b <= 1'b0;
          disp_data_out <= control[31];
          control <= {control[30:0], 1'b0};    // shift left
          if (dot_index == 0)
        state <= state+1;
          else
        dot_index <= dot_index-1;
       end
     
     8'h05:
       begin
          // Latch the control register data / dot data
          disp_ce_b <= 1'b1;
          dot_index <= 39;        // init for single char
          char_index <= 15;        // start with MS char
          state <= state+1;
          disp_rs <= 1'b0;         // Select the dot register
       end
     
     8'h06:
       begin
          // Load the user's dot data into the dot reg, char by char
          disp_ce_b <= 1'b0;
          disp_data_out <= dots[dot_index]; // dot data from msb
          if (dot_index == 0)
            if (char_index == 0)
              state <= 5;            // all done, latch data
        else
        begin
          char_index <= char_index - 1;    // goto next char
          dot_index <= 39;
        end
          else
        dot_index <= dot_index-1;    // else loop thru all dots
       end

       endcase

   always @ (data or char_index)
     case (char_index)
       4'h0:          nibble <= data[3:0];
       4'h1:          nibble <= data[7:4];
       4'h2:          nibble <= data[11:8];
       4'h3:          nibble <= data[15:12];
       4'h4:          nibble <= data[19:16];
       4'h5:          nibble <= data[23:20];
       4'h6:          nibble <= data[27:24];
       4'h7:          nibble <= data[31:28];
       4'h8:          nibble <= data[35:32];
       4'h9:          nibble <= data[39:36];
       4'hA:          nibble <= data[43:40];
       4'hB:          nibble <= data[47:44];
       4'hC:          nibble <= data[51:48];
       4'hD:          nibble <= data[55:52];
       4'hE:          nibble <= data[59:56];
       4'hF:          nibble <= data[63:60];
     endcase
     
   always @(nibble)
     case (nibble)
       4'h0: dots <= 40'b00111110_01010001_01001001_01000101_00111110;
       4'h1: dots <= 40'b00000000_01000010_01111111_01000000_00000000;
       4'h2: dots <= 40'b01100010_01010001_01001001_01001001_01000110;
       4'h3: dots <= 40'b00100010_01000001_01001001_01001001_00110110;
       4'h4: dots <= 40'b00011000_00010100_00010010_01111111_00010000;
       4'h5: dots <= 40'b00100111_01000101_01000101_01000101_00111001;
       4'h6: dots <= 40'b00111100_01001010_01001001_01001001_00110000;
       4'h7: dots <= 40'b00000001_01110001_00001001_00000101_00000011;
       4'h8: dots <= 40'b00110110_01001001_01001001_01001001_00110110;
       4'h9: dots <= 40'b00000110_01001001_01001001_00101001_00011110;
       4'hA: dots <= 40'b01111110_00001001_00001001_00001001_01111110;
       4'hB: dots <= 40'b01111111_01001001_01001001_01001001_00110110;
       4'hC: dots <= 40'b00111110_01000001_01000001_01000001_00100010;
       4'hD: dots <= 40'b01111111_01000001_01000001_01000001_00111110;
       4'hE: dots <= 40'b01111111_01001001_01001001_01001001_01000001;
       4'hF: dots <= 40'b01111111_00001001_00001001_00001001_00000001;
     endcase
  
endmodule

