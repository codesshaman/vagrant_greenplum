#!/bin/bash

echo "[Node Exporter] : download..."
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
echo "[Node Exporter] : successfully downloaded..."

echo "[Node Exporter] : installation..."
tar xvfz node_exporter-*.linux-amd64.tar.gz
cd node_exporter-*.*-amd64
sudo mv node_exporter /usr/bin/

echo "[Node Exporter] : creating a user..."
sudo useradd -r -M -s /bin/false node_exporter
sudo chown node_exporter:node_exporter /usr/bin/node_exporter

echo "[Node Exporter] : creating a system unit..."
{   echo '[Unit]'; \
    echo 'Description=Prometheus Node Exporter'; \
    echo '[Service]'; \
    echo 'User=node_exporter'; \
    echo 'Group=node_exporter'; \
    echo 'Type=simple'; \
    echo 'ExecStart=/usr/bin/node_exporter'; \
    echo '[Install]'; \
    echo 'WantedBy=multi-user.target'; \
} | tee /etc/systemd/system/node_exporter.service;

echo "[Node Exporter] : reload daemon..."
sudo systemctl daemon-reload
echo "[Node Exporter] : enable node exporter..."
sudo systemctl enable --now node_exporter
sudo systemctl status node_exporter
echo "Node exporter has been setup succefully!"

echo "[yum] : add repositories..."
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
yum update -y

echo "[yum] : install utillites..."
yum install -y yum-utils

echo "[Docker] : add repositori..."
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum update

echo "[Docker] : install and enable..."
yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin nano
systemctl enable docker
systemctl start docker

echo "[Docker] : add user rights..."
usermod -aG docker vagrant

echo "[docker-compose] : install..."
curl -L https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
chmod a+x /usr/local/bin/docker-compose

echo "[Vagrant] : install kernel headers..."
yum install -y epel-release
yum install -y gcc make perl kernel-devel kernel-headers bzip2 dkms

echo "[GreenPlum] : disable selinux..."
sed -i 's!SELINUX=permissive!SELINUX=disabled!g' /etc/selinux/config
