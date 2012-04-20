//----- Synthesizable Circuit -----

// Timescale: one time unit = 1ns (e.g., delay specification of #42 means 42ns of time), and
// simulator resolution is 0.1 ns
`timescale 1ns / 100ps

module SimpleGateCircuit (

	// Inputs:
	input	iA,
	input	iB,
	input	iC,
	input	iD,

	// Outputs:
	output	oLeft,
	output	oMidLeft,
	output	oMidRight,
	output	oRight
);
	wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12;

	not u1(w1, iA);
	not u2(w2, iB);
	not u3(w3, iC);
	not u4(w4, iD);
	not u5(w5, iA);
	not u6(oLeft, w5);
	and u7(w6, w1, iB);
	and u8(w7, iA, w2, iD);
	or u9(oMidLeft, w6, w7, w8);
	and u10(w8, iA, w2, iD);
	and u11(w9, w1, iC);
	and u12(w10, iC, w4);
	or u13(oMidRight, w9, w10, w11);
	and u14(w11, iA, w3, iD);
	not u15(w12, iD);
	not u16(oRight, w12);

endmodule