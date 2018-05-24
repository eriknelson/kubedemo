#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
templ=demo-setup.templ.yaml
outfile=demo-setup.yaml
CLIENT_TOKEN_NAME=$(kubectl get secrets -n automation-broker | grep 'automation-broker-client-token-*' | awk '{print $1}')
BROKER_CA_CERT=$(kubectl get secret -n automation-broker automation-broker-tls -o yaml | grep 'tls\.crt' | awk '{print $2}')
echo $BROKER_CA_CERT
echo $CLIENT_TOKEN_NAME
cat $_dir/$templ | sed "s|%%CLIENT_TOKEN_NAME%%|${CLIENT_TOKEN_NAME}|" > $_dir/$outfile
cat $_dir/$templ | sed -i "s|%%BROKER_CA_CERT%%|${BROKER_CA_CERT}|" $_dir/$outfile
cat $outfile
