#!/bin/bash
PKGDIR="/root/raspbian-addons/debian/pool/"

if [ ! -f "/etc/apt/sources.list.d/onedriver-arm64.list" ]; then
	echo "onedriver-arm64.list does not exist. adding repo..."
        echo "deb http://ppa.launchpad.net/papirus/papirus/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/onedriver-arm64.list
      	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D9F7BA8AAB06C5F3B889EBF0E3A37397117B103D
	sudo apt update
fi
echo "onedriver-arm64.list exists. continuing..."
sudo apt update
apt download onedriver:arm64
mv onedriver_*.deb $PKGDIR

if [ ! -f "/etc/apt/sources.list.d/onedriver-armhf.list" ]; then
	echo "onedriver-armhf.list does not exist. adding repo..."
  	echo "deb http://download.opensuse.org/repositories/home:/jstaf/Raspbian_10/ /" | sudo tee /etc/apt/sources.list.d/onedriver-armhf.list
	curl -fsSL https://download.opensuse.org/repositories/home:jstaf/Raspbian_10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_jstaf.gpg > /dev/null
	sudo apt update
fi
echo "onedriver-armhf.list exists. continuing..."
sudo apt update
apt download onedriver:armhf
mv onedriver_*.deb $PKGDIR
