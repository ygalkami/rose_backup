// Created by 'Verilog System Builder' (VSB) on 2/14/2008 at 3:51 PM.
// Auto-generated file; do not modify!
//
// All comments, suggestions, and bug reports to the author: 
// ed.doering@rose-hulman.edu

// ----------------------------------------------------------------------------
// Timescale: one time unit = 1ns (e.g., delay specification of #42
// means 42ns of time), and simulator resolution is 0.1 ns.
`timescale 1ns / 100ps
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// - - - - - - - - - - - - - SYNTHESIZABLE MODULE - - - - - - - - - - - - - - -
// ----------------------------------------------------------------------------

	// --------------------------------------------------------------------
	// Declarations for module, ports, and internal signals:
	// --------------------------------------------------------------------

module PWD_FinishLine (

	// Global system resources:
	input gClock,
	input gReset,

	// Clock enable:
	input iClockEnable,

// 	Inputs:
	input [3:0] iLaneSensor,
	input [3:0] iLaneSensorP,
	input iGate,

// 	Outputs:
	output reg [31:0] oDisplay,

	// State register:
	output reg [3:0] oState,
	output [3:0] oNextState
);


// Internal signals:
reg [1:0] iState;
reg iCarCrosses;
reg [31:0] opAllLanes;
reg [7:0] PLane1;
reg [7:0] PLane2;
reg [7:0] PLane3;
reg [7:0] PLane4;
reg [7:0] Lane1;
reg [7:0] Lane2;
reg [7:0] Lane3;
reg [7:0] Lane4;
reg [1:0] Place;
reg oRaceDone;


	// --------------------------------------------------------------------
	// System controller finite state machine:
	// --------------------------------------------------------------------

// State register:
always @ (posedge gClock, posedge gReset)
	if (gReset)
		oState <= 0;
	else
		if (iClockEnable) oState <= oNextState;

// NSD (next-state decoder):
assign oNextState =
	oState == 0 ?  iGate ? 1 : 0 :
	oState == 1 ?  iGate ? 2 : (|iLaneSensorP ? 0 : 1) :
	oState == 2 ?  |iLaneSensorP ? 3 : (oRaceDone ? 4 : 2) :
	oState == 3 ?  oRaceDone ? 4 : 2 :
	oState == 4 ?  4 :
	// Go to 'reset' state if no match above:
	0;

// OD (output decoder):
always @* begin
	iState = 0;	iCarCrosses = 0;
	case (oState)
	0 : begin iState='b00;  end
	1 : begin iState='b10;  end
	2 : begin iState='b01;  end
	3 : begin iState='b01; iCarCrosses=1;  end
	4 : begin iState='b11;  end
	default: begin 	iState = 0;	iCarCrosses = 0; end
	endcase
end

	// --------------------------------------------------------------------
	// Datapath registers and operators:
	// --------------------------------------------------------------------

// Datapath registers:
always @ (posedge gClock, posedge gReset)
	if (gReset) begin
		PLane1 <= 0;
		PLane2 <= 0;
		PLane3 <= 0;
		PLane4 <= 0;
		oDisplay <= 0;
		Place <= 0;
		Lane1 <= 8'b11111110;
		Lane2 <= 8'b11111110;
		Lane3 <= 8'b11111110;
		Lane4 <= 8'b11111110;
		oRaceDone <= 0;
end
else if (iClockEnable) begin
	PLane1 <= iLaneSensor[3]==1 ? 8'b01111111 : 8'b00110110;
	PLane2 <= iLaneSensor[2]==1 ? 8'b01111111 : 8'b00110110;
	PLane3 <= iLaneSensor[1]==1 ? 8'b01111111 : 8'b00110110;
	PLane4 <= iLaneSensor[0]==1 ? 8'b01111111 : 8'b00110110;
	oDisplay <= iState==2'b10 ? 32'b01011011010110110101101101011011 : opAllLanes;
	Place <= iCarCrosses ? Place+1 : Place;
	Lane1 <= (Place==0 && iLaneSensorP[3]==1) ? 8'b00110000: Lane1<- (Place==1 && iLaneSensorP[3]) ? 8'b01101101 : Lane1<- (Place==2 && iLaneSensorP[3]) ? 8'b01111001 : Lane1<- (Place==3 && iLaneSensorP[3]) ? 8'b00110011 : Lane1;
	Lane2 <= (Place==0 && iLaneSensorP[2]==1) ? 8'b00110000: Lane2<- (Place==1 && iLaneSensorP[2]) ? 8'b01101101 : Lane2<- (Place==2 && iLaneSensorP[2]) ? 8'b01111001 : Lane2<- (Place==3 && iLaneSensorP[2]) ? 8'b00110011 : Lane2;
	Lane3 <= (Place==0 && iLaneSensorP[1]==1) ? 8'b00110000: Lane3<- (Place==1 && iLaneSensorP[1]) ? 8'b01101101 : Lane3<- (Place==2 && iLaneSensorP[1]) ? 8'b01111001 : Lane3<- (Place==3 && iLaneSensorP[1]) ? 8'b00110011 : Lane3;
	Lane4 <= (Place==0 && iLaneSensorP[0]==1) ? 8'b00110000: Lane4<- (Place==1 && iLaneSensorP[0]) ? 8'b01101101 : Lane4<- (Place==2 && iLaneSensorP[0]) ? 8'b01111001 : Lane4<- (Place==3 && iLaneSensorP[0]) ? 8'b00110011 : Lane4;
	oRaceDone <= &iLaneSensor==1 ? 1 : 0;
end

// Datapath operators:
always @* begin
	opAllLanes = {PLane1 , PLane2, PLane3, PLane4};
	oDisplay = {Lane1 , Lane2, Lane3, Lane4};
end



endmodule

// ----------------------------------------------------------------------------
// - - - - - - - - - - - - - - TESTBENCH MODULE - - - - - - - - - - - - - - - -
// ----------------------------------------------------------------------------

module PWD_FinishLine_TB;
// Global system resources:
reg gClock;
reg gReset;

// Simulated inputs:
reg [3:0] iLaneSensor;
reg [3:0] iLaneSensorP;
reg iGate;

// Simulated responses (output ports):
wire [31:0] oDisplay;

// Simulated responses (internal signals):
wire [1:0] iState = UUT.iState;
wire iCarCrosses = UUT.iCarCrosses;
wire [31:0] opAllLanes = UUT.opAllLanes;
wire [7:0] PLane1 = UUT.PLane1;
wire [7:0] PLane2 = UUT.PLane2;
wire [7:0] PLane3 = UUT.PLane3;
wire [7:0] PLane4 = UUT.PLane4;
wire [7:0] Lane1 = UUT.Lane1;
wire [7:0] Lane2 = UUT.Lane2;
wire [7:0] Lane3 = UUT.Lane3;
wire [7:0] Lane4 = UUT.Lane4;
wire [1:0] Place = UUT.Place;
wire oRaceDone = UUT.oRaceDone;
wire [3:0] oState, oNextState;

// Instantiate the unit-under-test (UUT):
PWD_FinishLine UUT (
	// Global system resources:
	.gClock ( gClock ),
	.gReset ( gReset ),

	// Clock enable:
	.iClockEnable ( 1'b1 ),

// 	Inputs:
	.iLaneSensor ( iLaneSensor ),
	.iLaneSensorP ( iLaneSensorP ),
	.iGate ( iGate ),

// 	Outputs:
	.oDisplay ( oDisplay ),

	// Controller state:
	.oState ( oState ),
	.oNextState ( oNextState ));

// Emulate system clock and power-on reset pulse
initial begin gReset=1; #0.5 gReset=0; end
initial begin gClock=0; #0.4 forever #0.5 gClock=~gClock; end

// Specify input waveforms:
task LaneSensor (input integer lane);
 begin
iLaneSensorP=lane;
#1 iLaneSensorP=0;
end
endtask

initial begin
iLaneSensorP = 4'b0000;
iLaneSensor[3] = 0;
iLaneSensor[2] = 0;
iLaneSensor[1] = 0;
iLaneSensor[0] = 0;
iGate = 0;

#1
iGate = 1;

#10

LaneSensor(4'b1000) ;
iLaneSensor[3] = 1;
#1

LaneSensor(4'b0100);
iLaneSensor[2]=1;
#1

LaneSensor(4'b0010);
iLaneSensor[1] = 1;
#1

LaneSensor(4'b0001);
iLaneSensor[0] =1;

#5 $stop;
end

endmodule

// ----------------------------------------------------------------------------

