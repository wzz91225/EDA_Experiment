module E3_Sequence (
	input						clk						,
	input						rst_n					,

	// input						seq_in					,
	// output						seq_out					,

	output						LED_seq_out				,

	output		[4:0]			LED_seq_in				,
	output						LED_seq_equal			
	);



	wire						s_clk_1Hz										;
	wire						s_clk_1Hz_N										;

	wire						s_data											;


	wire		[15:0]			sequence_generator								;
	wire		[ 4:0]			sequence_compare								;

	assign						sequence_generator	= 16'b0111_0100_1101_1010	;
	assign						sequence_compare	= 5'b11010					;


	ClockDivider ClockDivider_inst (
		.clkin				( clk					),
		.clkout				( s_clk_1Hz				),
		.clkout_N			( s_clk_1Hz_N			)
	);


	SequenceGenerator SequenceGenerator_inst (
		.clk				( s_clk_1Hz				),
		.rst_n				( rst_n					),
		.seqence			( sequence_generator	),
		.seq_out			( s_data				),
		.LED_seq_out		( LED_seq_out			)
	);


	SequenceDetector SequenceDetector_inst (
		.clk				( s_clk_1Hz_N			),
		.rst_n				( rst_n					),
		.seq_in				( s_data				),
		.seq_compare		( sequence_compare		),
		.LED_seq_in			( LED_seq_in			),
		.LED_seq_equal		( LED_seq_equal			)		
	);


endmodule
