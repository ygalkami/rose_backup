//----- Synthesizable Circuit -----

// Timescale: one time unit = 1ns (e.g., delay specification of #42 means 42ns of time), and
// simulator resolution is 0.1 ns
`timescale 1ns / 100ps

module Ring_Ocisillator (

	// Inputs:
	input	iEnable,

	// Outputs:
	output	oA,
	output	oB,
	output	oC,
	output	oD,
	output	oE,
	output	oEn
);

wire w1, w2, w3, w4, w5, w6;

not #3 u1 (oB, oA);
not #3 u2 (oC, oB);
not #3 u3 (oD, oC);
not #3 u4 (oE, oD);
not #3 u5 (oEn, oE);
and #3 u6 (oA, iEnable, oEn);

endmodule