#!/bin/bash
source "/vagrant/scripts/common.sh"

function disableFirewall {
	echo "disabling firewall"
	/sbin/iptables-save
	ufw disable
}

function installUtilities {
	echo "install utilities"
	# for mongodb
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
	echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

	# run docker command inside docker http://www.therightcode.net/run-docker-into-a-container-on-a-mac/
	apt-get update -y && apt-get upgrade -y
	apt-get install -y curl
	curl -sSL https://get.docker.com/ubuntu/ | sh

	# install swarm https://github.com/docker/swarm/ http://docs.docker.com/swarm/
	#apt-get install -y golang git
	#/bin/mkdir -p /usr/local/src/gocode; export GOPATH=/usr/local/src/gocode
	#go get github.com/tools/godep
	#cd /usr/local/src/
	#git clone https://github.com/docker/swarm
	#cd swarm
	#$GOPATH/bin/godep go install .

	# install nginx as reverse proxy https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-14-04
	apt-get -y install nginx

	# install node.js npm
	apt-get -y install build-essential openssl libssl-dev pkg-config
	apt-get -y install nodejs nodejs-dev npm
	ln -s /usr/bin/nodejs  /usr/bin/node

	# install and build latest version of nodejs
	# if resourceExists /vagrant/resources/node-v0.12.0.tar.gz; then
	#	echo "install node.js from local file"
	# else
	#	curl -o /vagrant/resources/node-v0.12.0.tar.gz -O -L http://nodejs.org/dist/v0.12.0/node-v0.12.0.tar.gz
	# fi
	# tar -xzf /vagrant/resources/node-v0.12.0.tar.gz -C /usr/local
	# ln -s /usr/local/node-v0.12.0 /usr/local/node
	# cd /usr/local/node
	# ./configure
	# make
	# make install

    # install the latest version of npm
	# curl -o /vagrant/resources/install.sh -O --insecure -L https://npmjs.org/install.sh
	# /vagrant/resources/install.sh

	# configure the npm path
	npm config set prefix "/usr/local/"
	# npm config set cache "/usr/local/node-cache"

	# install node.js app of http-server https://github.com/nodeapps/http-server
    # npm install -g http-server

	# install the latest version of express (node.js framework http://expressjs.com/) exmaple http://www.cnblogs.com/zhongweiv/p/nodejs_express.html
	npm install -g express
	npm install -g express-generator
	# apt-get -y install node-express

	# create a project
	# express -e demoapp
	# install dependence
	# cd demoapp && npm install
	# run the app
	# DEBUG=demoapp:* ./bin/www

	# install mongodb for node.js http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
	apt-get install -y mongodb-org
	npm install -g session-mongoose
	npm install -g express-session cookie-parser
}
echo "setup ubuntu"

disableFirewall
installUtilities