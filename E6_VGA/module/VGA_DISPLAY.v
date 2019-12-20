// =================================================================================================
// Copyright(C) 2019 - wzz91225 PERSON. All rights reserved.
// =================================================================================================

// =================================================================================================
// File Name        :   VGA_DISPLAY
// Module           :   VGA_DISPLAY
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

module VGA_DISPLAY(
	input						VGA_CLK					, // (i) vga clk in
	input						RST_N					, // (i) reset, High Active
	input						VGA_IF_RGBEN			, // (i) 
	input			[23:0]		NUMBER_BCD				, // (i)
	output			[23:0]		VGA_BUF_RGB				  // (o) out
);


// =============================================================================
// Defination of parameter
// =============================================================================
	parameter					p_DISPLAY_X				= 11'd1024		,	// = 11'd5	,	//	
								p_DISPLAY_Y				= 11'd768		;	// = 11'd4	;	//	


// =============================================================================
// Defination of Internal Signals
// =============================================================================
	wire						w_VGA_IF_RGBEN_1		;
	reg							r_VGA_IF_RGBEN_1		;

	wire			[10:0]		w_X						;
	reg				[10:0]		r_X						;
	wire			[10:0]		w_Y						;
	reg				[10:0]		r_Y						;

	wire			[23:0]		w_VGA_BUF_RGB_0			;

	wire			[23:0]		w_VGA_BUF_RGB_BACK		;


	wire						w_DISPLAY_COVER_TXT_0	;
	wire						w_DISPLAY_COVER_TXT_1_0	;
	wire						w_DISPLAY_COVER_TXT_1_1	;

	wire			[23:0]		w_VGA_BUF_RGB_TXT_0		;
	wire			[23:0]		w_VGA_BUF_RGB_TXT_1_0	;
	wire			[23:0]		w_VGA_BUF_RGB_TXT_1_1	;


	wire						w_DISPLAY_COVER_NUM_0	;
	wire						w_DISPLAY_COVER_NUM_1	;
	wire						w_DISPLAY_COVER_NUM_2	;
	wire						w_DISPLAY_COVER_NUM_3	;
	wire						w_DISPLAY_COVER_NUM_4	;
	wire						w_DISPLAY_COVER_NUM_5	;

	wire			[23:0]		w_VGA_BUF_RGB_NUM_0		;
	wire			[23:0]		w_VGA_BUF_RGB_NUM_1		;
	wire			[23:0]		w_VGA_BUF_RGB_NUM_2		;
	wire			[23:0]		w_VGA_BUF_RGB_NUM_3		;
	wire			[23:0]		w_VGA_BUF_RGB_NUM_4		;
	wire			[23:0]		w_VGA_BUF_RGB_NUM_5		;

// =============================================================================
// RTL Body
// =============================================================================
	assign						w_VGA_IF_RGBEN_1		= r_VGA_IF_RGBEN_1	;
	assign						w_X						= r_X				;
	assign						w_Y						= r_Y				;


	assign						VGA_BUF_RGB				= ((w_DISPLAY_COVER_NUM_0) ? (w_VGA_BUF_RGB_NUM_0) 
														: ((w_DISPLAY_COVER_NUM_1) ? (w_VGA_BUF_RGB_NUM_1) 
														: ((w_DISPLAY_COVER_NUM_2) ? (w_VGA_BUF_RGB_NUM_2) 
														: ((w_DISPLAY_COVER_NUM_3) ? (w_VGA_BUF_RGB_NUM_3) 
														: ((w_DISPLAY_COVER_NUM_4) ? (w_VGA_BUF_RGB_NUM_4) 
														: ((w_DISPLAY_COVER_NUM_5) ? (w_VGA_BUF_RGB_NUM_5) 
														: ((w_DISPLAY_COVER_TXT_0) ? (w_VGA_BUF_RGB_TXT_0)
														: ((w_DISPLAY_COVER_TXT_1_0) ? (w_VGA_BUF_RGB_TXT_1_0)
														: ((w_DISPLAY_COVER_TXT_1_1) ? (w_VGA_BUF_RGB_TXT_1_1)
														: (w_VGA_BUF_RGB_BACK) )))))))));


	assign						w_VGA_BUF_RGB_0			= 24'hff_ff_ff		;



	VGA_DISPLAY_BACK VGA_DISPLAY_BACK_inst (
		.VGA_CLK				( VGA_CLK				), // (i) vga clk in
		.RST_N					( RST_N					), // (i) reset, High Active
		.VGA_IF_RGBEN_1			( w_VGA_IF_RGBEN_1		), // (i) 
		.DISPLAY_X				( p_DISPLAY_X			), // (i)
		.DISPLAY_Y				( p_DISPLAY_Y			), // (i)
		.CURRENT_X				( w_X					), // (i)
		.CURRENT_Y				( w_Y					), // (i)
		.VGA_BUF_RGB			( w_VGA_BUF_RGB_BACK	)  // (o) 
	);



	VGA_DISPLAY_TXT_0 VGA_DISPLAY_TXT_0_inst_0 (
		.VGA_CLK				( VGA_CLK					), // (i) vga clk in
		.RST_N					( RST_N						), // (i) reset, High Active
		.ENABLE					( 1'b1						), // (o)
		.VGA_IF_RGBEN_1			( w_VGA_IF_RGBEN_1			), // (i) 
		.POSITION_X				( 11'd480					), // (i) 
		.POSITION_Y				( 11'd368					), // (i) 
		.CURRENT_X				( w_X						), // (i)
		.CURRENT_Y				( w_Y						), // (i)
		.COVER					( w_DISPLAY_COVER_TXT_1_0	), // (o)
		.VGA_BUF_RGB			( w_VGA_BUF_RGB_TXT_1_0		)  // (o) 
	);



	VGA_DISPLAY_TXT_0 VGA_DISPLAY_TXT_0_inst_1 (
		.VGA_CLK				( VGA_CLK					), // (i) vga clk in
		.RST_N					( RST_N						), // (i) reset, High Active
		.ENABLE					( 1'b1						), // (o)
		.VGA_IF_RGBEN_1			( w_VGA_IF_RGBEN_1			), // (i) 
		.POSITION_X				( 11'd528					), // (i) 
		.POSITION_Y				( 11'd368					), // (i) 
		.CURRENT_X				( w_X						), // (i)
		.CURRENT_Y				( w_Y						), // (i)
		.COVER					( w_DISPLAY_COVER_TXT_1_1	), // (o)
		.VGA_BUF_RGB			( w_VGA_BUF_RGB_TXT_1_1		)  // (o) 
	);



	VGA_DISPLAY_TXT_1 VGA_DISPLAY_TXT_1_inst (
		.VGA_CLK				( VGA_CLK				), // (i) vga clk in
		.RST_N					( RST_N					), // (i) reset, High Active
		.ENABLE					( 1'b1					), // (o)
		.VGA_IF_RGBEN_1			( w_VGA_IF_RGBEN_1		), // (i) 
		.POSITION_X				( 11'd200				), // (i) 
		.POSITION_Y				( 11'd100				), // (i) 
		.CURRENT_X				( w_X					), // (i)
		.CURRENT_Y				( w_Y					), // (i)
		.COVER					( w_DISPLAY_COVER_TXT_0	), // (o)
		.VGA_BUF_RGB			( w_VGA_BUF_RGB_TXT_0	)  // (o) 
	);



	VGA_DISPLAY_TXT_2 VGA_DISPLAY_TXT_2_inst (
		.VGA_CLK				( VGA_CLK				), // (i) vga clk in
		.RST_N					( RST_N					), // (i) reset, High Active
		.ENABLE					( 1'b1					), // (o)
		.VGA_IF_RGBEN_1			( w_VGA_IF_RGBEN_1		), // (i) 
		.POSITION_X				( 11'd200				), // (i) 
		.POSITION_Y				( 11'd148				), // (i) 
		.CURRENT_X				( w_X					), // (i)
		.CURRENT_Y				( w_Y					), // (i)
		.COVER					( w_DISPLAY_COVER_TXT_2	), // (o)
		.VGA_BUF_RGB			( w_VGA_BUF_RGB_TXT_2	)  // (o) 
	);



	VGA_DISPLAY_NUM VGA_DISPLAY_NUM_inst_0 (
		.VGA_CLK				( VGA_CLK				), // (i) vga clk in
		.RST_N					( RST_N					), // (i) reset, High Active
		.ENABLE					( 1'b1					), // (i) 
		.VGA_IF_RGBEN_1			(  w_VGA_IF_RGBEN_1		), // (i) 
		.POSITION_X				( 11'd560				), // (i) 
		.POSITION_Y				( 11'd368				), // (i) 
		.CURRENT_X				( w_X					), // (i) 
		.CURRENT_Y				( w_Y					), // (i) 
		.NUMBER					( NUMBER_BCD[ 3: 0]		), // (i) 
		.COVER					( w_DISPLAY_COVER_NUM_0	), // (o) 
		.VGA_BUF_RGB			( w_VGA_BUF_RGB_NUM_0	)  // (o) 
	);



	VGA_DISPLAY_NUM VGA_DISPLAY_NUM_inst_1 (
		.VGA_CLK				( VGA_CLK				), // (i) vga clk in
		.RST_N					( RST_N					), // (i) reset, High Active
		.ENABLE					( 1'b1					), // (i) 
		.VGA_IF_RGBEN_1			(  w_VGA_IF_RGBEN_1		), // (i) 
		.POSITION_X				( 11'd544				), // (i) 
		.POSITION_Y				( 11'd368				), // (i) 
		.CURRENT_X				( w_X					), // (i) 
		.CURRENT_Y				( w_Y					), // (i) 
		.NUMBER					( NUMBER_BCD[ 7: 4]		), // (i) 
		.COVER					( w_DISPLAY_COVER_NUM_1	), // (o) 
		.VGA_BUF_RGB			( w_VGA_BUF_RGB_NUM_1	)  // (o) 
	);



	VGA_DISPLAY_NUM VGA_DISPLAY_NUM_inst_2 (
		.VGA_CLK				( VGA_CLK				), // (i) vga clk in
		.RST_N					( RST_N					), // (i) reset, High Active
		.ENABLE					( 1'b1					), // (i) 
		.VGA_IF_RGBEN_1			(  w_VGA_IF_RGBEN_1		), // (i) 
		.POSITION_X				( 11'd512				), // (i) 
		.POSITION_Y				( 11'd368				), // (i) 
		.CURRENT_X				( w_X					), // (i) 
		.CURRENT_Y				( w_Y					), // (i) 
		.NUMBER					( NUMBER_BCD[11: 8]		), // (i) 
		.COVER					( w_DISPLAY_COVER_NUM_2	), // (o) 
		.VGA_BUF_RGB			( w_VGA_BUF_RGB_NUM_2	)  // (o) 
	);



	VGA_DISPLAY_NUM VGA_DISPLAY_NUM_inst_3 (
		.VGA_CLK				( VGA_CLK				), // (i) vga clk in
		.RST_N					( RST_N					), // (i) reset, High Active
		.ENABLE					( 1'b1					), // (i) 
		.VGA_IF_RGBEN_1			(  w_VGA_IF_RGBEN_1		), // (i) 
		.POSITION_X				( 11'd496				), // (i) 
		.POSITION_Y				( 11'd368				), // (i) 
		.CURRENT_X				( w_X					), // (i) 
		.CURRENT_Y				( w_Y					), // (i) 
		.NUMBER					( NUMBER_BCD[15:12]		), // (i) 
		.COVER					( w_DISPLAY_COVER_NUM_3	), // (o) 
		.VGA_BUF_RGB			( w_VGA_BUF_RGB_NUM_3	)  // (o) 
	);



	VGA_DISPLAY_NUM VGA_DISPLAY_NUM_inst_4 (
		.VGA_CLK				( VGA_CLK				), // (i) vga clk in
		.RST_N					( RST_N					), // (i) reset, High Active
		.ENABLE					( 1'b1					), // (i) 
		.VGA_IF_RGBEN_1			(  w_VGA_IF_RGBEN_1		), // (i) 
		.POSITION_X				( 11'd464				), // (i) 
		.POSITION_Y				( 11'd368				), // (i) 
		.CURRENT_X				( w_X					), // (i) 
		.CURRENT_Y				( w_Y					), // (i) 
		.NUMBER					( NUMBER_BCD[19:16]		), // (i) 
		.COVER					( w_DISPLAY_COVER_NUM_4	), // (o) 
		.VGA_BUF_RGB			( w_VGA_BUF_RGB_NUM_4	)  // (o) 
	);



	VGA_DISPLAY_NUM VGA_DISPLAY_NUM_inst_5 (
		.VGA_CLK				( VGA_CLK				), // (i) vga clk in
		.RST_N					( RST_N					), // (i) reset, High Active
		.ENABLE					( 1'b1					), // (i) 
		.VGA_IF_RGBEN_1			(  w_VGA_IF_RGBEN_1		), // (i) 
		.POSITION_X				( 11'd448				), // (i) 
		.POSITION_Y				( 11'd368				), // (i) 
		.CURRENT_X				( w_X					), // (i) 
		.CURRENT_Y				( w_Y					), // (i) 
		.NUMBER					( NUMBER_BCD[23:20]		), // (i) 
		.COVER					( w_DISPLAY_COVER_NUM_5	), // (o) 
		.VGA_BUF_RGB			( w_VGA_BUF_RGB_NUM_5	)  // (o) 
	);


	
	always @(posedge VGA_CLK or negedge RST_N) begin
		if (!RST_N) begin
			r_VGA_IF_RGBEN_1	<= 1'b0;
		end else begin
			if (VGA_IF_RGBEN) begin
				r_VGA_IF_RGBEN_1	<= 1'b1;
			end else begin
				r_VGA_IF_RGBEN_1	<= 1'b0;
			end
		end
	end



	always @(posedge VGA_CLK or negedge RST_N) begin
		if (!RST_N) begin
			r_X		<= 11'd0;
			r_Y		<= 11'd0;
		end else begin
			if (w_VGA_IF_RGBEN_1) begin
				if (r_X < (p_DISPLAY_X - 11'd1)) begin
					r_X		<= r_X + 11'd1;
				end else begin
					r_X		<= 11'd0;
					if (r_Y < (p_DISPLAY_Y - 11'd1)) begin
						r_Y		<= r_Y + 11'd1;
					end else begin
						r_Y		<= 11'd0;
					end
				end
			end else begin
				r_X		<= r_X;
				r_Y		<= r_Y;
			end
		end
	end



endmodule
