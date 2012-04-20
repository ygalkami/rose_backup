% ----------------------------------------------------------------
% This helper module defines the Pac-Man game board.
% ----------------------------------------------------------------
-module(board).
-compile(export_all).

width() -> 29.
height() -> 32.

% isBlocked(Row, Col) returns true if the path is blocked at that position
isBlocked( 0, _) -> true;
% ----------------------
isBlocked( 1, 0) -> true;
isBlocked( 1,14) -> true;
isBlocked( 2, C) -> isBlocked(1, C);
% ----------------------
isBlocked( 3, 0) -> true;
isBlocked( 3, 3) -> true;
isBlocked( 3, 4) -> true;
isBlocked( 3, 5) -> true;
isBlocked( 3, 8) -> true;
isBlocked( 3, 9) -> true;
isBlocked( 3,10) -> true;
isBlocked( 3,11) -> true;
isBlocked( 3,14) -> true;
isBlocked( 4, C) -> isBlocked(3, C);
% ----------------------
isBlocked( 5, 0) -> true;
isBlocked( 6, 0) -> true;
% ----------------------
isBlocked( 7, 0) -> true;
isBlocked( 7, 3) -> true;
isBlocked( 7, 4) -> true;
isBlocked( 7, 5) -> true;
isBlocked( 7, 8) -> true;
isBlocked( 7,11) -> true;
isBlocked( 7,12) -> true;
isBlocked( 7,13) -> true;
isBlocked( 7,14) -> true;
% ----------------------
isBlocked( 8, 0) -> true;
isBlocked( 8, 8) -> true;
isBlocked( 8,14) -> true;
isBlocked( 9, C) -> isBlocked(8, C);
% ----------------------
isBlocked(10, 0) -> true;
isBlocked(10, 1) -> true;
isBlocked(10, 2) -> true;
isBlocked(10, 3) -> true;
isBlocked(10, 4) -> true;
isBlocked(10, 5) -> true;
isBlocked(10, 8) -> true;
isBlocked(10, 9) -> true;
isBlocked(10,10) -> true;
isBlocked(10,11) -> true;
isBlocked(10,14) -> true;
% ----------------------
isBlocked(11, 5) -> true;
isBlocked(11, 8) -> true;
isBlocked(12, C) -> isBlocked(11, C);
% ----------------------
isBlocked(13, 0) -> true;
isBlocked(13, 1) -> true;
isBlocked(13, 2) -> true;
isBlocked(13, 3) -> true;
isBlocked(13, 4) -> true;
isBlocked(13, 5) -> true;
isBlocked(13, 8) -> true;
isBlocked(13,11) -> true;
isBlocked(13,12) -> true;
isBlocked(13,13) -> true;
isBlocked(13,14) -> true;
% ----------------------
isBlocked(14,11) -> true;
isBlocked(14,12) -> true;
isBlocked(14,13) -> true;
isBlocked(14,14) -> true;
isBlocked(15, C) -> isBlocked(14, C);
% ----------------------
isBlocked(16, C) -> isBlocked(13, C);
% ----------------------
isBlocked(17, C) -> isBlocked(11, C);
isBlocked(18, C) -> isBlocked(11, C);
% ----------------------
isBlocked(19, 0) -> true;
isBlocked(19, 1) -> true;
isBlocked(19, 2) -> true;
isBlocked(19, 3) -> true;
isBlocked(19, 4) -> true;
isBlocked(19, 5) -> true;
isBlocked(19, 8) -> true;
isBlocked(19, 9) -> true;
isBlocked(19,10) -> true;
isBlocked(19,11) -> true;
isBlocked(19,12) -> true;
isBlocked(19,13) -> true;
isBlocked(19,14) -> true;
% ----------------------
isBlocked(20, C) -> isBlocked(1, C);
isBlocked(21, C) -> isBlocked(1, C);
% ----------------------
isBlocked(22, 0) -> true;
isBlocked(22, 3) -> true;
isBlocked(22, 4) -> true;
isBlocked(22, 5) -> true;
isBlocked(22, 8) -> true;
isBlocked(22, 9) -> true;
isBlocked(22,10) -> true;
isBlocked(22,11) -> true;
isBlocked(22,14) -> true;
% ----------------------
isBlocked(23, 0) -> true;
isBlocked(23, 5) -> true;
isBlocked(24, C) -> isBlocked(23, C);
% ----------------------
isBlocked(25, 0) -> true;
isBlocked(25, 1) -> true;
isBlocked(25, 2) -> true;
isBlocked(25, 5) -> true;
isBlocked(25, 8) -> true;
isBlocked(25,11) -> true;
isBlocked(25,12) -> true;
isBlocked(25,13) -> true;
isBlocked(25,14) -> true;
% ----------------------
isBlocked(26, C) -> isBlocked(8, C);
isBlocked(27, C) -> isBlocked(8, C);
% ----------------------
isBlocked(28, 0) -> true;
isBlocked(28, C) when C >= 3 andalso C =< 11 -> true;
isBlocked(28,14) -> true;
% ----------------------
isBlocked(29, 0) -> true;
isBlocked(30, 0) -> true;
% ----------------------
isBlocked(31, _) -> true;
% ----------------------
% board is symetric about the vertical axis:
isBlocked(R, C) when C > 14 -> isBlocked(R, 28 - C);
% what isn't blocked, isn't blocked:
isBlocked(_,_)  -> false.
