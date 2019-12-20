// =================================================================================================
// Copyright(C) 2019 - wzz91225 PERSON. All rights reserved.
// =================================================================================================

// =================================================================================================
// File Name        :   VGA_DISPLAY_1
// Module           :   VGA_DISPLAY_1
// Function         :   
// Type             :   RTL
// -------------------------------------------------------------------------------------------------
// Update History   :
// -------------------------------------------------------------------------------------------------
// Rev.Level    Date            Coded by            Contents
// 0.0.1        2019/12/20      wzz91225            Create new
// =================================================================================================
// End Revision
// =================================================================================================

// =================================================================================================
// Timescale Define
// =================================================================================================
`timescale 1 ps/1 ps


// =================================================================================================
// Module Header
// =================================================================================================

module VGA_DISPLAY_2 (
	input						VGA_CLK					, // (i) vga clk in
	input						RST_N					, // (i) reset, High Active
	input						VGA_IF_RGBEN_1			, // (i) 
	input			[10:0]		CURRENT_X				, // (i)
	input			[10:0]		CURRENT_Y				, // (i)
	output						ENABLE					, // (o)
	output			[23:0]		VGA_BUF_RGB				  // (o) 
);


// =============================================================================
// Defination of parameter
// =============================================================================
	parameter		[10:0]		p_POSITION_X			= 11'd400		;
	parameter		[10:0]		p_POSITION_Y			= 11'd320		;

	parameter		[10:0]		p_TEXT_X				= 11'd64		;
	parameter		[10:0]		p_TEXT_Y				= 11'd32		;

	parameter		[0:63]		p_TEXT_00				= 64'b_00000000000000000000000001110000_00000000000000000000000000000000	;
	parameter		[0:63]		p_TEXT_01				= 64'b_00000000000000000000000001100000_00000100000000000000111000000000	;
	parameter		[0:63]		p_TEXT_02				= 64'b_00000000000000000000000001100000_00000111000000000000111000000000	;
	parameter		[0:63]		p_TEXT_03				= 64'b_00000000000000000000000001100000_00001111000000000000111000000000	;
	parameter		[0:63]		p_TEXT_04				= 64'b_01111111111100000000000001100000_00001110000000000000111000000000	;
	parameter		[0:63]		p_TEXT_05				= 64'b_01111111111100000000000001100000_00001110000000000000111000000000	;
	parameter		[0:63]		p_TEXT_06				= 64'b_01100000011100000000000001100000_00011111111100000000111000000000	;
	parameter		[0:63]		p_TEXT_07				= 64'b_01100000011100000000000001100000_00111111111100000000111000000000	;
	parameter		[0:63]		p_TEXT_08				= 64'b_01100000011101111111111111111111_00111000000001111111111111111100	;
	parameter		[0:63]		p_TEXT_09				= 64'b_01100000011101111111111111111111_01110000000000111111111111111100	;
	parameter		[0:63]		p_TEXT_10				= 64'b_01100000011101100000000001100001_11110000000000110000111000011100	;
	parameter		[0:63]		p_TEXT_11				= 64'b_01100000011100000000000001100000_11100000000000110000111000011100	;
	parameter		[0:63]		p_TEXT_12				= 64'b_01100000011100000000000001100000_11011111111000110000111000011100	;
	parameter		[0:63]		p_TEXT_13				= 64'b_01111111111100000000000001100000_00011111111000110000111000011100	;
	parameter		[0:63]		p_TEXT_14				= 64'b_01111111111100000100000001100000_00000111000000110000111000011100	;
	parameter		[0:63]		p_TEXT_15				= 64'b_01100000011100011100000001100000_00000111000000110000111000011100	;
	parameter		[0:63]		p_TEXT_16				= 64'b_01100000011100001110000001100000_00000111000000110000111000011100	;
	parameter		[0:63]		p_TEXT_17				= 64'b_01100000011100001110000001100000_00000111000000110000111000011100	;
	parameter		[0:63]		p_TEXT_18				= 64'b_01100000011100000111000001100000_01111111111100110000111000011100	;
	parameter		[0:63]		p_TEXT_19				= 64'b_01100000011100000111000001100000_01111111111100111111111111111100	;
	parameter		[0:63]		p_TEXT_20				= 64'b_01100000011100000011000001100000_00000111000000111111111111111100	;
	parameter		[0:63]		p_TEXT_21				= 64'b_01100000011100000000000001100000_00000111000000110000111000011100	;
	parameter		[0:63]		p_TEXT_22				= 64'b_01111111111100000000000001100000_00000111000000110000111000011100	;
	parameter		[0:63]		p_TEXT_23				= 64'b_01111111111100000000000001100000_00000111000001110000111000011100	;
	parameter		[0:63]		p_TEXT_24				= 64'b_01100000011100000000000001100000_00000111001000000000111000000000	;
	parameter		[0:63]		p_TEXT_25				= 64'b_01100000011100000000000001100000_00000111011100000000111000000000	;
	parameter		[0:63]		p_TEXT_26				= 64'b_01100000011100000000000001100000_00000111111100000000111000000000	;
	parameter		[0:63]		p_TEXT_27				= 64'b_01100000000000000000000001100000_00000111111000000000111000000000	;
	parameter		[0:63]		p_TEXT_28				= 64'b_01100000000000000000000011100000_00001111100000000000111000000000	;
	parameter		[0:63]		p_TEXT_29				= 64'b_00000000000000000000111111100000_00001111000000000000111000000000	;
	parameter		[0:63]		p_TEXT_30				= 64'b_00000000000000000000011111100000_00000110000000000000111000000000	;
	parameter		[0:63]		p_TEXT_31				= 64'b_00000000000000000000011110000000_00000000000000000000111000000000	;



// =============================================================================
// Defination of Internal Signals
// =============================================================================
	reg							r_ENABLE				= 1'b0				;
	reg				[23:0]		r_VGA_BUF_RGB			= 24'h00_00_00		;

	wire						w_IN_POSTION			= ( (p_POSITION_Y <= CURRENT_Y) 
														&& (CURRENT_Y < p_POSITION_Y + p_TEXT_Y) 
														&& (p_POSITION_X <= CURRENT_X) 
														&& (CURRENT_X < p_POSITION_X + p_TEXT_X) ) ? 1'b1 : 1'b0;



// =============================================================================
// RTL Body
// =============================================================================
	assign						ENABLE					= r_ENABLE			;
	assign						VGA_BUF_RGB				= r_VGA_BUF_RGB		;
	


	always @(posedge VGA_CLK or negedge RST_N) begin
		if (RST_N == 1'b0) begin
			r_ENABLE		<= 1'b0;
			r_VGA_BUF_RGB	<= 24'h00_00_00;
		end else begin
			if (w_IN_POSTION == 1'b1) begin
				case (CURRENT_Y)
					(p_POSITION_Y + 11'd00):	r_ENABLE	<= p_TEXT_00[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd01):	r_ENABLE	<= p_TEXT_01[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd02):	r_ENABLE	<= p_TEXT_02[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd03):	r_ENABLE	<= p_TEXT_03[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd04):	r_ENABLE	<= p_TEXT_04[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd05):	r_ENABLE	<= p_TEXT_05[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd06):	r_ENABLE	<= p_TEXT_06[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd07):	r_ENABLE	<= p_TEXT_07[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd08):	r_ENABLE	<= p_TEXT_08[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd09):	r_ENABLE	<= p_TEXT_09[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd10):	r_ENABLE	<= p_TEXT_10[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd11):	r_ENABLE	<= p_TEXT_11[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd12):	r_ENABLE	<= p_TEXT_12[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd13):	r_ENABLE	<= p_TEXT_13[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd14):	r_ENABLE	<= p_TEXT_14[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd15):	r_ENABLE	<= p_TEXT_15[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd16):	r_ENABLE	<= p_TEXT_16[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd17):	r_ENABLE	<= p_TEXT_17[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd18):	r_ENABLE	<= p_TEXT_18[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd19):	r_ENABLE	<= p_TEXT_19[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd20):	r_ENABLE	<= p_TEXT_20[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd21):	r_ENABLE	<= p_TEXT_21[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd22):	r_ENABLE	<= p_TEXT_22[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd23):	r_ENABLE	<= p_TEXT_23[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd24):	r_ENABLE	<= p_TEXT_24[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd25):	r_ENABLE	<= p_TEXT_25[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd26):	r_ENABLE	<= p_TEXT_26[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd27):	r_ENABLE	<= p_TEXT_27[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd28):	r_ENABLE	<= p_TEXT_28[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd29):	r_ENABLE	<= p_TEXT_29[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd30):	r_ENABLE	<= p_TEXT_30[CURRENT_X - p_POSITION_X];
					(p_POSITION_Y + 11'd31):	r_ENABLE	<= p_TEXT_31[CURRENT_X - p_POSITION_X];
				endcase
				r_VGA_BUF_RGB	<= 24'hff_ff_ff;
			end else begin
				r_ENABLE		<= 1'b0;
				r_VGA_BUF_RGB	<= 24'h00_00_00;
			end
		end
	end



endmodule
