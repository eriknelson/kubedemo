kcmd="/usr/bin/kubectl --kubeconfig /home/ernelson/cluster/kubedemo/kube-1-master.conf"
$kcmd create serviceaccount --namespace kube-system tiller
$kcmd create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
$kcmd patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
