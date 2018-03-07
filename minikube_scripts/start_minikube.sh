#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkbin=~/bin/minikube
$mkbin start --extra-config=apiserver.Authorization.Mode=RBAC --vm-driver=kvm2
