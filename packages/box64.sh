#!/bin/bash
PKGDIR="/root/raspbian-addons/debian/pool/"

if [ ! -f "/etc/apt/sources.list.d/box64.list" ]; then
	echo "box64.list does not exist. adding repo..."
	sudo wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list
	wget -qO- https://ryanfortner.github.io/box64-debs/KEY.gpg | sudo apt-key add -
	sudo apt update
fi
echo "box64.list exists. continuing..."
sudo apt update
apt download box64:arm64
mv box64_* $PKGDIR
