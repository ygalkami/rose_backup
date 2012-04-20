//----- Testbench -----

// Timescale: one time unit = 1ns (e.g., delay specification of #42 means 42ns of time), and
// simulator resolution is 0.1 ns
`timescale 1ns / 100ps

module Ring_Ocisillator_TB;

// Input stimulus:
reg	iEnable;

// Output connections:
wire	oA;
wire	oB;
wire	oC;
wire	oD;
wire	oE;
wire	oEn;


//Instantiate the UUT (Unit Under Test):
Ring_Ocisillator UUT (
	// Inputs:
	.iEnable ( iEnable ),

	// Outputs:
	.oA ( oA ),
	.oB ( oB ),
	.oC ( oC ),
	.oD ( oD ),
	.oE ( oE ),
	.oEn ( oEn )
);

// Specify input stimulus:
initial begin

	// Initial values for input stimulus:
	iEnable = 1'b0;
	
	#20 iEnable = 1'b1;

	#50 $stop;
end

endmodule