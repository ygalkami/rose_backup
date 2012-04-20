-module(bap).
-compile(export_all).

days_until({Y, M, D}) -> 
	{YN, MN, DN} = date(),
	Days = sum_months(M) + D,
	DaysNow = sum_months(MN) + DN,
	(Y - YN) * 365 + (Days - DaysNow).

% Returns the number of days in the months before the given month. E.g., 
% sum_months(1) = 0.
% sum_months(2) = 31.
% sum_months(13) = 365.
sum_months(M) when (1 =< M) and (M =< 13) -> 
	DaysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31],
	MonthsToSum = lists:sublist(DaysInMonths, 1, M-1),
	lists:foldl(fun (A, B) -> A + B end, 0, MonthsToSum);
sum_months(M) ->
	exit({sum_monthsInvalidArgument, M}).

