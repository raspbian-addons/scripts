#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/persepolisdm/persepolis/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -s https://api.github.com/repos/persepolisdm/persepolis/releases/latest \
  | grep browser_download_url \
  | grep 'all.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/persepolis-$LATEST-all.deb