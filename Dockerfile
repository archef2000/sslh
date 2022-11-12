FROM alpine:3.15 as build
RUN apk add libconfig-dev pcre2-dev musl-dev libev-dev make automake g++ wget git && \
      #git clone https://github.com/yrutschle/sslh && \
      #cd sslh && \
      wget https://codeload.github.com/yrutschle/sslh/zip/refs/tags/v2.0-rc1 && \
      unzip v2.0-rc1 && \
      cd sslh-2.0-rc1/ && \
      sed -i 's/conf2struct/#conf2struct/g' Makefile && \
      ls && \
      /bin/sh -c make && \
      mkdir /sslh && \
      cp sslh-fork /sslh/sslh-fork && \
      ls

#
#ADD . /sslh
#
#RUN \
#  apk add \
#    gcc \
#    libconfig-dev \
#    make \
#    musl-dev \
#    pcre2-dev \
#    perl && \
#  cd /sslh && \
#  make systemd-sslh-generator && \
#  make sslh-select
#  #&& \
#  # && \
#  #strip sslh-select

FROM alpine:3.15.0
MAINTAINER Archef2000

#ENV SSH_HOST=localhost
#ENV HTTP_HOST=localhost
#ENV HTTPS_HOST=localhost
#ENV OPENVPN_HOST=localhost
#ENV SHADOWSOCKS_HOST=localhost
#ENV SOCKS5_HOST=localhost

LABEL org.label-schema.vcs-url="https://github.com/Archef2000/sslh" \
      org.label-schema.docker.cmd="docker run [--cap-add NET_ADMIN] -e SSH_HOST=host -e HTTP_HOST=host -e HTTPS_HOST=host -e OPENVPN_HOST=host -e SHADOWSOCKS_HOST=host -p 443:8443 -p 80:80 archef2000/sslh" \
      org.label-schema.docker.params="SSH_HOST=host running sshd,SSH_PORT=port to connect to SSH_HOST on. Default: 22,HTTPS_HOST=host running HTTPS server, HTTPS_PORT=port to connect to HTTPS_HOST on. Default: 443,OPENVPN_HOST=host running openvpn,OPENVPN_PORT=port to connect to OPENVPN_HOST on. Default: 1194,SHADOWSOCKS_HOST=host running shadowsocks,SHADOWSOCKS_PORT=port to connect to SHADOWSOCKS_HOST on. Default:8388,TRANSPARENT=run sslh as a transparent proxy (requires --cap-add NET_ADMIN)" \
      org.label-schema.schema-version="1.0" \
      maintainer="Archef2000"
      
RUN apk --no-cache add libconfig pcre2
COPY --from=build /sslh/sslh-fork /usr/local/bin/sslh
RUN chmod +x /usr/local/bin/sslh
#RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ sslh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/bin/sh", "/usr/local/bin/entrypoint.sh"]
