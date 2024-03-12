#!/bin/bash
# This script should be run as root
set -e

# Install required package
yum install -y squid wget

# Install CloudWatch Agent
wget https://amazoncloudwatch-agent.s3.amazonaws.com/redhat/amd64/latest/amazon-cloudwatch-agent.rpm
rpm -U ./amazon-cloudwatch-agent.rpm
rm amazon-cloudwatch-agent.rpm

# Setup Cloudwatch agent
cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<EOF
{
  "agent": {
    "metrics_collection_interval": 60,
    "run_as_user": "root"
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/squid/access.log",
            "log_group_class": "STANDARD",
            "log_group_name": "Squid proxy log",
            "log_stream_name": "Access log - {instance_id}",
            "retention_in_days": 3
          }
        ]
      }
    }
  },
  "metrics": {
    "aggregation_dimensions": [
      [
        "InstanceId"
      ]
    ],
    "append_dimensions": {
      "AutoScalingGroupName": "${aws:AutoScalingGroupName}",
      "ImageId": "${aws:ImageId}",
      "InstanceId": "${aws:InstanceId}",
      "InstanceType": "${aws:InstanceType}"
    },
    "metrics_collected": {
      "cpu": {
        "measurement": [
          "cpu_usage_idle",
          "cpu_usage_iowait",
          "cpu_usage_user",
          "cpu_usage_system"
        ],
        "metrics_collection_interval": 60,
        "totalcpu": false
      },
      "diskio": {
        "measurement": [
          "io_time"
        ],
        "metrics_collection_interval": 60,
        "resources": [
          "*"
        ]
      },
      "mem": {
        "measurement": [
          "mem_used_percent"
        ],
        "metrics_collection_interval": 60
      },
      "statsd": {
        "metrics_aggregation_interval": 60,
        "metrics_collection_interval": 60,
        "service_address": ":8125"
      }
    }
  }
}
EOF

# Enable Linux IP forwarding
# echo "net.ipv4.ip_forward = 1" >> /proc/sys/net/ipv4/ip_forward
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -p

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
systemctl start squid amazon-cloudwatch-agent
systemctl enable squid amazon-cloudwatch-agent
