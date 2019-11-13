#!/bin/bash
IP_PRIV=`ip addr | grep 'inet ' | grep 'enp0s8' | awk '{print $2}' | sed 's%/.*%%'`
echo "Private network: $IP_PRIV"
IP_PUB=`ip addr | grep 'inet ' | grep 'enp0s8' | awk '{print $2}' | sed 's%/.*%%'`
echo "Public network: $IP_PUB"
if [ "${HOSTNAME}" = "consul01" ]; then
  consul agent -dev -config-dir=/vagrant/consul.d -node=${HOSTNAME} -bind $IP_PRIV -client 0.0.0.0
else
  consul agent -dev -config-file=/vagrant/consul.d/cluster.json -node=${HOSTNAME} -bind $IP_PRIV -client 0.0.0.0
fi
