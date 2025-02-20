.PHONY: build run

VERSION := 3.17.0

build:
	@docker build --build-arg NORDVPN_VERSION=$(VERSION) -t nordvpn:$(VERSION) .

run:
	@docker run -it --rm --name vpn \
		--env NORDVPN_TOKEN=$(NORDVPN_TOKEN) \
		--env NORDVPN_CONNECT=$(NORDVPN_CONNECT) \
		--cap-add NET_ADMIN \
		--sysctl net.ipv6.conf.all.disable_ipv6=1 \
		nordvpn:$(VERSION) /bin/bash
	@true
