#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <time.h>
#include <signal.h>

#include "common.h"

#ifndef PROCESS_HANDLER_H
#define PROCESS_HANDLER_H

pid_t* _processes;
int _psize;
int _pcap;

int proc_add(pid_t newpid);

int proc_kill(pid_t killpid);

int proc_killall(void);

int proc_init(void);

int proc_wait(pid_t waitpid);

#endif
