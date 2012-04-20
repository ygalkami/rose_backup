% Points for comment: 1 / 1
% Points for benchmark/0: 1 / 1
% Points for benchmark table(s): 1 / 1
% ============================================================================
% Some code for testing process creation and destruction speed.
% ============================================================================
-module(creation).
-compile(export_all).

% benchmark(N), takes in a number of process_loops to spawn, spawns them, and measures how long it took to run in wall_clock time and how long on average each process took to run.
benchmark(N) ->
	statistics(runtime),
	statistics(wall_clock),
	Pids = [spawn(creation, process_loop, []) || _N <- lists:seq(1,N)],
	lists:foreach(fun(P) -> P ! {die} end, Pids),
	{_,RT} = statistics(runtime),
	{_,WCT} = statistics(wall_clock),
	{RT, WCT}.
	
process_loop() ->
	receive
		{die} -> "As you wish";
		_Unknown ->
			io:format("Received unexpected message: ~p~n", [_Unknown])
	end.

% TODO: implement this benchmark() function as specified in the homework
%       description.
benchmark() ->
	Runtimes = [{1000, benchmark(1000)}, {2000, benchmark(2000)}, 
				{5000, benchmark(5000)}, {10000, benchmark(10000)},
				{20000, benchmark(20000)}, {50000, benchmark(50000)},
				{100000, benchmark(100000)}, {200000, benchmark(200000)}],
	benchmark_print(), benchmark_help(Runtimes).

benchmark_print() -> io:format("\t\t\tCpu Time\t\t\tClock Time~n"), 
					 io:format("N\t\tTot(s)\t\tPer(ms)\t\tTot(s)\t\tPer(ms)~n").

benchmark_help([]) -> "";
benchmark_help([{N, {RT, WCT}}|T]) -> 
	io:format("~p\t\t~p\t\t~p\t\t~p\t\t~p~n", [N, RT / 1000, RT / N, WCT / 1000, WCT / N]), benchmark_help(T).

%                        Cpu Time                        Clock Time
%N               Tot(s)          Per(ms)         Tot(s)          Per(ms)
%1000            0.01            0.01            0.01            0.01
%2000            0.02            0.01            0.019           0.0095
%5000            0.04            0.008           0.052           0.0104
%10000           0.07            0.007           0.103           0.0103
%20000           0.16            0.008           0.209           0.01045
%50000           0.29            0.0058          0.416           0.00832
%100000          0.37            0.0037          0.608           0.00608
%200000          0.85            0.00425         1.384           0.00692
