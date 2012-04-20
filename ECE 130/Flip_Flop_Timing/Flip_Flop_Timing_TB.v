//----- Testbench -----

// Timescale: one time unit = 1ns (e.g., delay specification of #42 means 42ns of time), and
// simulator resolution is 0.1 ns
`timescale 1ns / 100ps

module Flip_Flop_Timing_TB;

// Input stimulus:
reg	iD;
reg	iG;

// Output connections:
wire	oQ;


//Instantiate the UUT (Unit Under Test):
Flip_Flop_Timing UUT (
	// Inputs:
	.iD ( iD ),
	.iG ( iG ),

	// Outputs:
	.oQ ( oQ )
);

// Specify input stimulus:
initial fork
	#0 iD = 1'b0; #70 iD = 1'b1; #90 iD = 1'b0; #120 iD = 1'b1; #160 iD = 1'b0; #190 iD = 1'b1; #200 iD = 1'b0;
	#210 iD = 1'b1; #220 iD = 1'b0; #230 iD = 1'b1; #240 iD = 1'b0; #250 iD = 1'b1; #300 iD = 1'b0;

	#0 iG = 1'b0; #40 iG = 1'b1; #60 iG = 1'b0; #100 iG = 1'b1; #140 iG = 1'b0; #180 iG = 1'b1; #245 iG = 1'b0;
	#270 iG = 1'b1; #280 iG = 1'b0; #305 iG = 1'b1; #315 iG = 1'b0;

	#320 $stop;
	
join

endmodule