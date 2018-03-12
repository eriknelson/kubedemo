#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sudo $_dir/iptables_setup.sh

sudo bash -c "echo \"192.168.66.2 kube-1-master kube-1-master.example.com\" >> /etc/hosts"
sudo bash -c "echo \"192.168.66.3 kube-2-node kube-2-node.example.com\" >> /etc/hosts"
