// Created by 'symgen' -- DO NOT EDIT
// 2008 02 01 04 17 18
`timescale 1ns / 1ps
module Reg_w4_iv0 (
   input ce,
   input [3:0] i,
   input clk,
   input res,
   output reg [3:0] o
);
always @ (posedge clk, posedge res)
   if (res)
      o <= 0;
   else
      if (ce)
         o <= i;
endmodule
