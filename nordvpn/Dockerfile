FROM almalinux:9.5-minimal

ARG NORDVPN_VERSION=3.20.0

RUN set -eu; \
        { \
            echo '[nordvpn]'; \
            echo 'name=NordVPN'; \
            echo 'baseurl=https://repo.nordvpn.com/yum/nordvpn/centos/x86_64/'; \
            echo 'enabled=1'; \
            echo 'gpgcheck=1'; \
            echo 'gpgkey=https://repo.nordvpn.com/gpg/nordvpn_public.asc'; \
        } | tee /etc/yum.repos.d/nordvpn.repo

RUN set -eux; \
        rpm -v --import https://repo.nordvpn.com/gpg/nordvpn_public.asc; \
        microdnf install -y "nordvpn-$NORDVPN_VERSION"; \
        microdnf clean all; \
        nordvpn -version

COPY nordvpnd.sh /
COPY docker-ipv4.sh /
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
