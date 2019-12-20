module Timer (
    clk,
    rst_N,

    en_SW,
    modulo_SW,

    number_BCD,
	LED
);

input   clk, rst_N;

input   en_SW, modulo_SW;

output  reg [11:0]  number_BCD;
output	reg			LED = 0;


reg     [9:0]   number  = 10'd0;



always @(posedge clk, negedge rst_N)
begin
    if (!rst_N) begin
        number <= 12'b0;
		LED <= 0;
	end
	else begin
		if (!en_SW) begin
			number <= number;
			LED <= 0;
		end
		else begin
			if (!modulo_SW) begin
				if (number >= 10'd14) begin
					number <= 10'd0;
					LED <= 1;
				end
				else begin
					number <= number + 10'd1;
					LED <= 0;
				end
			end
			else begin
				if (number >= 10'd114) begin
					number <= 10'd0;
					LED <= 1;
				end
				else begin
					number <= number + 10'd1;
					LED <= 0;
				end
			end
		end
	end

    number_BCD[3:0] <= number % 10;
    number_BCD[7:4] <= number / 10 % 10;
    number_BCD[11:8] <= number / 100 % 10;
end


endmodule
