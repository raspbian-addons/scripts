#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/sharkwouter/minigalaxy/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -s https://api.github.com/repos/sharkwouter/minigalaxy/releases/latest \
  | grep browser_download_url \
  | grep 'all.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/minigalaxy-$LATEST-all.deb
