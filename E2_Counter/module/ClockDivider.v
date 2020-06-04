module ClockDivider (
    clkin,
    clkout
);

input   	clkin;
output  reg	clkout	= 0;


reg     [25:0]  count   = 25'b0;

parameter  DivideNum    = 25'd0;


always @(posedge clkin)
begin
    if (count == DivideNum) begin
        count <= 25'b0;
		clkout <= !clkout;
    end
    else begin
        count <= count + 25'b1;
    end
end


endmodule
