#!/bin/bash
# set -x
BASE=/vagrant
CONSUL_VERSION="1.6.1"
CONSUL_ZIP="consul_${CONSUL_VERSION}_linux_amd64.zip"
CONSUL_URL="https://releases.hashicorp.com/consul/${CONSUL_VERSION}/${CONSUL_ZIP}"
PACKAGE_2_INSTALL=

which unzip >/dev/null 2>&1
if [ "$?" != "0" ]; then
	PACKAGE_2_INSTALL="${PACKAGE_2_INSTALL} unzip"
fi

which socat >/dev/null 2>&1
if [ "$?" != "0" ]; then
	PACKAGE_2_INSTALL="${PACKAGE_2_INSTALL} socat"
fi

if [ "${PACKAGE_2_INSTALL}" != "" ]; then
	echo "Install: ${PACKAGE_2_INSTALL}"
	sudo apt-get update -q
	sudo apt-get -qy install ${PACKAGE_2_INSTALL}
fi

if [[ ! -f ${BASE}/${CONSUL_ZIP} || ! -f /usr/local/bin/consul ]]; then
	wget -O ${BASE}/${CONSUL_ZIP} "${CONSUL_URL}"
	sudo unzip -o -d /usr/local/bin/ ${BASE}/${CONSUL_ZIP}
fi
