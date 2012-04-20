# Written By David Pick

all: driver scheduler

scheduler: scheduler.c
	gcc -o scheduler scheduler.c -g
driver: driver.o queue.o
	gcc -o driver driver.o queue.o -g
queue.o: queue.c queue.h
	gcc -c queue.c -g
driver.o: driver.c queue.h
	gcc -c driver.c -g
clean:
	rm *.o driver scheduler

