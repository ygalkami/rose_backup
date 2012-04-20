/** 
 *	xssh - the main shell executable
 *	
 *	Project: xssh
 *	By: Jon Klein, David Pick, Tim Wentz 
 **/

#include "xssh.h"

int main(int argc, char *argv[]){
	init(argc, argv);
	
	for(;;) {
		// zsh style prompt
		if(zshmode) {
			printf("\033[01;34m[%d] \033[22;32m[\033[01;33m%s\033[22;32m@\033[01;34m%s \033[22;31m%s\033[22;32m] %% ",env_com_count++,env_username,env_hostname, cwd);
		}
		// spec defined prompt
		else {
			printf(">> ");
		}
		// parse input from prompt
		if(parse_input(get())) {
			break;
		}		
	}

	return exit_status;
}

/**
 *	Run the specified script on the shell
 *
**/
void _run_file(char *filename) {
	char b[300];
	
	FILE *script = fopen(filename, "r");
	
	// specified script not found
	if (script == NULL) {
		printf("script not found: %s\n", filename);
		exit(1);
	}
	
	// for each line of the script either skip (blank line) or send to shell input parser
	while (fgets(b, sizeof(b), script)) {
		if (!strcmp(b,"\n")) {
			dprint("blank line detected - skipping");

		} else if (parse_input(b)) {
			dprint("Exit signal recieved");
			exit(exit_status);
		}
	}
}

/**
 *	Run initial preparations for the shell
 *
**/
void init(int argc, char *argv[]) {
	int i;
	char* script;
	
	zshmode = 0;
	debug = 0;
	xflag = 0;
	fileflag = 0;
	
	
	// working directory
	cwd = (char*)malloc(500*sizeof(char));
	getcwd(cwd, 500);
	
	// zsh prompt counter
	env_com_count = 1;
	
	// username and hostname
	env_username = getenv("USER");
	gethostname(env_hostname, HOSTSIZE);

	// get term width
	struct winsize ws;
    	ioctl(STDIN_FILENO, TIOCGWINSZ, &ws);
	env_tty_width = ws.ws_col;
	
	// setup background process handling
	proc_init();
	
	// setup env variables
	env_init();
	
	// set debug, xflag, and fileflag
	if (argc > 1) {	
		for(i=1; i<argc; i++) {
			if(!strcmp(argv[i], "-d") && (i + 1) < argc ) {
				debug = !strcmp(argv[i+++1], "1");
				dprint("debug mode activated");
			}
			
			else if(!strcmp(argv[i], "-x")) {
				xflag = 1;
			}
			
			else if(!strcmp(argv[i], "-zsh")) {
				zshmode = 1;
			}
			
			else if(strcmp(argv[i-1], "-d") && !fileflag) {
				fileflag = 1;
				script = argv[i];
				
				if(i+1 < argc) {
					int j;
					//printf("argc = %d\n", argc);
					for(j = i + 1; j < argc; j++) {
						char *tc = malloc(100 * sizeof(char));
						//char *dollar = malloc(100 * sizeof(char));
						//sprintf(dollar, "%s", "");
						sprintf(tc, "%d", j-i);
						
						//strcat(dollar, tc);
						//strcat(dollar, "=");
						//strcat(dollar, argv[j]);
						//printf("dollar = %s\n", dollar);
						
						env_add(tc, argv[j]);
						
						//putenv(dollar);
						free(tc);
						//free(dollar);
					}
				}
				
				
				_run_file(script);
			}
				
		}
		
		
	}
}
