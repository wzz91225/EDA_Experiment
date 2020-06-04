module SequenceDetector (
	input						clk						,
	input						rst_n					,

	input						seq_in					,

	output		[4:0]			LED_seq_in				,
	output						LED_seq_equal			
	);


	parameter					p_STATE_0				= 3'd0		;
	parameter					p_STATE_1				= 3'd1		;
	parameter					p_STATE_2				= 3'd2		;
	parameter					p_STATE_3				= 3'd3		;
	parameter					p_STATE_4				= 3'd4		;


	reg			[ 2:0]			r_state					= 3'd0		;
	reg			[ 4:0]			r_seq_in							;
	reg							r_seq_equal							;


	assign	LED_seq_in			= r_seq_in							;
	assign	LED_seq_equal		= (r_state == p_STATE_4 && seq_in == 1'b0) ? 1'b1 : 1'b0	;


	always @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			r_state		<= p_STATE_0;
		end else begin
			case (r_state)
				p_STATE_0:	begin					// INITIAL
					if (seq_in == 1'b0) begin
						r_state		<= p_STATE_0;
					end else begin
						r_state		<= p_STATE_1;
					end
				end

				p_STATE_1:	begin					// 1
					if (seq_in == 1'b0) begin
						r_state		<= p_STATE_1;
					end else begin
						r_state		<= p_STATE_2;
					end
				end
				
				p_STATE_2:	begin					// 11
					if (seq_in == 1'b0) begin
						r_state		<= p_STATE_3;
					end else begin
						r_state		<= p_STATE_2;
					end
				end
				
				p_STATE_3:	begin					// 110
					if (seq_in == 1'b0) begin
						r_state		<= p_STATE_1;
					end else begin
						r_state		<= p_STATE_4;
					end
				end
				
				p_STATE_4:	begin					// 1101
					if (seq_in == 1'b0) begin
						r_state		<= p_STATE_0;
					end else begin
						r_state		<= p_STATE_2;
					end
				end
				
				default:	begin
					r_state		<= p_STATE_0;
				end
			endcase
		end
	end

	
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			r_seq_in	<= 5'b0;
		end else begin
			r_seq_in	<= {r_seq_in[4:0], seq_in};
		end
	end


endmodule
