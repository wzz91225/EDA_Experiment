module ClockDivider (
	input						clkin				,	// 50MHz
	input						rst_N				,
	input		[ 1:0]			fast				,	
	output						clkout					// 1kHz
	// output						clkkey					// 400ms
);


	parameter					DivideNum_normal	= 25'd25_000;
	parameter					DivideNum_fast0		= 25'd416;
	parameter					DivideNum_fast1		= 25'd6;

	parameter					DivideNum_key		= 16'd10_000;


	wire		[25:0]			DivideNum			;

	reg							r_clkout			;
	reg			[25:0]			r_count				= 25'b0;

	// reg							r_clkkey			;
	// reg			[25:0]			r_count1			= 25'b0;


	assign		DivideNum		= (fast == 2'd0) ? DivideNum_normal : ((fast == 2'd1) ? DivideNum_fast0 : DivideNum_fast1);

	assign		clkout			= r_clkout;
	// assign		clkkey			= r_clkkey;



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


	// always @(posedge clkin or negedge rst_N) begin
	// 	if (!rst_N) begin
	// 		r_count1	<= 25'b0;
	// 		r_clkkey	<= 1'b0;
	// 	end else begin
	// 		if (r_count == DivideNum_key) begin
	// 			r_count1	<= 25'b0;
	// 			r_clkkey	<= !r_clkkey;
	// 		end else begin
	// 			r_count1	<= r_count1 + 25'b1;
	// 			r_clkkey	<= r_clkkey;
	// 		end
	// 	end
	// end


endmodule
