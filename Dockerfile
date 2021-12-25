FROM alpine:3.9.4
MAINTAINER Archef

LABEL org.label-schema.vcs-url="https://github.com/Archef2000/sslh" \
      org.label-schema.docker.cmd="docker run [--cap-add NET_ADMIN] -e SSH_HOST=host -e HTTP_HOST=host -e HTTPS_HOST=host -e OPENVPN_HOST=host -e SHADOWSOCKS_HOST=host -p 443:8443 -p 80:80 archef2000/sslh" \
      org.label-schema.docker.params="SSH_HOST=host running sshd,SSH_PORT=port to connect to SSH_HOST on. Default: 22,HTTPS_HOST=host running HTTPS server, HTTPS_PORT=port to connect to HTTPS_HOST on. Default: 443,OPENVPN_HOST=host running openvpn,OPENVPN_PORT=port to connect to OPENVPN_HOST on. Default: 1194,SHADOWSOCKS_HOST=host running shadowsocks,SHADOWSOCKS_PORT=port to connect to SHADOWSOCKS_HOST on. Default:8388,TRANSPARENT=run sslh as a transparent proxy (requires --cap-add NET_ADMIN)" \
      org.label-schema.schema-version="1.0" \
      maintainer="Archef2000"
      
RUN apk update && \
       apk add --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ sslh && \
       rm -rf /var/cache/apk/*

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/bin/sh", "/usr/local/bin/entrypoint.sh"]