#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/SpacingBat3/WebCord/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -s https://api.github.com/repos/SpacingBat3/WebCord/releases/latest \
  | grep browser_download_url \
  | grep 'armhf.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/webcord-$LATEST-armhf.deb

curl -s https://api.github.com/repos/SpacingBat3/WebCord/releases/latest \
  | grep browser_download_url \
  | grep 'arm64.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/webcord-$LATEST-arm64.deb
