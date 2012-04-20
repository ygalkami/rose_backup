-module(intro).
%-export([test/0]). % Others: fact/1, slowFib/1, fib/1, first/2, haar/1
-compile(export_all).

% TODO: A simple Factorial implementation, fact(N)
fact(N) when N == 0 -> 1;
fact(N) -> N * fact(N - 1).

% TODO: A simple Fibonacci implementation, slowFib(N)
slowFib(N) when N == 0 -> 0;
slowFib(N) when N == 1 -> 1;
slowFib(N) -> slowFib(N-1) + slowFib(N-2).

% TODO: Fast Fibonacci, fib(N)
fibHelp(N, [H | _T]) when N == 0 -> H;
fibHelp(N, [_H | [X | _Y]]) when N == 1 -> X;
fibHelp(N, [H | [X | _Y]]) -> fibHelp(N - 1, [X, H + X]).

fib(N) -> fibHelp(N, [0, 1]).

% TODO: A function to return the first N elements of L, first(N,L)
first(_N, L) when L == [] -> [];
first(N, _L) when N == 0 -> [];
first(N, [H | T]) -> [H | first(N - 1, T)].

% TODO: A function to calculate the 1-dimensional Haar wavelet, haar(L)
haar_count (L, X) when X == 0 -> L;
haar_count (L, X) -> haar_count(haar_avgs(L) ++ haar_change(L), X - 1).

haar_avgs ([]) -> [];
haar_avgs ([H | [X | Y]]) -> [((H + X) / 2.0)] ++ haar_avgs(Y).

haar_change ([]) -> [];
haar_change ([H | [X | Y]]) -> [((H - X) / 2.0)] ++ haar_change(Y).

haar ([]) -> [];
haar (L) -> haar_count (L, logN(2, length(L))).

% Calculates the log base N of X:
logN(N, X) -> math:log(X) / math:log(N).

% Here's a test function, used below, for haar.  You'll need to uncomment
% this when you're ready for it.
 test_haar(L) ->
 	io:format("haar(~p) = ~p~n", [L, haar(L)]).

% Here's some test code for your functions.  You'll probably want to 
% uncomment it from the bottom up.  (The commas are less annoying this way.)
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

