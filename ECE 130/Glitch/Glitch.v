//----- Synthesizable Circuit -----

// Timescale: one time unit = 1ns (e.g., delay specification of #42 means 42ns of time), and
// simulator resolution is 0.1 ns
`timescale 1ns / 100ps

module Glitch (

	// Inputs:
	input	iA,
	input	iB,
	input	iC,
	input	iD,

	// Outputs:
	output	oG
);


wire w1, w2, w3, w4, w8, w9, w10;

nand #1 u1 (w1, iA, iA);
nand #1 u2 (w2, iB, iB);
nand #1 u3 (w3, iC, iC);
nand #1 u4 (w4, iD, iD);
and #1 u5 (w8, w1, w3, iD);
and #1 u6 (w9, iC, w4);
and #1 u7 (w10, iA, w2, w3, w4);
or #1 u8 (oG, w8, w9, w10);


endmodule