/**
 *	builtin commands - all the functions for builtin commands, other than process and env vars commands
 *	
 *	Project: xssh
 *	By: Jon Klein, David Pick, Tim Wentz
 **/
 
#include "builtin.h"

/**
 *	Basic ls command
 *
**/
void com_ls() {
	DIR *dir = opendir(cwd);
	int num_cols = 5;

	if(dir)
	{
		struct dirent **namelist;
		int i = 0, j = 1, n, max = 0;

		n = scandir(cwd, &namelist, 0, alphasort);

		while (i < n) {
			if(namelist[i]->d_name[0] != '.') {
				if(max < strlen(namelist[i]->d_name)) {
					max = strlen(namelist[i]->d_name);
				}
			}
			i++;
		}

		max+=2;
		num_cols = floor(env_tty_width/max);

		i = 0;

		char* format = (char*)malloc(20*sizeof(char));
		sprintf(format, "%s%d%s", "%-", max, "s\033[0m");
		while (i < n) {
			if(namelist[i]->d_name[0] != '.') {
				printf("\033[0m");
				if(namelist[i]->d_type==4) {
					printf("\033[1;32m");
				}
				printf(format, namelist[i]->d_name);
				
				if(j % num_cols == 0 && j != i && j > 1) {
					printf("\n");
				}
				j++;
			}
			free(namelist[i]);
			i++;
		}
		free(namelist);
	}
	else
	{
		fprintf(stderr, "Error opening directory\n");
	}

	printf("\n");
}

void com_cd(char *loc) {
	if(loc == NULL) {
		chdir(getenv("HOME"));
		getcwd(cwd, 500);
	}
	else {
		chdir(loc);
		getcwd(cwd, 500);
	}
}

/**
 *	Set an environment variable
 *
**/
void com_set(char *var, char *replace) {
	if(debug) fprintf(stderr, "builtin - replace %s with %s\n", var, replace);
	env_add(var, replace);
}

/**
 *	Unset an environment variable
 *
**/
void com_unset(char **var, int count) {
	int i = 0;
	for(i = 0; i < count; i++) {
		env_remove(*(var+i));
	}
}

/**
 *	Sets the exit_status and quits the shell
 *
**/
void com_quit(char* status) {
	proc_killall();
	if(strlen(status) > 0) {
		printf("%s\n",status);
	}
	exit_status = 0;
}

/**
 *	Brainfuck interpreter
 *
**/
void com_bf(char *pc) {
	dprint("bf interpreter started");
	if (debug) fprintf(stderr, "program: %s, first %c\n", pc, *pc);
	int i=2000;
	int point=0;
	char *scratch;
	scratch = malloc(i*sizeof(char));
	for(i = 0; i < 2000; *(scratch+i++) = 0);
	dprint("memory initialized");
	
	while(*pc != '\0') {
		switch(*pc) {
			case '>' : point++; break;
			case '<' : if(point) {point--;} break;
			case '+' : ++(scratch[point]); break;
			case '-' : --(scratch[point]); break;
			case '.' : putchar(scratch[point]); break;
			case '#' : printf("%d",scratch[point]); break;
			case ',' : scratch[point]=getchar(); break;
			case '[' : if(!(scratch[point])) while(*(++pc) != ']'); break;
			case ']' : while(*pc-- != '['); break;
			default: if(debug) fprintf(stderr, "bf comment detected: %c\n", pc[0]);
		}
		pc++;
	}
	putchar('\n');
	free(scratch);
}
