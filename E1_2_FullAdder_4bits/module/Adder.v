module Adder (
    ain,
	bin,

    sout,	// sum bit
	cout	// carry bit
);

input   ain, bin;

output  sout, cout;



assign  sout     = ain ^ bin;
assign  cout     = ain & bin;



endmodule
