/* This is where you implement the core solution.
   by David Pick, 1/12/09
*/
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/time.h>
#include <sys/types.h>
#include <math.h>
#include "threads.h"

//function to be executed by thread
void *execute_thread(void *arg) {
  //cast arugments to struct and print info
  stuffpassed *p = (stuffpassed *) arg;
  printf("this is child number %d with tid #%u\n", (p->n) + 1, (unsigned int) pthread_self());
  
  int charsRead;
  char fileChars[500];
  charsRead = ReadFromFile(p->inFile, fileChars);
  WriteToFile(p->outFile, fileChars, charsRead);
}

int main(int argc, char* argv[]) {
  pthread_t thread1;
  int *times;
  int iret1, x, numt, time, tid, count = 0;
  double avg, stdd;
  int max = 0, min = 0;
  struct timeval tt, tt2, tv, tv2;
  stuffpassed stuff;
  time_t curtime;
  
  //make sure correct arguments are passed
  if (argc != 4) {
    printf("Usage: ./thread num_threads in_file out_file");
    exit(0);
  }
  
  //get current time
  gettimeofday(&tt, NULL);
  
  //parse command line arguments
  numt = atoi(argv[1]);
  stuff.inFile = argv[2];
  stuff.outFile = argv[3];
  times = malloc(numt * sizeof(int));
  
  //create threads
  for (x = 0; x < numt; x++) {  
    stuff.n = count;
    //get initial time
    gettimeofday(&tv, NULL);
    //create thread and wait for it to run
    iret1 = pthread_create( &thread1, NULL, execute_thread, &stuff);
    pthread_join( thread1, NULL);
    //get end time for thread
    gettimeofday(&tv2, NULL);
    time = (tv2.tv_sec*1000000+tv2.tv_usec)-(tv.tv_sec*1000000+tv.tv_usec);
    times[count] = time;
    //print running time of thread
    printf("this is the parent with tid #%u this thread took %d to run\n", (unsigned int) pthread_self(), time);
    count++;
  }
  
  //do some math on the information gathered from the threads
  mathCalcs(times, &max, &min, &avg, &stdd, numt);
  printf("Max: %d\nMin: %d\nMean: %f\nStandard Deviation: %f\n", max, min, avg, stdd);
  
  gettimeofday(&tt2, NULL);
  
  //print the total running time for the parent process
  time = (tt2.tv_sec*1000000+tt2.tv_usec)-(tt.tv_sec*1000000+tt.tv_usec);
  printf("The parent took %d to run.", time);

  return 0;
}

//do math calculations
void mathCalcs(int *array, int *max, int *min, double *avg, double *stdd, int n) {
  int i = 0, sum = 0;

  for (i = 0; i < n; i++) {
    if (array[i] > *max)
      *max = array[i];
    
    if (array[i] < *min || i == 0)
      *min = array[i];
      
    sum += array[i];
  }
  
  *avg = sum / n;
  int tempstdev = 0;
  for ( i = 0; i < n; i++) {
    tempstdev += (array[i] - *avg) * (array[i] - *avg);
  }
  
  *stdd = tempstdev / n;
  *stdd = sqrt(*stdd);
}

//functions from the myCopy program
int ReadFromFile(char filename[], char *chars) {
  int charsRead = 0;
  FILE * readFile = NULL;
  readFile = fopen(filename, "r");
  if (readFile == NULL) {
    perror(filename);
    exit(3);
  }
  charsRead = fread(chars, 1, 500, readFile);
  return charsRead;
}

int WriteToFile(char filename[], char *chars, int n) {
  FILE * writeFile = NULL;
  writeFile = fopen(filename, "w");
  if (writeFile == NULL) {
    perror(filename);
    exit(3);
  }
  fwrite(chars, 1, n, writeFile);
  return 1;
}