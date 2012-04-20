//----- Testbench -----

// Timescale: one time unit = 1ns (e.g., delay specification of #42 means 42ns of time), and
// simulator resolution is 0.1 ns
`timescale 1ns / 100ps

module SimpleGateCircuit_TB;

// Input stimulus:
reg	iA;
reg	iB;
reg	iC;
reg	iD;

// Output connections:
wire	oLeft;
wire	oMidLeft;
wire	oMidRight;
wire	oRight;


//Instantiate the UUT (Unit Under Test):
SimpleGateCircuit UUT (
	// Inputs:
	.iA ( iA ),
	.iB ( iB ),
	.iC ( iC ),
	.iD ( iD ),

	// Outputs:
	.oLeft ( oLeft ),
	.oMidLeft ( oMidLeft ),
	.oMidRight ( oMidRight ),
	.oRight ( oRight )
);

// Specify input stimulus:
initial begin

	// Initial values for input stimulus:
	iA = 1'b0;
	iB = 1'b0;
	iC = 1'b0;
	iD = 1'b0;

	//
	//--- START YOUR TEST PATTERNS HERE ---
	//

	#10 $stop;
end

endmodule