# -*- mode: ruby -*-
# vi: set ft=ruby :

VM_MEM = 4096
VM_CPU = 2
CLUSTER_SIZE = 4

def configure_cluster(machine_count, master_config)
  machine_count.times { |i| configure_host(i + 1, master_config) }
end

def configure_host(machine_id, master_config)
  kube_type = machine_id == 1 ? "master" : "node"
  hostname = "kube-#{machine_id}-#{kube_type}"
  fqdn = "#{hostname}.example.com"
  ip_address = "192.168.66.#{machine_id + 1}"

  master_config.vm.define(hostname) do |config|
    config.vm.hostname = fqdn

    config.landrush.enabled = true
    config.landrush.host_ip_address = ip_address
    config.landrush.tld = fqdn
    config.landrush.host ".#{fqdn}", ip_address
    config.landrush.guest_redirect_dns = false

    config.vm.provider "libvirt" do |v, override|
      v.memory = VM_MEM
      v.cpus = VM_CPU
      v.driver = "kvm"
      v.suspend_mode = "managedsave"
      override.vm.box = "centos/7"
    end

    config.vm.network :private_network, :ip => ip_address

    config.vm.provision :shell,
      :path => "provision.sh",
      :args => [kube_type, machine_id]
  end
end

Vagrant.configure("2") do |master_config|
  configure_cluster(CLUSTER_SIZE, master_config)
end
