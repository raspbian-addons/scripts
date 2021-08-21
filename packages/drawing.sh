#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
# drawing
LATEST=`curl -s https://api.github.com/repos/maoschanz/drawing/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
wget https://launchpad.net/~cartes/+archive/ubuntu/drawing/+files/drawing_$LATEST-0ubuntu1~hirsute_arm64.deb -O $PKGDIR/drawing-$LATEST-arm64.deb
wget https://launchpad.net/~cartes/+archive/ubuntu/drawing/+files/drawing_$LATEST-0ubuntu1~hirsute_armhf.deb -O $PKGDIR/drawing-$LATEST-armhf.deb

