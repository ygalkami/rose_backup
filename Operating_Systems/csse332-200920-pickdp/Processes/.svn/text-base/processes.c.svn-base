/* This is where you implement the core solution.
   by David Pick, 12/17/08
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/time.h>
#include <math.h>

int main (int argc, char* argv[]) {
  int nump, count = 0;
  int *times;
  double avg, stdd;
  int fork_pid, my_pid, time, max = 0, min = 0;
  char infilename[100], outfilename[100];
  struct timeval tt, tt2;
  time_t curtime;
  
  //ask for # of processes and files  
  printf("Enter the number of processes you would like to spawn: "); scanf("%d", &nump);
  //nump = atoi(argv[1]);
  //printf("Enter the input file: "); scanf("%s", infilename);
  //printf("Enter the output file: "); scanf("%s", outfilename);
  
  //create array to store times
  times = malloc(nump * sizeof(int));	
  
  //get initial time
  gettimeofday(&tt, NULL);
  
  //create process and do everything else
  while (count < nump && fork_pid != 0) {
    struct timeval tv, tv2;
    gettimeofday(&tv, NULL);
    
    //create child process
    fork_pid = fork();
    
    //make sure the process was created successfully
    if (fork_pid < 0 ) {
      fprintf(stderr, "Fork failed\n");
      exit(-1);
    }
    
    //get the processes pid
    my_pid = getpid();
    
    //if it is a child process, print the pid and number, and run the mycopy program
    if (fork_pid == 0) {
      printf("I am a child process with pid: %d and number %d / %d\n", my_pid, count + 1, nump);
      execl("./myCopy", "myCopy", "in.txt", "out.txt", NULL);
      
    }
    //this is the parent process 
    else {
      //wait for the child process to end
      waitpid(fork_pid, NULL, 0);
      //measure the time it took to run
      gettimeofday(&tv2, NULL);
      time = (tv2.tv_sec*1000000+tv2.tv_usec)-(tv.tv_sec*1000000+tv.tv_usec);
      //print some information and store the time in array for calculations later
      printf("This is the parent. The child with pid: %d took %d to run\n", fork_pid, time);
      times[count] = time;
    }
    count = count + 1;
  }
  //find, min, max, avg, and stdd for child processess
  if (fork_pid != 0) {
    mathCalcs(times, &max, &min, &avg, &stdd, nump);
    printf("Max: %d\nMin: %d\nMean: %f\nStandard Deviation: %f\n", max, min, avg, stdd);  
  
  //find how long the parent took to run
    gettimeofday(&tt2, NULL);
    time = (tt2.tv_sec*1000000+tt2.tv_usec) - (tt.tv_sec*1000000+tt.tv_usec);
    printf("The parent process took %d", time);
  }
  return 0;
}

//function to calculate min, max, avg, and standard deviation
void mathCalcs(int *array, int *max, int *min, double *avg, double *stdd, int n) {
  int i = 0, sum = 0;
  
  for (i = 0; i < n; i++) {
    //printf("%d\n", array[i]);
    if (array[i] > *max)
      *max = array[i];
    
    if (array[i] < *min || i == 0)
      *min = array[i];
      
    sum += array[i];
  }
  
  *avg = sum / n;
  int tempstdev = 0;
  for (i = 0; i < n; i++) {
    tempstdev += (array[i] - *avg) * (array[i] - *avg);
  }
  
  *stdd = tempstdev / n;
  *stdd = sqrt(*stdd);
}