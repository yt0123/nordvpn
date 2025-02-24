ARG NORDVPN_VERSION=3.17.0
FROM nordvpn:${NORDVPN_VERSION}

ENV TINYPROXY_VERSION=1.11.2

RUN set -eux; \
        microdnf install -y --enablerepo=crb epel-release; \
        microdnf install -y \
            tinyproxy-${TINYPROXY_VERSION}; \
        microdnf clean all; \
        tinyproxy -v

EXPOSE 8888

CMD ["tinyproxy", "-d"]
