//----- Synthesizable Circuit -----

// Timescale: one time unit = 1ns (e.g., delay specification of #42 means 42ns of time), and
// simulator resolution is 0.1 ns
`timescale 1ns / 100ps

module MyPattern (

	// Inputs:
	input	[7:0]	iStatus,
	input	[7:0]	iVelocity,
	input [7:0] iNote,
	input	iScheme,

	// Outputs:
	output	oLightON,
	output	oLightOFF,
	output	[15:0]	oLightSelect
);


wire w2, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w20;
wire w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31, w32, w33, w34, w35, w36, w37, w38, w39, w40, w41, w42, w43;

wire [7:0] w3;
wire [15:0] w19;
wire [7:0] w44;
wire [15:0] w45;

or u1 (oLightON, iStatus[4], w20);
not u30 (w2, iStatus[3]);
not u2 (oLightOFF, oLightON);
or u3 (w38, iVelocity[0], iVelocity[1]);
or u4 (w39, iVelocity[2], iVelocity[3]);
or u5 (w40, iVelocity[4], iVelocity[5]);
or u6 (w41, iVelocity[6], iVelocity[7]);
or u7 (w43, w38, w39);
or u8 (w42, w40, w41);
or u9 (w20, w43, w42);

and u14 (w4, w21, w22);
and u15 (w5, w4, w23);
and u16 (w6, w5, w24);
and u17 (w7, w6, w25);
and u18 (w8, w7, w26);
and u19 (w9, w8, w27);
and u20 (w10, w9, w28);
and u21 (w11, w10, w29);
and u22 (w12, w11, w30);
and u23 (w13, w12, w31);
and u24 (w14, w13, w32);
and u25 (w15, w14, w33);
and u26 (w16, w15, w34);
and u27 (w17, w16, w35);
and u28 (w18, w17, w36);
not u31 (w37, iVelocity[3]);

assign w19 = {w21, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18};
assign w45 = {w3, w44};

Decode3to8 u10 (

   // Inputs:
   .iCode(iStatus[2:0]),
   .iOutputEnable(iStatus[3]),

   // Outputs:
   .oOutput0(),
   .oOutput1(),
   .oOutput2(),
   .oOutput3(),
   .oOutput4(),
   .oOutput5(),
   .oOutput6(),
   .oOutput7(),
   .oOutput(w3)
);

Decode3to8 u11 (

   // Inputs:
   .iCode(iStatus[2:0]),
   .iOutputEnable(w2),

   // Outputs:
   .oOutput0(),
   .oOutput1(),
   .oOutput2(),
   .oOutput3(),
   .oOutput4(),
   .oOutput5(),
   .oOutput6(),
   .oOutput7(),
   .oOutput(w44)
);

Decode3to8 u12 (

   // Inputs:
   .iCode(iVelocity[2:0]),
   .iOutputEnable(iVelocity[3]),

   // Outputs:
   .oOutput0(w21),
   .oOutput1(w22),
   .oOutput2(w23),
   .oOutput3(w24),
   .oOutput4(w25),
   .oOutput5(w26),
   .oOutput6(w27),
   .oOutput7(w28),
   .oOutput()
);

Decode3to8 u13 (

   // Inputs:
   .iCode(iVelocity[2:0]),
   .iOutputEnable(w37),

   // Outputs:
   .oOutput0(w29),
   .oOutput1(w30),
   .oOutput2(w31),
   .oOutput3(w32),
   .oOutput4(w33),
   .oOutput5(w34),
   .oOutput6(w35),
   .oOutput7(w36),
   .oOutput()
);

MUX2 # (

   // Constant-valued parameters for this instance:
   .pWidth(16)
) u29 (
   // Inputs:
   .iDataInput0(w45),
   .iDataInput1(w19),
   .iDataSelect(iScheme),

   // Outputs:
   .oOutput(oLightSelect)
);


endmodule