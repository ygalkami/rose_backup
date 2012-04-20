------- file README_FIRST.txt    ------------------------------

Claude Anderson   January 16, 1994.  Revised October 25, 2007

This file gives an overview of the points-and-lines files.
The primary purpose is to illustrate how to use structs and
to reinforce some vector concepts.

A secondary purpose is to show how larger C programs can be broken up into
smaller source files.  This makes the editing and compilation process easier
because you only have to edit or recompile files that have been changed since
your last edit.

The program is broken up into three source files:

points-lines.h provides the declarations of some new data
types: points, lines, and vectors, as well as functions to
manipulate them.

point-line-functions.c provides the definitions of the functions declared in
the previous file.

points-lines-main.c contains the main function.



BELOW IS A SAMPLE RUN OF THE PROGRAM.  THE NUMBERS AT THE END OF ALL 
OF THE "Enter ..." LINES ARE ENTERED BY THE USER.

--------------------------------------------------------


This program illustrates some of the basic operations
On points, lines, and vectors.

Enter coordinates of p1, the first point on first segment: -1 3
Enter coordinates of p2, the second point on first segment: 5 11
Closest point to Origin is (-1.0000, 3.0000)
v1 is the vector from p1 to p2
L1 is the line through p1 in direction v1.
L3 is the line through p2 in direction v1.
s1 is the line segment from p1 to p2.
s3 is the line segment from p2 to p1.

Enter coordinates of p3, the first point on second segment: 2 4
Enter coordinates of p4, the second point on second segment: 7 -3
v2 is the vector from p3 to p4.
L2 is the line through p3 in direction v2.
s2 is the line segment from p3 to p4.


The distance between (-1.0000, 3.0000) and  (5.0000, 11.0000) is 10.0000.
v2 is the vector from p1 to midpoint of p1 and p2.
Vectors v1 and v3 are parallel.
Vectors v1 and v2 are not parallel.
Dot product of v1 and v2 is -26.00
Scalar multiple of v1 and 3 is 18.000i + 24.000j
Sum of v1 and v2 is 11.000i + 1.000j
Length of v1 is 10.00
The point (2.0000, 7.0000) is not on line L2.
The point (2.0000, 7.0000) is on line L1.
The segments s1 and s2 are not the same.
The segments s1 and s3 are the same.
The lines L1 and L2 are not the same.
The lines L1 and L3 are the same.
When we translate point (5.000, 11.000) by vector 5.000i + -7.000j,
 we get point ( 10,   4)