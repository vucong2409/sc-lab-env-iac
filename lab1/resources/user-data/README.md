# User data for EC2
This directory contain user data for instances created in Lab 1

## NAT Instance
- Enable IP forwarding
- Install and start `iptables` services
- Config iptables:
  - Add rules to nat table: Every POSTROUTING to eth0 will be jumped into MASQUERADE chain for DNAT.
  - Flush all rule in FORWARD chain to avoid conflict. 

## Proxy Instance
- Enable IP forwarding
- Install `squid`, `wget` and `amazon-cloudwatch-agent`
- Config Squid proxy:
  - Listen on port 3128
  - Allow all traffic of every protocol
- Config Amazon Cloudwatch agent:
  - Add dimension to log: `InstanceId` and `InstanceType` (No ASG/AMI dimension since we only have one instance here)
  - Collect some extra metrics:
    - CPU: `cpu_usage_idle`, `cpu_usage_iowait`, `cpu_usage_user` and `cpu_usage_system`
    - RAM: `mem_used_percent`
    - Disk IOPS: `io_time`
  - Collect log:
    - Squid access log at `/var/log/squid/access.log`
- Start `squid` and `amazon-cloudwatch-agent` service

## LDAP Instance

## App Instance
- Replace proxy address with DNS name of Proxy instance (since this is a template, not a completed bash script)
- Create directory for `weather-report` service
- Add code & service file for `weather-report` service
- Start `weather-report` service
