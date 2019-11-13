#!/bin/bash
# set -x
BASE=/vagrant
CONSUL_VERSION="1.6.1"
CONSUL_ZIP="consul_${CONSUL_VERSION}_linux_amd64.zip"
CONSUL_URL="https://releases.hashicorp.com/consul/${CONSUL_VERSION}/${CONSUL_ZIP}"
PACKAGE_2_INSTALL=

if [ "${HOSTNAME}" = "consul01" ]; then
  which apt-cacher-ng >/dev/null 2>&1
  if [ "$?" != "0" ]; then
    PACKAGE_2_INSTALL="${PACKAGE_2_INSTALL} apt-cacher-ng"
  fi
  if [ "${PACKAGE_2_INSTALL}" != "" ]; then
    echo "Install: ${PACKAGE_2_INSTALL}"
    sudo apt-get update -q
    sudo apt-get -qy install ${PACKAGE_2_INSTALL}
  fi
fi

if [ ! -f /etc/apt/apt.conf.d/02proxy ]; then
  echo 'Acquire::http::proxy "http://192.168.50.11:3142";' | sudo tee /etc/apt/apt.conf.d/02proxy
fi

which unzip >/dev/null 2>&1
if [ "$?" != "0" ]; then
  PACKAGE_2_INSTALL="${PACKAGE_2_INSTALL} unzip"
fi

if [ "${HOSTNAME}" = "consul01" ]; then
  which socat >/dev/null 2>&1
  if [ "$?" != "0" ]; then
    PACKAGE_2_INSTALL="${PACKAGE_2_INSTALL} socat"
  fi

  which docker >/dev/null 2>&1
  if [ "$?" != "0" ]; then
    PACKAGE_2_INSTALL="${PACKAGE_2_INSTALL} docker.io"
  fi
fi

if [ "${PACKAGE_2_INSTALL}" != "" ]; then
  echo "Install: ${PACKAGE_2_INSTALL}"
  sudo apt-get update -q
  sudo apt-get -qy install ${PACKAGE_2_INSTALL}
fi

unzip -l ${BASE}/${CONSUL_ZIP} >/dev/null 2>&1
if [ "$?" != "0" ]; then
  rm ${BASE}/${CONSUL_ZIP}
fi
if [[ ! -f ${BASE}/${CONSUL_ZIP} || ! -f /usr/local/bin/consul ]]; then
  if [[ ! -f ${BASE}/${CONSUL_ZIP} ]]; then
    echo "Download ${BASE}/${CONSUL_ZIP}"
    wget --progress=dot -O ${BASE}/${CONSUL_ZIP} "${CONSUL_URL}"
  fi
  sudo unzip -o -d /usr/local/bin/ ${BASE}/${CONSUL_ZIP}
fi

if [ "${HOSTNAME}" = "consul01" ]; then
  sudo -u vagrant id | grep -q docker
  if [ "$?" != "0" ]; then
    sudo adduser vagrant docker
  fi

  docker images | grep -q consul-envoy
  if [ "$?" != "0" ]; then
    docker build --file /vagrant/Dockerfile-consul-envoy -t consul-envoy .
  fi

  for image in abrarov/tcp-echo consul:latest; do
    docker images | grep -q $image
    if [ "$?" != "0" ]; then
      docker pull $image
    fi
  done
fi
