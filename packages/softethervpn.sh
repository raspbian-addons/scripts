#!/bin/bash
PKGDIR="/root/raspbian-addons/debian/pool/"
if [ ! -f /etc/apt/sources.list.d/softethervpn.list ]; then
	echo "softethervpn.list does not exist. creating now..."
	sudo bash -c "echo deb http://ppa.launchpad.net/paskal-07/softethervpn/ubuntu impish main > /etc/apt/sources.list.d/softethervpn.list"
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A36194BE91291215
	sudo apt update 
fi
sudo apt update
apt download softether-common:arm64
apt download softether-common:armhf
#apt download softether-vpn:arm64
#apt download softether-vpn:armhf
apt download softether-vpnbridge:arm64
apt download softether-vpnbridge:armhf
apt download softether-vpnclient:arm64
apt download softether-vpnclient:armhf
apt download softether-vpncmd:arm64
apt download softether-vpncmd:armhf
apt download softether-vpnserver:arm64
apt download softether-vpnserver:armhf
mv softether* $PKGDIR/
