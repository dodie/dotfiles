#!/bin/sh

num_of_network_interfaces=`ifconfig -a | sed 's/[ \t].*//;/^$/d' | grep -vE "lo|docker" | wc -l`
if [ "1" -eq $num_of_network_interfaces ] ; then
  network_interface=`ifconfig -a | sed 's/[ \t].*//;/^$/d' | grep -vE "lo|docker"`
else
  network_interface=`ifconfig -a | sed 's/[ \t].*//;/^$/d' | grep -vE "lo|docker" | dmenu`
fi
konsole -e slurm -i $network_interface
