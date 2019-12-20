module KeyRecognition (
	input								clk					, // 1kHz
	input								rst_N				,
	input								key_N				,
	output								flag_press			  //
);


	parameter							SinglePressCompare	= 8'd200		;
	// parameter							SinglePressPeriod	= 8'd250		;


	reg									r_flag_single		;

	reg					[ 7:0]			r_sc_cnt		;
	// reg					[ 7:0]			r_sp_cnt		;


	assign								flag_press			= r_flag_single		;


	always @(posedge clk or negedge rst_N) begin
		if (!rst_N) begin
			r_sc_cnt		<= 8'd0;
			// r_sp_cnt		<= SinglePressPeriod;
		end	else begin
			if (r_sc_cnt >= SinglePressCompare) begin
				r_sc_cnt		<= 8'd0;
				// r_sp_cnt		<= SinglePressPeriod;
				r_flag_single	<= 1'b1;
			end else begin
				r_flag_single	<= 1'b0;
				if (!key_N) begin
					r_sc_cnt		<= r_sc_cnt + 8'd1;
				end else begin
					r_sc_cnt		<= 8'd0;
				end
			end
		end	
	end


endmodule
