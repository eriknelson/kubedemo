#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sc_root=$HOME/cluster/src/github.com/kubernetes-incubator/service-catalog
pushd $sc_root/docs
mkdir -p certs && cd certs

which cfssl > /dev/null
if [[ $? -eq 1 ]]; then
  echo "Did not find cfssl bin...go getting it:"
else
  echo "Found cfssl."
fi

echo "Generating certs and sourcing vars..."
source ../../contrib/svc-cat-apiserver-aggregation-tls-setup.sh
echo "Runnig helm install with the following vars:"
echo "HELM_RELEASE_NAME: ${HELM_RELEASE_NAME}"
echo "SVCCAT_NAMESPACE: ${SVCCAT_NAMESPACE}"
echo "SC_SERVICE_CA: ${SC_SERVING_CA}"
echo "SC_SERVICE_CERT: ${SC_SERVING_CERT}"
echo "SC_SERVICE_KEY: ${SC_SERVING_KEY}"

KUBECONFIG=${_dir}/kube-1-master.conf helm install ../../charts/catalog \
    --name ${HELM_RELEASE_NAME} --namespace ${SVCCAT_NAMESPACE} \
    --set apiserver.auth.enabled=true \
        --set useAggregator=true \
        --set apiserver.tls.ca=$(base64 --wrap 0 ${SC_SERVING_CA}) \
        --set apiserver.tls.cert=$(base64 --wrap 0 ${SC_SERVING_CERT}) \
        --set apiserver.tls.key=$(base64 --wrap 0 ${SC_SERVING_KEY})

echo "Deployment complete."
popd
