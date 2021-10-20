#!/bin/bash
PKGDIR="/root/raspbian-addons/debian/pool/"

repo="go-gitea/gitea"
api=$(curl --silent "https://api.github.com/repos/$repo/releases/latest")
new=$(echo $api | grep -Po '"tag_name": "v\K.*?(?=")')

echo "Gitea version to package: $new"

[ ! -d /tmp/dpkg-deb ] && git clone https://github.com/chunky-milk/dpkg-deb.git /tmp/dpkg-deb --quiet

rm -rf /tmp/dpkg-deb

/tmp/dpkg-deb/gitea/build-package
mv /tmp/dpkg-deb/gitea/deb/*.deb $PKGDIR || sudo mv /tmp/dpkg-deb/gitea/deb/*.deb $PKGDIR

rm -rf /tmp/dpkg-deb
