#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/RasmusLindroth/tut/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
wget https://packages.azlux.fr/debian/pool/main/t/tut/tut_${LATEST}_arm64.deb -O $PKGDIR/tut_${LATEST}_arm64.deb
wget https://packages.azlux.fr/debian/pool/main/t/tut/tut_${LATEST}_armhf.deb -O $PKGDIR/tut_${LATEST}_armhf.deb