#!/bin/bash
source "/vagrant/scripts/common.sh"

function disableFirewall {
	echo "disabling firewall"
	/sbin/iptables-save
	ufw disable
}

function installUtilities {
	echo "install utilities"
	apt-get update
	apt-get -y install docker.io
	apt-get -y install zip
	service docker.io start
}
echo "setup centos"

disableFirewall
installUtilities