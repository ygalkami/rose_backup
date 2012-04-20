-module(introSolution).
-export([fact/1, slowFib/1, fib/1, first/2, haar/1, test/0]).

% TODO: A simple Factorial implementation, fact(N)
fact(0) -> 1;
fact(1) -> 1;
fact(N) when N > 1
	-> N * fact(N-1).


% TODO: A simple Fibonacci implementation, slowFib(N)
slowFib(0) -> 0;
slowFib(1) -> 1;
slowFib(N) when N > 1 
	-> slowFib(N-1) + slowFib(N-2).

% TODO: Fast Fibonacci, fib(N)
fib(0) -> 0;
fib(1) -> 1;
fib(N) when N > 1
	-> [F|_] = fibList(N),
	   F.

fibList(2) -> [ 1, 1, 0];
fibList(N) when N > 2
	-> 	Prev = fibList(N-1),
		[P1, P2 | _] = Prev,
		[P1+P2 | Prev].

% TODO: A function to return the first N elements of L, first(N,L)
first(N, L) when N =< length(L)
	-> lists:reverse( first(N, L, []) ).
	
first(0, _, Acc) -> Acc;
first(N, [L|Ls], Acc) -> first(N-1, Ls, [L|Acc]).

% TODO: A function to calculate the 1-dimensional Haar wavelet, haar(L)
haar(L) -> haar(L, trunc(logN(2, length(L)))).

haar(L, 0) -> L;
haar(L, N) when N > 0 -> haar(haar(L, [], []), N-1).

haar([], Lout1, Lout2) 
	-> lists:reverse(Lout1) ++ lists:reverse(Lout2);
haar([L1,L2|Lin], Lacc1, Lacc2)
	-> haar(Lin, [haarAve(L1,L2)|Lacc1], [haarCoef(L1,L2)|Lacc2]).
	
haarAve(X,Y) -> (X + Y) / 2.
haarCoef(X,Y) -> (X - Y) / 2.

% Calculates the log base N of X:
logN(N, X) -> math:log(X) / math:log(N).

% Test code for your functions:
test() -> 
	io:format("Testing haar~n"),
	test_haar([8, 5]),
	test_haar([5, 8]),
	test_haar([8, 5, 7, 3]),
	test_haar([8, 7, 5, 3]),
	test_haar(lists:seq(0,7,1)),
	io:format("Testing fact~n  N fact(N)~n"),
	test(fun(N) -> fact(N) end, 1, 10),
	io:format("Testing fast fib~n  N fib(N)~n"),
	test(fun(N) -> fib(N) end, 1, 40),
	io:format("Testing slow fib~n  N fib(N)~n"),
	test(fun(N) -> slowFib(N) end, 1, 10),
	io:format("Testing first~n"),
	L = lists:seq(1,20,2),
	test(fun(N) -> first(N, L) end, 1, 10),
	io:format("That is all.~n").

test(F, N, Max) when N =< Max -> 
	Fn = F(N),
	io:fwrite("~3B ~p~n", [N, Fn]),
	test(F, N+1, Max);
test(_, _, _) -> ok.

test_haar(L) ->
	io:format("haar(~p) = ~p~n", [L, haar(L)]).
