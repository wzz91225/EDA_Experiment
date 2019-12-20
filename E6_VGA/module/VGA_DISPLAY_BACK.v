// =================================================================================================
// Copyright(C) 2019 - wzz91225 PERSON. All rights reserved.
// =================================================================================================

// =================================================================================================
// File Name        :   VGA_DISPLAY_BACK
// Module           :   VGA_DISPLAY_BACK
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

module VGA_DISPLAY_BACK (
	input						VGA_CLK					, // (i) vga clk in
	input						RST_N					, // (i) reset, High Active
	input						VGA_IF_RGBEN_1			, // (i) 
	input			[10:0]		DISPLAY_X				, // (i)
	input			[10:0]		DISPLAY_Y				, // (i)
	input			[10:0]		CURRENT_X				, // (i)
	input			[10:0]		CURRENT_Y				, // (i)
	output			[23:0]		VGA_BUF_RGB				  // (o) 
);


// =============================================================================
// Defination of parameter
// =============================================================================
	parameter					Color_Cnt_Num			= 24'd2_000_000	;	// = 24'd6	;	// 

	// parameter					RGB_Cnt_Num1			= 4'd0			;
	parameter					RGB_Cnt_Num2			= 4'd0			;


// =============================================================================
// Defination of Internal Signals
// =============================================================================
	reg				[23:0]		r_VGA_BUF_RGB			;

	reg				[23:0]		r_color_cnt				;
	reg				[23:0]		r_rgb					;

	reg				[23:0]		r_rgb1					;
	// reg				[03:0]		r_rgbcnt1				;

	reg				[23:0]		r_rgb2					;
	reg				[03:0]		r_rgbcnt2				;



// =============================================================================
// RTL Body
// =============================================================================
	assign						VGA_BUF_RGB				= r_VGA_BUF_RGB;



	always @(posedge VGA_CLK or negedge RST_N) begin
		if (RST_N == 1'b0) begin
			r_VGA_BUF_RGB	<= 24'hff_ff_ff;
			r_rgb1			<= 24'hff_00_00;
			r_rgb2			<= 24'hff_00_00;
			// r_rgbcnt1		<= 4'd0;
			r_rgbcnt2		<= 4'd0;
		end else begin
			if (VGA_IF_RGBEN_1) begin
				r_VGA_BUF_RGB	<= r_rgb2;

				if (CURRENT_X == (DISPLAY_X - 11'd1)) begin
					if (CURRENT_Y == (DISPLAY_Y - 11'd1)) begin
						r_rgb1		<= r_rgb;
						r_rgb2		<= r_rgb;
					end else begin
						r_rgb1		<= r_rgb1;
						r_rgb2		<= r_rgb1;
					end

				end else begin
					r_rgb1		<= r_rgb1;
					
					r_rgbcnt2	<= r_rgbcnt2 + 4'd1;
					if (r_rgbcnt2 == RGB_Cnt_Num2) begin
						r_rgbcnt2	<= 4'd0;

						if ((r_rgb2[23:16] == 8'hff) && (r_rgb2[15:8] < 8'hff) && (r_rgb2[7:0] == 8'h00)) begin
							r_rgb2[15:8]	<= r_rgb2[15:8] + 8'h1;

						end else if ((r_rgb2[23:16] > 8'h00) && (r_rgb2[15:8] == 8'hff) && (r_rgb2[7:0] == 8'h00)) begin
							r_rgb2[23:16]	<= r_rgb2[23:16] - 8'h1;

						end else if ((r_rgb2[23:16] == 8'h00) && (r_rgb2[15:8] == 8'hff) && (r_rgb2[7:0] < 8'hff)) begin
							r_rgb2[7:0]		<= r_rgb2[7:0] + 8'h1;

						end else if ((r_rgb2[23:16] == 8'h00) && (r_rgb2[15:8] > 8'h00) && (r_rgb2[7:0] == 8'hff)) begin
							r_rgb2[15:8]	<= r_rgb2[15:8] - 8'h1;

						end else if ((r_rgb2[23:16] < 8'hff) && (r_rgb2[15:8] == 8'h00) && (r_rgb2[7:0] == 8'hff)) begin
							r_rgb2[23:16]	<= r_rgb2[23:16] + 8'h1;

						end else if ((r_rgb2[23:16] == 8'hff) && (r_rgb2[15:8] == 8'h00) && (r_rgb2[7:0] > 8'h00)) begin
							r_rgb2[7:0]		<= r_rgb2[7:0] - 8'h1;
						end
					end
				end

			end else begin
				r_VGA_BUF_RGB	<= 24'h00_00_00;
			end
		end
	end



	always @(posedge VGA_CLK or negedge RST_N) begin
		if (RST_N == 1'b0) begin
			r_color_cnt	<= 24'd0;
			r_rgb		<= 24'hff_00_00;
		end else begin
			if (VGA_IF_RGBEN_1) begin
				if (r_color_cnt < Color_Cnt_Num) begin
					r_color_cnt	<= r_color_cnt + 24'd1;
				end else begin
					r_color_cnt	<= 24'd0;

					if ((r_rgb[23:16] == 8'hff) && (r_rgb[15:8] < 8'hff) && (r_rgb[7:0] == 8'h00)) begin
						r_rgb[15:8]		<= r_rgb[15:8] + 8'h1;

					end else if ((r_rgb[23:16] > 8'h00) && (r_rgb[15:8] == 8'hff) && (r_rgb[7:0] == 8'h00)) begin
						r_rgb[23:16]	<= r_rgb[23:16] - 8'h1;

					end else if ((r_rgb[23:16] == 8'h00) && (r_rgb[15:8] == 8'hff) && (r_rgb[7:0] < 8'hff)) begin
						r_rgb[7:0]		<= r_rgb[7:0] + 8'h1;

					end else if ((r_rgb[23:16] == 8'h00) && (r_rgb[15:8] > 8'h00) && (r_rgb[7:0] == 8'hff)) begin
						r_rgb[15:8]		<= r_rgb[15:8] - 8'h1;

					end else if ((r_rgb[23:16] < 8'hff) && (r_rgb[15:8] == 8'h00) && (r_rgb[7:0] == 8'hff)) begin
						r_rgb[23:16]	<= r_rgb[23:16] + 8'h1;

					end else if ((r_rgb[23:16] == 8'hff) && (r_rgb[15:8] == 8'h00) && (r_rgb[7:0] > 8'h00)) begin
						r_rgb[7:0]		<= r_rgb[7:0] - 8'h1;

					end
				end
			end
		end
	end



endmodule
