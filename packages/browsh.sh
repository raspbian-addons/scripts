#!/bin/bash
PKGDIR="/root/raspbian-addons/debian/pool/"
# browsh
LATEST=`curl -s https://api.github.com/repos/browsh-org/browsh/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -s https://api.github.com/repos/browsh-org/browsh/releases/latest \
  | grep browser_download_url \
  | grep 'armv7.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/browsh-$LATEST-armhf.deb

curl -s https://api.github.com/repos/browsh-org/browsh/releases/latest \
  | grep browser_download_url \
  | grep 'arm64.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/browsh-$LATEST-arm64.deb
