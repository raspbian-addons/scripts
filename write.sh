#!/bin/bash
#cd /home/pi/raspbian-addons/debian/
#EMAIL="$(cat /home/pi/email)"
#GPGPASS="$(cat /home/pi/gpgpass)"
#rm InRelease Release Release.gpg Packages Packages.gz
#dpkg-scanpackages --multiversion . > Packages
#gzip -k -f Packages
#apt-ftparchive release . > Release
#gpg --default-key "${EMAIL}" --batch --pinentry-mode="loopback" --passphrase="$GPGPASS" -abs -o - Release > Release.gpg
#gpg --default-key "${EMAIL}" --batch --pinentry-mode="loopback" --passphrase="$GPGPASS" --clearsign -o - Release > InRelease
#echo "done"
#exit 0
