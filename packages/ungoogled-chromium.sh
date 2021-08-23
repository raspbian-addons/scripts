#!/bin/bash
PKGDIR="/home/pi/raspbian-addons/debian/pool/"
echo "https://download.opensuse.org/repositories/home:/ungoogled_chromium/Debian_Buster/"
if [ ! -f "/etc/apt/sources.list.d/home-ungoogled_chromium.list" ]; then
  echo 'deb http://download.opensuse.org/repositories/home:/ungoogled_chromium/Debian_Buster/ /' | sudo tee /etc/apt/sources.list.d/home-ungoogled_chromium.list > /dev/null
  curl -s 'https://download.opensuse.org/repositories/home:/ungoogled_chromium/Debian_Buster/Release.key' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home-ungoogled_chromium.gpg > /dev/null
  sudo apt update
fi
echo "home-ungoogled_chromium.list exists. continuing..."
sudo apt update
apt download ungoogled-chromium
mv ungoogled-chromium_* $PKGDIR
