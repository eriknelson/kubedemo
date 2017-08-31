#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
${_dir}/cluster_down.sh
${_dir}/cluster_up.sh
