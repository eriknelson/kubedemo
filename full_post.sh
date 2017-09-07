#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

${_dir}/post.sh
${_dir}/install_tiller.sh # helm init -- installs *unpermissioned* tiller pod
${_dir}/permission_tiller.sh # Sets up appropriate roles for tiller
${_dir}/permission_sc_sas.sh # sets up rolebindings for the catalog
source ${_dir}/kk.source # sets up rolebindings for the catalog

## Need to wait for tiller to come up for this
# helm install of the catalog. Also importantly generates certs and mounts
# catalog as part the aggregation server
# ${_dir}/install_service_catalog.sh

# run prep_local scripts and fire up broker on local host with make run

# Make sure .kube/config context is configured to point to 172.17.0.1 origin cluster

# Create the broker resource in the catalog
# kk create -f broker.yaml

# Confirm catalog calls coming in from 192.168.66.3, or kube-2-node!
# kk get servicebrokers should list the broker
# kk get serviceclasses should list the available service classes
