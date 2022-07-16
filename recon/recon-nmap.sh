#!/bin/bash


REQUIRED_PKG="nmap"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG
fi
echo "type the IP address of target"
read $ipaddress

nmap -T4 -sC -sV --script=vuln -oN target.txt $ipaddress 
 
