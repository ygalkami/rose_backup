/*
 * Guassian distribution random number generated.  Based on algorithm at
 * http://www.taygeta.com/random/gaussian.html
 */

#include <time.h>
#include <stdlib.h>
#include <math.h>
#include "gaussian.h"

#define FALSE 0
#define TRUE 1

typedef int boolean;

/*****************************************************************************
 * Seeds the random number generator with the current time, then dumps a few
 * values since approximately equal seeds yield similar results for the first
 * few random values.
 *****************************************************************************/ 
void seedRandomNumberGenerator() {
	srand(time(NULL));
	int i;
	for (i=0; i<100; i++) {
		rand();
	}
}
	
/*****************************************************************************
 * Returns a sample drawn at random from the normal Gaussian distribution 
 * centered at 0.
 *****************************************************************************/ 
double sample() {
	static boolean evenPass = TRUE;
	static double gset;
	double fac, rsq, v1, v2;
	
	if (evenPass) {
		// Executed every other call
		do {
			v1 = (2.0 * rand() / RAND_MAX) - 1.0;
			v2 = (2.0 * rand() / RAND_MAX) - 1.0;
			rsq = v1*v1 + v2*v2;
		} while (rsq >=1.0 || rsq == 0.0);

		fac = sqrt(-2.0*log(rsq)/rsq);
		gset = v1*fac;
		evenPass = FALSE;
		
		return v2*fac;
	} else {
		evenPass = TRUE;
		return gset;
	}
}

/*****************************************************************************
 * Returns a sample drawn at random from the Gaussian distribution with the
 * given mean and standard deviation.
 *****************************************************************************/ 
double gaussian(double mean, double stdev) {
	return sample() * stdev + mean;
}

	