#!/bin/bash
GPGPATH="/root/gpgpass"
EMAILPATH="/root/email"
cd ~/scripts && git pull origin master && cd ~/scripts/autoupdate
PKGDIR="/root/raspbian-addons/debian/pool/"

if [ ! -f ${GPGPASS} ]; then
  echo "error: gpgpass file not detected, exiting."
  exit 1
fi

if [ ! -f ${EMAIL} ]; then
  echo "error: email file not detected, exiting."
  exit 1
fi

app="$(echo $1)"
#FILES=$(bash -c "ls $PKGDIR | grep $app")
#echo "enter app to update (use deb package name): "
#read app
rm $PKGDIR/${app}_* || rm $PKGDIR/${app}-*
bash packages/${app}.sh
#bash write.sh
echo "Make sure to run write.sh, or the repository will break!"
