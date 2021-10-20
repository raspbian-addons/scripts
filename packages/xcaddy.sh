#!/bin/bash
PKGDIR="/root/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/caddyserver/xcaddy/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -s https://api.github.com/repos/caddyserver/xcaddy/releases/latest \
  | grep browser_download_url \
  | grep 'armv7.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/xcaddy-$LATEST-armhf.deb

curl -s https://api.github.com/repos/caddyserver/xcaddy/releases/latest \
  | grep browser_download_url \
  | grep 'arm64.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/xcaddy-$LATEST-arm64.deb
