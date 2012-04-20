/* ----------------   File point-line-functions.c   --------------------------
   Claude Anderson.  December 7, 1992.  Revised 1/16/94, 1/16/95, and 10/25/07.

   For an explanation of the organization of this program in three files,
   see the file README-FIRST.txt.

   For declarations of these functions and the various data types
   used here, see points-lines.h.

   For an example of the use of these functions, see points-lines-main.c
*/

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include "points-lines.h"

/* Definitions of several functions for creating and using  the
   various struct types.                                                   */

/******************************************
* Construct a point from its coordinates  *
*******************************************/

point makePoint(double x, double y) {  /* The return type of this function */
                                       /* is "point".                      */
  point p;                           
  p.xCoord = x;
  p.yCoord = y; 
  return p;
}

/***************************************************
* Find the distance between points p1 and p2.     *
***************************************************/
     
double distance (point p1,  point p2) {
  return sqrt(square(p1.xCoord - p2.xCoord) +
              square(p1.yCoord - p2.yCoord));
}

/***************************************************
*  Print the coordinates of p in a fixed format.    *
***************************************************/
void printPoint(point p) {
  printf("(%0.4lf, %0.4lf)", p.xCoord, p.yCoord);
}

/**************************************************************
* return the point from pList that is closest to the origin.  *
***************************************************************/
point closestToOrigin(point pList [], int pointCount) {
	point origin = {0, 0};
	point closest = pList[0];
	double shortest = distance(origin, pList[0]);
	int i;
	for (i = 1; i<pointCount; i++) {
	  double thisDistance = distance(pList[i], origin);
	  if (thisDistance < shortest) {
	  	shortest = thisDistance;
	  	closest = pList[i];
	  }
	}
	return closest;
}

/* For the remaining functions, we have provided descriptions
 * and stubs; you are to fill in the body of each.  For functions that 
 * return a value, we put in dummy values so the program will compile
 * without warning.  You will need to replace those return values with 
 * the real ones.
 */

/******************************************************************************
* Returns the point that is the midpoint of the segment s.                    *
*******************************************************************************/

point midPoint(segment s)  { 
  point p;
  double xmid, ymid;
  xmid = (s.p1.xCoord + s.p2.xCoord) / 2;
  ymid = (s.p1.yCoord + s.p2.yCoord)/ 2;
  p = makePoint(xmid, ymid);
  return p;
}

/*************************************************
* Construct the vector from p1 to p2.            *
* For example, the vector from (3, 2) to (5, -1) *
* is 2i - 3j .                                   *
**************************************************/
vector makeVecFromPoints(point p1, point p2) {
  vector v;
  v.xComponent = p2.xCoord - p1.xCoord;
  v.yComponent = p2.yCoord - p1.yCoord;
  return v;
}

/**************************************************
* Construct a line from a point and a vector.     *
**************************************************/
line makeLine(point p, vector v) {
  line L;
  L.pt = p;
  L.dir = v;
  return L;
}

/***************************************************
* Construct a line segment from its endpoints.     *
***************************************************/
segment makeSegment(point p1, point p2) {
  segment s;
  s.p1 = p1;
  s.p2 = p2;
  return s;
}

/**********************************************************
* Are v1 and v2 parallel?   Return 1 if true, 0 if false  *
* Suggestion: Try to avoid using division in your code.   *
**********************************************************/
  
int parallel(vector v1, vector v2) {
  //return 0; /* false */
  if (v1.xComponent * v2.yComponent - v2.xComponent * v1.yComponent == 0)
  	return 1;
  else
  	return 0;
}


/*********************************
* Are p1 and p2 the same point?  *
*********************************/

int samePoint(point p1, point p2){
  if (p1.xCoord == p2.xCoord && p1.yCoord == p2.yCoord)
  	return 1;
  else
  	return 0;
  
}

/*************************************************
* Are s1 and s2 the same segment?                *
* I.e. do their endpoints match (in some order)? *
**************************************************/

int sameSegment(segment s1, segment s2){  /* Are s1 and s2 the same?  */
    //return 0; /* false */
    if (samePoint(s1.p1, s2.p1) == 1 && samePoint(s1.p2, s2.p2) == 1)
      	return 1;
    else if (samePoint(s1.p1, s2.p2) == 1 && samePoint(s1.p2, s2.p1) == 1)
   		return 1;
   	else
    	return 0;
}

/************************************************************************
   Is point p on the line L?  Hint: If it is, then any vector from p to *
   a point on the line will be parallel to L's vector.                  *
*************************************************************************/

int onLine(point p, line L) {                /* is p on the line L?  */
	vector v;
  	v = makeVecFromPoints(p, L.pt);
  	if (parallel(v, L.dir) == 1)
  		return 1;
  	else
  		return 0;
  
}

/***********************************
* Are L1 and L2 the same line?     *
* Hint: use onLine() twice.          *
***********************************/

int sameLine(line L1, line L2) {
  if (parallel(L1.dir, L2.dir))
  {
  	if (L1.dir.xComponent == L2.dir.xComponent)
  		return 1;
  }
  else
  	return 0;
  
}


/*********************************************************
* Multiply the vector v by the scalar s,                 *
* For example, multiplying 2i + 3j by 4 yeilds 8i + 12j  *
*********************************************************/

vector scalarMultiply(vector v, double s) { /* Multiply v by the scalar s */
  vector m;
  m.xComponent = v.xComponent * s;
  m.yComponent = v.yComponent * s;
  return m;
  /* TODO: Write a correct return statement and any other needed statements. */
}


/******************************  
*  Add the vectors v1 and v2  *
*******************************/

vector addVectors(vector v1, vector v2) {
  vector sum;
  sum.xComponent = v1.xComponent + v2.xComponent;
  sum.yComponent = v1.yComponent + v2.yComponent;
  return sum;
  /* TODO: Write a correct return statement and any other neeeded statements. */
}

/************************************
* Find the dot product of v1 and v2 *
************************************/

double dotProd (vector a, vector b) {
  double dot;
  dot = a.xComponent * b.xComponent + a.yComponent * b.yComponent;
  return dot;
}


/*******************************************
* Length (magnitude) of the vector v.      *
* The length of ai + bj is sqrt(a*a + b*b) *
********************************************/

double length(vector v) {
	double length;
	length = sqrt(v.xComponent * v.xComponent + v.yComponent * v.yComponent);
	return length;
}

/*******************************************************************
*  Translates the point p by the vector v.                         *
*  for example, the point (4, 3) translated by the vrctor 2i - 4j  *
*  yields the point (6, -1)                                        *
********************************************************************/
    
point translatePointByVector(point p, vector v) {
  point t;
  t.xCoord = v.xComponent + p.xCoord;
  t.yCoord = v.yComponent + p.yCoord;
  return t;
   /* TODO: Write a correct return statement and any other neeeded statements. */
}
