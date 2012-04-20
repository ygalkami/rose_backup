% Points:
% new_next - 1
% spawn_ring - 1
% relay message exists - 1
% relay message passed M times - 1
% relay message replies to originator - 1
% message_test - 1
% time per message - 0
% ============================================================================
% Some code for testing message process speed.
% ============================================================================
-module(passing).
-compile(export_all).

ring_part_loop(NextProcessPid) ->
	receive
		{relay, String, Count, Originator} ->
			case Count == 0 of
				false -> 
					NextProcessPid ! {relay, String, Count - 1, Originator}, ring_part_loop(NextProcessPid);
				true -> Originator ! {print, String}, NextProcessPid ! {should_exit}
			end;
		{should_exit} -> NextProcessPid ! {should_exit};
		{new_next, Pid} -> ring_part_loop(Pid);
		_Unknown -> 
			io:format("ring_part_loop received unexpected message: ~p~n", 
					  [_Unknown]),
			ring_part_loop(NextProcessPid)
	end.

spawn_ring(N) -> PID = spawn(passing, ring_part_loop, [self()]), spawn_ring(N - 1, PID, PID).

spawn_ring(0, Prev, First) -> Prev ! {new_next, First}, Prev;
spawn_ring(N, Prev, First) -> 
	PID = spawn(passing, ring_part_loop, [self()]),
	Prev ! {new_next, PID},
	spawn_ring(N - 1, PID, First).

message_test(N, M) ->
	Process = spawn_ring(N),
	statistics(runtime),
	statistics(wall_clock),
	Process ! {relay, "message", N * M, self()},
	receive
		{print, Message} -> 
			erlang:display(Message),
			{_, RT} = statistics(runtime),
			{_, WCT} = statistics(wall_clock),
			{N, M, RT, WCT}
	end.

