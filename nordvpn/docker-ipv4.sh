#!/bin/bash

DEFAULT_GATEWAY_IF="$(ip route show default | awk '{print $5}')"
CONTAINER_IP="$(ip -4 -o addr show dev "$DEFAULT_GATEWAY_IF" | awk '{print $4}')"

echo "$CONTAINER_IP"
