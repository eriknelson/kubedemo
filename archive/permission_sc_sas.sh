#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export KUBECONFIG=${_dir}/kube-1-master.conf
kcmd="/usr/bin/kubectl --kubeconfig ${KUBECONFIG}"

$kcmd create clusterrolebinding service-catalog-apiserver --clusterrole=cluster-admin --serviceaccount=catalog:service-catalog-apiserver
$kcmd create clusterrolebinding service-catalog-controller-manager --clusterrole=cluster-admin --serviceaccount=catalog:service-catalog-controller-manager
