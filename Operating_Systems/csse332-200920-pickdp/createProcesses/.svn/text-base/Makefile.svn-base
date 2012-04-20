all: myCopy createAndWait2 createAndWait createChild

createAndWait2: createChildAndWait-v2.c
	gcc -o createAndWait2 createChildAndWait-v2.c -g

createAndWait: createChildAndWait.c
	gcc -o createAndWait createChildAndWait.c -g

myCopy: myCopy.c
	gcc -o myCopy myCopy.c -g

createChild: createChild.c
	gcc -o createChild createChild.c -g

clean:
	rm -rf  createAndWait createAndWait2 createChild myCopy *.o *.out
