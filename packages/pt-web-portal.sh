#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/pi-top/pi-topOS-Web-Portal/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
wget https://github.com/pi-top/pi-topOS-Web-Portal/releases/download/v${LATEST}/pt-web-portal_${LATEST}_all.deb -O $PKGDIR/pt-web-portal_${LATEST}_all.deb
