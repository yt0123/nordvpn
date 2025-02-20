ARG NORDVPN_VERSION=3.17.0
FROM nordvpn:${NORDVPN_VERSION}

ENV TRANSMISSION_VERSION=4.0.5
ENV TRANSMISSION_HOME=/var/lib/transmission

RUN set -eux; \
        microdnf install -y --enablerepo=crb epel-release; \
        microdnf install -y \
            transmission-cli-${TRANSMISSION_VERSION} \
            transmission-common-${TRANSMISSION_VERSION} \
            transmission-daemon-${TRANSMISSION_VERSION}; \
        microdnf clean all; \
        transmission-daemon --version; \
        transmission-cli --version

EXPOSE 9091

CMD ["transmission-daemon", "-f", "--log-level=info"]
