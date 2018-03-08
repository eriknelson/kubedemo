#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sc_root=$GOPATH/src/github.com/kubernetes-incubator/service-catalog
charts=$sc_root/charts/catalog
HELM_RELEASE_NAME=catalog
SVCCAT_NAMESPACE=catalog

~/bin/helm install \
  -f $charts/values.yaml \
  --name ${HELM_RELEASE_NAME} \
  --namespace ${SVCCAT_NAMESPACE} \
  $charts/Chart.yaml
