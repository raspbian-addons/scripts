#!/bin/bash
cd /root/raspbian-addons/debian/
EMAIL="$(cat /root/email)"
GPGPASS="$(cat /root/gpgpass)"
rm InRelease Release Release.gpg Packages Packages.gz
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages
apt-ftparchive release . > Release
gpg --default-key "${EMAIL}" --batch --pinentry-mode="loopback" --passphrase="$GPGPASS" -abs -o - Release > Release.gpg
gpg --default-key "${EMAIL}" --batch --pinentry-mode="loopback" --passphrase="$GPGPASS" --clearsign -o - Release > InRelease
echo "done"
exit 0
