#!/bin/bash

function error {
  echo -e "\e[91m$1\e[39m"
  exit 1
}

function ctrl_c() {
  break &>/dev/null
  rm repo.sh &>/dev/null
  exit 1
}
#make the ctrl_c function run if ctrl+c is pressed
trap "ctrl_c" 2

function removerepo() {
  echo "You chose to remove the repository. To cancel click ctrl+c in the next 5 seconds."
  sleep 5
  printf "Removing rpirepo.list..."
  sudo rm /etc/apt/sources.list.d/rpirepo.list || error "Failed to remove rpirepo.list!"
  #sudo rm /etc/apt/sources.list.d/rpi_addons.list || error "Failed to remove rpi_addons.list!"
  echo "done"
  printf "Removing GPG key..."
  sudo apt-key remove "232E 6F29 77AB D48E 5A9F  AD03 9ACB 4E70 D84B FD24" || error "Failed to remove GPG key!"
  echo "Updating APT lists..."
  sudo apt update || error "Failed to update APT lists!"
}

removerepo
echo "Bye!"
