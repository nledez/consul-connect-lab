#!/bin/bash
consul connect proxy -service web -upstream socat:9191
