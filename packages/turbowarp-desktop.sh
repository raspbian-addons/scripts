#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/TurboWarp/desktop/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
wget https://github.com/TurboWarp/desktop/releases/download/v${LATEST}/TurboWarp-linux-arm64-${LATEST}.deb -O $PKGDIR/turbowarp-desktop_${LATEST}_arm64.deb
wget https://github.com/TurboWarp/desktop/releases/download/v${LATEST}/TurboWarp-linux-armv7l-${LATEST}.deb -O $PKGDIR/turbowarp-desktop_${LATEST}_armhf.deb