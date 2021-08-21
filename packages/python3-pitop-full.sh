#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/pi-top/pi-top-Python-SDK/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
wget https://github.com/pi-top/pi-top-Python-SDK/releases/download/v${LATEST}/python3-pitop-full_${LATEST}_all.deb -O $PKGDIR/python3-pitop-full_${LATEST}_all.deb
