#!/bin/bash
# This script should be run as root
set -e

# Enable Linux IP forwarding
# echo "net.ipv4.ip_forward = 1" >> /proc/sys/net/ipv4/ip_forward
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -p

# Install required package
yum install -y squid

# Config squid proxy
cat > /etc/squid/squid.conf <<EOF
# Allow all
http_access allow all

# Enable squid on port 3128
http_port 3128

coredump_dir /var/spool/squid

#
# Add any of your own refresh_pattern entries above these.
#
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320
EOF

# Enable squid proxy
systemctl start squid
systemctl enable squid
