#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
chart=${_dir}/catalog-chart
HELM_RELEASE_NAME=catalog
SVCCAT_NAMESPACE=catalog

~/bin/helm install \
  --name ${HELM_RELEASE_NAME} \
  --namespace ${SVCCAT_NAMESPACE} \
  $chart
