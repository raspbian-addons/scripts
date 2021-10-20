#!/bin/bash
PKGDIR="/root/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/qier222/YesPlayMusic/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -s https://api.github.com/repos/qier222/YesPlayMusic/releases/latest \
  | grep browser_download_url \
  | grep 'armv7l.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/yesplaymusic-$LATEST-armhf.deb
