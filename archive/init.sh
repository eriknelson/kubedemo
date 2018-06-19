#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
${_dir}/start_minikube.sh
#${_dir}/permission_ks.sh
${_dir}/setup_tiller.sh
