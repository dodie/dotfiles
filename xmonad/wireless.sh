#!/bin/sh

wlanid=`iwconfig 2>&1 | grep IEEE | awk '{print $1}'`

iwconfig $wlanid 2>&1 | grep -q no\ wireless\ extensions\. && {
  echo Wired
  exit 0
}

essid=`iwconfig $wlanid | awk -F '"' '/ESSID/ {print $2}'`
stngth=`iwconfig $wlanid | awk -F '=' '/Quality/ {print $2}' | cut -d '/' -f 1`
bars=`expr $stngth / 10`

case $bars in
  0)  bar='[----------]' ;;
  1)  bar='[/---------]' ;;
  2)  bar='[//--------]' ;;
  3)  bar='[///-------]' ;;
  4)  bar='[////------]' ;;
  5)  bar='[/////-----]' ;;
  6)  bar='[//////----]' ;;
  7)  bar='[///////---]' ;;
  8)  bar='[////////--]' ;;
  9)  bar='[/////////-]' ;;
  10) bar='[//////////]' ;;
  *)  bar='Not connected' ;;
esac

echo $essid $bar

exit 0
