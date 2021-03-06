// =================================================================================================
// Copyright(C) 2019 - wzz91225 PERSON. All rights reserved.
// =================================================================================================

// =================================================================================================
// File Name        :   VGA_DISPLAY_IMG_0
// Module           :   VGA_DISPLAY_IMG_0
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

module VGA_DISPLAY_IMG_0 (
	input						VGA_CLK					, // (i) vga clk in
	input						RST_N					, // (i) reset, High Active
	input						ENABLE					, // (i)
	input						VGA_IF_RGBEN_1			, // (i) 
	input			[10:0]		POSITION_X				, // (i) 
	input			[10:0]		POSITION_Y				, // (i) 
	input			[10:0]		CURRENT_X				, // (i)
	input			[10:0]		CURRENT_Y				, // (i)
	output						COVER					, // (o)
	output			[23:0]		VGA_BUF_RGB				  // (o) 
);


// =============================================================================
// Defination of parameter
// =============================================================================

	parameter		[10:0]		p_TXT_X					= 11'd16		;
	parameter		[10:0]		p_TXT_Y					= 11'd32		;

	parameter		[0:15]		p_TXT_00				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_01				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_02				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_03				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_04				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_05				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_06				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_07				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_08				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_09				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_10				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_11				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_12				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_13				= 16'b_0000000111000000	;
	parameter		[0:15]		p_TXT_14				= 16'b_0000000111000000	;
	parameter		[0:15]		p_TXT_15				= 16'b_0000000111000000	;
	parameter		[0:15]		p_TXT_16				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_17				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_18				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_19				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_20				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_21				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_22				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_23				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_24				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_25				= 16'b_0000000111000000	;
	parameter		[0:15]		p_TXT_26				= 16'b_0000000111000000	;
	parameter		[0:15]		p_TXT_27				= 16'b_0000000111000000	;
	parameter		[0:15]		p_TXT_28				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_29				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_30				= 16'b_0000000000000000	;
	parameter		[0:15]		p_TXT_31				= 16'b_0000000000000000	;



// =============================================================================
// Defination of Internal Signals
// =============================================================================
	reg							r_COVER					= 1'b0				;
	reg				[23:0]		r_VGA_BUF_RGB			= 24'h00_00_00		;

	wire						w_IN_POSTION			= ( (POSITION_Y <= CURRENT_Y) 
														&& (CURRENT_Y < POSITION_Y + p_TXT_Y) 
														&& (POSITION_X <= CURRENT_X) 
														&& (CURRENT_X < POSITION_X + p_TXT_X) ) ? 1'b1 : 1'b0;



// =============================================================================
// RTL Body
// =============================================================================
	assign						COVER					= r_COVER			;
	assign						VGA_BUF_RGB				= r_VGA_BUF_RGB		;
	


	always @(posedge VGA_CLK or negedge RST_N) begin
		if (RST_N == 1'b0) begin
			r_COVER			<= 1'b0;
			r_VGA_BUF_RGB	<= 24'h00_00_00;
		end else begin
			if ((ENABLE) && (w_IN_POSTION == 1'b1)) begin
				case (CURRENT_Y)
					(POSITION_Y + 11'd00):	r_COVER	<= p_TXT_00[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd01):	r_COVER	<= p_TXT_01[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd02):	r_COVER	<= p_TXT_02[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd03):	r_COVER	<= p_TXT_03[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd04):	r_COVER	<= p_TXT_04[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd05):	r_COVER	<= p_TXT_05[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd06):	r_COVER	<= p_TXT_06[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd07):	r_COVER	<= p_TXT_07[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd08):	r_COVER	<= p_TXT_08[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd09):	r_COVER	<= p_TXT_09[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd10):	r_COVER	<= p_TXT_10[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd11):	r_COVER	<= p_TXT_11[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd12):	r_COVER	<= p_TXT_12[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd13):	r_COVER	<= p_TXT_13[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd14):	r_COVER	<= p_TXT_14[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd15):	r_COVER	<= p_TXT_15[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd16):	r_COVER	<= p_TXT_16[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd17):	r_COVER	<= p_TXT_17[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd18):	r_COVER	<= p_TXT_18[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd19):	r_COVER	<= p_TXT_19[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd20):	r_COVER	<= p_TXT_20[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd21):	r_COVER	<= p_TXT_21[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd22):	r_COVER	<= p_TXT_22[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd23):	r_COVER	<= p_TXT_23[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd24):	r_COVER	<= p_TXT_24[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd25):	r_COVER	<= p_TXT_25[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd26):	r_COVER	<= p_TXT_26[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd27):	r_COVER	<= p_TXT_27[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd28):	r_COVER	<= p_TXT_28[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd29):	r_COVER	<= p_TXT_29[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd30):	r_COVER	<= p_TXT_30[CURRENT_X - POSITION_X];
					(POSITION_Y + 11'd31):	r_COVER	<= p_TXT_31[CURRENT_X - POSITION_X];
					default:				r_COVER	<= 1'b0;
				endcase
				r_VGA_BUF_RGB	<= 24'hff_ff_ff;
			end else begin
				r_COVER			<= 1'b0;
				r_VGA_BUF_RGB	<= 24'h00_00_00;
			end
		end
	end



endmodule
