#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"

if [ ! -f "/etc/apt/sources.list.d/box86.list" ]; then
	echo "box86.list does not exist. adding repo..."
	sudo wget https://ryanfortner.github.io/box86-debs/box86.list -O /etc/apt/sources.list.d/box86.list
	wget -qO- https://ryanfortner.github.io/box86-debs/KEY.gpg | sudo apt-key add -
	sudo apt update
fi
echo "box86.list exists. continuing..."
sudo apt update
apt download box86:armhf
mv box86_* $PKGDIR
