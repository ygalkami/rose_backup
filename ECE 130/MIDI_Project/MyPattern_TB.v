//----- Testbench -----

// Timescale: one time unit = 1ns (e.g., delay specification of #42 means 42ns of time), and
// simulator resolution is 0.1 ns
`timescale 1ns / 100ps

module MyPattern_TB;

// Input stimulus:
reg	iVelocity;
reg	iStatus;
reg	iNote;
reg	iScheme;

// Output connections:
wire	oLightON;
wire	oLightOFF;
wire	oLightSelect;


//Instantiate the UUT (Unit Under Test):
MyPattern UUT (
	// Inputs:
	.iVelocity ( iVelocity ),
	.iStatus ( iStatus ),
	.iNote ( iNote ),
	.iScheme ( iScheme ),

	// Outputs:
	.oLightON ( oLightON ),
	.oLightOFF ( oLightOFF ),
	.oLightSelect ( oLightSelect )
);

// Specify input stimulus:
initial begin

	// Initial values for input stimulus:
	iVelocity = 8'b00000000;
	iStatus = 8'b10010000;
	iNote = 8'b00000000;
	iScheme = 1'b0;

	//
	//--- START YOUR TEST PATTERNS HERE ---
	//

	#10
	iVelocity = 8'b01011001;
	iStatus = 8'b10001111;
	iNote = 8'b01100101;
	iScheme = 1'b0;

	#10
	iVelocity = 8'b00000000;
	iStatus = 8'b10011010;
	iNote = 8'b01010000;
	iScheme = 1'b0;

	#10
	iVelocity = 8'b01111111;
	iStatus = 8'b10010111;
	iNote = 8'b00011111;
	iScheme = 1'b0;

		#10
	iVelocity = 8'b01011001;
	iStatus = 8'b10001111;
	iNote = 8'b01100101;
	iScheme = 1'b1;

	#10
	iVelocity = 8'b00000000;
	iStatus = 8'b10011010;
	iNote = 8'b01010000;
	iScheme = 1'b1;

	#10
	iVelocity = 8'b01111111;
	iStatus = 8'b10010111;
	iNote = 8'b00011111;
	iScheme = 1'b1;

	#20 $stop;
end

endmdule