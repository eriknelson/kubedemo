#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
_host=$(hostname)

if [[ "${_host}" == "kube-1-master.example.com" ]]; then
  echo "Running on master, draining nodes, deleting nodes, and resetting"
  export KUBECONFIG=/etc/kubernetes/admin.conf
  /usr/bin/kubectl drain kube-2-node.example.com --delete-local-data --force --ignore-daemonsets
  /usr/bin/kubectl delete node kube-2-node.example.com
  sudo /usr/bin/kubeadm reset
else
  echo "Running on node, resetting"
  sudo /usr/bin/kubeadm reset
fi
