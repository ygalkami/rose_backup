# Makefile for FTP client/server project in CSSE 432
# Created: Mark Ardis, Rose-Hulman Institute, 8/9/2002
# Modified: Archana Chidanandan, RHIT, 3/14/2007

all:	client 

client:	client.o globals.o
	gcc -o client client.o globals.o -lnsl

client.o: client.c globals.h
	gcc -c client.c -lnsl

globals.o: globals.c globals.h
	gcc -c globals.c -lnsl

clean:
	rm -f *.o