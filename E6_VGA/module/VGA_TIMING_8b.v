// =================================================================================================
// Copyright(C) 2019 - wzz91225 PERSON. All rights reserved.
// =================================================================================================

// =================================================================================================
// File Name        :   VGA_TIMING_8b
// Module           :   VGA_TIMING_8b
// Function         :   
// Type             :   RTL
// -------------------------------------------------------------------------------------------------
// Update History   :
// -------------------------------------------------------------------------------------------------
// Rev.Level    Date            Coded by            Contents
// 0.0.1        2019/12/20      wzz91225            Change to 8b
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

module VGA_TIMING_8b(
	input						VGA_CLK					, // (i) 65M clock
	input						VGA_RST_N				, // (i) reset, High Active

	output						VGA_HSYNC				, // (o) HSYNC signal
	output						VGA_VSYNC				, // (o) VSYNC signal
	output			[ 7:0]		VGA_R					, // (o) Red signal
	output			[ 7:0]		VGA_G					, // (o) Green signal
	output			[ 7:0]		VGA_B					, // (o) Blue signal
	output						VGA_SYNC_N				, // (o) 0
	output						VGA_BLANK_N				, // (o) 1

	output						VGA_DE					, // (o) DE signal
	output						VGA_IF_RGBEN			, // (o) if RGB enable
	input			[23:0]		VGA_BUF_RGB				  // (i) buffer RGB
);


// =============================================================================
// Defination of parameter
// =============================================================================
	parameter					VGA_H_SyncPulse			= 11'd136			; // Horizontal	Sync Pulse		//	= 11'd9;	//	
	parameter					VGA_H_BackPorch			= 11'd160			; // Horizontal	back porch		//	= 11'd7;	//	
	parameter					VGA_H_ActiveVideo		= 11'd1024			; // Horizontal	active video	//	= 11'd5;	//	
	parameter					VGA_H_FrontPorch		= 11'd24			; // Horizontal	front porch		//	= 11'd3;	//	

	parameter					VGA_V_SyncPulse			= 10'd6				; // Vertical	Sync Pulse		//	= 11'd8;	//	
	parameter					VGA_V_BackPorch			= 10'd29			; // Vertical	back porch		//	= 11'd6;	//	
	parameter					VGA_V_ActiveVideo		= 10'd768			; // Vertical	active video	//	= 11'd4;	//	
	parameter					VGA_V_FrontPorch		= 10'd3				; // Vertical	front porch		//	= 11'd2;	//	


	parameter					VGA_H_time1				= VGA_H_SyncPulse					; // Horizontal	Sync Pulse
	parameter					VGA_H_time2				= VGA_H_time1 + VGA_H_BackPorch		; // Horizontal	back porch
	parameter					VGA_H_time3				= VGA_H_time2 + VGA_H_ActiveVideo	; // Horizontal	active video
	parameter					VGA_H_time4				= VGA_H_time3 + VGA_H_FrontPorch	; // Horizontal	front porch

	parameter					VGA_V_time1				= VGA_V_SyncPulse					; // Vertical	Sync Pulse
	parameter					VGA_V_time2				= VGA_V_time1 + VGA_V_BackPorch		; // Vertical	back porch
	parameter					VGA_V_time3				= VGA_V_time2 + VGA_V_ActiveVideo	; // Vertical	active video
	parameter					VGA_V_time4				= VGA_V_time3 + VGA_V_FrontPorch	; // Vertical	front porch


// =============================================================================
// Defination of Internal Signals
// =============================================================================
	reg							r_VGA_HSYNC				;
	reg							r_VGA_VSYNC				;
	reg							r_VGA_DE				;
	reg							r_VGA_IF_RGBEN			;
	reg				[ 7:0]		r_VGA_R					;
	reg				[ 7:0]		r_VGA_G					;
	reg				[ 7:0]		r_VGA_B					;


	reg				[10:0]		r_Hcount				; // H sync pulse count
	reg				[09:0]		r_Vcount				; // H sync pulse count

	wire						s_if_acitve				; // Active


// =============================================================================
// RTL Body
// =============================================================================
	assign		VGA_HSYNC		= r_VGA_HSYNC			;
	assign		VGA_VSYNC		= r_VGA_VSYNC			;
	assign		VGA_DE			= r_VGA_DE				;
	assign		VGA_IF_RGBEN	= r_VGA_IF_RGBEN		;
	assign		VGA_R			= r_VGA_R				;
	assign		VGA_G			= r_VGA_G				;
	assign		VGA_B			= r_VGA_B				;

	assign		VGA_SYNC_N		= 1'b0					;
	assign		VGA_BLANK_N		= 1'b1					;

	assign		s_if_acitve		= ((VGA_V_time2 < r_Vcount) && (r_Vcount <= VGA_V_time3)) ? 1'b1 : 1'b0;



	//---------------------------------------------------------------------
    // V Control
    //---------------------------------------------------------------------
	always @(negedge VGA_HSYNC or negedge VGA_RST_N) begin
		if (!VGA_RST_N) begin
			r_Vcount		<= 10'd0;
			r_VGA_VSYNC		<= 1'b1;
		end else begin

			if (r_Vcount < VGA_V_time1) begin
				r_Vcount		<= r_Vcount + 10'd1;
				r_VGA_VSYNC		<= 1'b0;

			end else if (r_Vcount < VGA_V_time2) begin
				r_Vcount		<= r_Vcount + 10'd1;
				r_VGA_VSYNC		<= 1'b1;

			end else if (r_Vcount < VGA_V_time3) begin
				r_Vcount		<= r_Vcount + 10'd1;
				r_VGA_VSYNC		<= 1'b1;				

			end else if (r_Vcount < VGA_V_time4) begin
				if (r_Vcount == VGA_V_time4 - 10'd1) begin
					r_Vcount		<= 10'd0;
				end else begin
					r_Vcount		<= r_Vcount + 10'd1;
				end
				
				r_VGA_VSYNC		<= 1'b1;

			end else begin
				r_Vcount		<= 10'd0;
				r_VGA_VSYNC		<= 1'b1;
			end
		end
	end



	//---------------------------------------------------------------------
    // H Control
    //---------------------------------------------------------------------
	always @(posedge VGA_CLK or negedge VGA_RST_N) begin
		if (!VGA_RST_N) begin
			r_Hcount		<= 0;

			r_VGA_HSYNC		<= 1'b1;
			r_VGA_DE		<= 1'b0;
			r_VGA_IF_RGBEN	<= 1'b0;

			r_VGA_R			<= 8'h0;
			r_VGA_G			<= 8'h0;
			r_VGA_B			<= 8'h0;
		end else begin


			if (r_Hcount < VGA_H_time1) begin
				r_Hcount		<= r_Hcount + 11'd1;

				r_VGA_HSYNC		<= 1'b0;
				r_VGA_DE		<= 1'b0;
				r_VGA_IF_RGBEN	<= 1'b0;

				r_VGA_R			<= 8'h0;
				r_VGA_G			<= 8'h0;
				r_VGA_B			<= 8'h0;


			end else if (r_Hcount < VGA_H_time2) begin
				r_Hcount		<= r_Hcount + 11'd1;

				r_VGA_HSYNC		<= 1'b1;
				r_VGA_DE		<= 1'b0;


				if (s_if_acitve) begin
					if (r_Hcount < VGA_H_time2 - 11'd3) begin
						r_VGA_IF_RGBEN	<= 1'b0;
					end else begin
						r_VGA_IF_RGBEN	<= 1'b1;
					end
				end else begin
					r_VGA_IF_RGBEN	<= 1'b0;
				end
				
				r_VGA_R			<= 8'h0;
				r_VGA_G			<= 8'h0;
				r_VGA_B			<= 8'h0;


			end else if (r_Hcount < VGA_H_time3) begin
				r_Hcount		<= r_Hcount + 11'd1;

				r_VGA_HSYNC		<= 1'b1;

				if (s_if_acitve) begin
					r_VGA_DE		<= 1'b1;
					if (r_Hcount < VGA_H_time3 - 11'd3) begin
						r_VGA_IF_RGBEN	<= 1'b1;
					end else begin
						r_VGA_IF_RGBEN	<= 1'b0;
					end

					r_VGA_R			<= VGA_BUF_RGB[23:16];
					r_VGA_G			<= VGA_BUF_RGB[15: 8];
					r_VGA_B			<= VGA_BUF_RGB[ 7: 0];
				end else begin
					r_VGA_DE		<= 1'b0;
					r_VGA_IF_RGBEN	<= 1'b0;
				
					r_VGA_R			<= 8'h0;
					r_VGA_G			<= 8'h0;
					r_VGA_B			<= 8'h0;
				end
				

			end else if (r_Hcount < VGA_H_time4) begin
				if (r_Hcount == VGA_H_time4 - 11'd1) begin
					r_Hcount		<= 11'd0;
				end else begin
					r_Hcount		<= r_Hcount + 11'd1;
				end

				r_VGA_HSYNC		<= 1'b1;
				r_VGA_DE		<= 1'b0;
				r_VGA_IF_RGBEN	<= 1'b0;
				
				r_VGA_R			<= 8'h0;
				r_VGA_G			<= 8'h0;
				r_VGA_B			<= 8'h0;
				

			end else begin
				r_Hcount		<= 0;

				r_VGA_HSYNC		<= 1'b1;
				r_VGA_DE		<= 1'b0;
				r_VGA_IF_RGBEN	<= 1'b0;

				r_VGA_R			<= 8'h0;
				r_VGA_G			<= 8'h0;
				r_VGA_B			<= 8'h0;
			end	
		end
	end



endmodule
