#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BROKER_DIR=/git/src/github.com/openshift/ansible-service-broker
BROKER_SCRIPTS_DIR=${BROKER_DIR}/scripts

echo "Installing k8s deployment of ASB"
pushd $BROKER_SCRIPTS_DIR
./run_latest_k8s_build.sh
popd
