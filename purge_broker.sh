#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BROKER_DIR=/git/src/github.com/openshift/ansible-service-broker
export APB_IMAGE=docker.io/eriknelson/automation-broker-apb

echo "Purging broker"

pushd $BROKER_DIR
make undeploy
popd
