#!/bin/bash
#--pod-network-cidr=10.244.0.0/16
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
_host=$(hostname)
export KUBECONFIG=/etc/kubernetes/admin.conf

if [[ "${_host}" == "kube-1-master.example.com" ]]; then
  echo "Running on master, running re-init"
  sudo /usr/bin/kubeadm init \
    --token=$(cat /var/www/html/token) \
    --apiserver-advertise-address=192.168.66.2
  sudo chown vagrant:vagrant /etc/kubernetes/admin.conf

  echo "Applying romana networking"
  /usr/bin/kubectl apply -f \
    "https://raw.githubusercontent.com/romana/romana/master/containerize/specs/romana-kubeadm.yml"
else
  echo "Running on node, trying to join up with the cluster..."
  token=$(curl http://kube-1-master/token)
  sudo /usr/bin/kubeadm join kube-1-master:6443 --token=${token}
fi
