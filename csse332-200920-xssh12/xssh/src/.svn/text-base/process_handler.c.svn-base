/**
 *	process handler - the controller for all background and foreground cmds
 *	
 *	Project: xssh
 *	By: Jon Klein, David Pick, Tim Wentz 
 **/

#include "process_handler.h"

// adds newpid to list of processes, sets variables with pid
int proc_add(pid_t newpid) {
    if(++_psize == _pcap){
      _pcap *= 2;
      _processes = realloc(_processes, _pcap * sizeof(pid_t));
      
      if(_processes == NULL) {
        dprint("realloc of processs table failed");
        exit(1);
      }
    }
    
    _processes[_psize] = newpid;
    background_pid = newpid;
    if(zshmode) printf("[%d] %d\n", _psize + 1, newpid); // zsh emulation, pid of background process
    return 0;
}

// kills all child processes
int proc_killall(void) {
    dprint("killing all processes");
    int i;
    for(i = 0; i <_psize+1; i++) {
      if( (_processes[i]) < 0) {
        continue;
      }
      if(debug) fprintf(stderr, "killing pid %d", _processes[i]);
      kill(_processes[i],SIGKILL);
    }
    return 0;
}

// sets up process storage data structure
int proc_init(void) {
  dprint("initializing processess handler..");
  _pcap = 2;
  _psize = -1;
  _processes = malloc(sizeof(pid_t)*_pcap);
  return 0;
}

// builtin function to wait on processess
int proc_wait(pid_t wpid) {
  dprint("wait command");
  int status = 0;
  
  if(wpid == -1) {
    dprint("wait any");
    // wait any
    waitpid(-1, &status, 0);
  }
    
  else if(wpid == 0) {
    dprint("wait all");
    int i;
    for(i=0; i<_psize+1; i++) {
      if(debug) fprintf(stderr,"waiting on %d\n", _processes[i]);
      if( (_processes[i]) < 0) {
        dprint("process already terminated, skipping..");
        continue;
      }
      waitpid(_processes[i],&status,0);
    }
    proc_init();
  }

  else if(wpid > 0) {
    dprint("wait pid");
    waitpid(wpid, &status, 0);
  }
  
  else {
    dprint("invalid negative non -1 pid");
    return -1;
  }
  
  if(WIFEXITED(status)) {
      cmd_exit_status = WEXITSTATUS(status);  
  }
  
  return status;
}
