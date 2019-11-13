#!/bin/bash
docker run --rm --network host --name client-proxy \
  consul-envoy -sidecar-for client -admin-bind localhost:19001
