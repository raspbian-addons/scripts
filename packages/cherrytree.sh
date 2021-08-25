#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
# cherrytree
#the -3 at the end of the version number causes this to not work
#LATEST=`curl -s https://api.github.com/repos/giuspen/cherrytree/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
#https://launchpad.net/~giuspen/+archive/ubuntu/ppa/+files/cherrytree_0.99.40-3_arm64.deb
#echo "does not work yet."
if [ ! -f "/etc/apt/sources.list.d/cherrytree.list" ]; then
	echo "cherrytree.list does not exist. adding repo..."
  echo "deb http://ppa.launchpad.net/giuspen/ppa/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/cherrytree.list
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A98E8BBCABCF6A49A5DA2F43B8668B055FE1EFE4
	sudo apt update
fi
echo "cherrytree.list exists. continuing..."
sudo apt update
sudo apt download cherrytree:arm64
mv cherrytree_*.deb $PKGDIR
