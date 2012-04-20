//-----------------------------------------------------------------------------
// Verilog module library for ECE130
//
// Version D -- 11 Oct 2005 -- Added 'ClockEnabler', 'MUX8', and 'MUX16'
// Version C -- 04 Oct 2005 -- Added flip-flops (D, T, JK) and D-type latch
// Version B -- 26 Sep 2005 -- Added 'Debouncer' and 'OneShot'
// Version A -- 29 Aug 2005 -- Initial revision
//
// Dr. Edward Doering
// Department of Electrical and Computer Engineering
// Rose-Hulman Institute of Technology
//
//-----------------------------------------------------------------------------

`timescale 1ns / 100ps

//-----------------------------------------------------------------------------

module JKFF
// JK-type flip-flop
 	(
	// Inputs
	input	iJ,
	input	iK,
	input	iClk,
	input	iPreset,
	input	iClear,

	// Outputs:
	output	reg oQ,	
	output	oQn
	);


	// Device behavior
	always @ (posedge iClk or posedge iPreset or posedge iClear)
		if (iClear)
			oQ <= 0;
		else if (iPreset)
			oQ <= 1;
		else
			case ({iJ,iK})
				0: oQ <= oQ;
				1: oQ <= 0;
				2: oQ <= 1;
				3: oQ <= ~oQ;
			endcase

	assign oQn = ~oQ;

endmodule

//-----------------------------------------------------------------------------

module TFF
// T-type flip-flop
 	(
	// Inputs
	input	iT,
	input	iClk,
	input	iPreset,
	input	iClear,

	// Outputs:
	output	reg oQ,	
	output	oQn
	);


	// Device behavior
	always @ (posedge iClk or posedge iPreset or posedge iClear)
		if (iClear)
			oQ <= 0;
		else if (iPreset)
			oQ <= 1;
		else
			oQ <= (iT) ? ~oQ : oQ;

	assign oQn = ~oQ;

endmodule

//-----------------------------------------------------------------------------

module DLatch
// D-type latch with active-high reset
 	(
	// Inputs
	input	iD,
	input	iGate,
	input	iReset,

	// Outputs:
	output	oQ,	
	output	oQn
	);


	// Device behavior
	assign oQ = iReset ? 0 : iGate ? iD : oQ;
	assign oQn = ~oQ;

endmodule

//-----------------------------------------------------------------------------

module DFF
// D-type flip-flop
 	(
	// Inputs
	input	iD,
	input	iClk,
	input	iPreset,
	input	iClear,

	// Outputs:
	output	reg oQ,	
	output	oQn
	);


	// Device behavior
	always @ (posedge iClk or posedge iPreset or posedge iClear)
		if (iClear)
			oQ <= 0;
		else if (iPreset)
			oQ <= 1;
		else
			oQ <= iD;

	assign oQn = ~oQ;

endmodule

//-----------------------------------------------------------------------------

module Adder
// Add two unsigned values A and B to produce Sum. Carry-out
// and carry-in ports are included.

# (
	// Constant-valued parameters
	parameter	pWidth = 8

) 	(
	// Inputs
	input	[pWidth-1 : 0]	iA,
	input	[pWidth-1 : 0]	iB,
	input	iCarryIn,

	// Outputs:
	output	[pWidth-1 : 0]	oSum,	
	output	oCarryOut
	);


	// Device behavior
	assign {oCarryOut,oSum} = iA + iB + iCarryIn;

endmodule

//-----------------------------------------------------------------------------

module Comparator
// Compare two unsigned values A and B to determine equality, inequality, 
// greater than, and so on. Unneeded outputs may be left blank when
// instantiating the module.

# (
	// Constant-valued parameters
	parameter	pWidth = 8

) 	(
	// Inputs
	input	[pWidth-1 : 0]	iA,
	input	[pWidth-1 : 0]	iB,

	// Outputs:
	output	oAeqB,	
	output	oAneB,	
	output	oAltB,	
	output	oAleB,	
	output	oAgtB,	
	output	oAgeB	
	);


	// Device behavior
	assign oAeqB = iA == iB;
	assign oAneB = iA != iB;
	assign oAltB = iA <  iB;
	assign oAleB = iA <= iB;
	assign oAgtB = iA >  iB;
	assign oAgeB = iA >= iB;

endmodule

//-----------------------------------------------------------------------------

module Counter
// Increments (or decrements) the stored value by a fixed amount when the 
// count enable is asserted.

# (
	// Constant-valued parameters
	parameter	pWidth = 8,
	parameter	pInitialValue = 0,
	parameter	pDirectionIsDown = 0,
	parameter	pAmount = 1

) 	(
	// Global system connections
	input	gClock,
	input	gReset,

	// Inputs
	input	iUpdate,

	// Outputs:
	output	reg	[ pWidth-1 : 0 ]	oCounterValue
	);


	// Device behavior
	always @ (posedge gClock or posedge gReset)
		if (gReset)
			oCounterValue <= pInitialValue;
		else
			if (iUpdate)
				if (pDirectionIsDown)
					oCounterValue <= oCounterValue - pAmount;
				else
					oCounterValue <= oCounterValue + pAmount;

endmodule

//-----------------------------------------------------------------------------


module CounterUpDown
// Increments or decrements the stored value by a variable amount when the count 
// enable is asserted; count direction is controlled by an input; counter can 
// be loaded with a new value.

# (
	// Constant-valued parameters
	parameter	pWidth = 8,
	parameter	pInitialValue = 0

) 	(
	// Global system connections
	input	gClock,
	input	gReset,

	// Inputs
	input	iUpdate,
	input	iCountDown,
	input	[ pWidth-1 : 0 ]	iAmount,
	input	iLoadCount,
	input	[ pWidth-1 : 0 ]	iNewCount,

	// Outputs:
	output	reg	[ pWidth-1 : 0 ]	oCounterValue
	);


	// Device behavior
	always @ (posedge gClock or posedge gReset)
		if (gReset)
			oCounterValue <= pInitialValue;
		else
			if (iLoadCount)
				oCounterValue <= iNewCount;
			else if (iUpdate)
				if (iCountDown)
					oCounterValue <= oCounterValue - iAmount;
				else
					oCounterValue <= oCounterValue + iAmount;

endmodule

//-----------------------------------------------------------------------------


module Decode2to4
// Accepts a two-bit input code and asserts the associated output when enabled.
	(
	// Inputs
	input	[1:0]	iCode,
	input	iOutputEnable,

	// Outputs:
	output	reg	oOutput0,
	output	reg	oOutput1,
	output	reg	oOutput2,
	output	reg	oOutput3,
	output	[3:0] oOutput
	);


	// Device behavior
	always @*
		if (iOutputEnable) begin
			oOutput0 = iCode == 0;
			oOutput1 = iCode == 1;
			oOutput2 = iCode == 2;
			oOutput3 = iCode == 3;
		end
		else begin
			oOutput0 = 0;
			oOutput1 = 0;
			oOutput2 = 0;
			oOutput3 = 0;
		end

	assign oOutput = {oOutput3,oOutput2,oOutput1,oOutput0};

endmodule

//-----------------------------------------------------------------------------


module Decode3to8
// Accepts a three-bit input code and asserts the associated output when enabled.
	(
	// Inputs
	input	[2:0]	iCode,
	input	iOutputEnable,

	// Outputs:
	output	reg	oOutput0,
	output	reg	oOutput1,
	output	reg	oOutput2,
	output	reg	oOutput3,
	output	reg	oOutput4,
	output	reg	oOutput5,
	output	reg	oOutput6,
	output	reg	oOutput7,
	output	[7:0] oOutput
	);


	// Device behavior
	always @*
		if (iOutputEnable) begin
			oOutput0 = iCode == 0;
			oOutput1 = iCode == 1;
			oOutput2 = iCode == 2;
			oOutput3 = iCode == 3;
			oOutput4 = iCode == 4;
			oOutput5 = iCode == 5;
			oOutput6 = iCode == 6;
			oOutput7 = iCode == 7;
		end
		else begin
			oOutput0 = 0;
			oOutput1 = 0;
			oOutput2 = 0;
			oOutput3 = 0;
			oOutput4 = 0;
			oOutput5 = 0;
			oOutput6 = 0;
			oOutput7 = 0;
		end

	assign oOutput = {oOutput7,oOutput6,oOutput5,oOutput4,oOutput3,oOutput2,oOutput1,oOutput0};

endmodule

//-----------------------------------------------------------------------------


module Encode4to2
// Accepts four inputs and produces the two-bit binary code indicating which 
// input is asserted. When multiple inputs are asserted, priority is given to 
// the lower-numbered input.

	(
	// Inputs
	input	iInput0,
	input	iInput1,
	input	iInput2,
	input	iInput3,

	// Outputs:
	output	reg	[1:0] oCode,
	output	reg	oNoInputsActive
	);


	// Device behavior
	always @* begin
		oCode = 0;
		oNoInputsActive = 0;

		if (iInput0) oCode = 0;
		else if (iInput1) oCode = 1;
		else if (iInput2) oCode = 2;
		else if (iInput3) oCode = 3;
		else oNoInputsActive = 1;
	end

endmodule

//-----------------------------------------------------------------------------


module Encode8to3
// Accepts eight inputs and produces the three-bit binary code indicating which 
// input is asserted. When multiple inputs are asserted, priority is given to 
// the lower-numbered input.

	(
	// Inputs
	input	iInput0,
	input	iInput1,
	input	iInput2,
	input	iInput3,
	input	iInput4,
	input	iInput5,
	input	iInput6,
	input	iInput7,

	// Outputs:
	output	reg	[2:0] oCode,
	output	reg	oNoInputsActive
	);


	// Device behavior
	always @* begin
		oCode = 0;
		oNoInputsActive = 0;

		if (iInput0) oCode = 0;
		else if (iInput1) oCode = 1;
		else if (iInput2) oCode = 2;
		else if (iInput3) oCode = 3;
		else if (iInput4) oCode = 4;
		else if (iInput5) oCode = 5;
		else if (iInput6) oCode = 6;
		else if (iInput7) oCode = 7;
		else oNoInputsActive = 1;
	end

endmodule

//-----------------------------------------------------------------------------


module Synchronizer
// Synchronizes asynchronous external inputs to the system clock

# (
	// Constant-valued parameters
	parameter	pInitialValue = 0

) 	(
	// Global system connections
	input	gClock,
	input	gReset,

	// Inputs
	input	iAsyncInput,

	// Outputs:
	output	reg	oSyncInput
	);


	// Device behavior
	always @ (posedge gClock or posedge gReset)
		if (gReset)
			oSyncInput <= pInitialValue;
		else
			oSyncInput <= iAsyncInput;

endmodule

//-----------------------------------------------------------------------------


module FrequencyDivider 
// Produces a periodic single-clock-period pulse at a reduced frequency from 
// the system clock.

# (
	// Constant-valued parameters
	parameter	pDivisor = 4,
	parameter	pBits = 2,
	parameter	pInitialValue = 0

) 	(
	// Global system connections
	input	gClock,
	input	gReset,

	// Outputs:
	output	reg	oLowerFrequency
	);

	// Internal device declarations
	reg [pBits-1 : 0]	rCount;

	// Device behavior
	always @ (posedge gClock or posedge gReset)
		if (gReset) begin
			rCount <= 0;
			oLowerFrequency <= pInitialValue;
		end
		else
		if (rCount != pDivisor - 1) begin
			rCount <= rCount + 1;
			oLowerFrequency <= 0;
		end
		else begin
			rCount <= 0;
			oLowerFrequency <= 1;
		end
	
endmodule

//-----------------------------------------------------------------------------

module MUX2
// Output data is the same as the selected input data; two possible input data sources.

# (
	// Constant-valued parameters
	parameter	pWidth = 8

) 	(
	// Inputs
	input	[pWidth-1 : 0]	iDataInput0,
	input	[pWidth-1 : 0]	iDataInput1,
	input	iDataSelect,

	// Outputs:
	output	[pWidth-1 : 0]	oOutput
	);


	// Device behavior
	assign oOutput = (iDataSelect) ? iDataInput1 : iDataInput0;

endmodule

//-----------------------------------------------------------------------------


module MUX4
// Output data is the same as the selected input data; four possible input data sources.

# (
	// Constant-valued parameters
	parameter	pWidth = 8

) 	(
	// Inputs
	input	[pWidth-1 : 0]	iDataInput0,
	input	[pWidth-1 : 0]	iDataInput1,
	input	[pWidth-1 : 0]	iDataInput2,
	input	[pWidth-1 : 0]	iDataInput3,
	input	[1:0]	iDataSelect,

	// Outputs:
	output	reg	[pWidth-1 : 0]	oOutput
	);


	// Device behavior
	always @*
		case (iDataSelect)
			0 : oOutput = iDataInput0;
			1 : oOutput = iDataInput1;
			2 : oOutput = iDataInput2;
			3 : oOutput = iDataInput3;
		endcase

endmodule

//-----------------------------------------------------------------------------

module MUX8
// Output data is the same as the selected input data; eight possible input data sources.

# (
	// Constant-valued parameters
	parameter	pWidth = 8

) 	(
	// Inputs
	input	[pWidth-1 : 0]	iDataInput0,
	input	[pWidth-1 : 0]	iDataInput1,
	input	[pWidth-1 : 0]	iDataInput2,
	input	[pWidth-1 : 0]	iDataInput3,
	input	[pWidth-1 : 0]	iDataInput4,
	input	[pWidth-1 : 0]	iDataInput5,
	input	[pWidth-1 : 0]	iDataInput6,
	input	[pWidth-1 : 0]	iDataInput7,
	input	[2:0]	iDataSelect,

	// Outputs:
	output	reg	[pWidth-1 : 0]	oOutput
	);


	// Device behavior
	always @*
		case (iDataSelect)
			0 : oOutput = iDataInput0;
			1 : oOutput = iDataInput1;
			2 : oOutput = iDataInput2;
			3 : oOutput = iDataInput3;
			4 : oOutput = iDataInput4;
			5 : oOutput = iDataInput5;
			6 : oOutput = iDataInput6;
			7 : oOutput = iDataInput7;
		endcase

endmodule

//-----------------------------------------------------------------------------

module MUX16
// Output data is the same as the selected input data; sixteen possible input data sources.

# (
	// Constant-valued parameters
	parameter	pWidth = 8

) 	(
	// Inputs
	input	[pWidth-1 : 0]	iDataInput0,
	input	[pWidth-1 : 0]	iDataInput1,
	input	[pWidth-1 : 0]	iDataInput2,
	input	[pWidth-1 : 0]	iDataInput3,
	input	[pWidth-1 : 0]	iDataInput4,
	input	[pWidth-1 : 0]	iDataInput5,
	input	[pWidth-1 : 0]	iDataInput6,
	input	[pWidth-1 : 0]	iDataInput7,
	input	[pWidth-1 : 0]	iDataInput8,
	input	[pWidth-1 : 0]	iDataInput9,
	input	[pWidth-1 : 0]	iDataInput10,
	input	[pWidth-1 : 0]	iDataInput11,
	input	[pWidth-1 : 0]	iDataInput12,
	input	[pWidth-1 : 0]	iDataInput13,
	input	[pWidth-1 : 0]	iDataInput14,
	input	[pWidth-1 : 0]	iDataInput15,
	input	[3:0]	iDataSelect,

	// Outputs:
	output	reg	[pWidth-1 : 0]	oOutput
	);


	// Device behavior
	always @*
		case (iDataSelect)
			0 : oOutput = iDataInput0;
			1 : oOutput = iDataInput1;
			2 : oOutput = iDataInput2;
			3 : oOutput = iDataInput3;
			4 : oOutput = iDataInput4;
			5 : oOutput = iDataInput5;
			6 : oOutput = iDataInput6;
			7 : oOutput = iDataInput7;
			8 : oOutput = iDataInput8;
			9 : oOutput = iDataInput9;
			10 : oOutput = iDataInput10;
			11 : oOutput = iDataInput11;
			12 : oOutput = iDataInput12;
			13 : oOutput = iDataInput13;
			14 : oOutput = iDataInput14;
			15 : oOutput = iDataInput15;
		endcase

endmodule

//-----------------------------------------------------------------------------

module Register
// Stores the value presented on the data input when the enable input is asserted

# (
	// Constant-valued parameters
	parameter	pWidth = 8,
	parameter	pInitialValue = 0

) 	(
	// Global system connections
	input	gClock,
	input	gReset,

	// Inputs
	input	iStoreInput,
	input	[ pWidth-1 : 0 ]	iDataInput,

	// Outputs:
	output	reg	[ pWidth-1 : 0 ]	oOutput
	);


	// Device behavior
	always @ (posedge gClock or posedge gReset)
		if (gReset)
			oOutput <= pInitialValue;
		else
			if (iStoreInput)
				oOutput <= iDataInput;

endmodule

//-----------------------------------------------------------------------------


module Register4
// Stores the value presented on the selected data input (four total) when the 
// associated input enable is asserted. If more than one "store data" input is 
// asserted simultaneously, lower-numbered inputs have priority.


# (
	// Constant-valued parameters
	parameter	pWidth = 8,
	parameter	pInitialValue = 0

) 	(
	// Global system connections
	input	gClock,
	input	gReset,

	// Inputs
	input	iStoreInput0,
	input	iStoreInput1,
	input	iStoreInput2,
	input	iStoreInput3,
	input	[ pWidth-1 : 0 ]	iDataInput0,
	input	[ pWidth-1 : 0 ]	iDataInput1,
	input	[ pWidth-1 : 0 ]	iDataInput2,
	input	[ pWidth-1 : 0 ]	iDataInput3,

	// Outputs:
	output	reg	[ pWidth-1 : 0 ]	oOutput
	);


	// Device behavior
	always @ (posedge gClock or posedge gReset)
		if (gReset)
			oOutput <= pInitialValue;
		else
			if (iStoreInput0)
				oOutput <= iDataInput0;
			else if (iStoreInput1)
				oOutput <= iDataInput1;
			else if (iStoreInput2)
				oOutput <= iDataInput2;
			else if (iStoreInput3)
				oOutput <= iDataInput3;

endmodule

//-----------------------------------------------------------------------------

module TransitionDetector
// Produces a single-clock-period pulse when a transition (change) is detected 
// on input signal. Can detect either low-to-high (rising edge) transition, 
// high-to-low (falling edge) transition, or both. Input must already be 
// synchronized to master clock.

 	(
	// Global system connections
	input	gClock,
	input	gReset,

	// Inputs
	input	iInput,
	input	iDetectRisingEdge,
	input	iDetectFallingEdge,

	// Outputs:
	output	oTransitionDetected
	);

	// Internal device declarations
	reg [3:0] rS;

	// Device behavior
	always @ (posedge gClock or posedge gReset)
		if (gReset)
			rS <= 4'b1000;
		else
			rS <= {
				rS[3] & ~iInput | rS[0],
				rS[3] & iInput,
				rS[2] | rS[1] & iInput ,
				rS[1] & ~iInput
				};

	assign oTransitionDetected = rS[2] & iDetectRisingEdge | rS[0] & iDetectFallingEdge;

endmodule

//-----------------------------------------------------------------------------

module Display (
// Digit display interface for Digilent DIO1, DIO4, and Spartan-3 boards offering
// individual control of each LED segment.
//
// - Accepts four 8-bit input values, where the most significant bit
//     corresponds to the decimal point, and the remaining seven bits
//     correspond to the segments "a" through "g". For example, the
//     value 8'b10010101 will activate the decimal point and segments
//     "c", "e" and "g". A "1" lights the segment, and a "0" turns it off.
// - Uses multiplexed display scheme with 100 Hz refresh to minimize flicker.
// - Requires 50MHz master clock
// - Requires active-high master reset (all segments active on reset)
//
// Instantiation template:
/*
Display instancename (
	// System connections
    .gClock(  ), 
    .gReset(  ), 	 // Active high

    // Data inputs
    .iRight(  ),   	// 8-bit values for each digit
    .iMiddleRight(  ),
    .iMiddleLeft(  ),
    .iLeft(  ),

    // Direct connections to DIO1 or DIO4 board:
    // Segment selectors
    .oSegmentA(  ), 
    .oSegmentB(  ), 
    .oSegmentC(  ), 
    .oSegmentD(  ), 
    .oSegmentE(  ), 
    .oSegmentF(  ), 
    .oSegmentG(  ), 
    .oSegmentDP(  ),
    
    // Digit selectors 
    .oDigitRight(  ), 
    .oDigitMiddleRight(  ), 
    .oDigitMiddleLeft(  ), 
    .oDigitLeft(  )
    );
defparam instancename.pDigitSelectLevel = 1;
	// Use 0 for DIO4 and Spartan-3 board, 1 for DIO1 board (parameter defaults to 0 
	// when 'defparam' line is omitted).
*/
// End of instantiation template
//
// Author: Ed Doering
// Created: 22 Jan 2003
// Revised: 20 Mar 2004 (added parameter to choose digit select assertion level)
// 	16 Aug 2005 (updated for Spartan-3 board; updated signal names)

	// Inputs:
	input gClock,	// System clock (50 MHz)
	input gReset,	// Master reset (active high)

	input [7:0] iRight,			// Pattern to display on rightmost digit
	input [7:0] iMiddleRight,	// Pattern to display on middle right digit
	input [7:0] iMiddleLeft,	// Pattern to display on middle left digit
	input [7:0] iLeft,			// Pattern to display on leftmost digit

	// Outputs:
	output reg oSegmentA,	// LED segment a (active low)
	output reg oSegmentB,	// etc.
	output reg oSegmentC,
	output reg oSegmentD,
	output reg oSegmentE,
	output reg oSegmentF,
	output reg oSegmentG,
	output reg oSegmentDP,	// LED decimal point
	output reg oDigitRight,	// Rightmost digit enable (active high)
	output reg oDigitMiddleRight,	// etc.
	output reg oDigitMiddleLeft,
	output reg oDigitLeft
);

// User-adjustable constants
parameter pDigitSelectLevel = 0;	// Set to 1 for DIO1 board, 0 for DIO4 and Spartan-3 boards

parameter pClockFrequency = 50;	// Clock frequency in MHz
parameter pRefreshFrequency = 100;	// Display refresh rate (for entire display) in Hz

// Upper limit for frequency divider counter
parameter pUpperLimit = (pClockFrequency * 1000000) / (4 * pRefreshFrequency);
//parameter pUpperLimit = 2; // for simulation only

// Number of bits for frequency divider counter (will accommodate 
// refresh frequencies down to 1 Hz)
parameter pDividerCounterBits = 24;


// Registered identifiers:
reg [pDividerCounterBits-1:0] rCycles;
reg [1:0] rDigitSelect;
reg [3:0] rDigit;
reg [7:0] rPattern;

// Frequency divider and 2-bit counter for digit selector
always @ (posedge gClock or posedge gReset)
	if (gReset) begin
		rCycles <= 0;
		rDigitSelect <= 3;
	end
	else
		if (rCycles == pUpperLimit)	begin
			rCycles <= 0;
			rDigitSelect <= rDigitSelect - 1;
		end
		else
			rCycles <= rCycles + 1;

// Decode the digit selector to four control lines
always @ (rDigitSelect)
	if (pDigitSelectLevel)
		case (rDigitSelect)
			2'b00 : rDigit <= 4'b0001;
			2'b01 : rDigit <= 4'b0010;
			2'b10 : rDigit <= 4'b0100; 
			2'b11 : rDigit <= 4'b1000;
		endcase
	else
		case (rDigitSelect)
			2'b00 : rDigit <= 4'b1110;
			2'b01 : rDigit <= 4'b1101;
			2'b10 : rDigit <= 4'b1011; 
			2'b11 : rDigit <= 4'b0111;
		endcase

// MUX the four 8-bit inputs to a single 8-bit value, and bit-wise
// complement to make active low
always @ (rDigitSelect or iRight or iMiddleRight or iMiddleLeft or iLeft)
	case (rDigitSelect)
		2'b00 : rPattern <= ~iRight;
		2'b01 : rPattern <= ~iMiddleRight;
		2'b10 : rPattern <= ~iMiddleLeft;
		2'b11 : rPattern <= ~iLeft;
	endcase

// Create registered outputs (for glitch-free output)
always @ (posedge gClock or posedge gReset)
	if (gReset) begin
		oSegmentA <= 0;
		oSegmentB <= 0;
		oSegmentC <= 0;
		oSegmentD <= 0;
		oSegmentE <= 0;
		oSegmentF <= 0;
		oSegmentG <= 0;
		oSegmentDP <= 0;
		oDigitRight <= pDigitSelectLevel;
		oDigitMiddleRight <= pDigitSelectLevel;
		oDigitMiddleLeft <= pDigitSelectLevel;
		oDigitLeft <= pDigitSelectLevel;
	end
	else begin
		oSegmentDP <= rPattern[7];
		oSegmentA <= rPattern[6];
		oSegmentB <= rPattern[5];
		oSegmentC <= rPattern[4];
		oSegmentD <= rPattern[3];
		oSegmentE <= rPattern[2];
		oSegmentF <= rPattern[1];
		oSegmentG <= rPattern[0];
		oDigitRight <= rDigit[0];
		oDigitMiddleRight <= rDigit[1];
		oDigitMiddleLeft <= rDigit[2];
		oDigitLeft <= rDigit[3];
	end

endmodule

//-----------------------------------------------------------------------------

module DisplayHex (
// Digit display interface for Digilent DIO1, DIO4 and Spartan-3 boards
//
// - Accepts two 8-bit values on input, and displays the hexadecimal
//     representation of each value on the four-digit seven-segment display
// - Uses multiplexed display scheme with 100 Hz refresh to minimize flicker.
// - Requires 50MHz master clock
// - Requires active-high master reset (all segments active on reset)
// - Works with either active high or active low digit selectors (easiest
//	to use 'defparam pDigitSelectLevel = <value>' (where <value> is
//	is either 1 for high or 0 for low) immediately after instantiating
//	the module)
//
// Instantiation template:
/*
DigitDisplay instancename (
	// System connections
    .gClock(  ), 
    .gReset(  ), 	 // Active high

    // Data inputs
    .iRight(  ),   // 8-bit value
    .iLeft(  ),    // 8-bit value

    // Direct connections to DIO1 or DIO4 board:
    // Segment selectors
    .oSegmentA(  ), 
    .oSegmentB(  ), 
    .oSegmentC(  ), 
    .oSegmentD(  ), 
    .oSegmentE(  ), 
    .oSegmentF(  ), 
    .oSegmentG(  ), 
    .oSegmentDP(  ),
    
    // Digit selectors 
    .oDigitRight(  ), 
    .oDigitMiddleRight(  ), 
    .oDigitMiddleLeft(  ), 
    .oDigitLeft(  )
    );
defparam instancename.pDigitSelectLevel = 1;
	// Use 0 for DIO4 and Spartan-3 boards, 1 for DIO1 board (parameter defaults to 0 
	// when 'defparam' line is omitted).
*/
// End of instantiation template
//
// Author: Ed Doering
// Created: 21 Jan 2003
// Revised: 16 Mar 2004 (added parameter to choose digit select assertion level)
// 	16 Aug 2005 (updated for Spartan-3; updated signal names)

	// Global system resources:
	input gClock,	// System clock (50 MHz)
	input gReset,	// Master reset (active high)

	// Inputs:
	input [7:0] iRight,	// Value to display on right two digits
	input [7:0] iLeft,	// Value to display on left two digits

	// Outputs:
	output reg oSegmentA,	// LED segment a (active low)
	output reg oSegmentB,	// etc.
	output reg oSegmentC,
	output reg oSegmentD,
	output reg oSegmentE,
	output reg oSegmentF,
	output reg oSegmentG,
	output reg oSegmentDP,	// LED decimal point
	output reg oDigitRight,	// Rightmost digit enable (active high)
	output reg oDigitMiddleRight,	// etc.
	output reg oDigitMiddleLeft,
	output reg oDigitLeft
);

// User-adjustable constants
parameter pDigitSelectLevel = 0;	// Set 0 for DIO4 and Spartan-3 boards, 0 for DIO1 board
parameter pClockFrequency = 50;	// Clock frequency in MHz
parameter pRefreshFrequency = 100;	// Display refresh rate (for entire display) in Hz

// Upper limit for frequency divider counter
parameter pUpperLimit = (pClockFrequency * 1000000) / (4 * pRefreshFrequency);
//parameter pUpperLimit = 2; // for simulation only

// Number of bits for frequency divider counter (will accommodate 
// refresh frequencies down to 1 Hz)
parameter pDividerCounterBits = 24;


// Registered identifiers:
reg [pDividerCounterBits-1:0] rCycles;
reg [1:0] rDigitSelect;
reg [7:0] rNybble;
reg [3:0] rDigit;
wire wDecimalPoint;
reg [6:0] rCharacter;

// Frequency divider and 2-bit counter for digit selector
always @ (posedge gClock or posedge gReset)
	if (gReset) begin
		rCycles <= 0;
		rDigitSelect <= 3;
	end
	else
		if (rCycles == pUpperLimit)	begin
			rCycles <= 0;
			rDigitSelect <= rDigitSelect - 1;
		end
		else
			rCycles <= rCycles + 1;

// Decode the digit selector to four control lines
always @ (rDigitSelect)
	if (pDigitSelectLevel)
		case (rDigitSelect)
			2'b00 : rDigit <= 4'b0001;
			2'b01 : rDigit <= 4'b0010;
			2'b10 : rDigit <= 4'b0100; 
			2'b11 : rDigit <= 4'b1000;
		endcase
	else
		case (rDigitSelect)
			2'b00 : rDigit <= 4'b1110;
			2'b01 : rDigit <= 4'b1101;
			2'b10 : rDigit <= 4'b1011; 
			2'b11 : rDigit <= 4'b0111;
		endcase

// Activate decimal point when left-middle digit is selected
assign wDecimalPoint = ~(rDigitSelect == 2'b10);

// MUX the four 4-bit inputs to a single 4-bit value
always @ (rDigitSelect or iRight or iLeft)
	case (rDigitSelect)
		2'b00 : rNybble <= iRight[3:0];
		2'b01 : rNybble <= iRight[7:4];
		2'b10 : rNybble <= iLeft[3:0];
		2'b11 : rNybble <= iLeft[7:4];
	endcase

// Convert 4-bit value to character
always @ (rNybble)
	case (rNybble)       //     abcdefg
		4'h0 : rCharacter <= ~(7'b1111110);
		4'h1 : rCharacter <= ~(7'b0110000);
		4'h2 : rCharacter <= ~(7'b1101101);
		4'h3 : rCharacter <= ~(7'b1111001);
		4'h4 : rCharacter <= ~(7'b0110011);
		4'h5 : rCharacter <= ~(7'b1011011);
		4'h6 : rCharacter <= ~(7'b1011111);
		4'h7 : rCharacter <= ~(7'b1110000);
		4'h8 : rCharacter <= ~(7'b1111111);
		4'h9 : rCharacter <= ~(7'b1111011);
		4'ha : rCharacter <= ~(7'b1110111);
		4'hb : rCharacter <= ~(7'b0011111);
		4'hc : rCharacter <= ~(7'b1001110);
		4'hd : rCharacter <= ~(7'b0111101);
		4'he : rCharacter <= ~(7'b1001111);
		4'hf : rCharacter <= ~(7'b1000111);
		default : rCharacter <= ~(7'b1001001);	
	endcase

// Create registered outputs (for glitch-free output)
always @ (posedge gClock or posedge gReset)
	if (gReset) begin
		oSegmentA <= 0;
		oSegmentB <= 0;
		oSegmentC <= 0;
		oSegmentD <= 0;
		oSegmentE <= 0;
		oSegmentF <= 0;
		oSegmentG <= 0;
		oSegmentDP <= 0;
		oDigitRight <= pDigitSelectLevel;
		oDigitMiddleRight <= pDigitSelectLevel;
		oDigitMiddleLeft <= pDigitSelectLevel;
		oDigitLeft <= pDigitSelectLevel;
	end
	else begin
		oSegmentA <= rCharacter[6];
		oSegmentB <= rCharacter[5];
		oSegmentC <= rCharacter[4];
		oSegmentD <= rCharacter[3];
		oSegmentE <= rCharacter[2];
		oSegmentF <= rCharacter[1];
		oSegmentG <= rCharacter[0];
		oSegmentDP <= wDecimalPoint;
		oDigitRight <= rDigit[0];
		oDigitMiddleRight <= rDigit[1];
		oDigitMiddleLeft <= rDigit[2];
		oDigitLeft <= rDigit[3];
	end

endmodule

//-----------------------------------------------------------------------------

module Debouncer (
// Switch debouncer for Digilent FPGA boards
//
// Requires a 50MHz clock, and implements a 10ms wait period.
// Includes glitch suppression. Built-in synchronizer.
// Outputs include a debounced replica of the input signal, and
// single clock period pulse outputs to indicate rising edge and
// falling edge detected (of clean signal).
//
// 10ms at 50MHz is 500,000 master clock cycles, requiring 19 bits
// of register space.

	// Global system resources:
	input gClock,	// System clock (must be 50 MHz)
	input gReset,	// Master reset (asynchronous, active high)

	// Inputs:
	input iBouncy,	// Bouncy switch signal

	// Outputs:
	output reg oDebounced,	// Debounced replica of switch signal
	output reg oPulseOnRisingEdge,	// Single pulse to indicate rising edge detected
	output reg oPulseOnFallingEdge	// Single pulse to indicate falling edge detected
);

// Constant parameters
parameter pInitialValue = 0;
parameter pTimerWidth = 19;
parameter pInitialTimerValue = 19'd500_000; // for synthesis
//parameter pInitialTimerValue = 19'd20; // for simulation

// Registered identifiers:
reg	rInitializeTimer;
reg	rWaitForTimer;
reg	rSaveInput;
reg	rBouncy_Syncd;
reg	[pTimerWidth-1:0] rTimer;

// Wire identifiers:
wire	wTransitionDetected;
wire	wTimerFinished;

// Controller:
always @ (posedge gClock or posedge gReset)
	if (gReset)
		{rInitializeTimer,rWaitForTimer,rSaveInput} <= {3'b100};
	else begin
		rInitializeTimer <= rInitializeTimer && !wTransitionDetected ||
							rSaveInput;
		rWaitForTimer <= rInitializeTimer && wTransitionDetected ||
							rWaitForTimer && !wTimerFinished;
		rSaveInput <= rWaitForTimer && wTimerFinished;
	end		

// Datapath:
always @ (posedge gClock or posedge gReset)
	if (gReset) begin
		rBouncy_Syncd <= 0;
		oDebounced <= pInitialValue;
		oPulseOnRisingEdge <= 0;
		oPulseOnFallingEdge <= 0;
		rTimer <= pInitialTimerValue;
	end
	else begin
		rBouncy_Syncd <= iBouncy;
		oDebounced <= (rSaveInput) ? rBouncy_Syncd : oDebounced;
		oPulseOnRisingEdge <= (rSaveInput && rBouncy_Syncd);
		oPulseOnFallingEdge <= (rSaveInput && !rBouncy_Syncd);
		rTimer <= (rInitializeTimer) ? pInitialTimerValue : rTimer - 1;
	end

assign wTransitionDetected = rBouncy_Syncd ^ oDebounced;
assign wTimerFinished = (rTimer == 0);

endmodule


//-----------------------------------------------------------------------------

module OneShot (
// "One-shot" pulse generator. Produces a pulse of desired length in response
// to a trigger signal, which may be as short as a single clock period.
//

	// Global system resources:
	input gClock,	// System clock
	input gReset,	// Master reset (asynchronous, active high)

	// Inputs:
	input iTrigger,	// Trigger signal to initiate output pulse

	// Outputs:
	output oPulse	// Pulse of desired length (active high)
);

// User-adjustable parameters
parameter pTimerWidth = 23;
parameter pPulseLength = 23'd5_000_000; // for synthesis; defaults to 100ms
					// for Digilent 50MHz oscillator
//parameter pPulseLength = 23'd5; // for simulation only

// Registered identifiers:
reg	rInitializeTimer;
reg	rWaitForTimer;
reg	[pTimerWidth-1:0] rTimer;

// Wire identifiers:
wire	wTimerFinished;

// Controller:
always @ (posedge gClock or posedge gReset)
	if (gReset)
		{rInitializeTimer,rWaitForTimer} <= {2'b10};
	else begin
		rInitializeTimer <= rInitializeTimer && !iTrigger ||
						rWaitForTimer && wTimerFinished
						|| pPulseLength == 0;
		rWaitForTimer <= rInitializeTimer && iTrigger && pPulseLength != 0 ||
						rWaitForTimer && !wTimerFinished;
	end		

// Datapath:
always @ (posedge gClock or posedge gReset)
	if (gReset)
		rTimer <= pPulseLength-1;
	else
		rTimer <= (rInitializeTimer) ? pPulseLength-1 : rTimer - 1;

assign wTimerFinished = (rTimer == 0);
assign oPulse = rWaitForTimer;


endmodule

//-----------------------------------------------------------------------------

module ClockEnabler (
// Multi-mode pulse generator to serve as clock enable. Pulse duration is always
// a single period of gClock, no matter which mode is selected. The LED output provides
// a visual indicator (a 40ms pulse) to accompany the output pulse.
//
// iMode = 0 -- oEnable is single pulse in response to iSingleStep (usually a pushbutton)
// iMode = 1 -- oEnable is periodic pulse at 0.5Hz rate
// iMode = 2 -- oEnable is periodic pulse at 1.0Hz rate
// iMode = 3 -- oEnable is constant 1 (continuously enabled)

	// Global system resources:
	input	gClock,
	input	gReset,

	// Inputs:
	input	iSingleStep,
	input	[1:0] iMode,

	// Outputs:
	output	oEnable,
	output	oLED
);


// Functionality:
Debouncer # (

   // Constant-valued parameters for this instance:
   .pInitialValue(0)
) U1 (
   // Global system connections:
   .gClock(gClock),
   .gReset(gReset),

   // Inputs:
   .iBouncy(iSingleStep),

   // Outputs:
   .oDebounced(),
   .oPulseOnRisingEdge(wPulseSingle),
   .oPulseOnFallingEdge()
);

FrequencyDivider # (

   // Constant-valued parameters for this instance:
   .pDivisor(100000000),
   .pBits(27),
   .pInitialValue(0)
) U2 (
   // Global system connections:
   .gClock(gClock),
   .gReset(gReset),

   // Outputs:
   .oLowerFrequency(wPulse05)
);

FrequencyDivider # (

   // Constant-valued parameters for this instance:
   .pDivisor(50000000),
   .pBits(26),
   .pInitialValue(0)
) U3 (
   // Global system connections:
   .gClock(gClock),
   .gReset(gReset),

   // Outputs:
   .oLowerFrequency(wPulse1)
);

OneShot # (

   // Constant-valued parameters for this instance:
   .pPulseLength(2000000),
   .pTimerWidth(21)
) U4 (
   // Global system connections:
   .gClock(gClock),
   .gReset(gReset),

   // Inputs:
   .iTrigger(oEnable),

   // Outputs:
   .oPulse(oLED)
);

MUX4 # (

   // Constant-valued parameters for this instance:
   .pWidth(1)
) U5 (
   // Inputs:
   .iDataInput0(wPulseSingle),
   .iDataInput1(wPulse05),
   .iDataInput2(wPulse1),
   .iDataInput3(1'b1),
   .iDataSelect(iMode),

   // Outputs:
   .oOutput(oEnable)
);

endmodule


//-----------------------------------------------------------------------------
// End of Verilog module library for ECE130
//-----------------------------------------------------------------------------
