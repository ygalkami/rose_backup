/**
 *	env variables - handles all the environment variable management
 *	
 *	Project: xssh
 *	By: Jon Klein, David Pick, Tim Wentz
 **/

#include "env_variables.h"

/**
 *	Adds an environment var to the list
 *
**/
void env_add(char *var, char *replace) {
  int size = 0;
  if(replace == NULL) replace = "";
  if(debug) fprintf(stderr, "var = %s - replace = %s\n", var, replace);
  extern char **environ;
  
  if(var == NULL){
    while(environ[size+++1] != NULL) {
      printf("\t%s\n", environ[size]);
    }
    return;
  }

  while(replace[size++] != '\0');
  while(var[size++] != '\0');
  char *temp = malloc(sizeof(char)*size + 20);
  
  strcat(temp, var);
  strcat(temp, "=");
  strcat(temp, replace);
  if(debug) fprintf(stderr, "temp = %s\n", temp);
  putenv(temp);
   
  if(debug) fprintf(stderr, "checking %s replacement, it is %s\n", var, getenv(var)); 
}

/**
 *	Removes an environment var from the list
 *
**/
void env_remove(char *var) {
  unsetenv(var);
}

/**
 *	Initialize datastructures for environmental variable storage
 *
**/ 
void env_init() {
  char *envpid = malloc(10*sizeof(char));
  sprintf(envpid,"$=%d",getpid());
  // if(1) fprintf(stderr,"setting %s\n",envpid);
  putenv(envpid);
  
}
