#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"

if [ ! -f "/etc/apt/sources.list.d/box64.list" ]; then
	echo "box64.list does not exist. adding repo..."
	sudo wget https://box64.armlinux.ml/box64.list -O /etc/apt/sources.list.d/box64.list
	wget -qO- https://box64.armlinux.ml/KEY.gpg | sudo apt-key add -
	sudo apt update
fi
echo "box64.list exists. continuing..."
sudo apt update
apt download box64:arm64
mv box64_* $PKGDIR
