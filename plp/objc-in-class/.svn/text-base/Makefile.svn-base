LFLAGS = -lobjc

SRC = node.m \
      empty.m \
      main.m

OBJ = $(SRC:%.m=%.o)

EXE = main

all: $(OBJ)
	gcc -o $(EXE) $(OBJ) $(LFLAGS)

%.o : %.m %.h
	gcc -c $(basename $@).m

.PHONY: clean
clean:
	-rm $(OBJ) $(EXE)