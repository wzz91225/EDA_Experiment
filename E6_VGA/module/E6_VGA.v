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
	output						VGA_BLANK_N				, // (o) 1


	input						k						, // alarm
	input						k1						, // alarm_en
	input						k2						, // stopwatch

	input						remin					,
	input						rehour					,

	input						key1_N					, // up		/ pause
	input						key2_N					, // down	/ reset

	input			[ 1:0]		fast					,

	output						LED_hourly				,
	output						LED_alarm				,
	
	output			[41:0]		DigitalTube_out			
);



	wire						w_CLK_100M				;
	wire						w_CLK_200M				;
	wire						w_CLK_65M				;

	wire						w_CLK_1K				;


	wire			[ 2:0]		w_DTube_en				;
	wire			[ 2:0]		w_Twinkle_en			;
	wire			[23:0]		w_number_BCD			;

	wire						w_HOURLY				;
	wire						w_ALARM					;



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



	ClockDivider ClockDivider_inst (
		.clkin					( CLK					),
		.rst_N					( RST_N					),
		.fast					( fast					),
		.clkout					( w_CLK_1K				)
	);


	DigitalClock_Drive DigitalClock_Drive_inst (
		.clk					( CLK					),
		.rst_N					( RST_N					),
		.DTube_en				( w_DTube_en			),
		.Twinkle_en				( w_Twinkle_en			),
		.number_BCD				( w_number_BCD			),
		.HOURLY					( w_HOURLY				),
		.ALARM					( w_ALARM				),
		.Dtube_out				( DigitalTube_out		),
		.LED_hourly				( LED_hourly			),
		.LED_alarm				( LED_alarm				),
		.VGA_CLK_IN				( w_CLK_65M				),
		.VGA_CLK_OUT			( VGA_CLK				),
		.VGA_HSYNC				( VGA_HSYNC				),
		.VGA_VSYNC				( VGA_VSYNC				),
		.VGA_R					( VGA_R					),
		.VGA_G					( VGA_G					),
		.VGA_B					( VGA_B					),
		.VGA_SYNC_N				( VGA_SYNC_N			),
		.VGA_BLANK_N			( VGA_BLANK_N			),
	);


	DigitalClock_Logic DigitalClock_Logic_inst (
		.clk					( w_CLK_1K				),
		.rst_N					( RST_N					),
		.alarm					( k						),
		.alarm_en				( k1					),
		.stopwatch				( k2					),
		.remin					( remin					),
		.rehour					( rehour				),
		.key1_N					( key1_N				),
		.key2_N					( key2_N				),
		.DTube_en				( w_DTube_en			),
		.Twinkle_en				( w_Twinkle_en			),
		.number_BCD				( w_number_BCD			),
		.LED_hourly				( w_HOURLY				),
		.LED_alarm				( w_ALARM				)
	);



endmodule
