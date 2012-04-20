#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <termios.h>
#include <fcntl.h>
#include <sys/stat.h>

#include "common.h"
#include "input_handler.h"
#include "input_parse.h"
#include "builtin.h"
#include "process_handler.h"
#include "env_variables.h"

#ifndef XSSH_H
#define XSSH_H

void init();

void _run_file(char *filename);

#endif
