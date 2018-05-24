#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
~/bin/minikube start --extra-config=apiserver.Authorization.Mode=RBAC --vm-driver=kvm2
#sleep 2s
#kubectl create clusterrolebinding kube-system-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default
