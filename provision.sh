# Fix interface not coming up
ifup eth1

kubetype=$1
kubernetes_version=$3

#echo "Configuring kube"
#cp /vagrant/etc/kubernetes.repo /etc/yum.repos.d

# Disable special firewall rule managers
systemctl disable firewalld
systemctl stop firewalld

# Disable selinux
setenforce 0

yum install -y epel-release && yum install -y ansible

cd /vagrant/kubeadm-playbook
mkdir -p /var/www/html && chown -R vagrant /var/www/html
groupadd docker
gpasswd --add vagrant docker

ansible-playbook -i 'localhost,' -c local common.yml
ansible-playbook -i 'localhost,' -c local ${kubetype}.yml

#if [[ $kubetype == "master" ]]; then
  #yum install -y epel-release && yum install -y ansible

  ##echo "Setting up master specific config..."
  ##yum -y install --enablerepo=kubernetes kubeadm
  ##kubeadm reset
  ###kubeadm init \
    ###--apiserver-advertise-address="kube-1-master"
    ###--kubernetes-version="$kubernetes_version"
  ##kubeadm init
#else
  #echo "Setting up node specific config..."
  #cd /vagrant/kubeadm-playbook
  #ansible-playbook -i 'localhost,' -c local common.yml
  #ansible-playbook -i 'localhost,' -c local node.yml
#fi

#ansible-playbook

## Setup newer Docker
#rpm --import "https://sks-keyservers.net/pks/lookup?op=get&search=0xee6d536cf7dc86e2d7d56f59a178ac6c6238f52e"
#yum install -y yum-utils
#yum-config-manager --add-repo https://packages.docker.com/1.12/yum/repo/main/centos/7
#yum makecache fast
#yum install -y docker-engine
#usermod -a -G docker vagrant
#systemctl start docker && systemctl enable docker

#yum -y install --enablerepo=kubernetes kubelet
##yum -y install vim net-tools bind-utils

#systemctl enable kubelet && systemctl start kubelet

## Kube type specific configs
#if [[ $kubetype == "master" ]]; then
  #echo "Setting up master specific config..."
  #yum -y install --enablerepo=kubernetes kubeadm
  #kubeadm reset
  ##kubeadm init \
    ##--apiserver-advertise-address="kube-1-master"
    ##--kubernetes-version="$kubernetes_version"
  #kubeadm init
#else
  #echo "Setting up node specific config..."
#fi

## Copy over shared config
#cp /vagrant/etc/kubernetes.config /etc/kubernetes/config
#cp /vagrant/etc/flanneld /etc/sysconfig/flanneld

## Kube type specific configs
#if [[ $kubetype == "master" ]]; then
  #echo "Setting up master specific config..."
  #cp /vagrant/etc/etcd.conf /etc/etcd
  #cp /vagrant/etc/kubernetes.apiserver /etc/kubernetes/apiserver

  #systemctl restart etcd
  #systemctl enable etcd
  #systemctl status etcd

  ###################################################
  ## TODO: This is awful, there has to be a better way to do this.
  ## Problem is that the service isn't up by the time I need to make etcd entries
  #echo "Sleeping 5s..."
  #sleep 5s
  #echo "Waking up!"
  ###################################################

  ## Configure etcd to hold the network overlay configuration
  #etcdctl mkdir /kube-centos/network
  #etcdctl mk /kube-centos/network/config "{ \"Network\": \"172.30.0.0/16\", \"SubnetLen\": 24, \"Backend\": { \"Type\": \"vxlan\" } }"

  ## Start services on master
  #for SERVICES in kube-apiserver kube-controller-manager kube-scheduler flanneld; do
    #systemctl restart $SERVICES
    #systemctl enable $SERVICES
    #systemctl status $SERVICES
  #done
#else
  ## Configure the services on the nodes
  #echo "Setting up node specific config..."
  #cp /vagrant/etc/kubelet /etc/kubernetes

  ## Hostname
  #echo 'KUBELET_HOSTNAME=""' >> /etc/kubernetes/kubelet

  #for SERVICES in kube-proxy kubelet flanneld docker; do
    #systemctl restart $SERVICES
    #systemctl enable $SERVICES
    #systemctl status $SERVICES
  #done

  #kubectl config set-cluster default-cluster --server=http://192.168.66.2:8080
  #kubectl config set-context default-context --cluster=default-cluster --user=default-admin
  #kubectl config use-context default-context
#fi
