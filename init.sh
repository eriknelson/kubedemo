#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
${_dir}/start_minikube.sh
${_dir}/permission_ks.sh
${_dir}/setup_tiller.sh
echo "Sleeping for 5s to wait for tiller."
sleep 5s
${_dir}/install_service_catalog.sh
