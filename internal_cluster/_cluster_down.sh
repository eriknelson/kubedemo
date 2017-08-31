#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
_host=$(hostname)
export KUBECONFIG=/vagrant/kube-1-master.conf

if [[ "${_host}" == "kube-1-master.example.com" ]]; then
  echo "Running on master, draining nodes, deleting nodes, and resetting"
  /usr/bin/kubectl drain kube-2-node.example.com --delete-local-data --force --ignore-daemonsets
  /usr/bin/kubectl delete node kube-2-node.example.com
  sudo /usr/bin/kubeadm reset
else
  echo "Running on node, resetting"
  sudo /usr/bin/kubeadm reset
fi
