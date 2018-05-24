#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
kubectl create ns privileged

$_dir/render_demosetup_template.sh
$_dir/render_secret_template.sh

kubectl create -f $_dir/secret.yaml
kubectl create -f $_dir/demo-setup.yaml
