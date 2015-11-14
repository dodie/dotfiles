#!/bin/sh
volume=`amixer -D pulse sget Master | awk -F"[][]" '/%/ { print $2 }' | head -n 1 | sed -e 's/%//g'`
bars=`expr $volume / 10`

case $bars in
  0)  bar='[----------]' ;;
  1)  bar='[>---------]' ;;
  2)  bar='[>>--------]' ;;
  3)  bar='[>>>-------]' ;;
  4)  bar='[>>>>------]' ;;
  5)  bar='[>>>>>-----]' ;;
  6)  bar='[>>>>>>----]' ;;
  7)  bar='[>>>>>>>---]' ;;
  8)  bar='[>>>>>>>>--]' ;;
  9)  bar='[>>>>>>>>>-]' ;;
  10) bar='[>>>>>>>>>>]' ;;
  *)  bar='[----!!----]' ;;
esac

echo $bar

exit 0
