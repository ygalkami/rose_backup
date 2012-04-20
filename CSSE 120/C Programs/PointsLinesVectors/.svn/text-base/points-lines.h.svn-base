/* ----------------   File points-lines.h   ----------------
   Claude Anderson.  December 7, 1992.  
   Revised 1/16/94, 1/16/95, 10/25/07, and 11/1/07

   For an explanation of the organization of this program in three files,
   as well as how to compile them, see the file README-FIRST.txt.

   Definitions of the functions declared here are in the file
   point-line-functions.c.

   Examples of how to use the functions are in points-lines-main.c

   We extend in-class points example 
   to include lines, line segments,  and vector operations.

   I could have chosen to use the "point" data structure to represent
   vectors as well.  But to make a distinction between a point and a
   vector, I use different names for the fields.  Doing this allows the 
   compiler to help you find some logical errors if you accidentally 
   use a point where you meant a vector or vice-versa.
   To represent a line, I use a point and a vector indicating the line's 
   direction.   For a line segment, the two endpoints are given.

   Various geometric operations are declared, in order to illustrate the
   use of C structures.
*/

#ifndef POINTSLINES_H_
#define POINTSLINES_H_

#define square(s) ((s)*(s)) 

/* define the various types: point, line, segment, vector  */

typedef struct {
   double xCoord;
   double yCoord;
} point;

typedef struct {
   double xComponent;
   double yComponent;
} vector;

typedef struct {
   point pt;            /* pt is a point on the line.                     */
   vector dir;          /* dir is a vector giving a direction of the line.*/
} line;

typedef struct {       /* p1 and p2 are obviously the two endpoints.     */
   point p1;
   point p2;
} segment;


/* Construct a point from its coordinates      */
point makePoint(double x, double y);

/* Find the distance between points p1 and p2. */
double distance (point p1, point p2);

/* print the coordinates of p in fixed format.  */
void printPoint(point p);

/* return the point from first pointCount elements 
 * of pList that is closest to the origin. */
point closestToOrigin(point pList [], int pointCount);

/* midpoint of the segment s. */
point midPoint(segment s);

/* Construct the vector from p1 to p2.         */
vector makeVecFromPoints(point p1, point p2);

/* Construct a line from a point and a vector. */
line makeLine(point p, vector v);

/* Construct a line segment from its endpoints.*/
segment makeSegment(point p1, point p2);



/* Are v1 and v2 parallel?                     */
int parallel(vector v1, vector v2);

/* Are p1 and p2 the same point?               */
int samePoint(point p1, point p2);

/* Are s1 and s2 the same segment?              */
int sameSegment(segment s1, segment s2);

/* Is p on the line L?                          */
int onLine(point p, line L);

/* Are L1 and L2 the same line?                 */
int sameLine(line L1, line L2);

/* Multiply the vector v by the scalar s        */
vector scalarMultiply(vector v, double s);

/* Add the vectors v1 and v2                    */
vector addVectors(vector v1, vector v2);

/* Find the dot product of v1 and v2            */
double dotProd (vector a, vector b);

/* Length (magnitude) of the vector v.          */
double length(vector v);

/* Translates the point p by the vector v.      */
point translatePointByVector(point p, vector v);

#endif /*POINTSLINES_H_*/
