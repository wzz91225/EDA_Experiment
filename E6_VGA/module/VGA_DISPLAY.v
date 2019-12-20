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

	wire			[23:0]		w_VGA_BUF_RGB_1			;

	wire						w_DISPLAY_2_ENABLE		;
	wire			[23:0]		w_VGA_BUF_RGB_2			;

// =============================================================================
// RTL Body
// =============================================================================
	assign						w_VGA_IF_RGBEN_1		= r_VGA_IF_RGBEN_1	;
	assign						w_X						= r_X				;
	assign						w_Y						= r_Y				;


	assign						VGA_BUF_RGB				= ((w_DISPLAY_2_ENABLE) ? (w_VGA_BUF_RGB_2) : (w_VGA_BUF_RGB_1))	;


	assign						w_VGA_BUF_RGB_0			= 24'hff_ff_ff		;



	VGA_DISPLAY_1 VGA_DISPLAY_1_inst (
		.VGA_CLK				( VGA_CLK				), // (i) vga clk in
		.RST_N					( RST_N					), // (i) reset, High Active
		.VGA_IF_RGBEN_1			( w_VGA_IF_RGBEN_1		), // (i) 
		.DISPLAY_X				( p_DISPLAY_X			), // (i)
		.DISPLAY_Y				( p_DISPLAY_Y			), // (i)
		.CURRENT_X				( w_X					), // (i)
		.CURRENT_Y				( w_Y					), // (i)
		.VGA_BUF_RGB			( w_VGA_BUF_RGB_1		)  // (o) 
	);



	VGA_DISPLAY_2 VGA_DISPLAY_2_inst (
		.VGA_CLK				( VGA_CLK				), // (i) vga clk in
		.RST_N					( RST_N					), // (i) reset, High Active
		.VGA_IF_RGBEN_1			( w_VGA_IF_RGBEN_1		), // (i) 
		.CURRENT_X				( w_X					), // (i)
		.CURRENT_Y				( w_Y					), // (i)
		.ENABLE					( w_DISPLAY_2_ENABLE	), // (o)
		.VGA_BUF_RGB			( w_VGA_BUF_RGB_2		)  // (o) 
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
