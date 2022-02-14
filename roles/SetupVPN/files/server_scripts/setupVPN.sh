#!/bin/bash

    ip=`curl ifconfig.me` &&
    docker volume create --name vpn_data &&
    docker run -v vpn_data:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u ${ip} &&
    docker run -v vpn_data:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn ovpn_initpki &&
    docker run -v vpn_data:/etc/openvpn -v ~/scripts/openvpn.conf:/etc/openvpn/openvpn.conf -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn
