module DigitalClock_Drive (
	input								clk					,
	input								rst_N				,

	input				[ 2:0]			DTube_en			,
	input				[ 2:0]			Twinkle_en			,
	input				[23:0]			number_BCD			,

	output				[41:0]			Dtube_out			
);



	DigitalTube_6b DigitalTube_6b_inst (
		.clk				( clk					),
		.rst_N				( rst_N					),
		.enable				( { {2{DTube_en[2]}}, {2{DTube_en[1]}}, {2{DTube_en[0]}} }			),
		.twinkle			( { {2{Twinkle_en[2]}}, {2{Twinkle_en[1]}}, {2{Twinkle_en[0]}} }	),
		.number_BCD			( number_BCD			),
		.pin_out			( Dtube_out				)
	);



endmodule
