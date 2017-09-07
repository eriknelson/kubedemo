#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkbin=${_dir}/req-header-mk
#mkbin=minikube
$mkbin start --extra-config=apiserver.Authorization.Mode=RBAC --vm-driver=kvm
