module E2_Counter (
    clk,
    rst_N,
    en_SW,
    modulo_SW,

    digital_tube_3b,
	LED
);

input   clk, rst_N;
input   en_SW, modulo_SW;

output  [20:0]  digital_tube_3b;
output			LED;


wire	[11:0]  number_BCD;
wire			clk_1Hz;



ClockDivider ClockDivider_inst (
    .clkin  (clk),
    .clkout (clk_1Hz)
);



Timer Timer_inst (
    .clk        (clk_1Hz),
    .rst_N      (rst_N),

    .en_SW      (en_SW),
    .modulo_SW  (modulo_SW),

    .number_BCD (number_BCD),
	.LED		(LED)
);



DigitalTube_3b DigitalTube_3b_inst (
    .clk        (clk),
    .rst_N      (rst_N),

    .number_BCD (number_BCD),
    .pin_out    (digital_tube_3b)
);



endmodule
