all: myCopy processes

myCopy: myCopy.c
	gcc -o myCopy myCopy.c -g
	
processes: processes.c
	gcc -o processes processes.c -lm -g
	
clean:
	rm -rf processes myCopy