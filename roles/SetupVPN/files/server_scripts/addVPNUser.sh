#!/bin/bash

[ -z $1 ] && echo "Use $0 clientname" && exit 0

clientName=${1}

docker run -v vpn_data:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn easyrsa build-client-full ${clientName} nopass &&
    docker run -v vpn_data:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_getclient ${clientName} > ${clientName}.ovpn
