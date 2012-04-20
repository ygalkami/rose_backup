/* ----------------   File points-lines-main.c   ----------------
   Claude Anderson.  December 7, 1992.  Revised 1/16/94, 1/16/95, and 10/25/07.

   For an explanation of the organization of this program in three files,
   as well as how to compile them, see the file README-FIRST.txt.

   For descriptions of the types and functions used here, see
   points-lines.h.  To see (and complete) the implementations of those
   functions, see point-line-functions.c.                                  */

#include <stdio.h>
#include <math.h>
#include "points-lines.h"

char *isOrIsNot(int v) {  /* returns a string */
	if (v) 
	  return "";
	else
	  return "not ";
}

int main ()
{ point   p1, p2, p3, p4, p5;
  double  x, y;
  vector  v1, v2, v3;
  line    L1, L2, L3;
  segment s1, s2, s3;

  printf("\nThis program illustrates some of the basic operations\n");
  printf("On points, lines, and vectors.\n\n");
  
  printf("Enter coordinates of p1, the first point on first segment: ");
  fflush(stdout);
  scanf("%lf %lf", &x, &y);
  p1 = makePoint(x, y);
  
  printf("Enter coordinates of p2, the second point on first segment: ");
  fflush(stdout);
  scanf("%lf %lf", &x, &y);
  p2 = makePoint(x, y);
  
   point pointList[8];
   pointList[0] = makePoint(2, 7);
   pointList[1] = makePoint(3, 6);
   pointList[2] = makePoint(4, 5);
   pointList[4] = makePoint(-7, 0); 
   pointList[3] = p1;
   
   point nearest = closestToOrigin(pointList, 5);
   printf("Closest point to Origin is ");
   printPoint(nearest);
   printf("\n");
  
  v1 = makeVecFromPoints(p1, p2);
  printf("v1 is the vector from p1 to p2\n");
  
  L1 = makeLine(p1, v1);
  printf("L1 is the line through p1 in direction v1.\n");
  
  L3 = makeLine(p2, v1);
  printf("L3 is the line through p2 in direction v1.\n");
  
  s1 = makeSegment(p1, p2);
  printf("s1 is the line segment from p1 to p2.\n");
  
  s3 = makeSegment(p2, p1);
  printf("s3 is the line segment from p2 to p1.\n\n");
  
    
  printf("Enter coordinates of p3, the first point on second segment: ");
  fflush(stdout);
  scanf("%lf %lf", &x, &y);
  p3 = makePoint(x, y);
  
  printf("Enter coordinates of p4, the second point on second segment: ");
  fflush(stdout);
  scanf("%lf %lf", &x, &y);
  p4 = makePoint(x, y);
  
  v2 = makeVecFromPoints(p3, p4);
  printf("v2 is the vector from p3 to p4.\n");
  
  L2 = makeLine(p3, v2);
  printf("L2 is the line through p3 in direction v2.\n");
  
  s2 = makeSegment(p3, p4);
  printf("s2 is the line segment from p3 to p4.\n\n");


  printf("\nThe distance between ");
  printPoint(p1);
  printf(" and  ");
  printPoint(p2);
  printf(" is %.4f.\n", distance(p1,p2));

  p5 = midPoint(s1);
  v3 = makeVecFromPoints(p2, p5);
  printf("v2 is the vector from p1 to midpoint of p1 and p2.\n");
  
  printf("Vectors v1 and v3 are %sparallel.\n", isOrIsNot(parallel(v1, v3)));
  printf("Vectors v1 and v2 are %sparallel.\n", isOrIsNot(parallel(v1, v2)));
  
  printf("Dot product of v1 and v2 is %0.2lf\n", dotProd(v1, v2));
  
  vector sMult = scalarMultiply(v1, 3);
  printf("Scalar multiple of v1 and 3 is %0.3lfi + %0.3lfj\n", 
         sMult.xComponent, sMult.yComponent);
         
  vector vSum = addVectors(v1, v2);
  printf("Sum of v1 and v2 is %0.3lfi + %0.3lfj\n", 
         vSum.xComponent, vSum.yComponent);
  
  printf("Length of v1 is %0.2lf\n", length(v1));
          
  
  printf("The point ");
  printPoint(p5);
  printf(" is %son line L2.\n", isOrIsNot(onLine(p5, L2)));
  
  printf("The point ");
  printPoint(p5);
  printf(" is %son line L1.\n", isOrIsNot(onLine(p5, L1)));
  
  printf("The segments s1 and s2 are %sthe same.\n",
          isOrIsNot(sameSegment(s1, s2)));
  printf("The segments s1 and s3 are %sthe same.\n",
         isOrIsNot(sameSegment(s1, s3)));
  printf("The lines L1 and L2 are %sthe same.\n",
         isOrIsNot(sameLine(L1, L2)));
  printf("The lines L1 and L3 are %sthe same.\n",
         isOrIsNot(sameLine(L1, L3)));
         
  point trP = translatePointByVector(p2, v2);      
  printf("When we translate point (%0.3lf, %0.3lf) by vector %0.3lfi + %0.3lfj,\n we get point (%3.lf, %3.lf)\n",
         p2.xCoord, p2.yCoord, v2.xComponent, v2.yComponent, trP.xCoord, trP.yCoord);
                
  return 0;
  }

 
