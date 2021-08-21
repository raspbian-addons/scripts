#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/ncarlier/webhookd/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`

wget https://packages.azlux.fr/debian/pool/main/w/webhookd/webhookd_${LATEST}_arm64.deb -O $PKGDIR/webhookd-${LATEST}-arm64.deb
wget https://packages.azlux.fr/debian/pool/main/w/webhookd/webhookd_${LATEST}_armhf.deb -O $PKGDIR/webhookd-${LATEST}-armhf.deb
