//----- Synthesizable Circuit -----

// Timescale: one time unit = 1ns (e.g., delay specification of #42 means 42ns of time), and
// simulator resolution is 0.1 ns
`timescale 1ns / 100ps

module TwoLights (
// Circuit to blink two LEDs

	// Inputs:
	input	iSelect,	// Selects which LED is ON

	// Outputs:
	output	oLeft,	// Left-side LED
	output	oRight	// Right-side LED
);


// Functionality:
not (oLeft, iSelect);
not (oRight, oLeft);


endmodule