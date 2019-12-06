module DigitalTube (
	input						clk				,
	input						rst_N			,

	input						enable			,
	input			[3:0]		number			,

	output			[6:0]		pin_out
);


	reg     		[6:0]		r_pin_out		;


	assign		pin_out			= r_pin_out;


	always @(posedge clk, negedge rst_N)
	begin
		if (!rst_N) begin
			r_pin_out	<= 7'b0000000;
		end
		else begin
			if (!enable) begin
				r_pin_out	<= 7'b1111111;
			end else begin
				case (number)
					0 :			r_pin_out	<= 7'b1000000;
					1 :			r_pin_out	<= 7'b1111001;
					2 :			r_pin_out	<= 7'b0100100;
					3 :			r_pin_out	<= 7'b0110000;
					4 :			r_pin_out	<= 7'b0011001;
					5 :			r_pin_out	<= 7'b0010010;
					6 :			r_pin_out	<= 7'b0000010;
					7 :			r_pin_out	<= 7'b1111000;
					8 :			r_pin_out	<= 7'b0000000;
					9 :			r_pin_out	<= 7'b0010000;
					default:	r_pin_out	<= 7'b0000000;
				endcase
			end
		end
	end


endmodule
