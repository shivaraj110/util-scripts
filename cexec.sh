#!/bin/bash
gcc -o cexec $1
./cexec $2 $3
sleep 300 && rm -rf cexec && notify-send "removed binary file"
