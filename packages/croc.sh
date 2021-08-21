#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/schollz/croc/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -s https://api.github.com/repos/schollz/croc/releases/latest \
  | grep browser_download_url \
  | grep 'ARM.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/croc-$LATEST-armhf.deb

curl -s https://api.github.com/repos/schollz/croc/releases/latest \
  | grep browser_download_url \
  | grep 'ARM64.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/croc-$LATEST-arm64.deb
