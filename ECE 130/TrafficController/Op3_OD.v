// Created by 'symgen' -- DO NOT EDIT
// 2008 02 01 04 18 47
`timescale 1ns / 1ps
module Op3_OD (
   input [3:0] a,
   input [3:0] b,
   input [3:0] c,
   output [6:0] o
);
//assign o = OD;

assign o =
			//6 40 Red
			//5 40 Yellow
			//4 40 Green
			//3 RH Red
			//2 RH Yellow
			//1 RH Green
			//0 Start Timer 
a == 0 ? 'b1000000 :
a == 1 ? 'b0001000 :
a == 2 ? 'b0011000 :
a == 3 ? 'b0101000 :
a == 4 ? 'b1001001 :
a == 5 ? 'b1000010 :
a == 6 ? 'b1000100 :
a == 7 ? 'b1001000 :
	'b0000000 ;
endmodule
