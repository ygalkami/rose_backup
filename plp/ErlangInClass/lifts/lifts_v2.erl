% ----------------------------------------------------------------
% This module simulates a system of elevators.
% ----------------------------------------------------------------
-module(lifts_v2).
-compile(export_all).

% Include records used in implementation
-include("lifts.hrl").

% ----------------------------------------------------------------
% Functions for starting processes
% ----------------------------------------------------------------
% Starts the elevator system.
start() -> io:format("Not yet implemented.~n").

% Starts a single car, returning the car's PID.
start_car(NumFloors) -> spawn(lifts_v2, car_loop, [#lift{top_floor=NumFloors}]).

% ----------------------------------------------------------------
% Process loops
% ----------------------------------------------------------------
% This is the main loop for "animating" an elevator car.
car_loop(Lift) ->
	receive
		{Sender, {status}} ->
			Sender ! {self(), {status, Lift}},
			car_loop(Lift);
		{Sender, {goto, Floor}}
			when (1 =< Floor) and (Floor =< Lift#lift.top_floor) ->
			OldRequests = Lift#lift.requests,
			NewRequests = sets:add_element(Floor, OldRequests),
			NewLift = Lift#lift{requests = NewRequests},
			Sender ! {self(), {floors_pending, NewRequests}},
			car_loop(NewLift);
		{Sender, {plummet}} ->
			Sender ! {self(), {as_you_wish, "EEEK!"}},
			Lift#lift{floor = 1};
			% No tail call, so loop exits and process does too
		_Unknown ->
			io:format("Received unexpected message: ~p~n", [_Unknown]),
			car_loop(Lift)
	end.

% ----------------------------------------------------------------
% Functions for sending requests to a lift car process
% ----------------------------------------------------------------
% Sends an inside-the-lift floor request to the given car.
car_request(CarPID, Floor) ->
	{_, Top} = car_floor(CarPID),
	if
		(1 =< Floor) and (Floor =< Top) -> 
			validate_pid(CarPID),
			CarPID ! {self(), {goto, Floor}},
			receive
				{CarPID, {floors_pending, _}} -> ok;
				_Unknown ->
					exit({unexpected_reply, _Unknown})
			end;
		true -> invalid_floor
	end.		
				
% Gets the floor that the given car is on, and the top most floor.  Returns
% a pair {CurrentFloor, TopFloor}.
car_floor(CarPID) ->
	validate_pid(CarPID),
	CarPID ! {self(), {status}},
	receive 
		{CarPID, {status, #lift{floor=Floor, top_floor=Top}}} -> {Floor, Top};
		_Unknown ->
			exit({unexpected_reply, _Unknown})
	end.		

% Tells the car to die.
car_die(CarPID) ->
	validate_pid(CarPID),
	CarPID ! {self(), {plummet}},
	receive
		{CarPID, {as_you_wish, _}} -> ok;
		_Unknown ->
			exit({unexpected_reply, _Unknown})
	end.		

% Gets the lift status from the given car as a string.
car_status(CarPID) ->
	validate_pid(CarPID),
	CarPID ! {self(), {status}},
	receive
		{CarPID, {status, Lift}} -> lift_to_string(Lift);
		_Unknown -> io:format("Received unexpected reply: ~p~n", [_Unknown])
	end.

% ----------------------------------------------------------------
% Helper functions
% ----------------------------------------------------------------
% Converts a lift record to a string.
lift_to_string(#lift{floor=Floor, doors_open=Doors, 
					 direction=Dir, requests=Requests}) ->
	"Lift on floor " ++ 
	integer_to_list(Floor) ++
	(case Doors of
		true -> ", doors open";
		false -> ", doors closed"
	 end) ++
	(case Dir of
		up -> ", moving up";
		down -> ", moving down";
		idle -> ", idle"
	 end) ++
	", requests pending: " ++ 
	(case sets:size(Requests) of
		0 -> "none";
		_ -> set_to_string(Requests)
	 end).

% Converts set of integers into a string.
set_to_string(SetOfInt) ->
	AsList = sets:to_list(SetOfInt),
	ListOfString = lists:map(fun integer_to_list/1, AsList),
	string:join(ListOfString, ", ").

% Checks whether the given process is alive.  Throws an exception if not.
validate_pid(Pid) ->
	case is_process_alive(Pid) of
		true -> ok;
		false -> throw({processNotLive, Pid})
	end.
