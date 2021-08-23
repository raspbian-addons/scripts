#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
#LATEST=`curl -s https://api.github.com/repos/PapirusDevelopmentTeam/papirus-icon-theme/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
#wget https://launchpad.net/~papirus/+archive/ubuntu/papirus/+files/papirus-icon-theme_$LATEST-5385+pkg21~ubuntu21.10.1_all.deb -O $PKGDIR/papirus-icon-theme-$LATEST.deb

if [ ! -f "/etc/apt/sources.list.d/papirus-icon-theme.list" ]; then
	echo "papirus-icon-theme.list does not exist. adding repo..."
  echo "deb http://ppa.launchpad.net/papirus/papirus/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/papirus-icon-theme.list
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9461999446FAF0DF770BFC9AE58A9D36647CAE7F
	sudo apt update
fi
echo "papirus-icon-theme.list exists. continuing..."
sudo apt update
sudo apt download papirus-icon-theme
mv papirus-icon-theme_*.deb $PKGDIR
