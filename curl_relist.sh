#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
curl -X PUT \
  -H "Content-Type: application/json" \
  -d '{"apiVersion": "servicecatalog.k8s.io/v1alpha1", "kind": "ServiceBroker", "metadata": {"name": "ansible-service-broker"}}' \
  "localhost:8001/apis/servicecatalog.k8s.io/v1alpha1/servicebrokers/ansible-service-broker/relist"

  #-d '{}' \
