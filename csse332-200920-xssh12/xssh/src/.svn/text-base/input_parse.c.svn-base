/**
 *	Input Parser - Takes a string and parses it for strings
 *	
 *	Project: xssh
 *	By: Jon Klein, David Pick, Tim Wentz
 **/

#include "input_parse.h"

int parse_input(char *ret)
{
	int argc = 0;
	int i;
	
	int backp = 0;
	int ordr = 0;
	int irdr = 0;
	int defout;
	int fd;
	
	char input[env_tty_width];
	
	char *tokenized[MAXARGS], *pch, *temp;
	strcpy(input, ret);
	
	//FILE *redirectFile = NULL;
	
	
	
	// scan through words checking for important symbols/special cases
	for(pch = strtok (input, " "); pch != NULL; pch = strtok(NULL, " ")) {
		if (pch[0] == '#') {
			break;
		}
		
		if (pch[0] == '<') {
			irdr = 1;
			temp = pch;
			temp++;
			fd = open(temp, O_RDWR | O_CREAT);
			defout = dup(0);
			dup2(fd, 0);
			close(fd);
			continue;
		}
		
		if (pch[0] == '>') {
			ordr = 1;
			temp = pch;
			temp++;
			fd = open(temp, O_RDWR | O_CREAT);
			defout = dup(1);
			dup2(fd, 1);
			close(fd);
			continue;
		}
		
		if (pch[0] == '&') {
			backp = 1;
			continue;
		}
		
		if (pch[0] == '$') {
			tokenized[argc] = getenv(++pch);
			if(tokenized[argc++]==NULL)  {
				printf("warning, environmental variable %s not set, aborting command\n", pch);
				goto end;
			}
			continue;
		}
		tokenized[argc++] = pch;	
	}
	
	
	// skip to end if the line is blank, fix up end of tokenized with NULL
	if(!argc) goto end;
	tokenized[argc] = NULL;
	
	// display command after variable substitution of -x flag was passed
	if(xflag) {
		for (i = 0; i < argc; i++) {
			printf("%s%c", tokenized[i], (i == argc-1) ? '\n' : ' ');
		}
	}
	
	// check for builtin commands, call as needed
	if(!strcmp(tokenized[0], "quit") || !strcmp(tokenized[0], "exit")) {
		if(argc == 2) {
			exit_status = atoi(tokenized[1]);
		}
		
		else {
			exit_status = cmd_exit_status;
		}
		proc_killall();
		return 1;
	}
	
	else if(!strcmp(tokenized[0], "set")) {
		if(debug) fprintf(stderr, "xssh - set %s as %s\n", tokenized[1], tokenized[2]);
		com_set(tokenized[1], tokenized[2]);
	}
	
	else if(!strcmp(tokenized[0], "unset")) {
		com_unset(tokenized+1, argc-1);
	}
	
	else if(!strcmp(tokenized[0], "wait")) {
		cmd_exit_status = proc_wait( tokenized[1] != NULL ? atoi(tokenized[1]) : 0);
	}
	
	else if(!strcmp(tokenized[0], "cd") || !strcmp(tokenized[0], "chdir")) {
		com_cd(tokenized[1]);
	}
	
	else if(!strcmp(tokenized[0], "ls")) {
		com_ls();
		//close(file);
	}
	
	else if(!strcmp(tokenized[0], "sl")) {
		int temp;
		scanf("%d", &temp);
		printf("%d", temp);
	}
	
	else if(!strcmp(tokenized[0], "bf")) {
		if(tokenized[1] != NULL) com_bf(tokenized[1]);
	}
	
	else if(!strcmp(tokenized[0], "echo")) {
		for(i=1;i<argc;i++) {
			printf("%s%c",tokenized[i],i != (argc-1) ? ' ' : '\n');
		}
	}
	
	
	// if the command is not builtin, look for it in the path. spawn in the background if requested
	else if(strlen(ret) > 0) {
		pid_t fpid = fork();
		int cstatus;
		if(!fpid) {
			execvp(tokenized[0],tokenized);
			printf("xssh: command not found: %s\n", tokenized[0]);
			dprint("child process failed to spawn command");
			exit(1);
		}
		
		else {
			if(fpid == -1) {
				dprint("fork failed, unable to create child process");
				exit(1);
			}
			else if (!backp) {
					wait(&cstatus);
					if(WIFEXITED(cstatus)) {
						cmd_exit_status = WEXITSTATUS(cstatus);
						char *tempenv = malloc(10*sizeof(char));
						sprintf(tempenv, "?=%d", cmd_exit_status);
						if(debug) fprintf(stderr, "setting %s\n", tempenv);
						putenv(tempenv);
					}
			}
			else {
				proc_add(fpid);
				if(debug) fprintf(stderr,"\n parent - spawned pid %d",fpid);
				
				char *tempenv = malloc(10*sizeof(char));
				sprintf(tempenv, "!=%d", fpid);
				if(debug) fprintf(stderr, "setting %s\n", tempenv);
				putenv(tempenv);
				
			}
		}
	}
	
	if (irdr == 1)
		dup2(defout, 0);
	if (ordr == 1)
		dup2(defout, 1);
	close(fd);
	close(defout);
	end: return 0;
}
