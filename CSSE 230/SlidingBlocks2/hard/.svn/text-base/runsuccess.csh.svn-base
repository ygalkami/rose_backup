#!/bin/csh
# usage: runsuccess initfile goalfile, where there is a solution
limit cputime 120
set CLASSPATH = '..:../lib'
/bin/rm -f /tmp/out${$}
echo $1 " " $2
java -cp ${CLASSPATH} Solver ${1} ${2} > /tmp/out${$}
if ($status != 0) echo "*** incorrect status"
java -cp ${CLASSPATH} Checker ${1} ${2} < /tmp/out$$
if ($status != 0) echo "*** incorrect solver output"
/bin/rm -f /tmp/out$$
echo " "
