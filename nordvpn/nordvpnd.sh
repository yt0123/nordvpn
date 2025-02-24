#!/bin/bash

set -euo pipefail

SOCKET_DIR=/run/nordvpn
PID_FILE=$SOCKET_DIR/nordvpn.pid
SOCKET_FILE=$SOCKET_DIR/nordvpnd.sock

LOG_FILE=/var/log/nordvpn/daemon.log

if [ -f "$PID_FILE" ]; then
    if kill -0 $(cat "$PID_FILE") 2>/dev/null; then
        echo "Daemon already running."
        exit 1
    fi
    # WARNING:
    #   This condition implies that the daemon is not running but the PID file exists.
    #   Run a daemon with new socket and overwrite the PID file.
    if [ -S "$SOCKET_FILE" ]; then
        unlink "$SOCKET_FILE"
    fi
fi

mkdir -p "$SOCKET_DIR"

nohup /usr/sbin/nordvpnd > "$LOG_FILE" 2>&1 &
echo $! > "$PID_FILE"

while [ ! -S "$SOCKET_FILE" ]; do
    sleep 1
done

echo "NordVPN daemon started successfully."
