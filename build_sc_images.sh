#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
prefix="docker.io/eriknelson"
tag="relist"
remote_apiserver=${prefix}/apiserver:${tag}
remote_controller_manager=${prefix}/controller-manager:${tag}
pushd $HOME/cluster/src/github.com/kubernetes-incubator/service-catalog
make clean && make images
docker tag apiserver:canary ${remote_apiserver}
docker tag controller-manager:canary ${remote_controller_manager}
docker push ${remote_apiserver}
docker push ${remote_controller_manager}
popd
