#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
if [ ! -f "/etc/apt/sources.list.d/network:messaging:xmpp:dino.list" ]; then
	echo 'deb http://download.opensuse.org/repositories/network:/messaging:/xmpp:/dino/Raspbian_10/ /' | sudo tee /etc/apt/sources.list.d/network:messaging:xmpp:dino.list
	curl -fsSL https://download.opensuse.org/repositories/network:messaging:xmpp:dino/Raspbian_10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/network_messaging_xmpp_dino.gpg > /dev/null
fi
echo ".list file exists. continuing..."
sudo apt update
apt download dino:armhf
apt download dino-dbgsym:armhf
apt download dino-dev:armhf
mv dino*.deb $PKGDIR
