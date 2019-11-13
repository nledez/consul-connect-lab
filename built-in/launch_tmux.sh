#!/bin/bash
TMUX_SESSION="ConsulConnect"

if [ "$1" = "kill" ]; then
	echo "Kill everything"
	tmux send-keys  -t consul        C-c C-m "exit" C-m
	tmux send-keys  -t socat         C-c C-m "exit" C-m
	tmux send-keys  -t sidecar_socat C-c C-m "exit" C-m
	tmux send-keys  -t proxy_web     C-c C-m "exit" C-m
	tmux send-keys  -t sidecar_web   C-c C-m "exit" C-m
	tmux send-keys  -t console       C-c C-m "exit" C-m
	exit 0
fi

tmux has-session -t ${TMUX_SESSION}
if [ $? != 0 ]; then
	echo "Creation ${TMUX_SESSION} session"
	tmux new-session -s ${TMUX_SESSION} -n ${TMUX_SESSION} -d
	tmux set-option base-index 1
	tmux send-keys -t ${TMUX_SESSION} "exit" C-m
	tmux new-window -n console
	tmux new-window -n consul
	tmux new-window -n socat
	tmux new-window -n sidecar_socat
	tmux new-window -n proxy_web
	tmux new-window -n sidecar_web
	tmux send-keys  -t consul        "/vagrant/launch_01_consul.sh"                         C-m
	tmux send-keys  -t socat         "sleep 1 && /vagrant/launch_02_socat.sh"               C-m
	tmux send-keys  -t sidecar_socat "sleep 2 && /vagrant/launch_03_proxy_sidecar_socat.sh" C-m
	tmux send-keys  -t proxy_web     "sleep 3 && /vagrant/launch_04_proxy_service_web.sh"   C-m
	tmux send-keys  -t sidecar_web   "sleep 4 && /vagrant/launch_05_proxy_sidecar_web.sh"   C-m
	tmux send-keys  -t console       "cat /vagrant/README.md"                               C-m
fi
tmux attach -t ${TMUX_SESSION}
