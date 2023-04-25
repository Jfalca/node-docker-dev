#!/bin/bash
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root"
    echo "Please run this script with sudo:"
    echo "ex: sudo ./build.sh"
    exit
fi

echo " -> Mounting containers... "
make up

echo " -> Mounting links... "
sudo ln -s "${PWD}"/links/run-node.sh /usr/local/bin/node
sudo ln -s "${PWD}"/links/run-npm.sh /usr/local/bin/npm
sudo ln -s "${PWD}"/links/run-yarn.sh /usr/local/bin/yarn
sudo ln -s "${PWD}"/links/run-pnpm.sh /usr/local/bin/pnpm

ls -la /usr/local/bin
echo ✔ Done.
echo ""
echo node $(node -v)
echo npm $(npm -v)
echo yarn $(yarn -v)
echo pnpm $(pnpm -v)