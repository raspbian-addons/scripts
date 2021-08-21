#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/pi-top/web-renderer/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
wget https://github.com/pi-top/web-renderer/releases/download/v${LATEST}/web-renderer-dbgsym_${LATEST}_armhf.deb -O $PKGDIR/web-renderer-dbgsym_${LATEST}_armhf.deb
wget https://github.com/pi-top/web-renderer/releases/download/v${LATEST}/web-renderer_${LATEST}_armhf.deb -O $PKGDIR/web-renderer_${LATEST}_armhf.deb
