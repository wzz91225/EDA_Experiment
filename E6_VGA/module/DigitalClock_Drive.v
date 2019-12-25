module DigitalClock_Drive (
	input						clk						,
	input						rst_N					,

	input			[ 2:0]		DTube_en				,
	input			[ 2:0]		Twinkle_en				,
	input			[23:0]		number_BCD				,
	input						HOURLY					,
	input						ALARM					,

	output			[41:0]		Dtube_out				,
	output						LED_hourly				,
	output						LED_alarm				,

	input						VGA_CLK_IN				, // (i)
	output						VGA_CLK_OUT				, // (o)
	output						VGA_HSYNC				, // (o) VGA Horizontal SYNC
	output						VGA_VSYNC				, // (o) VGA Vertical SYNC
	output			[ 7:0]		VGA_R					, // (o) VGA Red
	output			[ 7:0]		VGA_G					, // (o) VGA Green
	output			[ 7:0]		VGA_B					, // (o) VGA Blue
	output						VGA_SYNC_N				, // (o) 0
	output						VGA_BLANK_N				  // (o) 1
);



	parameter					Twinkle_Cnt				= 23'd5_000_000;


	
	reg				[22:0]		r_cnt					;
	reg							r_twinkle				;

	reg				[ 5:0]		r_enable				;
	wire			[ 5:0]		w_enable				;
	

	wire						w_VGA_IF_RGBEN			;
	wire			[23:0]		w_VGA_BUF_RGB			;



	assign						LED_hourly				= HOURLY		;
	assign						LED_alarm				= ALARM			;

	assign						w_enable				= r_enable		;

	assign						VGA_CLK_OUT				= VGA_CLK_IN	;



	DigitalTube_6b DigitalTube_6b_inst (
		.clk					( clk					),
		.rst_N					( rst_N					),
		.enable					( w_enable				),
		.number_BCD				( number_BCD			),
		.pin_out				( Dtube_out				)
	);



	VGA_TIMING_8b VGA_TIMING_8b_inst(
		.VGA_CLK				( VGA_CLK_IN			), // (i) 65M clock
		.VGA_RST_N				( rst_N					), // (i) reset, High Active

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
		.VGA_CLK				( VGA_CLK_IN			), // (i) vga clk in
		.RST_N					( rst_N					), // (i) reset, High Active
		.VGA_IF_RGBEN			( w_VGA_IF_RGBEN		), // (i) 
		.NUMBER_BCD				( number_BCD			), // (i)
		.NUMBER_ENABLE			( w_enable				), // (i)
		.HOURLY					( HOURLY				), // (i)
		.ALARM					( ALARM					), // (i)
		.VGA_BUF_RGB			( w_VGA_BUF_RGB			)  // (o) out
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
			if (!DTube_en[0]) begin
				r_enable[0]	<= 1'b0;
				r_enable[1]	<= 1'b0;
			end else if (Twinkle_en[0]) begin
				r_enable[0]	<= r_twinkle;
				r_enable[1]	<= r_twinkle;
			end else begin
				r_enable[0]	<= 1'b1;
				r_enable[1]	<= 1'b1;
			end
			
			if (!DTube_en[1]) begin
				r_enable[2]	<= 1'b0;
				r_enable[3]	<= 1'b0;
			end else if (Twinkle_en[1]) begin
				r_enable[2]	<= r_twinkle;
				r_enable[3]	<= r_twinkle;
			end else begin
				r_enable[2]	<= 1'b1;
				r_enable[3]	<= 1'b1;
			end
			
			if (!DTube_en[2]) begin
				r_enable[4]	<= 1'b0;
				r_enable[5]	<= 1'b0;
			end else if (Twinkle_en[2]) begin
				r_enable[4]	<= r_twinkle;
				r_enable[5]	<= r_twinkle;
			end else begin
				r_enable[4]	<= 1'b1;
				r_enable[5]	<= 1'b1;
			end
		end
	end



endmodule
