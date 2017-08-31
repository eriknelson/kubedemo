#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

output=$(vagrant ssh kube-1-master -c "cat /etc/kubernetes/admin.conf")
echo "${output}" > kube-1-master.conf

echo "alias kk=\"/usr/bin/kubectl --kubeconfig ${_dir}/kube-1-master.conf\"" > kk.source
echo "alias helm=\"KUBECONFIG=${_dir}/kube-1-master.conf helm\"" >> kk.source
