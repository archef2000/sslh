FROM arm32v6/alpine:latest
MAINTAINER Archef

ENV LISTEN_IP 0.0.0.0
ENV LISTEN_PORT 80
# ENV LISTEN2_IP 0.0.0.0
# ENV LISTEN2_PORT 443
ENV SSH_HOST localhost
ENV SSH_PORT 22
ENV OPENVPN_HOST localhost
ENV OPENVPN_PORT 1194
ENV HTTPS_HOST localhost
ENV HTTPS_PORT 8443
# ENV HTTP_HOST localhost
# ENV HTTP_PORT 8080

RUN apk update && \
       apk add --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ sslh && \
       rm -rf /var/cache/apk/*

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
