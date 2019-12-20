module ClockDivider (
	input						clkin			,
	input						rst_N			,
	output						clkout			
);


	parameter					DivideNum		= 25'd10;//_000_000;


	reg							r_clkout		;
	reg			[25:0]			r_count			= 25'b0;


	assign		clkout			= r_clkout;



	always @(posedge clkin or negedge rst_N) begin
		if (!rst_N) begin
			r_count		<= 25'b0;
			r_clkout	<= 1'b0;
		end else begin
			if (r_count == DivideNum) begin
				r_count		<= 25'b0;
				r_clkout	<= !r_clkout;
			end else begin
				r_count		<= r_count + 25'b1;
				r_clkout	<= r_clkout;
			end
		end
	end


endmodule
