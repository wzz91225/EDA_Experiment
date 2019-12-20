module Timer (
	input						clk					,
	input						rst_N				,

	input						enable				,
	input			[5:0]		count_num			,

	output						flag_re				,
	output			[7:0]		number_BCD
);


	reg				[7:0]		r_number_BCD		;
	reg				[5:0]		r_count				;


	
	assign		flag_re			= (r_count == 6'd1) ? 1 : 0;
	assign		number_BCD		= r_number_BCD		;


	always @(posedge clk or negedge rst_N)
	begin
		if (!rst_N) begin
			r_count		<= 6'd0;
		end
		else begin
			if (!enable) begin
				r_count		<= count_num;
			end
			else begin
				if ((r_count == 6'd0) || (r_count > count_num)) begin
					r_count		<= count_num;
				end else begin
					r_count		<= r_count - 1;
				end
			end
		end
	end


	always @(posedge clk or negedge rst_N)
	begin
		if (!rst_N) begin
			r_number_BCD[3:0] <= count_num % 10;
			r_number_BCD[7:4] <= count_num / 10;
		end
		else begin
			r_number_BCD[3:0] <= r_count % 10;
			r_number_BCD[7:4] <= r_count / 10;
		end
	end


endmodule
