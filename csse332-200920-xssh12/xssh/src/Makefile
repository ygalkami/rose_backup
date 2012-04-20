## The name of the C compiler.  The default is gcc
CC = gcc

## -g Tells compiler to include extra debugging informaton in its output
## -Wall Give warnings of constructs that look suspect
CFLAGS = -g -Wall 

## A list of options to pass to the linker. 
LDFLAGS = -lm

## Name the executable program, list header files and source files
PROG = xssh
HDRS = $(wildcard *.h)
SRCS = $(wildcard *.c)

## Give the object files the same names as the source files.
## Only change the extension from .c to .o.
OBJS = $(SRCS:.c=.o)

## Build the program from the object files
$(PROG): $(OBJS)
	$(CC) $(LDFLAGS) -o $(PROG) $(OBJS) 

## Rules for the source files.  They compile each X.c to make X.o
%.o: %.c %.h $(HDRS)
	$(CC) $(CFLAGS) -c -o $@ $<

## Remove all the compilation and debugging files
clean: 
	rm -f core $(PROG) $(OBJS)
## make test, make then run in debug mode
test:
	make
	./xssh -d 1 -x