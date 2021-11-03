#!/bin/bash

PKGDIR="/root/raspbian-addons/debian/pool/"

rm -rf /tmp/aojdk
mkdir /tmp/aojdk && cd /tmp/aojdk
AOJDK16_VER="16.0.1_9"
AOJDK16_BASE="https://github.com/AdoptOpenJDK/openjdk16-binaries/releases/download/"
AOJDK16_VER2=$(sed "s/_/%2B/g" <<<${AOJDK16_VER})
AOJDK16_VER3=$(sed "s/_/+/g" <<<${AOJDK16_VER})
AOJDK16_SRC="${AOJDK16_BASE}jdk-${AOJDK16_VER2}/OpenJDK16U-jdk_arm_linux_hotspot_${AOJDK16_VER}.tar.gz"
AOJDK16_FILE="aojdk16_${AOJDK16_VER}.tar.gz"

AOJDK16_PROVIDES="java-compiler, java-sdk, java10-sdk, java11-sdk, java12-sdk, java13-sdk, java14-sdk, java15-sdk, java16-sdk, java2-sdk, java5-sdk, java6-sdk, java7-sdk, java8-sdk, java9-sdk"
AOJDK16_PROVIDES_HEADLESS="java-sdk-headless, java10-sdk-headless, java11-sdk-headless, java12-sdk-headless, java13-sdk-headless, java14-sdk-headless, java15-sdk-headless, java16-sdk-headless, java2-sdk-headless, java5-sdk-headless, java6-sdk-headless, java7-sdk-headless, java8-sdk-headless, java9-sdk-headless"

echo "Building AdoptOpenJDK ${AOJDK16_VER}..."

cd ${TOP_DIR}
mkdir -p ./build/

wget ${AOJDK16_SRC} -O ${AOJDK16_FILE} >/dev/null

tar -xzf ${AOJDK16_FILE}

mkdir -p ./aojdk-16/DEBIAN
cp ./aojdk-16-src/{postinst,prerm} ./aojdk-16/DEBIAN
mkdir -p ./aojdk-16/usr/lib/jvm/java-16-adoptopenjdk-armhf

echo "Package: adoptopenjdk-16-jdk
Source: openjdk-16
Version: ${AOJDK16_VER3}
Architecture: armhf
Maintainer: Ryan Fortner <pinetmedia@gmail.com>
Depends: libc6 (>= 2.4), zlib1g (>= 1:1.1.4)
Provides: ${AOJDK16_PROVIDES}, ${AOJDK16_PROVIDES_HEADLESS}
Section: java
Priority: optional
Homepage: https://adoptopenjdk.net/
Description: OpenJDK Development Kit (JDK)
 OpenJDK is a development environment for building applications,
 applets, and components using the Java programming language.
 This build is provided by AdoptOpenJDK.net.
" > ./aojdk-16/DEBIAN/control

mv ./jdk-${AOJDK16_VER3}/{include,man,lib,bin,jmods} ./aojdk-16/usr/lib/jvm/java-16-adoptopenjdk-armhf/

dpkg -b ./aojdk-16/ ./build/adoptopenjdk-16-jdk_${AOJDK16_VER3}.deb

mv adoptopenjdk-16-jdk_${AOJDK16_VER3}.deb $PKGDIR
