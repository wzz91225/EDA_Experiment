module E5_DigitalClock (
	input								clk					,
	input								rst_N				,
	
	input								k					, // alarm
	input								k1					, // alarm_en
	input								k2					, // stopwatch

	input								remin				,
	input								rehour				,

	input								key1_N				, // up		/ pause
	input								key2_N				, // down	/ reset

	input				[ 1:0]			fast				,

	output								LED_hourly			,
	output								LED_alarm			,
	
	output				[41:0]			DigitalTube_out		
);

	wire								s_clk_1kHz			;
	// wire								s_clk_key			;

	wire				[ 2:0]			s_DTube_en			;
	wire				[ 2:0]			s_Twinkle_en		;
	wire				[23:0]			s_number_BCD		;



	ClockDivider ClockDivider_inst (
		.clkin				( clk					),
		.rst_N				( rst_N					),
		.fast				( fast					),
		.clkout				( s_clk_1kHz			)
		// .clkkey				( s_clk_key				)
	);


	DigitalClock_Drive DigitalClock_Drive_inst (
		.clk				( clk					),
		.rst_N				( rst_N					),
		.DTube_en			( s_DTube_en			),
		.Twinkle_en			( s_Twinkle_en			),
		.number_BCD			( s_number_BCD			),
		.Dtube_out			( DigitalTube_out		)
	);


	DigitalClock_Logic DigitalClock_Logic_inst (
		.clk				( s_clk_1kHz			),
		// .clkkey				( s_clk_key				),
		.rst_N				( rst_N					),
		.alarm				( k						),
		.alarm_en			( k1					),
		.stopwatch			( k2					),
		.remin				( remin					),
		.rehour				( rehour				),
		.key1_N				( key1_N				),
		.key2_N				( key2_N				),
		.DTube_en			( s_DTube_en			),
		.Twinkle_en			( s_Twinkle_en			),
		.number_BCD			( s_number_BCD			),
		.LED_hourly			( LED_hourly			),
		.LED_alarm			( LED_alarm				)
	);



endmodule
