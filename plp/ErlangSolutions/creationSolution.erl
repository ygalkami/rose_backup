% ============================================================================
% Some code for testing process creation and destruction speed.
% ============================================================================
-module(creationSolution).
-compile(export_all).

benchmark(N) ->
	statistics(runtime),
	statistics(wall_clock),
	Pids = [spawn(creationSolution, process_loop, []) || _N <- lists:seq(1,N)],
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

benchmark() ->
	io:format("             CPU Time             Clock Time~n"),
	io:format("   N    Tot (s)   Per (ms)    Tot (s)    Per (ms)~n"),
	Vals = [1000,2000,5000,10000,20000,50000,100000,200000],
	lists:foreach(fun benchmark_table_helper/1, Vals).
	
benchmark_table_helper(N) ->
	{R,W} = benchmark(N),
	io:format("~6w   ~5.3f      ~5.3f      ~5.3f      ~5.3f~n", 
			  [N, R/1000, R/N, W/1000, W/N]).

% ============================================================================
% Output on my MacBook Pro with 2.4 GHz Intel Core 2 Duo and 4 GB RAM, using
% both cores:
%
%              CPU Time             Clock Time
%    N    Tot (s)   Per (ms)    Tot (s)    Per (ms)
%   1000   0.000      0.000      0.010      0.010
%   2000   0.020      0.010      0.021      0.011
%   5000   0.080      0.016      0.084      0.017
%  10000   0.170      0.017      0.188      0.019
%  20000   0.350      0.018      0.378      0.019
%  50000   0.890      0.018      0.957      0.019
% 100000   1.750      0.018      1.936      0.019
% 200000   3.650      0.018      3.981      0.020
%
% and using a single core:
%              CPU Time             Clock Time
%    N    Tot (s)   Per (ms)    Tot (s)    Per (ms)
%   1000   0.000      0.000      0.006      0.006
%   2000   0.010      0.005      0.010      0.005
%   5000   0.020      0.004      0.020      0.004
%  10000   0.030      0.003      0.040      0.004
%  20000   0.060      0.003      0.078      0.004
%  50000   0.160      0.003      0.209      0.004
% 100000   0.320      0.003      0.430      0.004
% 200000   0.660      0.003      0.935      0.005
