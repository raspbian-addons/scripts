#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/v2rayA/v2rayA/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
wget https://github.com/v2rayA/v2rayA/releases/download/v${LATEST}/installer_debian_armhf_v${LATEST}.deb -O $PKGDIR/v2raya-${LATEST}-armhf.deb
wget https://github.com/v2rayA/v2rayA/releases/download/v${LATEST}/installer_debian_aarch64_v${LATEST}.deb -O $PKGDIR/v2raya-${LATEST}-arm64.deb
