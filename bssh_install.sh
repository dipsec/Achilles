#!/bin/bash
# Por Jarlley Ribeiro - 0fx66

clear
echo "  [        Brute install                  ]"
echo "  [       0fx66 - www.0fx66.blogspot.com  ]"
echo ""
echo " [*]  Downloadind BruteSSH. Please Wait..."
wget http://www.edge-security.com/soft/brutessh-0.5.tar.bz2 1> /dev/null 2> /dev/stdout
echo " [*]  Unpacking Brutessh. Please Wait..."
tar -jxvf brutessh-0.5.tar.bz2 1> /dev/null 2> /dev/stdout
echo " [*]  OK!"
echo " [*]  To run, use: python brutessh.py"
echo "  Exiting.."
