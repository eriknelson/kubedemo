kubetype=$1

echo "Configuring kube type: $kubetype, machine_id: $machine_id"

echo "Setting up cloud repo..."
cp /vagrant/etc/virt7-docker-common-release.repo /etc/yum.repos.d
yum -y install --enablerepo=virt7-docker-common-release kubernetes etcd flannel
yum -y install vim net-tools bind-utils

# Copy over shared config
cp /vagrant/etc/kubernetes.config /etc/kubernetes/config
cp /vagrant/etc/flanneld /etc/sysconfig/flanneld

# Disable special firewall rule managers
systemctl disable firewalld
systemctl stop firewalld

# Disable selinux
setenforce 0

# Kube type specific configs
if [[ $kubetype == "master" ]]; then
  echo "Setting up master specific config..."
  cp /vagrant/etc/etcd.conf /etc/etcd
  cp /vagrant/etc/kubernetes.apiserver /etc/kubernetes/apiserver

  systemctl restart etcd
  systemctl enable etcd
  systemctl status etcd

  ##################################################
  # TODO: This is awful, there has to be a better way to do this.
  # Problem is that the service isn't up by the time I need to make etcd entries
  echo "Sleeping 5s..."
  sleep 5s
  echo "Waking up!"
  ##################################################

  # Configure etcd to hold the network overlay configuration
  etcdctl mkdir /kube-centos/network
  etcdctl mk /kube-centos/network/config "{ \"Network\": \"172.30.0.0/16\", \"SubnetLen\": 24, \"Backend\": { \"Type\": \"vxlan\" } }"

  # Start services on master
  for SERVICES in kube-apiserver kube-controller-manager kube-scheduler flanneld; do
    systemctl restart $SERVICES
    systemctl enable $SERVICES
    systemctl status $SERVICES
  done
else
  # Configure the services on the nodes
  echo "Setting up node specific config..."
  cp /vagrant/etc/kubelet /etc/kubernetes

  # Hostname
  echo 'KUBELET_HOSTNAME=""' >> /etc/kubernetes/kubelet

  for SERVICES in kube-proxy kubelet flanneld docker; do
    systemctl restart $SERVICES
    systemctl enable $SERVICES
    systemctl status $SERVICES
  done

  kubectl config set-cluster default-cluster --server=http://kube-1-master:8080
  kubectl config set-context default-context --cluster=default-cluster --user=default-admin
  kubectl config use-context default-context
fi
