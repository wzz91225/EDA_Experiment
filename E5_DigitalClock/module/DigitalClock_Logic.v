module DigitalClock_Logic (
	input								clk					, // 1kHz
	// input								clkkey				,
	input								rst_N				,

	input								alarm				,
	input								stopwatch			,

	input								alarm_en			,

	input								remin				,
	input								rehour				,

	input								key1_N				, // up		/ pause
	input								key2_N				, // down	/ reset

	output				[ 2:0]			DTube_en			,
	output				[ 2:0]			Twinkle_en			,
	output				[23:0]			number_BCD			,

	output								LED_hourly			,
	output								LED_alarm			
);

	parameter							State_0				= 2'b00		, // clock
										State_1				= 2'b01		, // alarm
										State_2				= 2'b10		; // stopwatch
	

	wire				[ 1:0]			s_state				;

	wire				[ 5:0]			s_clkMode_sec		;
	wire				[ 5:0]			s_clkMode_min		;
	wire				[ 4:0]			s_clkMode_hour		;

	reg					[ 5:0]			r_alarm_min			;
	reg					[ 4:0]			r_alarm_hour		;

	wire				[ 5:0]			s_alarm_min			;
	wire				[ 4:0]			s_alarm_hour		;

	wire				[ 7:0]			s_num_1_BCD_alm		;
	wire				[ 7:0]			s_num_2_BCD_alm		;

	wire				[ 7:0]			s_num_0_BCD			;
	wire				[ 7:0]			s_num_1_BCD			;
	wire				[ 7:0]			s_num_2_BCD			;
	
	wire				[ 7:0]			s_num_0_BCD_clk		;
	wire				[ 7:0]			s_num_1_BCD_clk		;
	wire				[ 7:0]			s_num_2_BCD_clk		;
	
	wire				[ 7:0]			s_num_0_BCD_sw		;
	wire				[ 7:0]			s_num_1_BCD_sw		;
	wire				[ 7:0]			s_num_2_BCD_sw		;


	reg									r_alarm_en			;


	wire								s_flag_PressKey1	;
	wire								s_flag_PressKey2	;

	reg									r_timer_en_sw		;
	reg									r_timer_rst_sw		;
	wire								s_timer_en_sw		;
	wire								s_timer_rst_sw		;

	wire								s_flag_incmin		;
	wire								s_flag_decmin		;
	wire								s_flag_inchour		;
	wire								s_flag_dechour		;

	reg									r_flag_incmin		;
	reg									r_flag_decmin		;
	reg									r_flag_inchour		;
	reg									r_flag_dechour		;



	assign		s_flag_incmin			= r_flag_incmin		;
	assign		s_flag_decmin			= r_flag_decmin		;
	assign		s_flag_inchour			= r_flag_inchour	;
	assign		s_flag_dechour			= r_flag_dechour	;

	assign		s_alarm_hour			= r_alarm_hour		;
	assign		s_alarm_min				= r_alarm_min		;

	assign		s_timer_en_sw			= r_timer_en_sw		;
	assign		s_timer_rst_sw			= r_timer_rst_sw	;


	assign		s_state					= (stopwatch ? State_2 : (alarm ? State_1 : State_0));	

	
	assign		LED_hourly				= (s_clkMode_min == 6'd59) ? ((s_clkMode_sec > 6'd56) ? 1'b1 : 1'b0) : 1'b0;

	assign		LED_alarm				= (alarm_en ? (((s_clkMode_min == s_alarm_min) && (s_clkMode_hour == s_alarm_hour)) ? 1'b1 : 1'b0) : 1'b0);

	assign		DTube_en				= (s_state == State_1) ? 3'b110 : 3'b111;

	assign		Twinkle_en[2]			= (s_state != State_2) ? (rehour ? 1'b1 : 1'b0 ) : 1'b0;
	assign		Twinkle_en[1]			= (s_state != State_2) ? (remin ? 1'b1 : 1'b0 ) : 1'b0;
	assign		Twinkle_en[0]			= 1'b0;


	assign		s_num_1_BCD_alm[3:0]	= s_alarm_min % 4'd10;
	assign		s_num_1_BCD_alm[7:4]	= s_alarm_min / 4'd10;
	assign		s_num_2_BCD_alm[3:0]	= s_alarm_hour % 4'd10;
	assign		s_num_2_BCD_alm[7:4]	= s_alarm_hour / 4'd10;

	assign		s_num_0_BCD				= (s_state == State_0) ? s_num_0_BCD_clk : ((s_state == State_1) ? 8'd0 : s_num_0_BCD_sw);
	assign		s_num_1_BCD				= (s_state == State_0) ? s_num_1_BCD_clk : ((s_state == State_1) ? s_num_1_BCD_alm : s_num_1_BCD_sw);
	assign		s_num_2_BCD				= (s_state == State_0) ? s_num_2_BCD_clk : ((s_state == State_1) ? s_num_2_BCD_alm : s_num_2_BCD_sw);

	assign		number_BCD				= {s_num_2_BCD, s_num_1_BCD, s_num_0_BCD};



	Timer Timer_ClockMode_inst_0 (
		.clk				( clk					),
		.rst_N				( rst_N					),
		.softrst_N			( 1'd1					),
		.enable				( 1'd1					),
		.mode				( 1'd1					),
		.flag_incmin		( s_flag_incmin			),
		.flag_decmin		( s_flag_decmin			),
		.flag_inchour		( s_flag_inchour		),
		.flag_dechour		( s_flag_dechour		),
		// .ms					( 			),
		.sec				( s_clkMode_sec			),
		.min				( s_clkMode_min			),
		.hour				( s_clkMode_hour			),
		.num_0_BCD			( s_num_0_BCD_clk			),
		.num_1_BCD			( s_num_1_BCD_clk			),
		.num_2_BCD			( s_num_2_BCD_clk			)
	);


	Timer Timer_StopwatchMode_inst_1 (
		.clk				( clk					),
		.rst_N				( rst_N					),
		.softrst_N			( s_timer_rst_sw		),
		.enable				( s_timer_en_sw			),
		.mode				( 1'd0					),
		.flag_incmin		( 1'b0					),
		.flag_decmin		( 1'b0					),
		.flag_inchour		( 1'b0					),
		.flag_dechour		( 1'b0					),
		// .ms					( 			),
		// .sec				( 			),
		// .min				( 			),
		// .hour				( 			),
		.num_0_BCD			( s_num_0_BCD_sw			),
		.num_1_BCD			( s_num_1_BCD_sw			),
		.num_2_BCD			( s_num_2_BCD_sw			)
	);



	KeyRecognition KeyRecognition_inst_0 (
		.clk				( clk						),
		.rst_N				( rst_N						),
		.key_N				( key1_N					),
		.flag_press			( s_flag_PressKey1			)
	);


	KeyRecognition KeyRecognition_inst_1 (
		.clk				( clk						),
		.rst_N				( rst_N						),
		.key_N				( key2_N					),
		.flag_press			( s_flag_PressKey2			)
	);



	always @(posedge clk or negedge rst_N) begin
		if (!rst_N) begin
			r_flag_incmin	<= 1'b0;
			r_flag_inchour	<= 1'b0;
			r_flag_decmin	<= 1'b0;
			r_flag_dechour	<= 1'b0;
		end else begin
			if (s_state == State_0)	begin
				case ({s_flag_PressKey2, s_flag_PressKey1})
					2'b01:		begin
						r_flag_inchour	<= rehour;
						r_flag_incmin	<= remin;
						r_flag_decmin	<= 1'b0;
						r_flag_dechour	<= 1'b0;
					end

					2'b10:		begin
						r_flag_incmin	<= 1'b0;
						r_flag_inchour	<= 1'b0;
						r_flag_dechour	<= rehour;
						r_flag_decmin	<= remin;
					end

					default:	begin
						r_flag_incmin	<= 1'b0;
						r_flag_inchour	<= 1'b0;
						r_flag_decmin	<= 1'b0;
						r_flag_dechour	<= 1'b0;
					end
				endcase
			end
		end
	end



	always @(posedge clk or negedge rst_N) begin
		if (!rst_N) begin
			r_alarm_hour	<= 5'd0;
			r_alarm_min		<= 6'd0;
		end else begin
			if (s_state == State_1)	begin
				case ({s_flag_PressKey2, s_flag_PressKey1})
					2'b01:		begin
						if (rehour) begin
							if (r_alarm_hour < 5'd23) begin
								r_alarm_hour	<= r_alarm_hour + 5'd1;
							end else begin
								r_alarm_hour	<= 5'd0;
							end
						end

						if (remin) begin
							if (r_alarm_min < 6'd59) begin
								r_alarm_min		<= r_alarm_min + 6'd1;
							end else begin
								r_alarm_min		<= 6'd0;

								if (!rehour) begin
									if (r_alarm_hour < 5'd23) begin
										r_alarm_hour	<= r_alarm_hour + 5'd1;
									end else begin
										r_alarm_hour	<= 5'd0;
									end
								end
							end
						end
					end

					2'b10:		begin
						if (rehour) begin
							if (r_alarm_hour > 5'd0) begin
								r_alarm_hour	<= r_alarm_hour - 5'd1;
							end else begin
								r_alarm_hour	<= 5'd23;
							end
						end

						if (remin) begin
							if (r_alarm_min > 6'd0) begin
								r_alarm_min		<= r_alarm_min - 6'd1;
							end else begin
								r_alarm_min		<= 6'd59;

								if (!rehour) begin
									if (r_alarm_hour > 5'd0) begin
										r_alarm_hour	<= r_alarm_hour - 5'd1;
									end else begin
										r_alarm_hour	<= 5'd23;
									end
								end
							end
						end
					end

					default:	begin
						r_alarm_hour	<= r_alarm_hour;
						r_alarm_min		<= r_alarm_min;
					end
				endcase
			end
		end
	end



	always @(posedge clk or negedge rst_N) begin
		if (!rst_N) begin
			r_timer_en_sw	<= 1'd0;
			r_timer_rst_sw	<= 1'd0;
		end else begin
			if (s_state == State_2)	begin
				case ({s_flag_PressKey2, s_flag_PressKey1})
					2'b01:		begin
						r_timer_en_sw	<=~r_timer_en_sw;
						r_timer_rst_sw	<= 1'd1;
					end

					2'b10:		begin
						r_timer_en_sw	<= 1'd0;
						r_timer_rst_sw	<= 1'd0;
					end

					2'b11:		begin
						r_timer_en_sw	<=~r_timer_en_sw;
						r_timer_rst_sw	<= 1'd0;
					end

					default:	begin
						r_timer_en_sw	<= r_timer_en_sw;
						r_timer_rst_sw	<= 1'd1;
					end
				endcase
			end
		end
	end


endmodule
