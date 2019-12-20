// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Standard Edition"
// CREATED		"Fri Oct 18 16:55:19 2019"

module E1_2_FullAdder_4bits(
	ain,
	num1_in,
	num2_in,
	aout,
	sout
);


input wire	ain;
input wire	[3:0] num1_in;
input wire	[3:0] num2_in;
output wire	aout;
output wire	[3:0] sout;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;





E1_1_FullAdder_1bit	b2v_inst(
	.ain(ain),
	.bin(num1_in[0]),
	.cin(num2_in[0]),
	.sout(sout[0]),
	.cout(SYNTHESIZED_WIRE_0));


E1_1_FullAdder_1bit	b2v_inst1(
	.ain(SYNTHESIZED_WIRE_0),
	.bin(num1_in[1]),
	.cin(num2_in[1]),
	.sout(sout[1]),
	.cout(SYNTHESIZED_WIRE_1));


E1_1_FullAdder_1bit	b2v_inst2(
	.ain(SYNTHESIZED_WIRE_1),
	.bin(num1_in[2]),
	.cin(num2_in[2]),
	.sout(sout[2]),
	.cout(SYNTHESIZED_WIRE_2));


E1_1_FullAdder_1bit	b2v_inst3(
	.ain(SYNTHESIZED_WIRE_2),
	.bin(num1_in[3]),
	.cin(num2_in[3]),
	.sout(sout[3]),
	.cout(aout));


endmodule
