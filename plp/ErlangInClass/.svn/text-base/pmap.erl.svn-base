% Based on code in section 20.2 of Programming Erlang.  Modified for better
% parameter names and to use tail recursion in gather/3.
-module(pmap).
-compile(export_all).

% Our own version of map so we're sure to be running just Erlang code in 
% tests.
map(Func, List) -> map(Func, List, []).
map(_Func, [], Acc) -> lists:reverse(Acc);
map(Func, [H|T], Acc) -> 	map(Func, T, [Func(H) | Acc]).

% A parallel map function that distributes the computation across multiple
% processes.
pmap(Func, List) ->
	Self = self(),
	% make_ref returns a globally unique identifier:
	UniqRef = erlang:make_ref(),
	Pids = [spawn(pmap, do_it, [Self, UniqRef, Func, Item]) || Item <- List],
	gather(Pids, UniqRef, []).

do_it(Parent, UniqRef, Func, Item) ->
	% 'catch Term' captures errors from evaluating Term and converts them
	% into {'EXIT', Why} pairs.  This allows gather operation to terminate
	% with results from all the successful sub-computations.
	Parent ! {self(), UniqRef, (catch Func(Item))}.
		
% This collects the results for the pmap function IN ORDER.  How does it
% ensure that the results are ordered?  What would we change if we didn't care
% about the result order.
gather([], _UniqRef, Acc) -> lists:reverse(Acc);
gather([Pid|T], UniqRef, Acc) ->
	receive
		{Pid, UniqRef, Result} -> gather(T, UniqRef, [Result | Acc])
	end.
	
% Demo. of the catch in do_it/4
sample1() ->
	List = lists:seq(0, 5),
	F = fun(N) -> 1/N end,
	io:format("Mapping 1/Item across the list ~p~n", [List]),
	ResultPMap = pmap(F, List),
	io:format("Result: ~p~n", [ResultPMap]).


% This function uses both map and pmap to apply the given function to the 
% given list and reports the runtime and results.
test_driver(F, List) ->
	{MapTime, MapResult} = timer:tc(pmap, map, [F, List]),
	io:format("Using map in ~f ms: ~P~n", 
		[MapTime/1000, MapResult, 5]),
	{PMapTime, PMapResult} = timer:tc(pmap, pmap, [F, List]),
	io:format("Using pmap in ~f ms: ~P~n", 
		[PMapTime/1000, PMapResult, 5]).
	
% This is simple but it's NOT a good use of pmap.  Why not?
sample2() ->
	List = lists:seq(1,100000),
	F = fun(N) -> 1/N end,
	io:format("Mapping 1/Item across a list of ~w items~n", [length(List)]),
	test_driver(F, List).
	
% This shows small messages, big computation.
sample3() ->
	ItemCount = 100,
	N = 30,
	List = lists:duplicate(ItemCount, N),
	F = fun fib/1,
	io:format("Mapping recursive Fibonacci across a list of ~w items~n", 
		[length(List)]),
	test_driver(F, List).

% This shows bigger messages, smaller computation.
sample4() ->
	List = [[random:uniform() || _ <- lists:seq(1,1000)] 
				|| _ <- lists:seq(1,10000)],
	F = fun lists:sort/1,
	io:format("Mapping sort across a list of ~w items, each a list of length ~w~n", 
		[length(List), length(hd(List))]),
	test_driver(F, List).

% ----------------------------------------------------------------
% Restart erl between sample4 and sample5 or you'll run out of heap.
% ----------------------------------------------------------------

% This shows huge messages, smaller computation.
sample5() ->
	List = [[random:uniform() || _ <- lists:seq(1,10000)] 
				|| _ <- lists:seq(1,1000)],
	F = fun lists:sort/1,
	io:format("Mapping sort across a list of ~w items, each a list of length ~w~n", 
		[length(List), length(hd(List))]),
	test_driver(F, List).


fib(0) -> 0;
fib(1) -> 1;
fib(N) when N >= 2 andalso is_integer(N) -> fib(N-1) + fib(N-2).






