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
    curl -s --header "Authorization: token $token" https://api.github.com/repos/VSCodium/VSCodium/releases/latest \
      | grep browser_download_url \
      | grep 'armhf.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o codium_${CODIUM_API}_armhf.deb || error "Failed to download the codium:armhf"

    curl -s --header "Authorization: token $token" https://api.github.com/repos/VSCodium/VSCodium/releases/latest \
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
GORELEASER_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/goreleaser/goreleaser/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
GORELEASER_DATAFILE="$HOME/dlfiles-data/goreleaser.txt"
if [ ! -f "$GORELEASER_DATAFILE" ]; then
    status "$GORELEASER_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $GORELEASER_API > $GORELEASER_DATAFILE
fi
GORELEASER_CURRENT="$(cat ${GORELEASER_DATAFILE})"
if [ "$GORELEASER_CURRENT" != "$GORELEASER_API" ]; then
    status "goreleaser isn't up to date. updating now..."
    curl -s --header "Authorization: token $token" https://api.github.com/repos/goreleaser/goreleaser/releases/latest \
      | grep browser_download_url \
      | grep 'armhf.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o goreleaser_${GORELEASER_API}_armhf.deb || error "Failed to download goreleaser:armhf"

    curl -s --header "Authorization: token $token" https://api.github.com/repos/goreleaser/goreleaser/releases/latest \
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
HYPERFINE_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/sharkdp/hyperfine/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
HYPERFINE_DATAFILE="$HOME/dlfiles-data/hyperfine.txt"
if [ ! -f "$HYPERFINE_DATAFILE" ]; then
    status "$HYPERFINE_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $HYPERFINE_API > $HYPERFINE_DATAFILE
fi
HYPERFINE_CURRENT="$(cat ${HYPERFINE_DATAFILE})"
if [ "$HYPERFINE_CURRENT" != "$HYPERFINE_API" ]; then
    status "hyperfine isn't up to date. updating now..."
    curl -s --header "Authorization: token $token" https://api.github.com/repos/sharkdp/hyperfine/releases/latest \
      | grep browser_download_url \
      | grep 'armhf.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o hyperfine_${HYPERFINE_API}_armhf.deb || error "Failed to download hyperfine:armhf"

    curl -s --header "Authorization: token $token" https://api.github.com/repos/sharkdp/hyperfine/releases/latest \
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
BLOCKBENCH_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/JannisX11/blockbench/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
BLOCKBENCH_DATAFILE="$HOME/dlfiles-data/blockbench.txt"
if [ ! -f "$BLOCKBENCH_DATAFILE" ]; then
    status "$BLOCKBENCH_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $BLOCKBENCH_API > $BLOCKBENCH_DATAFILE
fi
BLOCKBENCH_CURRENT="$(cat ${BLOCKBENCH_DATAFILE})"
if [ "$BLOCKBENCH_CURRENT" != "$BLOCKBENCH_API" ]; then
    status "blockbench isn't up to date. updating now..."
    BLOCKBENCH_API_NOV=`curl -s --header "Authorization: token $token" https://api.github.com/repos/JannisX11/blockbench/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
    wget https://github.com/ryanfortner/blockbench-arm/raw/master/blockbench_${BLOCKBENCH_API_NOV}_arm64.deb || error "Failed to download blockbench:arm64"
    wget https://github.com/ryanfortner/blockbench-arm/raw/master/blockbench_${BLOCKBENCH_API_NOV}_armhf.deb || error "Failed to download blockbench:armhf"
    mv blockbench* $PKGDIR
    echo $BLOCKBENCH_API > $BLOCKBENCH_DATAFILE
    green "blockbench downloaded successfully."
fi
green "blockbench is up to date."

status "Updating webcord."
WEBCORD_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/SpacingBat3/WebCord/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
WEBCORD_DATAFILE="$HOME/dlfiles-data/webcord.txt"
if [ ! -f "$WEBCORD_DATAFILE" ]; then
    status "$WEBCORD_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $WEBCORD_API > $WEBCORD_DATAFILE
fi
WEBCORD_CURRENT="$(cat ${WEBCORD_DATAFILE})"
if [ "$WEBCORD_CURRENT" != "$WEBCORD_API" ]; then
    status "webcord isn't up to date. updating now..."
    curl -s --header "Authorization: token $token" https://api.github.com/repos/SpacingBat3/WebCord/releases/latest \
      | grep browser_download_url \
      | grep 'armhf.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o webcord_${WEBCORD_API}_armhf.deb || error "Failed to download webcord:armhf"

    curl -s --header "Authorization: token $token" https://api.github.com/repos/SpacingBat3/WebCord/releases/latest \
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
GITEA_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/go-gitea/gitea/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
GITEA_DATAFILE="$HOME/dlfiles-data/gitea.txt"
if [ ! -f "$GITEA_DATAFILE" ]; then
    status "$GITEA_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $GITEA_API > $GITEA_DATAFILE
fi
GITEA_CURRENT="$(cat ${GITEA_DATAFILE})"
if [ "$GITEA_CURRENT" != "$GITEA_API" ]; then
    status "gitea isn't up to date. updating now..."
    GITEA_API_NOV=`curl -s --header "Authorization: token $token" https://api.github.com/repos/go-gitea/gitea/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
    wget https://github.com/ryanfortner/gitea-arm/raw/master/debs/gitea_${GITEA_API_NOV}_arm64.deb || error "Failed to download gitea:arm64"
    wget https://github.com/ryanfortner/gitea-arm/raw/master/debs/gitea_${GITEA_API_NOV}_armhf.deb || error "Failed to download gitea:armhf"
    mv gitea* $PKGDIR
    echo $GITEA_API > $GITEA_DATAFILE
    green "gitea downloaded successfully."
fi
green "gitea is up to date."

status "Updating howdy."
HOWDY_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/boltgolt/howdy/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
HOWDY_DATAFILE="$HOME/dlfiles-data/howdy.txt"
if [ ! -f "$HOWDY_DATAFILE" ]; then
    status "$HOWDY_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $HOWDY_API > $HOWDY_DATAFILE
fi
HOWDY_CURRENT="$(cat ${HOWDY_DATAFILE})"
if [ "$HOWDY_CURRENT" != "$HOWDY_API" ]; then
    status "howdy isn't up to date. updating now..."
    curl -s --header "Authorization: token $token" https://api.github.com/repos/boltgolt/howdy/releases/latest \
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
KOREADER_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/koreader/koreader/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
KOREADER_DATAFILE="$HOME/dlfiles-data/koreader.txt"
if [ ! -f "$KOREADER_DATAFILE" ]; then
    status "$KOREADER_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $KOREADER_API > $KOREADER_DATAFILE
fi
KOREADER_CURRENT="$(cat ${KOREADER_DATAFILE})"
if [ "$KOREADER_CURRENT" != "$KOREADER_API" ]; then
    status "koreader isn't up to date. updating now..."
    curl -s --header "Authorization: token $token" https://api.github.com/repos/koreader/koreader/releases/latest \
      | grep browser_download_url \
      | grep 'armhf.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o koreader_${KOREADER_API}_armhf.deb || error "Failed to download koreader:armhf!"
    curl -s --header "Authorization: token $token" https://api.github.com/repos/koreader/koreader/releases/latest \
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
ICALINGUIA_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/Icalingua/Icalingua/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
ICALINGUA_DATAFILE="$HOME/dlfiles-data/icalingua.txt"
if [ ! -f "$ICALINGUA_DATAFILE" ]; then
    status "$ICALINGUA_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $ICALINGUIA_API > $ICALINGUA_DATAFILE
fi
ICALINGUA_CURRENT="$(cat ${ICALINGUA_DATAFILE})"
if [ "$ICALINGUA_CURRENT" != "$ICALINGUIA_API" ]; then
    status "icalingua isn't up to date. updating now..."
    curl -s --header "Authorization: token $token" https://api.github.com/repos/Icalingua/Icalingua/releases/latest \
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
TURBOWARP_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/TurboWarp/desktop/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
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
GH_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/cli/cli/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
GH_DATAFILE="$HOME/dlfiles-data/gh.txt"
if [ ! -f "$GH_DATAFILE" ]; then
    status "$GH_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $GH_API > $GH_DATAFILE
fi
GH_CURRENT="$(cat ${GH_DATAFILE})"
if [ "$GH_CURRENT" != "$GH_API" ]; then
    status "gh isn't up to date. updating now..."
    curl -s --header "Authorization: token $token" https://api.github.com/repos/cli/cli/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o gh_${GH_API}_arm64.deb || error "Failed to download gh:arm64!"
    curl -s --header "Authorization: token $token" https://api.github.com/repos/cli/cli/releases/latest \
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
CLOUDFLARED_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/cloudflare/cloudflared/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
CLOUDFLARED_DATAFILE="$HOME/dlfiles-data/cloudflared.txt"
if [ ! -f "$CLOUDFLARED_DATAFILE" ]; then
    status "$CLOUDFLARED_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $CLOUDFLARED_API > $CLOUDFLARED_DATAFILE
fi
CLOUDFLARED_CURRENT="$(cat ${CLOUDFLARED_DATAFILE})"
if [ "$CLOUDFLARED_CURRENT" != "$CLOUDFLARED_API" ]; then
    status "cloudflared isn't up to date. updating now..."
    curl -s --header "Authorization: token $token" https://api.github.com/repos/cloudflare/cloudflared/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o cloudflared_${CLOUDFLARED_API}_arm64.deb || error "Failed to download cloudflared:arm64!"
    curl -s --header "Authorization: token $token" https://api.github.com/repos/cloudflare/cloudflared/releases/latest \
      | grep browser_download_url \
      | grep 'arm.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o cloudflared_${CLOUDFLARED_API}_armhf.deb || error "Failed to download cloudflared:armhf!"

    mv cloudflared* $PKGDIR
    echo $CLOUDFLARED_API > $CLOUDFLARED_DATAFILE
    green "cloudflared downloaded successfully."
fi
green "cloudflared is up to date."

status "Updating polychromatic, polychromatic-cli, polychromatic-common, polychromatic-controller, polychromatic-tray-applet."
POLYCHROMATIC_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/polychromatic/polychromatic/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
POLYCHROMATIC_DATAFILE="$HOME/dlfiles-data/polychromatic.txt"
if [ ! -f "$POLYCHROMATIC_DATAFILE" ]; then
    status "$POLYCHROMATIC_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $POLYCHROMATIC_API > $POLYCHROMATIC_DATAFILE
fi
POLYCHROMATIC_CURRENT="$(cat ${POLYCHROMATIC_DATAFILE})"
if [ "$POLYCHROMATIC_CURRENT" != "$POLYCHROMATIC_API" ]; then
    status "polychromatic isn't up to date. updating now..."
    if [ ! -f "/etc/apt/sources.list.d/polychromatic.list" ]; then
	      echo "polychromatic.list does not exist. adding repo..."
  	    echo "deb http://ppa.launchpad.net/polychromatic/stable/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/polychromatic.list
	      sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 96B9CD7C22E2C8C5
	      sudo apt update
    fi
    echo "polychromatic.list exists. continuing..."
    sudo apt update
    apt download polychromatic:all || error "Failed to download polychromatic:all"
    apt download polychromatic-cli:all || error "Failed to download polychromatic-cli:all"
    apt download polychromatic-common:all || error "Failed to download polychromatic-common:all"
    apt download polychromatic-controller:all || error "Failed to download polychromatic-controller:all"
    apt download polychromatic-tray-applet:all || error "Failed to download polychromatic-tray-applet:all"

    mv polychromatic* $PKGDIR
    echo $POLYCHROMATIC_API > $POLYCHROMATIC_DATAFILE
    green "polychromatic downloaded successfully."
fi
green "polychromatic is up to date."

status "Updating fm."
FM_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/knipferrc/fm/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
FM_DATAFILE="$HOME/dlfiles-data/fm.txt"
if [ ! -f "$FM_DATAFILE" ]; then
    status "$FM_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $FM_API > $FM_DATAFILE
fi
FM_CURRENT="$(cat ${FM_DATAFILE})"
if [ "$FM_CURRENT" != "$FM_API" ]; then
    status "fm isn't up to date. updating now..."
    curl -s --header "Authorization: token $token" https://api.github.com/repos/knipferrc/fm/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o fm_${FM_API}_arm64.deb || error "Failed to download fm:arm64!"

    mv fm* $PKGDIR
    echo $FM_API > $FM_DATAFILE
    green "fm downloaded successfully."
fi
green "fm is up to date."

status "Updating grype."
GRYPE_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/anchore/grype/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
GRYPE_DATAFILE="$HOME/dlfiles-data/grype.txt"
if [ ! -f "$GRYPE_DATAFILE" ]; then
    status "$GRYPE_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $GRYPE_API > $GRYPE_DATAFILE
fi
GRYPE_CURRENT="$(cat ${GRYPE_DATAFILE})"
if [ "$GRYPE_CURRENT" != "$GRYPE_API" ]; then
    status "grype isn't up to date. updating now..."
    curl -s --header "Authorization: token $token" https://api.github.com/repos/anchore/grype/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o grype_${GRYPE_API}_arm64.deb || error "Failed to download grype:arm64!"

    mv grype* $PKGDIR
    echo $GRYPE_API > $GRYPE_DATAFILE
    green "grype downloaded successfully."
fi
green "grype is up to date."

status "Updating min."
MIN_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/minbrowser/min/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
MIN_DATAFILE="$HOME/dlfiles-data/min.txt"
if [ ! -f "$MIN_DATAFILE" ]; then
    status "$MIN_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $MIN_API > $MIN_DATAFILE
fi
MIN_CURRENT="$(cat ${MIN_DATAFILE})"
if [ "$MIN_CURRENT" != "$MIN_API" ]; then
    status "min isn't up to date. updating now..."
    curl -s --header "Authorization: token $token" https://api.github.com/repos/minbrowser/min/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o min_${MIN_API}_arm64.deb || error "Failed to download min:arm64!"
    curl -s --header "Authorization: token $token" https://api.github.com/repos/minbrowser/min/releases/latest \
      | grep browser_download_url \
      | grep 'armhf.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o min_${MIN_API}_armhf.deb || error "Failed to download min:armhf!"

    mv min* $PKGDIR
    echo $MIN_API > $MIN_DATAFILE
    green "min downloaded successfully."
fi
green "min is up to date."

status "Updating broot."
BROOT_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/Canop/broot/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")' | tr -d 'v'`
BROOT_DATAFILE="$HOME/dlfiles-data/broot.txt"
if [ ! -f "$BROOT_DATAFILE" ]; then
    status "$BROOT_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $BROOT_API > $BROOT_DATAFILE
fi
BROOT_CURRENT="$(cat ${BROOT_DATAFILE})"
if [ "$BROOT_CURRENT" != "$BROOT_API" ]; then
    status "broot isn't up to date. updating now..."
    mkdir broot-tmp || error "Failed to make broot build dir."
    cd broot-tmp || error "Failed to enter broot build dir."
    mkdir deb-base || error "Failed to make deb base folder for broot."
    mkdir -p deb-base/DEBIAN && mkdir -p deb-base/usr/bin
    wget https://dystroy.org/broot/download/armv7-unknown-linux-gnueabihf/broot -O deb-base/usr/bin/broot || error "Failed to download broot binary"
    chmod +x deb-base/usr/bin/broot || error "Failed to make broot binary executable"
    echo "Package: broot
Version: ${BROOT_API}
Section: net
Priority: optional
Architecture: armhf
Depends: bash
Maintainer: Ryan Fortner <ryankfortner@gmail.com>
Description: A new way to see and navigate directory trees
Homepage: https://dystroy.org/broot/
Bugs: https://github.com/Canop/broot/issues" > deb-base/DEBIAN/control || error "Failed to make control file for broot"
    chmod 755 deb-base/DEBIAN/*
    dpkg-deb --build deb-base/ ../broot_${BROOT_API}_armhf.deb || error "failed to create broot deb file (armhf)!"
    cd ../ && rm -rf broot-tmp
    #wget https://packages.azlux.fr/debian/pool/main/b/broot/broot_${BROOT_API}_armhf.deb -O broot_${BROOT_API}_armhf.deb || error "Failed to download broot:armhf!"
    mv broot* $PKGDIR
    echo $BROOT_API > $BROOT_DATAFILE
    green "broot downloaded successfully."
fi
green "broot is up to date."

status "Updating ckb-next."
CKB_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/ckb-next/ckb-next/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
CKB_DATAFILE="$HOME/dlfiles-data/ckb-next.txt"
if [ ! -f "$CKB_DATAFILE" ]; then
    status "$CKB_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $CKB_API > $CKB_DATAFILE
fi
CKB_CURRENT="$(cat ${CKB_DATAFILE})"
if [ "$CKB_CURRENT" != "$CKB_API" ]; then
    status "ckb-next isn't up to date. updating now..."
    if [ ! -f "/etc/apt/sources.list.d/ckb-next.list" ]; then
	      echo "ckb-next.list does not exist. adding repo..."
  	      echo "deb http://ppa.launchpad.net/tatokis/ckb-next/ubuntu focal main " | sudo tee /etc/apt/sources.list.d/ckb-next.list
	      sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA84DB44A908C515
	      sudo apt update
    fi
    echo "ckb-next.list exists. continuing..."
    sudo apt update
    apt download ckb-next:armhf || error "Failed to download ckb-next:armhf"
    #apt download ckb-next-dbgsym:armhf || error "Failed to download ckb-next-dbgsym:armhf"
    apt download ckb-next:arm64 || error "Failed to download ckb-next:arm64"
    #apt download ckb-next-dbgsym:arm64 || error "Failed to download ckb-next-dbgsym:arm64"
    mv ckb-next* $PKGDIR
    echo $CKB_API > $CKB_DATAFILE
    green "ckb-next downloaded successfully."
fi
green "ckb-next is up to date."

status "Updating arduino-cli."
ARDUINOCLI_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/arduino/arduino-cli/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
ARDUINOCLI_DATAFILE="$HOME/dlfiles-data/arduino-cli.txt"
if [ ! -f "$ARDUINOCLI_DATAFILE" ]; then
    status "$ARDUINOCLI_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $ARDUINOCLI_API > $ARDUINOCLI_DATAFILE
fi
ARDUINOCLI_CURRENT="$(cat ${ARDUINOCLI_DATAFILE})"
if [ "$ARDUINOCLI_CURRENT" != "$ARDUINOCLI_API" ]; then
    status "arduino-cli isn't up to date. updating now..."
    rm -rf arduino-cli-debbuild
    mkdir arduino-cli-debbuild
    cd arduino-cli-debbuild || error "failed to cd into arduino-cli build dir"
    mkdir 32 && cd 32
    curl -s https://api.github.com/repos/arduino/arduino-cli/releases/latest \
      | grep browser_download_url \
      | grep 'ARMv7.tar.gz"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o arduino-cli_${ARDUINOCLI_API}_armhf.tar.gz || error "Failed to download arduino-cli v${LATEST} armhf"
    mkdir deb || error "Failed to make deb dir for deb build"
    tar -xvf arduino-cli_${ARDUINOCLI_API}_armhf.tar.gz || error "Failed to extract 32 bit archive"
    mkdir -p deb/DEBIAN
    mkdir -p deb/usr/bin
    mkdir -p deb/usr/share/doc/arduino-cli
    mv arduino-cli deb/usr/bin || error "Failed to move binary to deb/usr/bin/!"
    cd deb/usr/share/doc/arduino-cli || error "Failed to enter doc directory"
    wget https://github.com/ryanfortner/ryanfortner/releases/download/1002/arduino-cli-docs.zip || error "failed to download docs zip"
    unzip arduino-cli-docs.zip && rm arduino-cli-docs.zip || error "failed"
    cd ../../../../../
    #mv LICENSE.txt deb/usr/share/doc/arduino-cli/ || error "Failed to move license"
    echo "package (${ARDUINOCLI_API}) stable; urgency=medium
  Please check the source repo for the full changelog
  You can found the link at https://github.com/arduino/arduino-cli
-- Ryan Fortner <ryankfortner@gmail.com>  $(date -R)" > deb/DEBIAN/changelog || error "Failed to create changelog!"
    echo "Package: arduino-cli
Version: ${ARDUINOCLI_API}
Section: utils
Priority: optional
Architecture: armhf
Depends: bash
Maintainer: Ryan Fortner <ryankfortner@gmail.com>
Description: Arduino command line tool
Homepage: https://github.com/arduino/arduino-cli
Bugs: https://github.com/arduino/arduino-cli/issues" > deb/DEBIAN/control || error "Failed to create control file"
    chmod 755 deb/DEBIAN/*
    dpkg-deb --build deb/ $STARTDIR/arduino-cli_${ARDUINOCLI_API}_armhf.deb || error "Failed to build armhf deb!"
    cd ../
    mkdir 64 && cd 64
    curl -s https://api.github.com/repos/arduino/arduino-cli/releases/latest \
      | grep browser_download_url \
      | grep 'ARM64.tar.gz"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o arduino-cli_${ARDUINOCLI_API}_arm64.tar.gz || error "Failed to download arduino-cli v${LATEST} arm64"
    mkdir deb || error "Failed to make deb dir for deb build"
    tar -xvf arduino-cli_${ARDUINOCLI_API}_arm64.tar.gz || error "Failed to extract 64 bit archive"
    mkdir -p deb/DEBIAN
    mkdir -p deb/usr/bin
    mkdir -p deb/usr/share/doc/arduino-cli
    mv arduino-cli deb/usr/bin || error "Failed to move binary to deb/usr/bin/!"
    cd deb/usr/share/doc/arduino-cli || error "Failed to enter doc directory"
    wget https://github.com/ryanfortner/ryanfortner/releases/download/1002/arduino-cli-docs.zip || error "failed to download docs zip"
    unzip arduino-cli-docs.zip && rm arduino-cli-docs.zip || error "failed"
    cd ../../../../../
    #mv LICENSE.txt deb/usr/share/doc/arduino-cli/ || error "Failed to move license"
    echo "package (${ARDUINOCLI_API}) stable; urgency=medium
  Please check the source repo for the full changelog
  You can found the link at https://github.com/arduino/arduino-cli
-- Ryan Fortner <ryankfortner@gmail.com>  $(date -R)" > deb/DEBIAN/changelog || error "Failed to create changelog!"
    echo "Package: arduino-cli
Version: ${ARDUINOCLI_API}
Section: utils
Priority: optional
Architecture: arm64
Depends: bash
Maintainer: Ryan Fortner <ryankfortner@gmail.com>
Description: Arduino command line tool
Homepage: https://github.com/arduino/arduino-cli
Bugs: https://github.com/arduino/arduino-cli/issues" > deb/DEBIAN/control || error "Failed to create control file"
    chmod 755 deb/DEBIAN/*
    dpkg-deb --build deb/ $STARTDIR/arduino-cli_${ARDUINOCLI_API}_arm64.deb || error "Failed to build arm64 deb!"
    cd $STARTDIR
    rm -rf arduino-cli-debbuild
    mv arduino-cli* $PKGDIR
    echo $ARDUINOCLI_API > $ARDUINOCLI_DATAFILE
    green "arduino-cli downloaded successfully."
fi
green "arduino-cli is up to date."

status "Updating lx-music-desktop."
LMD_API=`curl -s --header "Authorization: token $token" https://api.github.com/repos/lyswhut/lx-music-desktop/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")'`
LMD_DATAFILE="$HOME/dlfiles-data/lx-music-desktop.txt"
if [ ! -f "$LMD_DATAFILE" ]; then
    status "$LMD_DATAFILE does not exist."
    status "Grabbing the latest release from GitHub."
    echo $LMD_API > $LMD_DATAFILE
fi
LMD_CURRENT="$(cat ${LMD_DATAFILE})"
if [ "$LMD_CURRENT" != "$LMD_API" ]; then
    status "lx-music-desktop isn't up to date. updating now..."
    curl -s --header "Authorization: token $token" https://api.github.com/repos/lyswhut/lx-music-desktop/releases/latest \
      | grep browser_download_url \
      | grep 'arm64.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o lx-music-desktop_${LMD_API}_arm64.deb || error "Failed to download lx-music-desktop:arm64!"
    curl -s --header "Authorization: token $token" https://api.github.com/repos/lyswhut/lx-music-desktop/releases/latest \
      | grep browser_download_url \
      | grep 'armv7l.deb"' \
      | cut -d '"' -f 4 \
      | xargs -n 1 curl -L -o lx-music-desktop_${LMD_API}_armhf.deb || error "Failed to download lx-music-desktop:armhf!"

    mv lx-music-desktop* $PKGDIR
    echo $LMD_API > $LMD_DATAFILE
    green "lx-music-desktop downloaded successfully."
fi
green "lx-music-desktop is up to date."

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
