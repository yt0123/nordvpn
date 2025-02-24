#!/bin/bash

set -eo pipefail

# Run nordvpnd as daemon
/nordvpnd.sh

# Set Docker IPv4 subnet to whitelist
nordvpn whitelist add subnet "$(/docker-ipv4.sh)" > /dev/null || {
    echo "Docker IPv4 subnet already whitelisted."
}

# Disable analytics
if [ "$(nordvpn settings | awk '/^Analytics:/ {print $2}')" = "enabled" ]; then
    nordvpn set analytics disabled >/dev/null
fi

# Login automatically if token is present
if [ -n "$NORDVPN_TOKEN" ]; then
    if nordvpn account >/dev/null; then
        echo "Already logged in."
    else
        nordvpn login --token "$NORDVPN_TOKEN" || {
            echo "Invalid token."
            exit 1
        }
    fi
fi

# Run VPN automatically if connect option is present
if [ -n "$NORDVPN_CONNECT" ]; then
    nordvpn connect "$NORDVPN_CONNECT" || {
        echo "Connection failed."
        exit 1
    }
fi

exec "$@"
