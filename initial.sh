#!/bin/bash

# Update the package list and install required packages
sudo apt-get update
#sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# Add the Docker repository key and repository
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get install -y apt-transport-https gnupg2

# Add the Kubernetes repository key and repository
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list


# Update the package list again to get the new repositories
sudo apt-get update

# Install Docker and Kubernetes
#sudo apt-get install -y docker-ce kubelet=1.15.7-00 kubeadm=1.15.7-00 kubectl=1.15.7-00
sudo apt-get install -y kubectl kubeadm kubelet kubernetes-cni docker.io
sudo systemctl start docker
sudo systemctl enable docker

#Add the current user to the Docker group
sudo usermod -aG docker $USER
newgrp docker

#update the iptables of Linux Nodes to enable them to see bridged traffic correctly.
cat << EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

