#!/bin/bash

#Regułki z powłoki systemowej. Nie edytować.##################################
lista=`cat $1` 
ilosc=`wc -l $1 | awk {'print $1'}`
i=1;
data_rozp_skan=`date +%H:%M:%S-%d.%m.%y`
if [ -e ~/skaner.log ]
then

	echo "Znaleziono folder z logami. Tworzę nowy katalog sesji";
	mkdir ~/skaner.log/$data_rozp_skan
	sleep 2s;

else

	echo "Plik logów nie został znaleziony. Rozpoczynam tworzenie katalogu";
	mkdir ~/skaner.log
	mkdir ~/skaner.log/$data_rozp_skan
	sleep 2s;

fi
#################################################################################

for x in $lista ; do

	clear;
	echo "Trwa Skanowanie Listy IP. Zeskanowano $i z $ilosc."
	nmap -p 22 $x | grep -i 'tcp' -B 3 >> /tmp/skaner_a.log
	((++i))

done

i=0;
for y in $lista ; do
	data=`date +%H:%M:%S-%D`
	tymczas=`cat /tmp/skaner_a.log | grep -i $y -A 3`
	((++i))
	if [[ $tymczas =~ open ]] ; then
		echo "Host $y o numerze: $i z $ilosc został zeskanowany: $data Ma otwarty port 22 ( open )";
		echo " $y : $i/$ilosc : 22=open : $data" >> ~/skaner.log/$data_rozp_skan/serwery_open.log
	elif [[ $tymczas =~ filtered ]] ; then
		echo "Host $y o numerze: $i z $ilosc został zeskanowany: $data Ma filtrowany port 22 ( filtered )";
		echo " $y : $i/$ilosc : 22=filtered : $data" >> ~/skaner.log/$data_rozp_skan/serwery_filtred.log
	elif [[ $tymczas =~ close ]] ; then
		echo "Host $y o numerze: $i z $ilosc został zeskanowany: $data Ma otwarty zamknięty 22 ( close )";
		echo " $y : $i/$ilosc : 22=close : $data" >> ~/skaner.log/$data_rozp_skan/serwery_close.log
	fi

done

clear
echo "Analizuję dane..."
sleep 5s;

serwery_open_ilosc=`wc ~/skaner.log/$data_rozp_skan/serwery_open.log | awk {'print $1'}`
serwery_close_ilosc=`wc ~/skaner.log/$data_rozp_skan/serwery_close.log | awk {'print $1'}`
serwery_filtred_ilosc=`wc ~/skaner.log/$data_rozp_skan/serwery_filtred.log | awk {'print $1'}`

clear;

echo "Wynik skanowania:";
echo "Otwarte: $serwery_open_ilosc";
echo "Zamknięte: $serwery_close_ilosc";
echo "Filtrowane: $serwery_filtred_ilosc";

#zapis loga jako last log
echo $data_rozp_skan > ~/skaner.log/lastlog.data
cat ~/skaner.log/$data_rozp_skan/serwery_open.log | awk {'print $2'} > ~/skaner.log/lastlog.ip-open
echo "Dane zapisane w ~/skaner.log/lastlog*"
