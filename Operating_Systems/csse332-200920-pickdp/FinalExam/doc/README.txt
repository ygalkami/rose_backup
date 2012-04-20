This is the file in which you write your report.
Be sure to include your name in your report.

This scheduling algorithm software was written by David Pick.

Description of the project:
In this project we were asked to implement a Shortest Job Next process
scheduling algorithm.


to run the program run the following command

./scheduler <input file> <scheduling algorithm>

SAMPLE INPUT:
<pid> <arrival time> <service time>
2 0 5
5 1 10

SAMPLE OUTPUT:
Current Time: 0, pid: 2000, Remaining service time: 3
Current Time: 3, pid: 3000, Remaining service time: 6
Current Time: 9, pid: 6000, Remaining service time: 2
Current Time: 11, pid: 4000, Remaining service time: 4
Current Time: 15, pid: 5000, Remaining service time: 5

Turnaround time for process with PID 2000 = 3
Turnaround time for process with PID 3000 = 7
Turnaround time for process with PID 6000 = 3
Turnaround time for process with PID 4000 = 11
Turnaround time for process with PID 5000 = 14

Average turnaround time: 7.60

Difference between Shortest Job Next and Shortest Service Time algorithms:

In the shortest job next algorithm the job with the shortest service time is
run when the previous job finishes.

The difference between the shortest remaining time next and shortest job
next is preemption. In the shortest job next algorithm if a job with a
shorter remaining time enters the ready queue before the current running job
is finish, that process will start running and the currently running process
will be put into the ready queue.

This does not occur in the shortest job next algorithm because once a
process has started running it won't be stopped for another process.