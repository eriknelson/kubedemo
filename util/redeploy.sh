#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
${_dir}/purge_service_catalog.sh && ${_dir}/install_service_catalog.sh
