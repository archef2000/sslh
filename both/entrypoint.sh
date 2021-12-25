#!/bin/sh

sslh -f -u root --listen $LISTEN_IP:$LISTEN_PORT --listen $LISTEN2_IP:$LISTEN2_PORT \
   --ssh $SSH_HOST:$SSH_PORT \
   --tls $HTTPS_HOST:$HTTPS_PORT \
   --http $HTTP_HOST:$HTTP_PORT \  
   --openvpn $OPENVPN_HOST:$OPENVPN_PORT
