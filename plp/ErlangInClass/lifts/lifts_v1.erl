% ----------------------------------------------------------------
% This module simulates a system of elevators.
% ----------------------------------------------------------------
-module(lifts_v1).
-compile(export_all).

% Include records used in implementation
-include("lifts.hrl").

% Starts the elevator system.
start() -> io:format("Not yet implemented.~n").

% Starts a single car, returning the car's PID.
start_car(NumFloors) -> spawn(lifts_v1, car_loop, [#lift{top_floor=NumFloors}]).

% TODO: What other messages should the car receive?  Look at the record
% declaration for ideas.
car_loop(Lift) ->
	receive
		{plummet} ->
			io:format("EEEK!~n"),
			Lift#lift{floor = 1};
			% No tail call, so loop exits and process does too
		_Unknown ->
			io:format("Received unexpected message: ~p~n", [_Unknown]),
			car_loop(Lift)
	end.
