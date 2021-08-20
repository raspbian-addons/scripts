#!/bin/bash
mkdir -p ~/raspbian-addons/debian/pool
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
echo "enter app to update (use deb package name): "
read app
rm -f $PKGDIR/$APP*
bash packages/$app
