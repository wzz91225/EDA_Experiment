module E1_1_FullAdder_1bit (
    ain,
	bin,
	cin,

    sout,	// sum bit
	cout	// carry bit
);

input   ain, bin, cin;

output  sout, cout;



wire	sum_1, carry_1, carry_2;

assign	cout	= carry_1 | carry_2;



Adder Adder_inst_1(
	.ain	(ain),
	.bin	(bin),
	.sout	(sum_1),
	.cout	(carry_1)
);



Adder Adder_inst_2(
	.ain	(sum_1),
	.bin	(cin),
	.sout	(sout),
	.cout	(carry_2)
);



endmodule


