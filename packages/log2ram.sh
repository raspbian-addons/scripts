#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/azlux/log2ram/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
wget http://packages.azlux.fr/debian/pool/main/l/log2ram/log2ram_${LATEST}_all.deb -O $PKGDIR/log2ram-$LATEST-all.deb
