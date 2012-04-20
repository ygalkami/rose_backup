//----- Testbench -----

// Timescale: one time unit = 1ns (e.g., delay specification of #42 means 42ns of time), and
// simulator resolution is 0.1 ns
`timescale 1ns / 100ps

module TwoLights_TB;

// Input stimulus:
reg	iSelect;

// Output connections:
wire	oLeft;
wire	oRight;


//Instantiate the UUT (Unit Under Test):
TwoLights UUT (
	// Inputs:
	.iSelect ( iSelect ),	// Selects

	// Outputs:
	.oLeft ( oLeft ),	// Left-side
	.oRight ( oRight )	// Right-side
);

// Specify input stimulus:
initial begin

	// Initial values for input stimulus:
	iSelect = 1'b0;

	#10 iSelect = 1;
	#10 iSelect = 0;
	#2 iSelect = 1;
	#2 iSelect = 0;


	#30 $stop;
end

endmodule
