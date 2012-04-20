#ifndef COMMON_H
#define COMMON_H

#define HOSTSIZE 20
#define MAXARGS 40

#define dprint(msg) if(debug){fprintf(stderr, "%s\n", (msg));}

/* exit status of shell (quit arg) */
int exit_status;

/* exit status of last forgound command ($?) */
int cmd_exit_status;

/* character width of the current terminal */
int env_tty_width;

/* prompt count - zsh mode */
int env_com_count;

/* shell user username */
char* env_username;

/* shell hostname */
char env_hostname[HOSTSIZE];

/* current working directory */
char* cwd;

/* debug, xflag, and file flags*/
char debug;
char fileflag;
char xflag;

/* flag for ZSH emulation mode */
int zshmode;

/* PID of last background command ($!) */
int background_pid;

#endif
