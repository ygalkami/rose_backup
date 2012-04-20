% Modules are declared like this:
-module(basics).
-compile(export_all).

% export declaration says which of the functions, and of what _ARITY_
% should be available.
-export([foo/1, bar/2, blah/1, upTo/1]).

% a simple function:
foo(N) -> N * 2.

% a two arg function.
bar(N, M) -> bar(N) * bar(M).

bar(X) when X rem 2 == 0 -> 0;
bar(X) when X rem 2 /= 0 -> 1.

%patten matching with floats
blah(X) when trunc(X) == 2 -> "foo";
blah(_) -> "bar".

% upto N

upTo(N) when N =< 0 -> [];
upTo(N) -> upToHelp(N, []).

upToHelp(N, L) when N == 0 -> L;
upToHelp(N, L) -> upToHelp(N - 1, [N | L]).
