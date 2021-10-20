#!/bin/bash
PKGDIR="/root/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/raspberrypi/rpi-imager/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
wget http://archive.raspberrypi.org/debian/pool/main/r/rpi-imager/rpi-imager-dbgsym_${LATEST}_arm64.deb -O $PKGDIR/rpi-imager-dbgsym_${LATEST}_arm64.deb
wget http://archive.raspberrypi.org/debian/pool/main/r/rpi-imager/rpi-imager-dbgsym_${LATEST}_armhf.deb -O $PKGDIR/rpi-imager-dbgsym_${LATEST}_armhf.deb
wget http://archive.raspberrypi.org/debian/pool/main/r/rpi-imager/rpi-imager_${LATEST}_arm64.deb -O $PKGDIR/rpi-imager_${LATEST}_arm64.deb
wget http://archive.raspberrypi.org/debian/pool/main/r/rpi-imager/rpi-imager_${LATEST}_armhf.deb -O $PKGDIR/rpi-imager_${LATEST}_armhf.deb
