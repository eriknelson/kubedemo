#!/usr/bin/bash
iptables -I FORWARD -d 192.168.66.2/24 -j ACCEPT
iptables -I FORWARD -d 192.168.66.3/24 -j ACCEPT
