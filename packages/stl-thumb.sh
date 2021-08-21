#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/unlimitedbacon/stl-thumb/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
wget https://github.com/unlimitedbacon/stl-thumb/releases/download/v${LATEST}/stl-thumb_${LATEST}_arm64.deb -O $PKGDIR/stl-thumb_${LATEST}_arm64.deb
wget https://github.com/unlimitedbacon/stl-thumb/releases/download/v${LATEST}/stl-thumb_${LATEST}_armhf.deb -O $PKGDIR/stl-thumb_${LATEST}_armhf.deb
