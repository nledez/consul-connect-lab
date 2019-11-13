#!/bin/bash
docker run --rm --network host --name echo-proxy \
  consul-envoy -sidecar-for echo
