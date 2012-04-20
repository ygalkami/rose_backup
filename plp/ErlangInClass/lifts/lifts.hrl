% ============================================================================
% Records for use in the Lift simulation.  Records in Erlang are like
% structs in C.
% Unlike Erlang tuples they:
% - have named "fields", 
% - support default values for fields, and
% - support creating new records by changing just some elements,
%   while copying the others from an existing record.
% ============================================================================
-record(lift, {
	floor = 1,             % the current floor of the lift
	top_floor,             % the top floor that the lift can reach
	doors_open = true,     % the status of the lift's doors
	direction = idle,      % the direction for the lift: up, down, or idle
	requests = sets:new()  % requested floors for the lift to visit
}).

