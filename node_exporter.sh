#!/bin/bash

wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
tar xvf node_exporter-1.3.1.linux-amd64.tar.gz
cd node_exporter-1.3.1.linux-amd64
cp node_exporter /usr/local/bin
useradd --no-create-home --shell /bin/false node_exporter
chown node_exporter:node_exporter /usr/local/bin/node_exporter
touch /etc/systemd/system/node_exporter.service
cat > /etc/systemd/system/node_exporter.service <<- EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target
[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
[Install]
WantedBy=multi-user.target
EOF

#if grep -q '0' /etc/default/grub; then
#	echo "this is 0"
#else 
#	echo " this is not 0"
#ifi

systemctl daemon-reload 
echo " RELOADING SYSTEM "
systemctl start node_exporter
systemctl status node_exporter
systemctl enable node_exporter
