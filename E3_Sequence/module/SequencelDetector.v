module SequenceDetector (
	input						clk						,
	input						rst_n					,

	input						seq_in					,
	input		[4:0]			seq_compare				,

	output		[4:0]			LED_seq_in				,
	output						LED_seq_equal			
	);


	reg			[ 4:0]			r_seq_in											;
	reg							r_seq_equal											;


	assign	LED_seq_in			= r_seq_in											;
	assign	LED_seq_equal		= (r_seq_in == seq_compare) ? 1'b1 : 1'b0			;


	always @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			r_seq_in	<= 5'b0;
		end else begin
			r_seq_in	<= {r_seq_in[4:0], seq_in};
		end
	end


endmodule
