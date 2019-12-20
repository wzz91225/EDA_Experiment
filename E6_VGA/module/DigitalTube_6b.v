module DigitalTube_6b (
	input						clk				,
	input						rst_N			,

	input			[ 5:0]		enable			,
	input			[ 5:0]		twinkle			,
	input			[23:0]		number_BCD		,

	output			[41:0]		pin_out
);

	parameter					Twinkle_Cnt		= 23'd5_000_000;

	reg				[ 5:0]		r_enable		;
	reg				[22:0]		r_cnt			;
	reg							r_twinkle		;


	DigitalTube DigitalTube_bit0_inst(
		.clk			( clk				),
		.rst_N			( rst_N				),

		.enable			( r_enable[0]		),
		.number			( number_BCD[ 3: 0]	),

		.pin_out		( pin_out[ 6: 0]	)
	);

	DigitalTube DigitalTube_bit1_inst(
		.clk			( clk				),
		.rst_N			( rst_N				),

		.enable			( r_enable[1]		),
		.number			( number_BCD[ 7: 4]	),

		.pin_out		( pin_out[13: 7]	)
	);


	DigitalTube DigitalTube_bit2_inst(
		.clk			( clk				),
		.rst_N			( rst_N				),

		.enable			( r_enable[2]		),
		.number			( number_BCD[11: 8]	),

		.pin_out		( pin_out[20:14]	)
	);

	DigitalTube DigitalTube_bit3_inst(
		.clk			( clk				),
		.rst_N			( rst_N				),

		.enable			( r_enable[3]		),
		.number			( number_BCD[15:12]	),

		.pin_out		( pin_out[27:21]	)
	);

	DigitalTube DigitalTube_bit4_inst(
		.clk			( clk				),
		.rst_N			( rst_N				),

		.enable			( r_enable[4]		),
		.number			( number_BCD[19:16]	),

		.pin_out		( pin_out[34:28]	)
	);

	DigitalTube DigitalTube_bit5_inst(
		.clk			( clk				),
		.rst_N			( rst_N				),

		.enable			( r_enable[5]		),
		.number			( number_BCD[23:20]	),

		.pin_out		( pin_out[41:35]	)
	);



	always @(posedge clk or negedge rst_N) begin
		if (!rst_N) begin
			r_cnt		<= 23'd0;
			r_twinkle	<= 1'b1;
		end else begin
			if (r_cnt >= Twinkle_Cnt) begin
				r_cnt		<= 23'd0;
				r_twinkle	<= ~r_twinkle;
			end else begin
				r_cnt		<= r_cnt + 23'd1;
				r_twinkle	<= r_twinkle;
			end
		end
	end



	always @(posedge clk or negedge rst_N) begin
		if (!rst_N) begin
			r_enable	<= 6'b111111;
		end else begin
			if (!enable[0]) begin
				r_enable[0]	<= 1'b0;
			end else if (twinkle[0]) begin
				r_enable[0]	<= r_twinkle;
			end else begin
				r_enable[0]	<= 1'b1;
			end
			
			if (!enable[1]) begin
				r_enable[1]	<= 1'b0;
			end else if (twinkle[1]) begin
				r_enable[1]	<= r_twinkle;
			end else begin
				r_enable[1]	<= 1'b1;
			end
			
			if (!enable[2]) begin
				r_enable[2]	<= 1'b0;
			end else if (twinkle[2]) begin
				r_enable[2]	<= r_twinkle;
			end else begin
				r_enable[2]	<= 1'b1;
			end
			
			if (!enable[3]) begin
				r_enable[0]	<= 1'b0;
			end else if (twinkle[3]) begin
				r_enable[3]	<= r_twinkle;
			end else begin
				r_enable[3]	<= 1'b1;
			end
			
			if (!enable[4]) begin
				r_enable[4]	<= 1'b0;
			end else if (twinkle[4]) begin
				r_enable[4]	<= r_twinkle;
			end else begin
				r_enable[4]	<= 1'b1;
			end
			
			if (!enable[5]) begin
				r_enable[5]	<= 1'b0;
			end else if (twinkle[5]) begin
				r_enable[5]	<= r_twinkle;
			end else begin
				r_enable[5]	<= 1'b1;
			end
		end
	end


endmodule

