#!/bin/bash
#source /root/.gpg-agent-info
#export GPG_AGENT_INFO
cd /root/raspbian-addons/debian
  
for new_pkg in `ls pkgs_incoming`; do
    echo $new_pkg
    #reprepro_expect
    /root/reprepro.exp -- --noguessgpgtty -Vb /root/raspbian-addons/debian/ includedeb precise /root/raspbian-addons/debian/pkgs_incoming/$new_pkg
    if [ $? != 0 ]; then
        echo "Import of $new_pkg failed, reporting ..."
    else
        rm -rf pkgs_incoming/$new_pkg
    fi
done