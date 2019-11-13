#!/bin/bash
consul agent -dev -config-dir=/vagrant/consul.d -node=machine -bind 0.0.0.0 -client 0.0.0.0
