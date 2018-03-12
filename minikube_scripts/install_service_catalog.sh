#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sc_root=$GOPATH/src/github.com/kubernetes-incubator/service-catalog
chart=$sc_root/charts/catalog
HELM_RELEASE_NAME=catalog
SVCCAT_NAMESPACE=catalog

~/bin/helm install \
  --name ${HELM_RELEASE_NAME} \
  --namespace ${SVCCAT_NAMESPACE} \
  $chart
