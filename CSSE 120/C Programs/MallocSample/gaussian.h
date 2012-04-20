#ifndef GAUSSIAN_H_
#define GAUSSIAN_H_

#endif /*GAUSSIAN_H_*/

/*****************************************************************************
 * Seeds the random number generator with the current time, then dumps a few
 * values since approximately equal seeds yield similar results for the first
 * few random values.
 *****************************************************************************/ 
void seedRandomNumberGenerator();

/*****************************************************************************
 * Returns a sample drawn at random from the gaussian distribution centered
 * at 0 and clipped at -1 and 1.
 *****************************************************************************/ 
double sample();

/*****************************************************************************
 * Returns a sample drawn at random from the Gaussian distribution with the
 * given mean and standard deviation.
 *****************************************************************************/ 
double gaussian(double mean, double stdev);

