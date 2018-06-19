#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd /git/src/github.com/kubernetes-incubator/service-catalog
kubectl create -f $_dir/ups-broker.yaml
popd
