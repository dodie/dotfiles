#!/bin/sh

network_interface=`ifconfig -a | sed 's/[ \t].*//;/^$/d' | grep -vE "lo|docker" | dmenu`
konsole -e slurm -i $network_interface
