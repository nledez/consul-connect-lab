#!/bin/bash
docker run --rm -v/vagrant/consul.d/envoy_demo.hcl:/etc/consul/envoy_demo.hcl \
  --network host --name consul-agent consul:latest \
  agent -dev -config-file /etc/consul/envoy_demo.hcl
