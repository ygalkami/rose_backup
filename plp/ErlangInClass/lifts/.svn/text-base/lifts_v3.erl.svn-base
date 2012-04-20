% ----------------------------------------------------------------
% This module simulates a system of elevators.
% ----------------------------------------------------------------
-module(lifts_v3).
-compile(export_all).

% Include records used in implementation
-include("lifts.hrl").

% ----------------------------------------------------------------
% Functions for starting processes
% ----------------------------------------------------------------
% Starts the elevator system.
start() -> io:format("Not yet implemented.~n").

% Starts a single car, returning the car's PID.
start_car(NumFloors) -> 
	Lift = #lift{top_floor=NumFloors},
	HWPid = spawn(lifts_v3, car_hardware, [{idle}, nil]),
	CarPID = spawn(lifts_v3, car_loop, [Lift, HWPid]),
	HWPid ! {self(), {setCar, CarPID}},
	CarPID.

% ----------------------------------------------------------------
% Process loops
% ----------------------------------------------------------------
% This is the main loop for "animating" an elevator car.
car_loop(Lift, HWPid) ->
	% Extracts most of the current field values.  We need them all.
	#lift{floor = Floor, 
		  top_floor = Top, 
		  direction = Dir,
		  requests = Requests} = Lift,
	
	receive
		% Hardware feedback
		{HWPid, {arrived, NewFloor}} -> 
			io:format("Arrived at ~p~n", [NewFloor]),
			case sets:is_element(NewFloor, Requests) of
				true -> 
					% Arrived at requested floor, so open doors
					HWPid ! {self(), {open}},
					car_loop(Lift#lift{floor=NewFloor}, HWPid);
				false -> 
					% Arrived at unrequested floor
					if
						(NewFloor =/= Top) and (NewFloor =/= 1) ->
							% Keep moving
							HWPid ! {self(), {move, Dir, NewFloor}},
							car_loop(Lift#lift{floor=NewFloor}, HWPid);
						true -> 
							% At top or bottom floor, so either stop or reverse
							NewDir = case {sets:size(Requests), Dir} of
										{0,_}    -> idle;
										{_,up}   -> down;
										{_,down} -> up
									 end,
							if
								NewDir =/= idle -> 
									HWPid ! {self(), {move, Dir, NewFloor}};
								true ->
									ok
							end,
							car_loop(Lift#lift{floor=NewFloor, 
											   direction=NewDir}, HWPid)
					end
			end;
		{HWPid, {opened}} ->
			io:format("Doors opened~n"),
			% Clear any request for this floor
			NewRequests = sets:del_element(Floor, Requests),
			% Either close the doors if more work to do, or else just sit here
			AreRequestsPending = (sets:size(NewRequests) > 0),
			NewDir = 
				if 
					AreRequestsPending -> 
						HWPid ! {self(), {close}},
						Dir;
					true -> idle
				end,
			car_loop(Lift#lift{requests=NewRequests, 
							   direction=NewDir, 
							   doors_open=true}, HWPid);
		{HWPid, {closed}} ->
			io:format("Doors closed~n"),
			% Doors closed, move if we need to:
			ReqsAbove = sets:size(sets:filter(fun (F) -> F > Floor end, Requests)),
			ReqsBelow = sets:size(sets:filter(fun (F) -> F < Floor end, Requests)),
			NewDir = case Dir of 
						idle ->
							if
								(ReqsAbove == 0) and (ReqsBelow == 0) -> idle;
								ReqsAbove > ReqsBelow ->
									HWPid ! {self(), {move, up, Floor}},
									up;
								true ->
									HWPid ! {self(), {move, down, Floor}},
									down
							end;
						up ->
							if
								ReqsAbove > 0 ->
									HWPid ! {self(), {move, up, Floor}},
									up;
								ReqsBelow > 0 ->
									HWPid ! {self(), {move, down, Floor}},
									down;
								true -> idle
							end;
						down ->
							if
								ReqsBelow > 0 ->
									HWPid ! {self(), {move, down, Floor}},
									down;
								ReqsAbove > 0 ->
									HWPid ! {self(), {move, up, Floor}},
									up;
								true -> idle
							end
					end,
			car_loop(Lift#lift{doors_open=false, direction=NewDir}, HWPid);

		% Requests
		{Sender, {status}} ->
			Sender ! {self(), {status, Lift}},
			car_loop(Lift, HWPid);
		{Sender, {goto, ReqFloor}}
			when (1 =< ReqFloor) and (ReqFloor =< Lift#lift.top_floor) ->
			NewRequests = sets:add_element(ReqFloor, Requests),
			Sender ! {self(), {floors_pending, NewRequests}},
			NewDir = case Dir of
						idle ->
							% If the lift is idle we may need to start it moving.
							if
								ReqFloor > Floor ->
									HWPid ! {self(), {close}},
									up;
								ReqFloor < Floor ->
									HWPid ! {self(), {close}},
									down;
								true ->
									HWPid ! {self(), {open}},
									idle
							end;
						_ -> Dir
					end,
			NewLift = Lift#lift{requests = NewRequests, direction = NewDir},
			car_loop(NewLift, HWPid);
		{Sender, {goto, InvalidFloor}} ->
			Sender ! {self(), {invalidFloor, InvalidFloor}},
			car_loop(Lift, HWPid);
		{Sender, {plummet}} ->
			Sender ! {self(), {as_you_wish, "EEEK!"}},
			exit(goodbye_cruel_world);
			% No tail call, so loop exits and process does too
			
		% Other
		_Unknown ->
			io:format("car_loop received unexpected message: ~p~n", [_Unknown]),
			car_loop(Lift, HWPid)
	end.
	
% This loop simulates the hardware for an elevator shaft.
% Status is one of:
% 	{idle}
%	{movingUp, FromFloor}
%	{movingDown, FromFloor}
%	{opening}
%	{closing}
car_hardware(Status, CarPID) ->
	Delay = case Status of 
				{idle} -> infinity;
				{movingUp, _} -> 5000;
				{movingDown, _} -> 4000;
				{opening} -> 1500;
				{closing} -> 1500
			end,
	receive
		% Configuration
		{_Sender, {setCar, NewCarPID}} ->
			link(NewCarPID), % Die if the car dies
			car_hardware(Status, NewCarPID);
			
		% Simulation requests
		{CarPID, {open}} ->
			car_hardware({opening}, CarPID);
		{CarPID, {close}} ->
			car_hardware({closing}, CarPID);
		{CarPID, {move, up, FromFloor}} ->
			car_hardware({movingUp, FromFloor}, CarPID);
		{CarPID, {move, down, FromFloor}} ->
			car_hardware({movingDown, FromFloor}, CarPID);
			
		% Other
		{CarPID, {die}} ->
			ok;
			% No tail call, so process ends
		_Unknown ->
			io:format("car_hardware received unexpected message: ~p~n", [_Unknown]),
			car_hardware(Status, CarPID)
	after Delay ->
		case Status of
			{idle} ->
				ok;
			{movingUp, FromFloor} ->
				CarPID ! {self(), {arrived, FromFloor + 1}};
			{movingDown, FromFloor} ->
				CarPID ! {self(), {arrived, FromFloor - 1}};
			{opening} ->
				CarPID ! {self(), {opened}};
			{closing} ->
				CarPID ! {self(), {closed}}
		end,
		car_hardware({idle}, CarPID)
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

% Monitors the current status of the given car and prints out any changes
% in status.  Returns the PID which can be used to kill the monitor.
monitor_car(CarPID) -> spawn(lifts_v3, monitor_car_printer, [CarPID, ""]).
monitor_car_printer(CarPID, PrevStatus) ->
	link(CarPID),
	NewStatus = car_status(CarPID),
	if
		NewStatus =/= PrevStatus ->
			io:format("~p~n", [car_status(CarPID)]);
		true -> ok
	end,
	receive
		{kill} -> ok
	after 1000 ->
		monitor_car_printer(CarPID, NewStatus)
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
