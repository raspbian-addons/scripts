#!/bin/bash
git pull origin master
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
app="$(echo $1)"
#echo "enter app to update (use deb package name): "
#read app
rm -f $PKGDIR/$app*
bash packages/${app}.sh
echo "
Current packages in the repository are:
 "
ls $PKGDIR
bash write.sh
