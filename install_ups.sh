#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd /git/src/github.com/kubernetes-incubator/service-catalog
helm install charts/ups-broker --name ups-broker --namespace ups-broker
kubectl create -f ./contrib/examples/walkthrough/ups-broker.yaml
popd
