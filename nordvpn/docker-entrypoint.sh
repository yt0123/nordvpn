#!/bin/bash

set -eo pipefail

# Run nordvpnd as daemon
/nordvpnd.sh

while [ ! -S /run/nordvpn/nordvpnd.sock ]; do
    sleep 1
done

# Disable analytics
nordvpn set analytics disabled >/dev/null

# Set Docker IPv4 subnet to whitelist
nordvpn whitelist add subnet "$(/docker-ipv4.sh)" >/dev/null

# Login automatically if token is present
if [ -n "$NORDVPN_TOKEN" ]; then
    nordvpn login --token "$NORDVPN_TOKEN" || {
        echo "Invalid token."
        exit 1
    }
fi

# Run VPN automatically if connect option is present
if [ -n "$NORDVPN_CONNECT" ]; then
    nordvpn connect "$NORDVPN_CONNECT" || {
        echo "Connection failed."
        exit 1
    }
fi

exec "$@"
