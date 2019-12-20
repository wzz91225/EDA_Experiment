module DigitalTube_2b (
	input						clk				,
	input						rst_N			,

	input						enable			,
	input			[7:0]		number_BCD		,

	output			[13:0]		pin_out
);


DigitalTube DigitalTube_bit0_inst(
	.clk			( clk				),
	.rst_N			( rst_N				),

	.enable			( enable			),
	.number			( number_BCD[3:0]	),

	.pin_out		( pin_out[6:0]		)
);

DigitalTube DigitalTube_bit1_inst(
	.clk			( clk				),
	.rst_N			( rst_N				),

	.enable			( enable			),
	.number			( number_BCD[7:4]	),

	.pin_out		( pin_out[13:7]		)
);


endmodule

