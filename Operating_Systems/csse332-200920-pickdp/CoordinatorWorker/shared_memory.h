#include <stdio.h>
#include <stdlib.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/types.h>

/*
 * Obtain a unique key.
 * Change this value to a unique value that other classmates are not using.
*
extern key_t SH_MEM_KEY;

/*
 * Struct that defines the items that must be placed in shared memory.
 * It consists of two items - the image array and the histogram error.
 * The image array will be populated by the parent process. The 
 * histogram array will populated by the child processes. 
 */

typedef struct {
  int histogram[256];
  int image[32][32];
} sharedMemoryStruct;

void get_shared_memory_child(int *ShmID, sharedMemoryStruct **ShmPTR);
void get_shared_memory_parent(int *ShmID, sharedMemoryStruct **ShmPTR);

