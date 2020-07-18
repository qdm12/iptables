ARG ALPINE_VERSION=3.12

FROM alpine:${ALPINE_VERSION}
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF
LABEL \
    org.opencontainers.image.authors="quentin.mcgaw@gmail.com" \
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.version=$VERSION \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.url="https://github.com/qdm12/iptables" \
    org.opencontainers.image.documentation="https://github.com/qdm12/iptables" \
    org.opencontainers.image.source="https://github.com/qdm12/iptables" \
    org.opencontainers.image.title="Small container to run iptables rules for your host" \
    org.opencontainers.image.description="Small container to run iptables rules for your host"
RUN apk add --no-cache -q --progress --update iptables
ENV PRIVATE_IPS=10.0.0.0/8,172.16.0.0/12,192.168.0.0/16
ENTRYPOINT [ "/rules.sh" ]
