#!/bin/bash

set -euo pipefail

SOCKET_DIR=/run/nordvpn
PID_FILE=/run/nordvpn/nordvpn.pid
LOG_FILE=/var/log/nordvpn/daemon.log

if [ -f "$PID_FILE" ]; then
    echo "Daemon already running."
    exit 1
fi

mkdir -p "$SOCKET_DIR"

nohup /usr/sbin/nordvpnd > "$LOG_FILE" 2>&1 &
echo $! > "$PID_FILE"
