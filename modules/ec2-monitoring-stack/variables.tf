variable "resource_region" {
  type        = string
  description = "Region to create resources in."
}

variable "alert_topic_arn" {
  type        = string
  description = "ARN of the topic to send alerts to."
}

variable "ec2_hostname" {
  type        = string
  description = "Hostname of the monitored EC2 instance."
}

variable "ec2_id" {
  type        = string
  description = "ID of monitored EC2 instance."
}
