#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export KUBECONFIG=/etc/kubernetes/admin.conf
/usr/bin/kubectl version | base64 | tr -d '\n'
