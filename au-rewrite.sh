#!/bin/bash

#########################################
#            au-rewrite.sh              #
# downloads and writes certain packages #
#           every 24 hours              #
#########################################

PKGDIR="/root/raspbian-addons/debian/pkgs_incoming/"
DATEA="$(date)"

# This part takes the token from the token script. This is a READ ONLY token, and is only used so that there are more github api requests available.
source /root/token.sh

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

function red {
  echo -e "\e[91m$1\e[39m"
}

status() { #cyan text to indicate what is happening
    #detect if a flag was passed, and if so, pass it on to the echo command
    if [[ "$1" == '-'* ]] && [ ! -z "$2" ];then
        echo -e $1 "\e[96m$2\e[0m" 1>&2
    else
        echo -e "\e[96m$1\e[0m" 1>&2
    fi
}

green() { #announce the success of a major action
    echo -e "\e[92m$1\e[0m" 1>&2
}

status "Updating codium."
CODIUM_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/VSCodium/VSCodium/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
CODIUM_DATAFILE="$HOME/dlfiles-data/codium.txt"
if [ ! -f "$CODIUM_DATAFILE" ]; then
    status "$CODIUM_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $CODIUM_API > $CODIUM_DATAFILE
fi
CODIUM_CURRENT="$(cat ${CODIUM_DATAFILE})"
if [ "$CODIUM_CURRENT" != "$CODIUM_API" ]; then
    status "codium isn't up to date. updating now..."
    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/VSCodium/VSCodium/releases/latest \
      | grep browser_download_url \
      | grep 'armhf.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o codium_${CODIUM_API}_armhf.deb || error "Failed to download the codium:armhf"

    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/VSCodium/VSCodium/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o codium_${CODIUM_API}_arm64.deb || error "Failed to download codium:arm64"

    mv codium* $PKGDIR
    echo $CODIUM_API > $CODIUM_DATAFILE
    green "codium downloaded successfully."
fi
green "codium is up to date."

status "Updating goreleaser."
GORELEASER_API=`curl -s --header --header "Authorization: token $token" https://api.github.com/repos/goreleaser/goreleaser/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
GORELEASER_DATAFILE="$HOME/dlfiles-data/goreleaser.txt"
if [ ! -f "$GORELEASER_DATAFILE" ]; then
    status "$GORELEASER_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $GORELEASER_API > $GORELEASER_DATAFILE
fi
GORELEASER_CURRENT="$(cat ${GORELEASER_DATAFILE})"
if [ "$GORELEASER_CURRENT" != "$GORELEASER_API" ]; then
    status "goreleaser isn't up to date. updating now..."
    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/goreleaser/goreleaser/releases/latest \
      | grep browser_download_url \
      | grep 'armhf.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o goreleaser_${GORELEASER_API}_armhf.deb || error "Failed to download goreleaser:armhf"

    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/goreleaser/goreleaser/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o goreleaser_${GORELEASER_API}_arm64.deb || error "Failed to download goreleaser:arm64"

    mv goreleaser* $PKGDIR
    echo $GORELEASER_API > $GORELEASER_DATAFILE
    green "goreleaser downloaded successfully."
fi
green "goreleaser is up to date."

status "Updating hyperfine."
HYPERFINE_API=`curl -s --header --header "Authorization: token $token" https://api.github.com/repos/sharkdp/hyperfine/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
HYPERFINE_DATAFILE="$HOME/dlfiles-data/hyperfine.txt"
if [ ! -f "$HYPERFINE_DATAFILE" ]; then
    status "$HYPERFINE_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $HYPERFINE_API > $HYPERFINE_DATAFILE
fi
HYPERFINE_CURRENT="$(cat ${HYPERFINE_DATAFILE})"
if [ "$HYPERFINE_CURRENT" != "$HYPERFINE_API" ]; then
    status "hyperfine isn't up to date. updating now..."
    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/sharkdp/hyperfine/releases/latest \
      | grep browser_download_url \
      | grep 'armhf.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o hyperfine_${HYPERFINE_API}_armhf.deb || error "Failed to download hyperfine:armhf"

    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/sharkdp/hyperfine/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o hyperfine_${HYPERFINE_API}_arm64.deb || error "Failed to download hyperfine:arm64"

    mv hyperfine* $PKGDIR
    echo $HYPERFINE_API > $HYPERFINE_DATAFILE
    green "hyperfine downloaded successfully."
fi
green "hyperfine is up to date."

status "Updating blockbench."
BLOCKBENCH_API=`curl -s --header --header "Authorization: token $token" https://api.github.com/repos/JannisX11/blockbench/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
BLOCKBENCH_DATAFILE="$HOME/dlfiles-data/blockbench.txt"
if [ ! -f "$BLOCKBENCH_DATAFILE" ]; then
    status "$BLOCKBENCH_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $BLOCKBENCH_API > $BLOCKBENCH_DATAFILE
fi
BLOCKBENCH_CURRENT="$(cat ${BLOCKBENCH_DATAFILE})"
if [ "$BLOCKBENCH_CURRENT" != "$BLOCKBENCH_API" ]; then
    status "blockbench isn't up to date. updating now..."
    BLOCKBENCH_API_NOV=`curl -s --header --header "Authorization: token $token" https://api.github.com/repos/JannisX11/blockbench/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
    wget https://github.com/ryanfortner/blockbench-arm/raw/master/blockbench_${BLOCKBENCH_API_NOV}_arm64.deb || error "Failed to download blockbench:arm64"
    wget https://github.com/ryanfortner/blockbench-arm/raw/master/blockbench_${BLOCKBENCH_API_NOV}_armhf.deb || error "Failed to download blockbench:armhf"
    mv blockbench* $PKGDIR
    echo $BLOCKBENCH_API > $BLOCKBENCH_DATAFILE
    green "blockbench downloaded successfully."
fi
green "blockbench is up to date."

status "Updating webcord."
WEBCORD_API=`curl -s --header --header "Authorization: token $token" https://api.github.com/repos/SpacingBat3/WebCord/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
WEBCORD_DATAFILE="$HOME/dlfiles-data/webcord.txt"
if [ ! -f "$WEBCORD_DATAFILE" ]; then
    status "$WEBCORD_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $WEBCORD_API > $WEBCORD_DATAFILE
fi
WEBCORD_CURRENT="$(cat ${WEBCORD_DATAFILE})"
if [ "$WEBCORD_CURRENT" != "$WEBCORD_API" ]; then
    status "webcord isn't up to date. updating now..."
    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/SpacingBat3/WebCord/releases/latest \
      | grep browser_download_url \
      | grep 'armhf.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o webcord_${WEBCORD_API}_armhf.deb || error "Failed to download webcord:armhf"

    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/SpacingBat3/WebCord/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o webcord_${WEBCORD_API}_arm64.deb || error "Failed to download webcord:arm64"

    mv webcord* $PKGDIR
    echo $WEBCORD_API > $WEBCORD_DATAFILE
    green "webcord downloaded successfully."
fi
green "webcord is up to date."

status "Updating gitea."
GITEA_API=`curl -s --header --header "Authorization: token $token" https://api.github.com/repos/go-gitea/gitea/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
GITEA_DATAFILE="$HOME/dlfiles-data/gitea.txt"
if [ ! -f "$GITEA_DATAFILE" ]; then
    status "$GITEA_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $GITEA_API > $GITEA_DATAFILE
fi
GITEA_CURRENT="$(cat ${GITEA_DATAFILE})"
if [ "$GITEA_CURRENT" != "$GITEA_API" ]; then
    status "gitea isn't up to date. updating now..."
    GITEA_API_NOV=`curl -s --header --header "Authorization: token $token" https://api.github.com/repos/go-gitea/gitea/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
    wget https://github.com/ryanfortner/gitea-arm/raw/master/debs/gitea_${GITEA_API_NOV}_arm64.deb || error "Failed to download gitea:arm64"
    wget https://github.com/ryanfortner/gitea-arm/raw/master/debs/gitea_${GITEA_API_NOV}_armhf.deb || error "Failed to download gitea:armhf"
    mv gitea* $PKGDIR
    echo $GITEA_API > $GITEA_DATAFILE
    green "gitea downloaded successfully."
fi
green "gitea is up to date."

status "Updating howdy."
HOWDY_API=`curl -s --header --header "Authorization: token $token" https://api.github.com/repos/boltgolt/howdy/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
HOWDY_DATAFILE="$HOME/dlfiles-data/howdy.txt"
if [ ! -f "$HOWDY_DATAFILE" ]; then
    status "$HOWDY_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $HOWDY_API > $HOWDY_DATAFILE
fi
HOWDY_CURRENT="$(cat ${HOWDY_DATAFILE})"
if [ "$HOWDY_CURRENT" != "$HOWDY_API" ]; then
    status "howdy isn't up to date. updating now..."
    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/boltgolt/howdy/releases/latest \
      | grep browser_download_url \
      | grep '.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o howdy_${HOWDY_API}_all.deb || error "Failed to download howdy:all!"

    mv howdy* $PKGDIR
    echo $HOWDY_API > $HOWDY_DATAFILE
    green "howdy downloaded successfully."
fi
green "howdy is up to date."

status "Updating koreader."
KOREADER_API=`curl -s --header --header "Authorization: token $token" https://api.github.com/repos/koreader/koreader/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
KOREADER_DATAFILE="$HOME/dlfiles-data/koreader.txt"
if [ ! -f "$KOREADER_DATAFILE" ]; then
    status "$KOREADER_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $KOREADER_API > $KOREADER_DATAFILE
fi
KOREADER_CURRENT="$(cat ${KOREADER_DATAFILE})"
if [ "$KOREADER_CURRENT" != "$KOREADER_API" ]; then
    status "koreader isn't up to date. updating now..."
    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/koreader/koreader/releases/latest \
      | grep browser_download_url \
      | grep 'armhf.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o koreader_${KOREADER_API}_armhf.deb || error "Failed to download koreader:armhf!"
    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/koreader/koreader/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o koreader_${KOREADER_API}_arm64.deb || error "Failed to download koreader:arm64!"

    mv koreader* $PKGDIR
    echo $KOREADER_API > $KOREADER_DATAFILE
    green "koreader downloaded successfully."
fi
green "koreader is up to date."

status "Updating icalingua."
ICALINGUIA_API=`curl -s --header --header "Authorization: token $token" https://api.github.com/repos/Icalingua/Icalingua/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
ICALINGUA_DATAFILE="$HOME/dlfiles-data/icalingua.txt"
if [ ! -f "$ICALINGUA_DATAFILE" ]; then
    status "$ICALINGUA_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $ICALINGUIA_API > $ICALINGUA_DATAFILE
fi
ICALINGUA_CURRENT="$(cat ${ICALINGUA_DATAFILE})"
if [ "$ICALINGUA_CURRENT" != "$ICALINGUIA_API" ]; then
    status "icalingua isn't up to date. updating now..."
    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/Icalingua/Icalingua/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o icalingua_${ICALINGUIA_API}_arm64.deb || error "Failed to download icalingua:arm64!"

    mv icalingua* $PKGDIR
    echo $ICALINGUIA_API > $ICALINGUA_DATAFILE
    green "icalingua downloaded successfully."
fi
green "icalingua is up to date."

status "Updating turbowarp-desktop."
TURBOWARP_API=`curl -s --header --header "Authorization: token $token" https://api.github.com/repos/TurboWarp/desktop/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
TURBOWARP_DATAFILE="$HOME/dlfiles-data/turbowarp-desktop.txt"
if [ ! -f "${TURBOWARP_DATAFILE}" ]; then
    status "${TURBOWARP_DATAFILE} does not exist."
    status "Grabbing the latest release from GitHub."
    echo ${TURBOWARP_API} > ${TURBOWARP_DATAFILE}
fi
TURBOWARP_CURRENT="$(cat ${TURBOWARP_DATAFILE})"
if [ "${TURBOWARP_CURRENT}" != "${TURBOWARP_API}" ]; then
    status "turbowarp-desktop isn't up to date. updating now..."
    wget https://github.com/TurboWarp/desktop/releases/download/v${TURBOWARP_API}/TurboWarp-linux-arm64-{TURBOWARP_API}.deb -O turbowarp-desktop_${TURBOWARP_API}_arm64.deb || error "Failed to download turbowarp-desktop:arm64"
    wget https://github.com/TurboWarp/desktop/releases/download/v${TURBOWARP_API}/TurboWarp-linux-armv7l-${TURBOWARP_API}.deb -O turbowarp-desktop_${TURBOWARP_API}_armhf.deb || error "Failed to download turbowarp-desktop:armhf"
    mv turbowarp-desktop* $PKGDIR
    echo ${TURBOWARP_API} > ${TURBOWARP_DATAFILE}
    green "turbowarp-desktop downloaded successfully."
fi
green "turbowarp-desktop is up to date."

status "Updating gh."
GH_API=`curl -s --header --header "Authorization: token $token" https://api.github.com/repos/cli/cli/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
GH_DATAFILE="$HOME/dlfiles-data/gh.txt"
if [ ! -f "$GH_DATAFILE" ]; then
    status "$GH_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $GH_API > $GH_DATAFILE
fi
GH_CURRENT="$(cat ${GH_DATAFILE})"
if [ "$GH_CURRENT" != "$GH_API" ]; then
    status "gh isn't up to date. updating now..."
    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/cli/cli/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o gh_${GH_API}_arm64.deb || error "Failed to download gh:arm64!"
    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/cli/cli/releases/latest \
      | grep browser_download_url \
      | grep 'armv6.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o gh_${GH_API}_armhf.deb || error "Failed to download gh:armhf!"

    mv gh* $PKGDIR
    echo $GH_API > $GH_DATAFILE
    green "gh downloaded successfully."
fi
green "gh is up to date."

status "Updating cloudflared."
CLOUDFLARED_API=`curl -s --header --header "Authorization: token $token" https://api.github.com/repos/cloudflare/cloudflared/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
CLOUDFLARED_DATAFILE="$HOME/dlfiles-data/cloudflared.txt"
if [ ! -f "$CLOUDFLARED_DATAFILE" ]; then
    status "$CLOUDFLARED_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $CLOUDFLARED_API > $CLOUDFLARED_DATAFILE
fi
CLOUDFLARED_CURRENT="$(cat ${CLOUDFLARED_DATAFILE})"
if [ "$CLOUDFLARED_CURRENT" != "$CLOUDFLARED_API" ]; then
    status "gh isn't up to date. updating now..."
    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/cloudflare/cloudflared/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o cloudflared_${CLOUDFLARED_API}_arm64.deb || error "Failed to download cloudflared:arm64!"
    curl -s --header --header "Authorization: token $token" https://api.github.com/repos/cloudflare/cloudflared/releases/latest \
      | grep browser_download_url \
      | grep 'arm.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o cloudflared_${CLOUDFLARED_API}_armhf.deb || error "Failed to download cloudflared:armhf!"

    mv cloudflared* $PKGDIR
    echo $CLOUDFLARED_API > $CLOUDFLARED_DATAFILE
    green "cloudflared downloaded successfully."
fi
green "cloudflared is up to date."

status "Writing packages."
cd /root/raspbian-addons/debian
for new_pkg in `ls pkgs_incoming`; do
    status $new_pkg
    #reprepro_expect
    /root/reprepro.exp -- --noguessgpgtty -Vb /root/raspbian-addons/debian/ includedeb precise /root/raspbian-addons/debian/pkgs_incoming/$new_pkg
    if [ $? != 0 ]; then
        red "Import of $new_pkg failed!"
    else
        rm -rf pkgs_incoming/$new_pkg
    fi
done
