#!/bin/bash

## Install node exporter for methrics (commit it if your not need methrics)

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

