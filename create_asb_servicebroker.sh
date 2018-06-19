#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
kubectl create ns foo
output_dir=$_dir/.output

$_dir/render_demosetup_template.sh
$_dir/render_secret_template.sh

kubectl create -f $output_dir/secret.yaml
kubectl create -f $output_dir/demo-setup.yaml
