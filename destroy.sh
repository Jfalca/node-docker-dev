#!/bin/bash
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

echo " -> Removing links... "
sudo rm /usr/local/bin/node
sudo rm /usr/local/bin/npm
sudo rm /usr/local/bin/yarn
sudo rm /usr/local/bin/pnpm
echo ✔ Done.

echo " -> Destroying containers... "
make down
ls -la /usr/local/bin
echo ✔ Done.