% ============================================================================
% Some code for testing message process speed.
% ============================================================================
-module(passingSolution).
-compile(export_all).

ring_part_loop(NextProcessPid) ->
	receive
		{new_next, Pid} ->
			ring_part_loop(Pid);
		{relay, String, M, Originator, start} ->
			NextProcessPid ! {relay, String, M, Originator, self()},
			ring_part_loop(NextProcessPid);
		{relay, String, 0, Originator, Pid} when Pid =:= self() ->
			Originator ! String,
			ring_part_loop(NextProcessPid);
		{relay, String, M, Originator, Pid} when Pid =:= self() ->
			NextProcessPid ! {relay, String, M-1, Originator, Pid},
			ring_part_loop(NextProcessPid);
		{relay, String, M, Originator, Pid} ->
			NextProcessPid ! {relay, String, M, Originator, Pid},
			ring_part_loop(NextProcessPid);
		{exit} ->
			NextProcessPid ! {exit};
		_Unknown -> 
			io:format("ring_part_loop received unexpected message: ~p~n", 
					  [_Unknown]),
			ring_part_loop(NextProcessPid)
	end.

spawn_ring(N) ->
	FirstPid = spawn(passingSolution, ring_part_loop, [self()]),
	LastPid = spawn_helper(N-1, FirstPid),
	FirstPid ! {new_next, LastPid},
	FirstPid.

spawn_helper(0, PrevPid) -> PrevPid;
spawn_helper(N, PrevPid) ->
	Pid = spawn(passingSolution, ring_part_loop, [PrevPid]),
	spawn_helper(N-1, Pid).
	
test_m(RingPid, M) ->
	erlang:statistics(runtime),
	erlang:statistics(wall_clock),
	RingPid ! {relay, test, M, self(), start},
	receive
		test -> test
	end,
	{_,RT} = erlang:statistics(runtime),
	{_,WCT} = erlang:statistics(wall_clock),
	{RT, WCT}.
	
message_test(N, M) ->
	RPid = spawn_ring(N),
	{R,W} = test_m(RPid, M),
	RPid ! {exit},
	{N,M,W,R}.
	
% Results
% 4> passingSolution:message_test(10000,1000).
% {10000,1000,10945,10910}
% 5> 10945/(10000*1000).
% 0.0010945
% That's 1.09 microseconds per message send!
