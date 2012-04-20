// VTM (Verilog Template Maker) created this template file at
// 11:01 am on October 20, 2006.
// All comments, suggestions, and bug reports to the author: ed.doering at rose-hulman.edu

// It is your responsibility to modify, add, or delete sections of this template
// to make your system work properly. The output from VTM should be considered as
// only a starting point.
//-------------------------------------------------------------------------------

//----- Synthesizable Circuit -----

// Timescale: one time unit = 1ns (e.g., delay specification of #42 means 42ns of time), and
// simulator resolution is 0.1 ns
`timescale 1ns / 100ps

module TrafficSignalController_TOPLEVEL (

	// Global system resources:
	input	gClock,
	input	gReset,

	// Inputs:
	input	iAutoSensed,
	input	iStartSystem,
	input	[1:0]	iMode,
	input	iSingleStep,

	// Outputs:
	output	oSingleStepLED,
	output	[1:0]	oModeLED,
//	output	[3:0]	oState,
	output	oAutoSensed,
	output	oStartSystem,
	output	[7:0]	oDisplaySegment,
	output	[3:0]	oDisplayEnable
);

reg [2:0] rTimer;
wire [3:0] wState;
wire wTimerDone;
reg [7:0] rTimerDisplay;
assign oModeLED = iMode;
assign oAutoSensed = iAutoSensed;
assign oStartSystem = iStartSystem;

TrafficSignalController_FSM TrafficSignalController_FSM (
	.iAutoSensed	( wAutoSensed ),
	.iStartSystem	( wStartSystem ),
	.iTimerDone		( wTimerDone ),

	.oUS40Red		( wUS40Red ),
	.oUS40Yellow	( wUS40Yellow ),
	.oUS40Green		( wUS40Green ),
	.oRHRed			( wRHRed ),
	.oRHYellow		( wRHYellow ),
	.oRHGreen		( wRHGreen ),
	.oStartTimer	( wStartTimer ),

	.gReset(  gReset  ), 
	.gClock(  gClock  ), 
	.iClockEnable(  wClockEnable  ), 
	.oState(  wState  ) 
   );

ClockEnabler ClockEnabler (

   // Global system connections:
   .gClock(gClock),
   .gReset(gReset),

   // Inputs:
   .iSingleStep(iSingleStep),
   .iMode(iMode),

   // Outputs:
   .oEnable(wClockEnable),
   .oLED(oSingleStepLED)
);

Debouncer # (

   // Constant-valued parameters for this instance:
   .pInitialValue(1'b0)
) DebounceAutoSensor (
   // Global system connections:
   .gClock(gClock),
   .gReset(gReset),

   // Inputs:
   .iBouncy(iAutoSensed),

   // Outputs:
   .oDebounced(wAutoSensed),
   .oPulseOnRisingEdge(),
   .oPulseOnFallingEdge()
);

Debouncer # (

   // Constant-valued parameters for this instance:
   .pInitialValue(1'b0)
) DebounceStartSystem (
   // Global system connections:
   .gClock(gClock),
   .gReset(gReset),

   // Inputs:
   .iBouncy(iStartSystem),

   // Outputs:
   .oDebounced(wStartSystem),
   .oPulseOnRisingEdge(),
   .oPulseOnFallingEdge()
);


// Timer
always @ (posedge gClock, posedge gReset)
	if (gReset)
		rTimer <= 3'd0;
	else
		if (wClockEnable)
			rTimer <= wStartTimer ? 3'd7 :
				rTimer == 0 ? 3'd0 : rTimer - 1;

assign wTimerDone = rTimer == 0;

// Font generator for timer display
function [7:0] FontGenerator (input [3:0] val);
	begin
		case (val)          //    Dabcdefg
			0 : FontGenerator = 8'b01111110;
			1 : FontGenerator = 8'b00110000;
			2 : FontGenerator = 8'b01101101;
			3 : FontGenerator = 8'b01111001;
			4 : FontGenerator = 8'b00110011;
			5 : FontGenerator = 8'b01011011;
			6 : FontGenerator = 8'b01011111;
			7 : FontGenerator = 8'b01110000;

			8 : FontGenerator = 8'b01111111;
			9 : FontGenerator = 8'b01111011;
			'ha : FontGenerator = 8'b01110111;
			'hb : FontGenerator = 8'b00011111;
			'hc : FontGenerator = 8'b01001110;
			'hd : FontGenerator = 8'b00111101;
			'he : FontGenerator = 8'b01001111;
			'hf : FontGenerator = 8'b01000111;

			default : FontGenerator = 8'b00000001;	
		endcase
	end
endfunction

Display Display (

   // Global system connections:
   .gClock(gClock),
   .gReset(gReset),

   // Inputs:
   .iLeft({1'b0,wUS40Red,2'b00,wUS40Green,2'b00,wUS40Yellow}),
   .iMiddleLeft({1'b0,wRHRed,2'b00,wRHGreen,2'b00,wRHYellow}),
   .iMiddleRight(FontGenerator(wState)),
   .iRight(FontGenerator({1'b0,rTimer})),

   // Outputs:
   .oSegmentA(oDisplaySegment[7]),
   .oSegmentB(oDisplaySegment[6]),
   .oSegmentC(oDisplaySegment[5]),
   .oSegmentD(oDisplaySegment[4]),
   .oSegmentE(oDisplaySegment[3]),
   .oSegmentF(oDisplaySegment[2]),
   .oSegmentG(oDisplaySegment[1]),
   .oSegmentDP(oDisplaySegment[0]),
   .oDigitLeft(oDisplayEnable[3]),
   .oDigitMiddleLeft(oDisplayEnable[2]),
   .oDigitMiddleRight(oDisplayEnable[1]),
   .oDigitRight(oDisplayEnable[0])
);




endmodule

