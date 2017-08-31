#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

${_dir}/post.sh
${_dir}/install_tiller.sh
${_dir}/permission_tiller.sh
${_dir}/permission_sc_sas.sh

## Need to wait for tiller to come up for this
#${_dir}/install_service_catalog.sh

## Need the SC to be up
# kk create -f broker.yaml
