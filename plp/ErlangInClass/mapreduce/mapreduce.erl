% Based on code from Ch. 20 of Programming Erlang.
-module(mapreduce).
-compile(export_all).

% ----------------------------------------------------------------------------
% Launches a mapreduce algorithm and blocks until results are available.
%
% MapFunc(Pid, X), processes X and sends {Key, Val} messages to Pid.
%
% FoldFunc(Key, [Val], AccIn) -> AccOut, tail recursive function that
%   folds across a list of values associated with a given key.  Used by reduce
%   process to calculate a final answer after all map processes are done.
%
% Acc0, initial accumulator value used as the identity element for the fold
%   function.
%
% List, the list of items for which map processes will be spawned.
mapreduce(MapFunc, FoldFunc, Acc0, List) ->
	Self = self(),
	ReducePid = 
		spawn(fun() -> reduce(Self, MapFunc, FoldFunc, Acc0, List) end),
	receive
		{ReducePid, Result} -> Result
	end.
	
% ----------------------------------------------------------------------------
% Spawns a process for each item in the given list.  Receives returned 
% {Key, Value} messages, combining those with a common key into a list of 
% values.  Folds over the resulting dictionary (see dict:fold) to produce the
% final results, which is sent back to Parent.
reduce(Parent, MapFunc, FoldFunc, Acc0, List) ->
	process_flag(trap_exit, true),
	ReducePid = self(),
	lists:foreach(fun(X) -> 
						spawn_link(fun() -> MapFunc(ReducePid,X) end) 
				  end, List),
	N = length(List),
	Dict = collect_replies(N, dict:new()),
	Result = dict:fold(FoldFunc, Acc0, Dict),
	Parent ! {ReducePid, Result}.
	
% ----------------------------------------------------------------------------
% Receives returned {Key, Value} messages, combining those with a common key
% into a list of values.  Once N map processes have exited, then return a 
% dictionary of {Key, [Value]} pairs.
collect_replies(0, Dict) -> Dict;
collect_replies(N, Dict) ->
	receive
		{Key, Val} ->
			case dict:is_key(Key, Dict) of
				true ->
					Dict1 = dict:append(Key, Val, Dict),
					collect_replies(N, Dict1);  % N does NOT decrease
				false ->
					Dict1 = dict:store(Key, [Val], Dict),
					collect_replies(N, Dict1)   % N does NOT decrease
			end;
		% Indicates a map processes has exited:
		{'EXIT', _Signal, _Why} ->
			collect_replies(N-1, Dict)
	end.


% ----------------------------------------------------------------------------
% Uses mapreduce to get word counts for a file.
test() -> wc_file("gettysburg.txt").

wc_file(File) ->
	MapFunc = fun generate_words/2,
	FoldFunc = fun count_words/3,
	{ok, OpenFile} = file:open(File, read),
	Lines = get_lines(OpenFile, []),
	file:close(OpenFile),
	Result = mapreduce(MapFunc, FoldFunc, [], Lines),
	lists:reverse(lists:sort(Result)).
	
% Returns the lines of the given file in reverse order.
get_lines(OpenFile, Acc) ->
	case io:get_line(OpenFile, "") of
		eof -> Acc;
		Line -> get_lines(OpenFile, [Line|Acc])
	end.

generate_words(ReducePid, Line) -> 
	Separators = "\n\t .,-", 
	Words = string:tokens(Line, Separators),
	lists:foreach(fun(Word) -> ReducePid ! {Word,1} end, Words).

count_words(Key, Vals, Acc) -> [{length(Vals), Key} | Acc].