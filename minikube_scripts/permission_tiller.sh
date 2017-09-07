#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#export KUBECONFIG=${_dir}/kube-1-master.conf
kcmd="/usr/bin/kubectl"
$kcmd create serviceaccount --namespace kube-system tiller
$kcmd create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
$kcmd patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
