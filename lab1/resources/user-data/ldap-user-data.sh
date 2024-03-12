#!/bin/bash
# This script should be run as root
set -e

# Install required package
yum install -y bind-utils rng-tools ipa-server

# Since every AWS VPC has built-in DNS Server and hostname configured as FQDN properly
# we can skip setup DNS step.

# Enable and start rngd
systemctl enable rngd
systemctl start rngd
