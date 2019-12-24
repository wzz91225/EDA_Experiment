module DigitalTube_6b (
	input						clk				,
	input						rst_N			,

	input			[ 5:0]		enable			,
	input			[23:0]		number_BCD		,

	output			[41:0]		pin_out
);


	DigitalTube DigitalTube_bit0_inst(
		.clk			( clk				),
		.rst_N			( rst_N				),

		.enable			( enable[0]		),
		.number			( number_BCD[ 3: 0]	),

		.pin_out		( pin_out[ 6: 0]	)
	);

	DigitalTube DigitalTube_bit1_inst(
		.clk			( clk				),
		.rst_N			( rst_N				),

		.enable			( enable[1]		),
		.number			( number_BCD[ 7: 4]	),

		.pin_out		( pin_out[13: 7]	)
	);


	DigitalTube DigitalTube_bit2_inst(
		.clk			( clk				),
		.rst_N			( rst_N				),

		.enable			( enable[2]		),
		.number			( number_BCD[11: 8]	),

		.pin_out		( pin_out[20:14]	)
	);

	DigitalTube DigitalTube_bit3_inst(
		.clk			( clk				),
		.rst_N			( rst_N				),

		.enable			( enable[3]		),
		.number			( number_BCD[15:12]	),

		.pin_out		( pin_out[27:21]	)
	);

	DigitalTube DigitalTube_bit4_inst(
		.clk			( clk				),
		.rst_N			( rst_N				),

		.enable			( enable[4]		),
		.number			( number_BCD[19:16]	),

		.pin_out		( pin_out[34:28]	)
	);

	DigitalTube DigitalTube_bit5_inst(
		.clk			( clk				),
		.rst_N			( rst_N				),

		.enable			( enable[5]		),
		.number			( number_BCD[23:20]	),

		.pin_out		( pin_out[41:35]	)
	);


endmodule

