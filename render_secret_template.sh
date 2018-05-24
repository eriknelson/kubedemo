#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
templ=secret.templ.yaml
outfile=secret.yaml
CLIENT_TOKEN_NAME=$(kubectl get secrets -n automation-broker | grep 'automation-broker-client-token-*' | awk '{print $1}')
CA_CERT=$(kubectl get secret -n automation-broker $CLIENT_TOKEN_NAME -o yaml | grep 'ca\.crt:' | awk '{print $2}')
TOKEN=$(kubectl get secret -n automation-broker $CLIENT_TOKEN_NAME -o yaml | grep 'token:' | awk '{print $2}')
echo $TOKEN
cat $_dir/$templ | sed "s/%%CA_CERT%%/${CA_CERT}/" > $_dir/$outfile
sed -i "s/%%TOKEN%%/${TOKEN}/" $_dir/$outfile
sed -i "s|%%SECRET_NAME%%|${CLIENT_TOKEN_NAME}|" $_dir/$outfile
cat $outfile
