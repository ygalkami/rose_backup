/*************************************************************
 * This is the file in which you will implement your solution.
* By David Pick, on 2/19/09.
 ************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>


typedef struct {
	int Atime;
	int pid;
	int Stime;
	int done;
	int Ttime;
} process;




int main(int argc, char* argv[] ){
	int j = 0, i = 0, time = 0, total = 0, processesLeft = 0;
	int pid, Atime, Stime;
	float avg = 0;

	printf("This process scheduler was written by David Pick on 2/19/09\n");
	

	process processArray[1000];
	int inorder[1000];
	
	if (argc != 3) {
		printf("You must pass two arguments\n");
		exit(1);
	}
	
	if (strcmp(argv[2],  "SJN") == 1) {
		printf("This program does not handle that scheduling algorithm");
		exit(1);
	}
	
	FILE *inFile = fopen(argv[1], "r");
	
	if (inFile == NULL) {
		printf("You must pass a valid file.\n");
		exit(1);
	}
	
	
	while(fscanf(inFile, "%d %d %d", &pid, &Atime, &Stime) != EOF) {
		processArray[i].Atime = Atime;
		processArray[i].pid = pid;
		processArray[i].Stime = Stime; 
		processArray[i].done = 0;
		i++;
	}

	printf("\n");

	int previousTime;
	for (j = 0; j < i; j++) {
		inorder[j] = shortest(processArray, time, i);
		printf("Current Time: %d, pid: %d, Remaining service time: %d\n", time, processArray[inorder[j]].pid, processArray[inorder[j]].Stime);
		time += processArray[inorder[j]].Stime;
		processArray[inorder[j]].done = 1;
		processArray[inorder[j]].Ttime = time - processArray[inorder[j]].Atime;
	}
	
	printf("\n");
	
	for (j = 0; j < i; j++) {
		printf("Turnaround time for process with PID %d = %d\n", processArray[inorder[j]].pid, processArray[inorder[j]].Ttime);
		avg += processArray[inorder[j]].Ttime;
	}
	
	printf("\nAverage turnaround time: %.2f\n", avg / i);
	
	return 0;
}

int shortest(process array[], int time, int numProcesses) {
	int i = 0, shortestID;
	while(array[i].done != 0) i++;
	process shortest = array[i];
	shortestID = 0;
	
	for (i = 0; i < numProcesses; i++) {
		if (array[i].done == 0) {
			if (array[i].Stime <= shortest.Stime  && array[i].Atime <= time) {
				shortestID = i;
			}
		}
	}
	
	return shortestID;
}

