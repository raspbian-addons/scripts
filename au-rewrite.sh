#!/bin/bash

#########################################
#            au-rewrite.sh              #
# downloads and writes certain packages #
#           every 24 hours              #
#########################################

PKGDIR="/root/raspbian-addons/debian/pkgs_incoming/"
DATEA="$(date)"

# print the date to console (for logging purposes)
echo $DATEA

# ensure folder for downloads is available
mkdir -p ~/dlfiles
cd ~/dlfiles
rm -rf *

# create data directory, for storing the version.txt file
mkdir -p $HOME/dlfiles-data

# ensure armhf arch is added
sudo dpkg --add-architecture armhf

function error {
  echo -e "\e[91m$1\e[39m"
  exit 1
}

function redtext {
  echo -e "\e[91m$1\e[39m"
}

echo "Updating codium."
CODIUM_API=`curl -s https://api.github.com/repos/VSCodium/VSCodium/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
CODIUM_DATAFILE="$HOME/dlfiles-data/codium.txt"
if [ ! -f "$CODIUM_DATAFILE" ]; then
    echo "$CODIUM_DATAFILE does not exist."
    echo "Grabbing the latest release from GitHub."
    echo $CODIUM_API > $CODIUM_DATAFILE
fi
CODIUM_CURRENT="$(cat ${CODIUM_DATAFILE})"
if [ "$CODIUM_CURRENT" != "$CODIUM_API" ]; then
    echo "codium isn't up to date. updating now..."
    curl -s https://api.github.com/repos/VSCodium/VSCodium/releases/latest \
      | grep browser_download_url \
      | grep 'armhf.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o codium_${CODIUM_API}_armhf.deb || error "Failed to download the codium:armhf"

    curl -s https://api.github.com/repos/VSCodium/VSCodium/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o codium_${CODIUM_API}_arm64.deb || error "Failed to download codium:arm64"

    mv codium* $PKGDIR
    echo $CODIUM_API > $CODIUM_DATAFILE
    echo "codium downloaded successfully."
fi
echo "codium is up to date."

echo "Updating goreleaser."
GORELEASER_API=`curl -s https://api.github.com/repos/goreleaser/goreleaser/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
GORELEASER_DATAFILE="$HOME/dlfiles-data/goreleaser.txt"
if [ ! -f "$GORELEASER_DATAFILE" ]; then
    echo "$GORELEASER_DATAFILE does not exist."
    echo "Grabbing the latest release from GitHub."
    echo $GORELEASER_API > $GORELEASER_DATAFILE
fi
GORELEASER_CURRENT="$(cat ${GORELEASER_DATAFILE})"
if [ "$GORELEASER_CURRENT" != "$GORELEASER_API" ]; then
    echo "goreleaser isn't up to date. updating now..."
    curl -s https://api.github.com/repos/goreleaser/goreleaser/releases/latest \
      | grep browser_download_url \
      | grep 'armhf.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o goreleaser_${GORELEASER_API}_armhf.deb || error "Failed to download goreleaser:armhf"

    curl -s https://api.github.com/repos/goreleaser/goreleaser/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o goreleaser_${GORELEASER_API}_arm64.deb || error "Failed to download goreleaser:arm64"

    mv goreleaser* $PKGDIR
    echo $GORELEASER_API > $GORELEASER_DATAFILE
    echo "goreleaser downloaded successfully."
fi
echo "goreleaser is up to date."

echo "Updating hyperfine."
HYPERFINE_API=`curl -s https://api.github.com/repos/sharkdp/hyperfine/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
HYPERFINE_DATAFILE="$HOME/dlfiles-data/hyperfine.txt"
if [ ! -f "$HYPERFINE_DATAFILE" ]; then
    echo "$HYPERFINE_DATAFILE does not exist."
    echo "Grabbing the latest release from GitHub."
    echo $HYPERFINE_API > $HYPERFINE_DATAFILE
fi
HYPERFINE_CURRENT="$(cat ${HYPERFINE_DATAFILE})"
if [ "$HYPERFINE_CURRENT" != "$HYPERFINE_API" ]; then
    echo "hyperfine isn't up to date. updating now..."
    curl -s https://api.github.com/repos/sharkdp/hyperfine/releases/latest \
      | grep browser_download_url \
      | grep 'armhf.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o hyperfine_${HYPERFINE_API}_armhf.deb || error "Failed to download hyperfine:armhf"

    curl -s https://api.github.com/repos/sharkdp/hyperfine/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o hyperfine_${HYPERFINE_API}_arm64.deb || error "Failed to download hyperfine:arm64"

    mv hyperfine* $PKGDIR
    echo $HYPERFINE_API > $HYPERFINE_DATAFILE
    echo "hyperfine downloaded successfully."
fi
echo "hyperfine is up to date."

echo "Updating blockbench."
BLOCKBENCH_API=`curl -s https://api.github.com/repos/JannisX11/blockbench/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
BLOCKBENCH_DATAFILE="$HOME/dlfiles-data/blockbench.txt"
if [ ! -f "$BLOCKBENCH_DATAFILE" ]; then
    echo "$BLOCKBENCH_DATAFILE does not exist."
    echo "Grabbing the latest release from GitHub."
    echo $BLOCKBENCH_API > $BLOCKBENCH_DATAFILE
fi
BLOCKBENCH_CURRENT="$(cat ${BLOCKBENCH_DATAFILE})"
if [ "$BLOCKBENCH_CURRENT" != "$BLOCKBENCH_API" ]; then
    echo "blockbench isn't up to date. updating now..."
    BLOCKBENCH_API_NOV=`curl -s https://api.github.com/repos/JannisX11/blockbench/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
    wget https://github.com/ryanfortner/blockbench-arm/raw/master/blockbench_${BLOCKBENCH_API_NOV}_arm64.deb || error "Failed to download blockbench:arm64"
    wget https://github.com/ryanfortner/blockbench-arm/raw/master/blockbench_${BLOCKBENCH_API_NOV}_armhf.deb || error "Failed to download blockbench:armhf"
    mv blockbench* $PKGDIR
    echo $BLOCKBENCH_API > $BLOCKBENCH_DATAFILE
    echo "blockbench downloaded successfully."
fi
echo "blockbench is up to date."

echo "Updating webcord."
WEBCORD_API=`curl -s https://api.github.com/repos/SpacingBat3/WebCord/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
WEBCORD_DATAFILE="$HOME/dlfiles-data/webcord.txt"
if [ ! -f "$WEBCORD_DATAFILE" ]; then
    echo "$WEBCORD_DATAFILE does not exist."
    echo "Grabbing the latest release from GitHub."
    echo $WEBCORD_API > $WEBCORD_DATAFILE
fi
WEBCORD_CURRENT="$(cat ${WEBCORD_DATAFILE})"
if [ "$WEBCORD_CURRENT" != "$WEBCORD_API" ]; then
    echo "webcord isn't up to date. updating now..."
    curl -s https://api.github.com/repos/SpacingBat3/WebCord/releases/latest \
      | grep browser_download_url \
      | grep 'armhf.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o webcord_${WEBCORD_API}_armhf.deb || error "Failed to download webcord:armhf"

    curl -s https://api.github.com/repos/SpacingBat3/WebCord/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o webcord_${WEBCORD_API}_arm64.deb || error "Failed to download webcord:arm64"

    mv webcord* $PKGDIR
    echo $WEBCORD_API > $WEBCORD_DATAFILE
    echo "webcord downloaded successfully."
fi
echo "webcord is up to date."

echo "Updating gitea."
GITEA_API=`curl -s https://api.github.com/repos/go-gitea/gitea/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
GITEA_DATAFILE="$HOME/dlfiles-data/gitea.txt"
if [ ! -f "$GITEA_DATAFILE" ]; then
    echo "$GITEA_DATAFILE does not exist."
    echo "Grabbing the latest release from GitHub."
    echo $GITEA_API > $GITEA_DATAFILE
fi
GITEA_CURRENT="$(cat ${GITEA_DATAFILE})"
if [ "$GITEA_CURRENT" != "$GITEA_API" ]; then
    echo "gitea isn't up to date. updating now..."
    GITEA_API_NOV=`curl -s https://api.github.com/repos/go-gitea/gitea/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
    wget https://github.com/ryanfortner/gitea-arm/raw/master/debs/gitea_${GITEA_API_NOV}_arm64.deb || error "Failed to download gitea:arm64"
    wget https://github.com/ryanfortner/gitea-arm/raw/master/debs/gitea_${GITEA_API_NOV}_armhf.deb || error "Failed to download gitea:armhf"
    mv gitea* $PKGDIR
    echo $GITEA_API > $GITEA_DATAFILE
    echo "gitea downloaded successfully."
fi
echo "gitea is up to date."

echo "Updating howdy."
HOWDY_API=`curl -s https://api.github.com/repos/boltgolt/howdy/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
HOWDY_DATAFILE="$HOME/dlfiles-data/howdy.txt"
if [ ! -f "$HOWDY_DATAFILE" ]; then
    echo "$HOWDY_DATAFILE does not exist."
    echo "Grabbing the latest release from GitHub."
    echo $HOWDY_API > $HOWDY_DATAFILE
fi
HOWDY_CURRENT="$(cat ${HOWDY_DATAFILE})"
if [ "$HOWDY_CURRENT" != "$HOWDY_API" ]; then
    echo "howdy isn't up to date. updating now..."
    curl -s https://api.github.com/repos/boltgolt/howdy/releases/latest \
      | grep browser_download_url \
      | grep '.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o howdy_${HOWDY_API}_all.deb || error "Failed to download howdy:all!"

    mv howdy* $PKGDIR
    echo $HOWDY_API > $HOWDY_DATAFILE
    echo "howdy downloaded successfully."
fi
echo "howdy is up to date."

echo "Updating webhookd."
WEBHOOKD_API=`curl -s https://api.github.com/repos/ncarlier/webhookd/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
WEBHOOKD_DATAFILE="$HOME/dlfiles-data/webhookd.txt"
if [ ! -f "$WEBHOOKD_DATAFILE" ]; then
    echo "$WEBHOOKD_DATAFILE does not exist."
    echo "Grabbing the latest release from GitHub."
    echo $WEBHOOKD_API > $WEBHOOKD_DATAFILE
fi
WEBHOOKD_CURRENT="$(cat ${WEBHOOKD_DATAFILE})"
if [ "$WEBHOOKD_CURRENT" != "$WEBHOOKD_API" ]; then
    echo "webhookd isn't up to date. updating now..."
    all_dist=('arm' 'arm64')
    for dist in "${all_dist[@]}"; do

      STARTDIR="$(pwd)"
      rm -rf ${STARTDIR}
      DESTDIR="$STARTDIR/pkg"
      OUTDIR="$STARTDIR/deb"
      mkdir "$OUTDIR"

      # Remove potential leftovers from a previous build
      rm -rf "$DESTDIR"

      wget -q https://github.com/ncarlier/webhookd/releases/download/v${WEBHOOKD_API}/webhookd-linux-$dist.tgz -O "$STARTDIR/tar.tgz" || error "Failed to download webhookd tar.gz"
      tar xzf "$STARTDIR/tar.tgz" -C "$STARTDIR/"
      wget -q https://raw.githubusercontent.com/ncarlier/webhookd/master/etc/default/webhookd.env -O "$STARTDIR/webhookd.env" || error "Failed to download webhookd env file"
    
      install -Dm 755 "$STARTDIR/webhookd" "$DESTDIR/usr/local/bin/webhookd"
      install -Dm 755 "$STARTDIR/webhookd.env" "$DESTDIR/etc/default/webhookd.env"
      install -Dm 644 "$STARTDIR/webhookd.service" "$DESTDIR/etc/systemd/system/webhookd.service" 
    
      mkdir -p "$DESTDIR/DEBIAN"
      [ ! -d /tmp/dpkg-deb ] && git clone https://github.com/ryanfortner/dpkg-deb.git /tmp/dpkg-deb --quiet || error "Failed to clone webhookd"
      cp /tmp/dpkg-deb/webhookd/DEBIAN/* "$DESTDIR/DEBIAN/"
    
      # Modify control file for build
      sed -i "s/VERSION-TO-REPLACE/${WEBHOOKD_API}/" "$DESTDIR/DEBIAN/control"
    
      [ "$dist" == "arm" ] &&  dist="armhf"
      sed -i "s/ARCHI-TO-REPLACE/$dist/" "$DESTDIR/DEBIAN/control"
    
      # Build .deb
      dpkg-deb --build "$DESTDIR" "$OUTDIR" || error "Failed to build webhookd deb"

    done
    mv $OUTDIR/*.deb * $PKGDIR
    echo $WEBHOOKD_API > $WEBHOOKD_DATAFILE
    echo "webhookd downloaded successfully."
fi
echo "webhookd is up to date."

echo "Writing packages."
cd /root/raspbian-addons/debian
for new_pkg in `ls pkgs_incoming`; do
    echo $new_pkg
    #reprepro_expect
    /root/reprepro.exp -- --noguessgpgtty -Vb /root/raspbian-addons/debian/ includedeb precise /root/raspbian-addons/debian/pkgs_incoming/$new_pkg
    if [ $? != 0 ]; then
        redtext "Import of $new_pkg failed!"
    else
        rm -rf pkgs_incoming/$new_pkg
    fi
done
