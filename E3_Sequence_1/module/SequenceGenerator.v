module SequenceGenerator (
	input						clk						,
	input						rst_n					,

	input		[15:0]			seqence					,	

	output						seq_out					,
	output						LED_seq_out				
	);


	reg			[15:0]			r_seq_out								;


	assign	seq_out				= r_seq_out[15]							;
	assign	LED_seq_out			= r_seq_out[15]							;


	always @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			r_seq_out	<= seqence;
		end else begin
			r_seq_out	<= {r_seq_out[14:0], r_seq_out[15]};
		end
	end


endmodule
