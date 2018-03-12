#!/bin/bash
POD_NAME=$1
CMD="kubectl get pod ${POD_NAME} -o go-template='{{.status.podIP}}'"
POD_IP=$(bash -c "$CMD")
kubectl run busybox --image=busybox --restart=Never --tty -i --generator=run-pod/v1 --env "POD_IP=${POD_IP}"
