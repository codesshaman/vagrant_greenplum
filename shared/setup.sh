#!/bin/bash

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
yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
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
# mount /dev/cdrom /mnt
# sh /mnt/VBoxLinuxAdditions.run
# umount /mnt