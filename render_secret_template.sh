#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
templ=templates/secret.templ.yaml
output_dir=$_dir/.output
mkdir -p ${output_dir}
outfile=$output_dir/secret.yaml
CLIENT_TOKEN_NAME=$(kubectl get secrets -n automation-broker | grep 'automation-broker-client-token-*' | awk '{print $1}')
CA_CERT=$(kubectl get secret -n automation-broker $CLIENT_TOKEN_NAME -o yaml | grep 'ca\.crt:' | awk '{print $2}')
TOKEN=$(kubectl get secret -n automation-broker $CLIENT_TOKEN_NAME -o yaml | grep 'token:' | awk '{print $2}')
echo $TOKEN
cat $_dir/$templ | sed "s/%%CA_CERT%%/${CA_CERT}/" > $outfile
sed -i "s/%%TOKEN%%/${TOKEN}/" $outfile
sed -i "s|%%SECRET_NAME%%|${CLIENT_TOKEN_NAME}|" $outfile
cat $outfile
