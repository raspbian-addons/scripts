#!/bin/bash
PKGDIR="/root/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/caddyserver/caddy/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
curl -s https://api.github.com/repos/caddyserver/caddy/releases/latest \
  | grep browser_download_url \
  | grep 'armv7.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/caddy-$LATEST-armhf.deb

curl -s https://api.github.com/repos/caddyserver/caddy/releases/latest \
  | grep browser_download_url \
  | grep 'arm64.deb"' \
  | cut -d '"' -f 4 \
  | xargs -n 1 curl -L -o $PKGDIR/caddy-$LATEST-arm64.deb
