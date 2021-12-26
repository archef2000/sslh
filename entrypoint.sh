#!/bin/sh
SSLH_OPTS=
[ ! -z "${SSH_HOST}" ] && SSLH_OPTS="${SSLH_OPTS} --ssh ${SSH_HOST}:${SSH_PORT:=22}"
[ ! -z "${HTTPS_HOST}" ] && SSLH_OPTS="${SSLH_OPTS} --tls ${HTTPS_HOST}:${HTTPS_PORT:=443}"
[ ! -z "${OPENVPN_HOST}" ] && SSLH_OPTS="${SSLH_OPTS} --openvpn ${OPENVPN_HOST}:${OPENVPN_PORT:=1194}"
[ ! -z "${SHADOWSOCKS_HOST}" ] && SSLH_OPTS="${SSLH_OPTS} --anyprot ${SHADOWSOCKS_HOST}:${SHADOWSOCKS_PORT:=8388}"
[ ! -z "${HTTP_HOST}" ] && SSLH_OPTS="${SSLH_OPTS} --http ${HTTP_HOST}:${HTTP_PORT:=80}"

sslh -f -u sslh --listen 0.0.0.0:80 --listen 0.0.0.0:443 \
   ${SSLH_OPTS} \
   $@
