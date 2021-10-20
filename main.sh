#!/bin/bash
GPGPATH="/home/root/gpgpass"
EMAILPATH="/home/root/email"
git pull origin master
PKGDIR="/home/root/raspbian-addons/debian/pool/"

if [ ! -f ${GPGPASS} ]; then
  echo "error: gpgpass file not detected, exiting."
  exit 1
fi

if [ ! -f ${EMAIL} ]; then
  echo "error: email file not detected, exiting."
  exit 1
fi

app="$(echo $1)"
#echo "enter app to update (use deb package name): "
#read app
rm -f $PKGDIR/$app*
bash packages/${app}.sh
#bash write.sh
echo "Make sure to run write.sh, or the repository will break!"
