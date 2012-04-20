all: worker coordinator


coordinator: coordinator.o shared_memory.o
	gcc -o coordinator coordinator.o shared_memory.o -g

coordinator.o: coordinator.c shared_memory.h  
	gcc coordinator.c -g -c 

worker: worker.o update_histogram.o shared_memory.o
	gcc worker.o update_histogram.o shared_memory.o -g -o worker

worker.o: worker.c update_histogram.h shared_memory.h
	gcc worker.c -c -g

update_histogram.o: update_histogram.c update_histogram.h
	gcc -c update_histogram.c

shared_memory.o: shared_memory.c shared_memory.h
	gcc -c shared_memory.c -g

clean:
	rm -f *.o
