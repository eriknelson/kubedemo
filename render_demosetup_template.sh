#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
templ=$_dir/templates/demo-setup.templ.yaml
output_dir=$_dir/.output
mkdir -p ${output_dir}
outfile=$output_dir/demo-setup.yaml
CLIENT_TOKEN_NAME=$(kubectl get secrets -n automation-broker | grep 'automation-broker-client-token-*' | awk '{print $1}')
BROKER_CA_CERT=$(kubectl get secret -n automation-broker automation-broker-tls -o yaml | grep 'tls\.crt' | awk '{print $2}')
echo $BROKER_CA_CERT
echo $CLIENT_TOKEN_NAME
cat $templ | sed "s|%%CLIENT_TOKEN_NAME%%|${CLIENT_TOKEN_NAME}|" > $outfile
cat $templ | sed -i "s|%%BROKER_CA_CERT%%|${BROKER_CA_CERT}|" $outfile
cat $outfile
