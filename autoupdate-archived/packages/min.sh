#!/bin/bash
PKGDIR="/root/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/ryanfortner/minbrowser-arm-builds/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -s https://api.github.com/repos/ryanfortner/minbrowser-arm-builds/releases/latest \
  | grep browser_download_url \
  | grep 'armhf.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/min-$LATEST-armhf.deb

LATEST=`curl -s https://api.github.com/repos/minbrowser/min/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -s https://api.github.com/repos/minbrowser/min/releases/latest \
  | grep browser_download_url \
  | grep 'arm64.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/min-$LATEST-arm64.deb
