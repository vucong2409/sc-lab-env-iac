#!/bin/bash
# This script should be run as root
set -e

# Enable Linux IP forwarding
# echo "net.ipv4.ip_forward = 1" >> /proc/sys/net/ipv4/ip_forward
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -p

# Install required package
yum install -y iptables-services

# Enable iptables
systemctl start iptables
systemctl enable iptables

# Setup NAT for this instance
# Based on https://docs.aws.amazon.com/vpc/latest/userguide/VPC_NAT_Instance.html
# - Redirect all request for eth0 to MASQUERADE chain
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -F FORWARD
