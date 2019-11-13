#!/bin/bash
socat -v tcp-l:8181,fork exec:"/bin/cat"
