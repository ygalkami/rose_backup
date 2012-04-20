// StageLights_TOP.v -- Top-level module for StageLights system
// 
// ECE130: Intro to Digital Logic

//----- Synthesizable Circuit -----

// Timescale: one time unit = 1ns (e.g., delay specification of #42 means 42ns of time), and
// simulator resolution is 0.1 ns
`timescale 1ns / 100ps

module StageLights_TOP (

	// Global system resources:
	input	gClock,
	input	gReset,

	// Inputs:
	input	iMIDI,
	input	iShowMIDI,
	input	iScheme,

	// Outputs:
	output	[7:0] oSegment,
	output	[3:0] oDigit,
	output	[7:0] oLED,
	output	[15:0] oLight
);

// Wire declarations
wire [7:0] wMIDI_Byte;
wire wMIDI_Byte_Ready;
wire wLightON, wLightOFF;
wire [15:0] wLightSelect;
wire [7:0] wDispSeg, wDispHexSeg;
wire [3:0] wDispDig, wDispHexDig;
wire [15:0] wLightOneShot;

// Reg declarations
reg [7:0] rStatus, rNote, rVelocity, rByte1, rByte2;
reg [1:0] rByteCount;
reg [15:0] rLight;



// Pattern module
MyPattern MyPattern (
	.iScheme	( iScheme ),
	.iStatus	( rStatus ),
	.iNote	( rNote ),
	.iVelocity	( rVelocity ),
	.oLightON	( wLightON ),
	.oLightOFF	( wLightOFF ),
	.oLightSelect	( wLightSelect )

);

// Clocked elements
always @ (posedge gClock, posedge gReset)
	if (gReset) begin
		rByte1 <= 0;
		rByte2 <= 0;
		rStatus <= 0;
		rNote <= 0;
		rVelocity <= 0;
		rByteCount <= 0;
		rLight <= 0;
	end
	else begin

		// Light control (FFs with SR behavior, R priority)
		rLight <= ( ( {16{wLightON}} & wLightSelect) | rLight) 
			& ~( {16{wLightOFF}} & wLightSelect );

		if (wMIDI_Byte_Ready) begin
			// Storage for previous bytes
			rByte2 <= rByte1;
			rByte1 <= wMIDI_Byte;

			// Byte counter: Wait for Note-On or Note-Off status
			// byte before counting bytes. Store complete MIDI
			// message after three bytes arrive.
			case (rByteCount)
				0: if (wMIDI_Byte[7:4]==8 || wMIDI_Byte[7:4]==9)
					rByteCount <= 1;
				1: rByteCount <= 2;
				2: begin
					rStatus <= rByte2;
					rNote <= rByte1;
					rVelocity <= wMIDI_Byte;
					rByteCount <= 0;
				   end
			endcase

		end
   end


// Baud clock (single-cycle pulse, 31.25 kHz)
FrequencyDivider # (

   // Constant-valued parameters for this instance:
   .pDivisor(81),	// 16*38400 baud (Roland Serial MIDI Driver Ver.3.2 for Windows XP)
//   .pDivisor(100),	// 16*31250 baud (MIDI)
   .pBits(7),
   .pInitialValue(0)
) BaudClock (
   // Global system connections:
   .gClock(gClock),
   .gReset(gReset),

   // Outputs:
   .oLowerFrequency(wBaudClock)
);

// UART receiver (Ken Chapman's UART for PicoBlaze processor)
// Documentation: http://www.xilinx.com/ipcenter/processor_central/picoblaze/member/index.htm
// Source code: http://www.xilinx.com/ipcenter/processor_central/picoblaze/member/KCPSM3.zip
uart_rx UART_RX
(	.serial_in	( iMIDI ),
	.data_out	( wMIDI_Byte ),
	.read_buffer	( wMIDI_Byte_Ready ),
	.reset_buffer	( 1'b0 ),
	.en_16_x_baud	( wBaudClock ),
	.buffer_data_present ( wMIDI_Byte_Ready ),
	.buffer_full(),
	.buffer_half_full(),
	.clk		( gClock )
);

// DisplayHex for MIDI message display
DisplayHex DisplayHex (

   // Global system connections:
   .gClock(gClock),
   .gReset(gReset),

   // Inputs:
   .iLeft(rStatus),
   .iRight(rNote),

   // Outputs:
   .oSegmentA(wDispHexSeg[7]),
   .oSegmentB(wDispHexSeg[6]),
   .oSegmentC(wDispHexSeg[5]),
   .oSegmentD(wDispHexSeg[4]),
   .oSegmentE(wDispHexSeg[3]),
   .oSegmentF(wDispHexSeg[2]),
   .oSegmentG(wDispHexSeg[1]),
   .oSegmentDP(wDispHexSeg[0]),
   .oDigitLeft(wDispHexDig[3]),
   .oDigitMiddleLeft(wDispHexDig[2]),
   .oDigitMiddleRight(wDispHexDig[1]),
   .oDigitRight(wDispHexDig[0])
);

// Display -- On-board lights display
Display Display (

   // Global system connections:
   .gClock(gClock),
   .gReset(gReset),

   // Inputs:
   .iLeft       ( {1'b0, oLight[15:12], 3'b0} ),
   .iMiddleLeft ( {1'b0, oLight[11:8], 3'b0} ),
   .iMiddleRight( {1'b0, oLight[7:4], 3'b0} ),
   .iRight      ( {1'b0, oLight[3:0], 3'b0} ),

   // Outputs:
   .oSegmentA(wDispSeg[7]),
   .oSegmentB(wDispSeg[6]),
   .oSegmentC(wDispSeg[5]),
   .oSegmentD(wDispSeg[4]),
   .oSegmentE(wDispSeg[3]),
   .oSegmentF(wDispSeg[2]),
   .oSegmentG(wDispSeg[1]),
   .oSegmentDP(wDispSeg[0]),
   .oDigitLeft(wDispDig[3]),
   .oDigitMiddleLeft(wDispDig[2]),
   .oDigitMiddleRight(wDispDig[1]),
   .oDigitRight(wDispDig[0])
);

// MUX for seven-segment display
assign oSegment = iShowMIDI ? wDispHexSeg : wDispSeg;
assign oDigit = iShowMIDI ? wDispHexDig : wDispDig;
assign oLED = iShowMIDI ? rVelocity : 8'h00;


// 9ms one-shot pulse generators, one for each channel. 
// Choose pulse duration to avoid strobing effects with 100Hz display.
genvar k;
generate
	for (k=0; k<16; k=k+1)
	begin: M
		OneShot # (

		   // Constant-valued parameters for this instance:
		   .pPulseLength(450000),
		   .pTimerWidth(19)
		) OneShot (
		   // Global system connections:
		   .gClock(gClock),
		   .gReset(gReset),

		   // Inputs:
		   .iTrigger(rLight[k]),

		   // Outputs:
		   .oPulse(wLightOneShot[k])
		);
	end
endgenerate

// "OR" the one-shot pulse with the rLight signal to ensure that the
// displayed pulse is at least 9ms long (some MIDI files use very short
// events on the percussion channel).
generate
	for (k=0; k<16; k=k+1)
	begin: j
		assign oLight[k] = rLight[k] | wLightOneShot[k];
	end
endgenerate


endmodule




