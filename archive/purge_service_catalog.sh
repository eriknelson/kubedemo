#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export KUBECONFIG=${_dir}/kube-1-master.conf
helm del --purge catalog
