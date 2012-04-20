//----- Synthesizable Circuit -----

// Timescale: one time unit = 1ns (e.g., delay specification of #42 means 42ns of time), and
// simulator resolution is 0.1 ns
`timescale 1ns / 100ps

module Flip_Flop_Timing (

	// Inputs:
	input	iD,
	input	iG,

	// Outputs:
	output	oQ
);


DLatch DLatch (

   // Inputs:
   .iD(iD),
   .iGate(iG),
   .iReset(1'b0),

   // Outputs:
   .oQ(oQ),
   .oQn()
);



endmodule