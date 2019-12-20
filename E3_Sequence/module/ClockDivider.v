module ClockDivider (
	clkin               ,
	clkout              ,
	clkout_N
);

input					clkin;
output			reg		clkout			= 0;
output			reg		clkout_N		= 1;


reg			[25:0]		count			= 25'b0;

parameter				DivideNum		= 25'd25000000;


always @(posedge clkin) begin
	if (count == DivideNum) begin
		count		<= 25'b0;
		clkout		<= !clkout;
		clkout_N	<= !clkout_N;
	end else begin
		count		<= count + 25'b1;
	end
end


endmodule
