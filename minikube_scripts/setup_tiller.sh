#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
~/bin/helm init && ${_dir}/permission_tiller.sh
