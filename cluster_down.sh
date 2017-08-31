#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

vagrant ssh kube-1-master -c '/vagrant/internal_cluster/_cluster_down.sh'
vagrant ssh kube-2-node -c '/vagrant/internal_cluster/_cluster_down.sh'
