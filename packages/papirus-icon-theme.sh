#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
LATEST=`curl -s https://api.github.com/repos/PapirusDevelopmentTeam/papirus-icon-theme/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
wget https://launchpad.net/~papirus/+archive/ubuntu/papirus/+files/papirus-icon-theme_$LATEST-5385+pkg21~ubuntu21.10.1_all.deb -O $PKGDIR/papirus-icon-theme-$LATEST.deb
