#include <stdio.h>
#include <sys/types.h>
#include <dirent.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <sys/wait.h>

#include "common.h"
#include "process_handler.h"
#include "env_variables.h"

#ifndef BUILTIN_H
#define BUILTIN_H

void com_ls();

void com_cd(char *loc);

void com_quit(char* status);

void com_set(char *var, char *replace);

void com_unset(char **var, int count);

void com_bf(char *prog);

#endif
