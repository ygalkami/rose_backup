% This module provides a Sudoku puzzle solver.
% by Curt Clifton
% Programming Language Paradigms
% Rose-Hulman Institute of Technology
% Spring 2008
-module(sudokuSolution).
-compile(export_all).

% ---------------------------------------------------------------------
% A puzzle is represented as a list of lists, where the inner lists
% represent rows of the puzzle.  The atom 'u' represents an unknown 
% value.
% ---------------------------------------------------------------------
puzzle(1) -> [[1]];
puzzle(2) -> [[u]];
puzzle(3) -> [ % Impossible
	[1,u,3,4],
	[2,3,4,1],
	[3,4,1,2],
	[4,1,2,3]
];
puzzle(4) -> [
	[1,3,4,2],
	[u,2,u,u],
	[2,u,3,1],
	[u,u,u,4]
];
puzzle(5) -> [ % From Grand Master Su Doku Ultimate, by Wayne Gould, p. 11
	[6,9,8, 2,u,7, 1,3,4],
	[5,4,u, u,6,1, 9,8,u],
	[u,1,3, 9,4,u, u,5,2],
	
	[9,5,u, u,8,2, 3,u,6],
	[2,u,6, 4,1,u, 7,9,u],
	[3,7,u, 5,9,u, u,4,8],
	
	[8,2,u, 6,u,4, 5,7,u],
	[u,3,7, u,2,5, u,6,9],
	[u,6,5, 1,u,9, 8,u,3]
];
puzzle(6) -> [ % From Grand Master Su Doku Ultimate, by Wayne Gould, p. 11
	[u,u,u, 2,u,7, 1,3,u],
	[5,4,u, u,6,u, u,8,u],
	[u,1,u, 9,u,u, u,5,2],
	
	[9,5,u, u,8,2, u,u,6],
	[u,u,6, u,u,u, 7,u,u],
	[3,u,u, 5,9,u, u,4,8],
	
	[8,2,u, u,u,4, u,7,u],
	[u,3,u, u,2,u, u,6,9],
	[u,6,5, 1,u,9, u,u,u]
];
puzzle(7) -> [ % From Grand Master Su Doku Ultimate, by Wayne Gould, p. 136
	[u,3,u, 4,u,8, u,u,2],
	[5,u,8, u,u,1, u,u,u],
	[u,u,u, u,9,u, 6,u,u],
	
	[u,9,u, u,u,u, 7,u,6],
	[u,u,5, u,u,u, 4,u,u],
	[6,u,2, u,u,u, u,9,u],
	
	[u,u,4, u,6,u, u,u,u],
	[u,u,u, 3,u,u, 8,u,9],
	[8,u,u, 1,u,5, u,6,u]
];
puzzle(8) -> lists:duplicate(9, lists:duplicate(9, u));
puzzle(9) -> lists:duplicate(16, lists:duplicate(16, u)).
expected(3) -> impossible;
expected(_) -> ok.

% ---------------------------------------------------------------------
% Some helper functions for checking puzzles.
% ---------------------------------------------------------------------

% ---------------------------------------------------------------------
% is_valid that the given puzzle has the appropriate structure, without 
% checking that the actual numbers are placed appropriately.
is_valid(Puzzle) ->
	NumRows = length(Puzzle),
	RowLengthsOK = lists:all(fun(Row) -> length(Row) =:= NumRows end, Puzzle),
	ValuesOK = lists:all(fun(Row) ->
		lists:all(fun(Cell) ->
			          Cell =:= u orelse Cell >= 1 andalso Cell =< NumRows 
				end, Row) 
			end, Puzzle),
	is_square(NumRows) andalso RowLengthsOK andalso ValuesOK.

% ---------------------------------------------------------------------
% Returns true iff the argument is a perfect square.
is_square(N) -> trunc(math:sqrt(N)) == math:sqrt(N).

% ---------------------------------------------------------------------
% Returns true iff the given Puzzle is a valid partial solution
check_partial_solution(Puzzle) ->
	check_partials(Puzzle)
	andalso check_partials(transpose(Puzzle))
	andalso check_partials(get_submatrices(Puzzle)).

% ---------------------------------------------------------------------
% Takes a list of subcomponents of the puzzle (rows, columns, or blocks) and 
% returns true if there are no duplicates.
check_partials([]) -> true;
check_partials([First|Rest]) -> case no_dups_but_unknown(lists:sort(First)) of
	true -> check_partials(Rest);
	false -> false
end.

% ---------------------------------------------------------------------
% Returns a list of lists where each inner lists represents one column of the
% puzzle.
transpose(Puzzle) -> transpose(Puzzle, []).
% Takes a list of row suffixes, plus an accumulator of the columns so far:
transpose([[]|_], Acc) -> % if first row is empty, then rest must be also
	lists:reverse(Acc); 
transpose(Rows, Acc) ->
	NextColumn = [H || [H|_] <- Rows],
	Tails = [T || [_|T] <- Rows],
	transpose(Tails, [NextColumn|Acc]).

% ---------------------------------------------------------------------
% Returns a list of lists where each inner lists represents one nxn 
% sub-matrix of the given (n*n)x(n*n) puzzle.
% This implementation assumes no larger than 64x64 puzzles so that each
% cell can be represented by a single byte.
get_submatrices(Puzzle) -> 
	NSquared = length(Puzzle),
	N = trunc(math:sqrt(NSquared)),
	% Convert to list of list of binaries, one binary for each N cells in 
	% scan-line order
	BinaryEncoded = 
		[split_into_ns(list_to_binary(lists:map(fun remove_unk/1, Row)),
				       N, []) 
				|| Row <- Puzzle],
	BinaryTrans = transpose(BinaryEncoded),
	[lists:map(fun add_unk/1, binary_to_list(BinBlock))
		|| BlockCol <- BinaryTrans, 
		BinBlock <- split_into_ns(list_to_binary(BlockCol), NSquared, [])].

% ---------------------------------------------------------------------
% A pair of helper functions to convert the unknown atom, 'u', into an
% integer and back.  Used to make puzzles convertable to binaries.
remove_unk(u) -> 0;
remove_unk(N) when is_integer(N) -> N.
add_unk(0) -> u;
add_unk(N) when is_integer(N) -> N.

% ---------------------------------------------------------------------
% Splits a given binary into a list of binaries with N bytes in each.
% Requires: length(Bin) rem N =:= 0.
split_into_ns(<<>>, _N, Acc) -> lists:reverse(Acc);
split_into_ns(Bin, N, Acc) ->
	{H, T} = split_binary(Bin, N),
	split_into_ns(T, N, [H|Acc]).


% ---------------------------------------------------------------------
% Returns true if the given SORTED list contains no duplicates, other than the
% atom 'u' which represents an unknown value.
no_dups_but_unknown([]) -> true;
no_dups_but_unknown([_]) -> true;
% relies on atoms sorting after numbers:
no_dups_but_unknown([u|_]) -> true; 
no_dups_but_unknown([N,M|Rest]) when N =/= M -> no_dups_but_unknown([M|Rest]);
no_dups_but_unknown([N,N|_]) -> false. % duplicate numbers

% ---------------------------------------------------------------------
% Return true iff the given Puzzle is a valid complete solution
check_solution(Puzzle) ->
	is_complete(Puzzle) andalso check_partial_solution(Puzzle).

% ---------------------------------------------------------------------
% Returns true iff the given Puzzle has no unknown cells.
is_complete(Puzzle) ->
	lists:all(fun (Row) -> lists:all(fun (Cell) -> Cell =/= u end, Row)
			  end, Puzzle).

% ---------------------------------------------------------------------
% Utility function to test solver against all sample problems.
% ---------------------------------------------------------------------
test() -> 
	TestsToRun = lists:seq(1,9,1),  % <-- change list to run a subset of tests
	Quiet = false, % <-- set to true to not report anything on success
	io:format("Testing all puzzles~n", []),
	Result = [{N, solve(puzzle(N))} || N <- TestsToRun],
	lists:foreach(fun ({Case, {IsOK, Puzzle}}) ->
						Mismatch = case expected(Case) of
							IsOK -> "";
							_ -> "UNEXPECTED!"
						end,
						Invalid = case check_solution(Puzzle) of
							false when IsOK == ok -> "NOT A VALID SOLUTION!";
							_ -> ""
						end,
						if
							(Mismatch == "") and (Invalid == "")
							and Quiet == true -> io:format(".");
							true ->
								io:format("~nCase ~p: ~p ~s~n~p~n~s~n", 
									[Case, IsOK, Mismatch, Puzzle, Invalid])
						end
	              	end,
				  Result),
	io:format("~n"),
	done.


% ---------------------------------------------------------------------
% IMPLEMENT YOUR SOLVE FUNCTION, AND ANY HELPER FUNCTIONS, HERE.
% ---------------------------------------------------------------------
% Your function should return a tuple {ok, Puzzle}, where Puzzle is a complete
% solution if one exists. If no solution exists, your function should return a
% tuple {impossible, Puzzle}, where Puzzle is the partial configuration for
% which no solution could be found.
% solve(Puzzle) -> {impossible, Puzzle}
solve(Puzzle) -> case is_valid(Puzzle) of
 	false -> {invalid, Puzzle};
	true -> solve_valid(Puzzle)
end.

% ---------------------------------------------------------------------
% Attempts to solve the given puzzle.
% Requires is_valid(Puzzle).
solve_valid(Puzzle) -> case check_solution(Puzzle) of
	true -> {ok, Puzzle};
	_ -> solve(Puzzle, attempts(Puzzle))
end.

% ---------------------------------------------------------------------
% Attempts to solve the given puzzle, which must not already be solved,
% by attempting to place each of the given list of possibilities in
% the first available space, then recursing.
solve(Puzzle, []) -> {impossible, Puzzle};
solve(Puzzle, [A|Remaining]) ->
	case is_complete(Puzzle) of
		true -> {impossible, Puzzle};
		false ->  
			case solve_valid(subst_first(Puzzle, A)) of
				{ok, Answer} -> {ok, Answer};
				_ -> solve(Puzzle, Remaining)
			end
	end.

% ---------------------------------------------------------------------
% Returns a list of possible numbers for the first blank in the given
% puzzle.  Puzzle must have a blank in it!
% attempts(Puzzle) -> lists:seq(1,length(Puzzle), 1).
attempts(Puzzle) -> 
	Size = trunc(math:sqrt(length(Puzzle))),
	try find_first_blank(Puzzle, 1, 1) of
		{R,C} -> begin
			Row = lists:nth(R, Puzzle),
			Column = lists:nth(C, transpose(Puzzle)),
			BlockN = 1 + ((R - 1) div Size) + ((C-1) div Size) * Size,
			Block = lists:nth(BlockN, get_submatrices(Puzzle)),
			Possibilities = ((lists:seq(1,length(Puzzle), 1) -- Row)
							 -- Column) -- Block,
			lists:filter(fun (N) -> N =/= u end, Possibilities)
		end
	catch
		throw:noBlanks -> throw({noBlanks, Puzzle})
	end.

% ---------------------------------------------------------------------
% Returns the row and column (1 based) of the first blank in the given puzzle.
% Puzzle must have a blank in it!
find_first_blank([], _, _) -> throw(noBlanks);
find_first_blank([[] | Rows], R, _) -> 
	find_first_blank(Rows, R+1, 1);
find_first_blank([[u|_] | _], R, C) -> {R, C};
find_first_blank([[_|PartialRow] | Rows], R, C) ->
	find_first_blank([PartialRow | Rows], R, C+1).


% ---------------------------------------------------------------------
% Returns a new puzzle with the first occurence of the atom 'u' replaced with
% the given N.
subst_first(Puzzle, N) -> subst_first(Puzzle, [], N, seek).
subst_first([], Acc, _, _) -> lists:reverse(Acc);
subst_first([Row|Rest], Acc, N, found) ->
	subst_first(Rest, [Row|Acc], N, found);
subst_first([Row|Rest], Acc, N, seek) ->
	case subst_in_row(Row, [], N, seek) of
		{found, NewRow} -> subst_first(Rest, [NewRow|Acc], N, found);
		{seek, Row}     -> subst_first(Rest, [Row|Acc], N, seek)
	end.

% ---------------------------------------------------------------------
% Returns a new row with the first occurence of the atom 'u' replaced with
% the given N.
subst_in_row([], Acc, _, SF) -> {SF, lists:reverse(Acc)};
subst_in_row([M|Ms], Acc, N, found) -> subst_in_row(Ms, [M|Acc], N, found);
subst_in_row([u|Ms], Acc, N, seek) -> subst_in_row(Ms, [N|Acc], N, found);
subst_in_row([M|Ms], Acc, N, seek) -> subst_in_row(Ms, [M|Acc], N, seek).
