module Timer (
	input								clk					,
	input								rst_N				,
	input								softrst_N			,

	input								enable				,
	input								mode				,

	// input								flag_rstsec			,
	input								flag_incmin			,
	input								flag_decmin			,
	input								flag_inchour		,
	input								flag_dechour		,

	output				[6:0]			ms					,
	output				[5:0]			sec					,
	output				[5:0]			min					,
	output				[4:0]			hour				,

	output				[7:0]			num_0_BCD			,
	output				[7:0]			num_1_BCD			,
	output				[7:0]			num_2_BCD			
);

	parameter							Mode_0				= 1'd0		,
										Mode_1				= 1'd1		;


	reg					[9:0]			r_ms				;
	reg					[5:0]			r_sec				;
	reg					[5:0]			r_min				;
	reg					[4:0]			r_hour				;


	reg					[7:0]			r_num_0_BCD			;
	reg					[7:0]			r_num_1_BCD			;
	reg					[7:0]			r_num_2_BCD			;


	assign		ms						= r_ms				;
	assign		sec						= r_sec				;
	assign		min						= r_min				;
	assign		hour					= r_hour			;
	
	assign		num_0_BCD				= r_num_0_BCD		;
	assign		num_1_BCD				= r_num_1_BCD		;
	assign		num_2_BCD				= r_num_2_BCD		;


	always @(posedge clk or negedge rst_N or negedge softrst_N)
	begin
		if (!rst_N || !softrst_N) begin
			r_ms	<= 10'd0;
			r_sec	<= 6'd0;
			r_min	<= 6'd0;
			r_hour	<= 5'd0;
		end
		else begin
			if (!enable) begin
				r_ms	<= r_ms;
				r_sec	<= r_sec;
				r_min	<= r_min;
				r_hour	<= r_hour;
			end
			else begin
				if (flag_incmin && !flag_decmin) begin
					if (r_min < 6'd59) begin
						r_min	<= r_min + 6'd1;
					end else begin
						r_min	<= 6'd0;

						if (r_hour < 5'd23) begin
							r_hour	<= r_hour + 5'd1;
						end else begin
							r_hour	<= 5'd0;
						end
					end
				end
				
				if (!flag_incmin && flag_decmin) begin
					if (r_min > 6'd0) begin
						r_min	<= r_min - 6'd1;
					end else begin
						r_min	<= 6'd59;

						if (r_hour > 5'd0) begin
							r_hour	<= r_hour - 5'd1;
						end else begin
							r_hour	<= 5'd23;
						end
					end
				end

				if (flag_inchour && !flag_dechour) begin
					if (r_hour < 5'd23) begin
						r_hour	<= r_hour + 5'd1;
					end else begin
						r_hour	<= 5'd0;
					end
				end

				if (!flag_inchour && flag_dechour) begin
					if (r_hour > 5'd0) begin
						r_hour	<= r_hour - 5'd1;
					end else begin
						r_hour	<= 5'd23;
					end
				end

				if (!flag_incmin && !flag_decmin && !flag_inchour && !flag_dechour) begin
					if (r_ms < 10'd999) begin
						r_ms	<= r_ms + 10'd1;
					end else begin
						r_ms	<= 10'd0;

						if (r_sec < 6'd59) begin
							r_sec	<= r_sec + 6'd1;
						end else begin
							r_sec	<= 6'd0;

							if (r_min < 6'd59) begin
								r_min	<= r_min + 6'd1;
							end else begin
								r_min	<= 6'd0;

								if (r_hour < 5'd23) begin
									r_hour	<= r_hour + 5'd1;
								end else begin
									r_hour	<= 5'd0;
								end
							end
						end
					end
				end
			end
		end
	end



	always @(posedge clk or negedge rst_N or negedge softrst_N)
	begin
		if (!rst_N || !softrst_N) begin
			r_num_0_BCD[3:0]	<= 4'd0;
			r_num_0_BCD[7:4]	<= 4'd0;
		end
		else begin
			if ((mode == Mode_0) && (r_hour == 7'd0)) begin
				r_num_0_BCD[3:0]	<= r_ms / 10 % 10;
				r_num_0_BCD[7:4]	<= r_ms / 100;
			end else begin
				r_num_0_BCD[3:0]	<= r_sec % 10;
				r_num_0_BCD[7:4]	<= r_sec / 10;
			end
		end
	end


	always @(posedge clk or negedge rst_N or negedge softrst_N)
	begin
		if (!rst_N || !softrst_N) begin
			r_num_1_BCD[3:0]	<= 4'd0;
			r_num_1_BCD[7:4]	<= 4'd0;
		end
		else begin
			if ((mode == Mode_0) && (r_hour == 7'd0)) begin
				r_num_1_BCD[3:0]	<= r_sec % 10;
				r_num_1_BCD[7:4]	<= r_sec / 10;
			end else begin
				r_num_1_BCD[3:0]	<= r_min % 10;
				r_num_1_BCD[7:4]	<= r_min / 10;
			end
		end
	end


	always @(posedge clk or negedge rst_N or negedge softrst_N)
	begin
		if (!rst_N || !softrst_N) begin
			r_num_2_BCD[3:0]	<= 4'd0;
			r_num_2_BCD[7:4]	<= 4'd0;
		end
		else begin
			if ((mode == Mode_0) && (r_hour == 7'd0)) begin
				r_num_2_BCD[3:0]	<= r_min % 10;
				r_num_2_BCD[7:4]	<= r_min / 10;
			end else begin
				r_num_2_BCD[3:0]	<= r_hour % 10;
				r_num_2_BCD[7:4]	<= r_hour / 10;
			end
		end
	end


endmodule
