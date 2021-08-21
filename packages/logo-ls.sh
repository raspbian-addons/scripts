#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
# logo-ls
LATEST=`curl -s https://api.github.com/repos/Yash-Handa/logo-ls/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -s https://api.github.com/repos/Yash-Handa/logo-ls/releases/latest \
  | grep browser_download_url \
  | grep 'armv6.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/logo-ls-$LATEST-armhf.deb

curl -s https://api.github.com/repos/Yash-Handa/logo-ls/releases/latest \
  | grep browser_download_url \
  | grep 'arm64.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/logo-ls-$LATEST-arm64.deb
