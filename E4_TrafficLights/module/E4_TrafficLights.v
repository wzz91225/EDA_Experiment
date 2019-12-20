module E4_TrafficLights (
	input								clk					,
	input								rst_N				,
	
	input								s					,

	output				[2:0]			ryg0				,
	output				[2:0]			ryg1				,
	
	output				[13:0]			digital_tube_0		,
	output				[13:0]			digital_tube_1		
);


	parameter							State_0				= 3'd0		,
										State_1				= 3'd1		,
										State_2				= 3'd2		,
										State_3				= 3'd3		,
										State_4				= 3'd4		;
	

	reg					[2:0]			r_ryg0				;
	reg					[2:0]			r_ryg1				;


	wire								s_clk_1Hz			;

	wire								s_timer0_flag		;
	wire								s_timer1_flag		;

	wire				[7:0]			s_number0_BCD		;
	wire				[7:0]			s_number1_BCD		;

	reg									r_dt0_enable		;
	reg					[5:0]			r_dt0_cnt_num		;
	wire								s_dt0_enable		;
	wire				[5:0]			s_dt0_cnt_num		;


	reg									r_dt1_enable		;
	reg					[5:0]			r_dt1_cnt_num		;
	wire								s_dt1_enable		;
	wire				[5:0]			s_dt1_cnt_num		;


	reg					[2:0]			r_state				;


	assign				s_dt0_enable	= r_dt0_enable		;
	assign				s_dt0_cnt_num	= r_dt0_cnt_num		;

	assign				s_dt1_enable	= r_dt1_enable		;
	assign				s_dt1_cnt_num	= r_dt1_cnt_num		;

	assign				ryg0			= r_ryg0			;
	assign				ryg1			= r_ryg1			;



	ClockDivider ClockDivider_inst (
		.clkin				( clk					),
		.rst_N				( rst_N					),
		.clkout				( s_clk_1Hz				)
	);


	Timer Timer0_inst (
		.clk				( s_clk_1Hz				),
		.rst_N				( rst_N					),
		.enable				( s_dt0_enable			),
		.count_num			( s_dt0_cnt_num			),
		.flag_re			( s_timer0_flag			),
		.number_BCD			( s_number0_BCD			)
	);


	Timer Timer1_inst (
		.clk				( s_clk_1Hz				),
		.rst_N				( rst_N					),
		.enable				( s_dt1_enable			),
		.count_num			( s_dt1_cnt_num			),
		.flag_re			( s_timer1_flag			),
		.number_BCD			( s_number1_BCD			)
	);


	DigitalTube_2b DigitalTube_2b_0_inst (
		.clk				( clk					),
		.rst_N				( rst_N					),
		.enable				( r_dt0_enable			),
		.number_BCD			( s_number0_BCD			),
		.pin_out			( digital_tube_0		)
	);


	DigitalTube_2b DigitalTube_2b_1_inst (
		.clk				( clk					),
		.rst_N				( rst_N					),
		.enable				( r_dt1_enable			),
		.number_BCD			( s_number1_BCD			),
		.pin_out			( digital_tube_1		)
	);



	always @(posedge s_clk_1Hz or negedge rst_N) begin
		if (!rst_N) begin
			r_state			<= 3'd0;

			r_ryg0			<= 3'b111;
			r_ryg1			<= 3'b111;

			r_dt0_enable	<= 0;
			r_dt1_enable	<= 0;

			r_dt0_cnt_num	<= 6'd60;
			r_dt1_cnt_num	<= 6'd0;
		end else begin
			case (r_state)
				/* 主绿乡红 */
				3'd0 :		begin
					r_ryg0			<= 3'b001;
					r_ryg1			<= 3'b100;

					r_dt0_enable	<= 1;
					r_dt1_enable	<= 0;

					if (s_timer0_flag) begin
						if (s) begin
							r_state			<= 3'd2;

							r_dt0_cnt_num	<= 6'd4;
							r_dt1_cnt_num	<= 6'd0;
						end else begin
							r_state			<= 3'd1;
							
							r_dt0_cnt_num	<= 6'd60;
							r_dt1_cnt_num	<= 6'd0;
						end
					end else begin
						r_state			<= r_state;

						r_dt0_cnt_num	<= 6'd60;
						r_dt1_cnt_num	<= 6'd0;
					end
				end
				
				/* 主绿乡红 */
				3'd1 :		begin
					r_ryg0			<= 3'b001;
					r_ryg1			<= 3'b100;

					r_dt0_enable	<= 1;
					r_dt1_enable	<= 0;

					if (s) begin
						r_state			<= 3'd2;

						r_dt0_cnt_num	<= 6'd4;
						r_dt1_cnt_num	<= 6'd0;
					end else begin
						r_state			<= r_state;

						r_dt0_cnt_num	<= 6'd60;
						r_dt1_cnt_num	<= 6'd0;
					end
				end
				
				/* 主黄乡红 */
				3'd2 :		begin
					r_ryg0			<= 3'b010;
					r_ryg1			<= 3'b100;

					r_dt0_enable	<= 1;
					r_dt1_enable	<= 0;

					if (s_timer0_flag) begin
						r_state			<= 3'd3;
						
						r_dt0_cnt_num	<= 6'd0;
						r_dt1_cnt_num	<= 6'd20;
					end else begin
						r_state			<= r_state;
						
						r_dt0_cnt_num	<= 6'd4;
						r_dt1_cnt_num	<= 6'd0;
					end
				end
				
				/* 主红乡绿 */
				3'd3 :		begin
					r_ryg0			<= 3'b100;
					r_ryg1			<= 3'b001;

					r_dt0_enable	<= 0;
					r_dt1_enable	<= 1;

					if (!s || s_timer1_flag) begin
						r_state			<= 3'd4;

						r_dt0_cnt_num	<= 6'd0;
						r_dt1_cnt_num	<= 6'd4;
					end else begin
						r_state			<= r_state;

						r_dt0_cnt_num	<= 6'd0;
						r_dt1_cnt_num	<= 6'd20;
					end
				end
				
				/* 主红乡黄 */
				3'd4 :		begin
					r_ryg0			<= 3'b100;
					r_ryg1			<= 3'b010;

					r_dt0_enable	<= 0;
					r_dt1_enable	<= 1;

					if (s_timer1_flag) begin
						r_state			<= 3'd0;
						
						r_dt0_cnt_num	<= 6'd60;
						r_dt1_cnt_num	<= 6'd0;
					end else begin
						r_state			<= r_state;
						
						r_dt0_cnt_num	<= 6'd0;
						r_dt1_cnt_num	<= 6'd4;
					end
				end
				
				default :	begin
					r_state			<= 3'd0;

					r_ryg0			<= 3'b111;
					r_ryg1			<= 3'b111;
					
					r_dt0_enable	<= 0;
					r_dt1_enable	<= 0;

					r_dt0_cnt_num	<= 6'd60;
					r_dt1_cnt_num	<= 6'd0;
				end
			endcase
		end
	end



endmodule
