#!/bin/bash
PKGDIR="/root/raspbian-addons/debian/pool/"

if [ ! -f "/etc/apt/sources.list.d/gitea.list" ]; then
	echo "gitea.list does not exist. adding repo..."
	sudo wget https://ryanfortner.github.io/gitea-debs/gitea.list -O /etc/apt/sources.list.d/gitea.list
	wget -qO- https://ryanfortner.github.io/gitea-debs/KEY.gpg | sudo apt-key add -
	sudo apt update
fi
echo "gitea.list exists. continuing..."
LATEST=`curl -s https://api.github.com/repos/go-gitea/gitea/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
sudo apt update
apt download gitea:arm64 || #LATEST=`curl -s https://api.github.com/repos/go-gitea/gitea/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'` && wget https://github.com/chunky-milk/gitea-debs/raw/master/debian/gitea_${LATEST}_arm64.deb
apt download gitea:armhf
mv gitea* $PKGDIR
