#!/bin/bash
if [[ $1 == "" ]]; then
  nodeid=2
else
  nodeid=$1
fi

vagrant ssh kube-${nodeid}-node
