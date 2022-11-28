#!/bin/bash

sudo snap install juju --classic
sudo snap install lxd
sudo apt purge -y liblxc1 lxcfs lxd lxd-client
sudo adduser $USER lxd
sudo snap install kubectl --classic
 
lxd init --auto
lxc network set lxdbr0 ipv6.address none
lxc network get lxdbr0 ipv4.address
 
juju bootstrap localhost lxd-controller
juju add-model lxd-controller
juju deploy charmed-kubernetes
 
mkdir .kube
juju scp kubernetes-master/0:config ~/.kube/config
 
juju status
kubectl cluster-info
