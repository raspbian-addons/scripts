#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
if [ ! -f "/etc/apt/sources.list.d/home:manuelschneid3r.list" ]; then
	echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/Raspbian_10/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
	curl -fsSL https://download.opensuse.org/repositories/home:manuelschneid3r/Raspbian_10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_manuelschneid3r.gpg > /dev/null
fi
echo ".list file exists. continuing..."
sudo apt update
apt download albert:arm64
apt download albert-dbgsym:arm64
apt download albert:armhf
apt download albert-dbgsym:armhf
mv albert*.deb $PKGDIR
