#include <stdio.h>
#include <termios.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>

#include "common.h"

#ifndef INPUT_HANDLER_H
#define INPUT_HANDLER_H

typedef struct {
	char *buf;
	int curpos;
	int len;
} line;

char* get();

void _rmchar(line *l);

void _pchar(char c, line *l);

void _pstr(char *str, line *l);

void _newline(line *l, int bufsize);

char* _getTabPrefix(line *l);

#endif
