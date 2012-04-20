-module(basics2).
-compile(export_all).

% ----------------------------------------------------------------
% while loop, functionally
% We wouldn't actually use this, but its an interesting challenge.
% Think of it as a functional etude.
% ----------------------------------------------------------------
% TODO: Add a comment here explaining what while() does.
% While a takes two lambas 1 to execute, and one to test the input against
% If the test lamba returns true the body lambda is executed and the while is called again with the nex input
% otherwise its exitsf()
while(BodyF,ConditionF,Input) ->
	while(BodyF,ConditionF,Input,ConditionF(Input)).

while(BodyF,ConditionF,Input,true) ->
	while(BodyF, ConditionF, BodyF(Input));
while(_BodyF, _ConditionF, Input, _) ->
	Input.
	
up() -> while(fun(N) -> N + 1 end, fun(N) -> N < 10 end, 1).

fact(N) -> {_,_,Answer} = factHelp(N), Answer.
factHelp(N) ->
	while(fun({Max, Cur, Acc}) -> {Max, Cur+1, Acc*Cur} end,
	fun({Max, Cur, _Acc}) -> Cur < Max end,
	{N, 1, 1}).


% An elegant, but very inefficient, Quicksort
qsort([]) -> [];
qsort([Pivot|T]) ->
	qsort([X || X <-T, X < Pivot])
	++ [Pivot] ++
	qsort([X || X <-T, X >= Pivot]).

% Generates a random list of Count integers
randomList(Count) ->
	Max = 50,
	[random:uniform(Max) || _ <- lists:seq(1,Count)].

% Returns the maximum of a pair of values.
max(X,Y) when X > Y -> X;
max(_,Y) -> Y.


% This function takes a list of non-empty lists and returns a new list
% containing the first element of each original list.  For example:
%
% 1> basics2:firstOfEach([]).
% []
% 2> basics2:firstOfEach([[1,2],[3,4]]).
% [1,3]
% 3> basics2:firstOfEach([[1],[2,3],[4,5,6]]).
% [1,2,4]

% TODO: Implement firstOfEach(ListOfLists) using a list comprehension.

firstOfEach(L) -> [X || [X,_] <- L].
