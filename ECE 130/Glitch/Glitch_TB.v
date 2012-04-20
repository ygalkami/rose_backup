//----- Testbench -----

// Timescale: one time unit = 1ns (e.g., delay specification of #42 means 42ns of time), and
// simulator resolution is 0.1 ns
`timescale 1ns / 100ps

module Glitch_TB;

// Input stimulus:
reg	iA;
reg	iB;
reg	iC;
reg	iD;

// Output connections:
wire	oG;


//Instantiate the UUT (Unit Under Test):
Glitch UUT (
	// Inputs:
	.iA ( iA ),
	.iB ( iB ),
	.iC ( iC ),
	.iD ( iD ),

	// Outputs:
	.oG ( oG )
);

// Specify input stimulus:
initial begin

	// Initial values for input stimulus:
	iA = 1'b0;
	iB = 1'b0;
	iC = 1'b0;
	iD = 1'b0;
	
	//No glitch
	#10 {iA, iB, iC, iD} = 4'b1000;
	#10 {iA, iB, iC, iD} = 4'b1010;

	#10 {iA, iB, iC, iD} = 4'b0001;
	#10 {iA, iB, iC, iD} = 4'b0101;

	#10 {iA, iB, iC, iD} = 4'b0010;
	#10 {iA, iB, iC, iD} = 4'b0110;

	//Glitch
	#50 {iA, iB, iC, iD} = 4'b1000;
	#10 {iA, iB, iC, iD} = 4'b0010;

	#10 {iA, iB, iC, iD} = 4'b0001;
	#10 {iA, iB, iC, iD} = 4'b0010;

	#10 {iA, iB, iC, iD} = 4'b0101;
	#10 {iA, iB, iC, iD} = 4'b0010;

	#50 $stop;
end

endmodule