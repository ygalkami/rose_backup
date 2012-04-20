// Created by 'symgen' -- DO NOT EDIT
// 2008 02 01 04 18 00
`timescale 1ns / 1ps
module Op2_NSD (
   input [2:0] a,
   input [3:0] b,
   output [3:0] o
);
//assign o = NSD;

// Aliases
wire [3:0] state = b;
wire iAutoSensed = a[2];
wire iStartSystem = a[1];
wire iTimerDone = a[0];

// Next-state decoder logic
assign o = 
	state == 0 ? (iStartSystem == 0 ? 1 : 2) :
	state == 1 ? (iStartSystem == 0 ? 0 : 2) :
	state == 2 ? (iAutoSensed == 0 ? 2 : 3) :
	state == 3 ? 4 :
	state == 4 ? 5 :
	state == 5 ? (iTimerDone == 0 ? (iAutoSensed == 1 ? 5 : 6) : 6) :
	state == 6 ? 7 :
	state == 7 ? 2 :

	0; 
endmodule
