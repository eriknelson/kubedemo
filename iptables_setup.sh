#!/usr/bin/bash
sudo iptables -I FORWARD -d 192.168.66.2/24 -j ACCEPT
sudo iptables -I FORWARD -d 192.168.66.3/24 -j ACCEPT
sudo iptables -I FORWARD -d 172.18.0.1/16 -j ACCEPT
