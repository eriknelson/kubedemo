#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BROKER_DIR=/git/src/github.com/openshift/ansible-service-broker
export APB_IMAGE=docker.io/eriknelson/automation-broker-apb
export BROKER_IMAGE=docker.io/ansibleplaybookbundle/origin-ansible-service-broker:canary

echo "Installing k8s deployment of ASB"

pushd $BROKER_DIR
make deploy
popd
