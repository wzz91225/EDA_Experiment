module E6_VGA (
	input						RST_N					, // (i)
	input						CLK						, // (i)

	output						VGA_CLK					, // (o)
	output						VGA_HSYNC				, // (o) VGA Horizontal SYNC
	output						VGA_VSYNC				, // (o) VGA Vertical SYNC
	output			[ 7:0]		VGA_R					, // (o) VGA Red
	output			[ 7:0]		VGA_G					, // (o) VGA Green
	output			[ 7:0]		VGA_B					, // (o) VGA Blue
	output						VGA_SYNC_N				, // (o) 0
	output						VGA_BLANK_N				  // (o) 1
);



	wire						w_CLK_100M				;
	wire						w_CLK_200M				;
	wire						w_CLK_65M				;

	wire						w_VGA_IF_RGBEN			;
	wire			[23:0]		w_VGA_BUF_RGB			;



	assign						VGA_CLK					= w_CLK_65M;



	PLL_0 PLL_0_inst (
		.refclk					( CLK					), // refclk.clk
		.rst					(~RST_N					), // reset.reset
		.outclk_0				( w_CLK_100M			), // outclk0.clk
		.outclk_1				( w_CLK_200M			), // outclk1.clk
		.locked					( 						)
	);

	PLL_1 PLL_1_inst (
		.refclk					( w_CLK_200M			), // refclk.clk
		.rst					(~RST_N					), // reset.reset
		.outclk_0				( w_CLK_65M				), // outclk0.clk
		.locked					( 						)
	);


	VGA_TIMING_8b VGA_TIMING_8b_inst(
		.VGA_CLK				( w_CLK_65M				), // (i) 65M clock
		.VGA_RST_N				( RST_N					), // (i) reset, High Active

		.VGA_HSYNC				( VGA_HSYNC				), // (o) HSYNC signal
		.VGA_VSYNC				( VGA_VSYNC				), // (o) VSYNC signal
		.VGA_R					( VGA_R					), // (o) Red signal
		.VGA_G					( VGA_G					), // (o) Green signal
		.VGA_B					( VGA_B					), // (o) Blue signal
		.VGA_SYNC_N				( VGA_SYNC_N			), // (o) 0
		.VGA_BLANK_N			( VGA_BLANK_N			), // (o) 1

		.VGA_DE					( 						), // (o) DE signal
		.VGA_IF_RGBEN			( w_VGA_IF_RGBEN		), // (o) if RGB enable
		.VGA_BUF_RGB			( w_VGA_BUF_RGB			)  // (i) buffer RGB
	);



	VGA_DISPLAY VGA_DISPLAY_inst(
		.VGA_CLK				( w_CLK_65M				), // (i) vga clk in
		.RST_N					( RST_N					), // (i) reset, High Active
		.VGA_IF_RGBEN			( w_VGA_IF_RGBEN		), // (i) 
		.VGA_BUF_RGB			( w_VGA_BUF_RGB			)  // (o) out
	);



endmodule
