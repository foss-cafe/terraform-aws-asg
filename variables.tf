######### For Launch Configuraions ##############
variable "name" {
  type        = string
  description = "The name of the launch configuration. If you leave this blank, Terraform will auto-generate a unique name "
  default     = null
}

variable "image_id" {
  type        = string
  description = "The EC2 image ID to launch"
  default     = null
}


variable "instance_type" {
  type        = string
  description = "The size of instance to launch"
  default     = null
}


variable "iam_instance_profile" {
  type        = string
  description = "The name attribute of the IAM instance profile to associate with launched instances."
  default     = null
}

variable "key_name" {
  type        = string
  description = "The key name that should be used for the instance"
  default     = null
}

variable "security_groups" {
  type        = list
  description = "A list of associated security group IDS."
  default     = []
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public ip address with an instance in a VPC."
  default     = false
}

variable "user_data" {
  type        = string
  description = " The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument"
  default     = null
}

variable "user_data_base64" {
  type        = string
  description = "Can be used instead of user_data to pass base64-encoded binary data directly"
  default     = null
}

variable "enable_monitoring" {
  type        = bool
  description = "Enables/disables detailed monitoring. This is enabled by default."
  default     = false
}


variable "ebs_optimized" {
  type        = bool
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance"
  type        = list(map(string))
  default = [
    {
      "volume_size" = "20"
      "volume_type" = "gp2"
    }
  ]
}

variable "placement_tenancy" {
  type        = string
  description = "The tenancy of the instance. Valid values are default or dedicated"
  default     = "default"
}

########### For ASG ############

variable "max_size" {
  type        = number
  description = "The maximum size of the auto scale group"
  default     = "3"
}

variable "min_size" {
  type        = number
  description = "The minimum size of the auto scale group"
  default     = "1"
}

variable "desired_capacity" {
  type        = number
  description = "The number of Amazon EC2 instances that should be running in the group"
  default     = "1"
}
variable "vpc_zone_identifier" {
  type        = list(string)
  description = "A list of subnet IDs to launch resources in"
  default     = []
}
variable "default_cooldown" {
  type        = number
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start."
  default     = 30
}

variable "health_check_grace_period" {
  type        = number
  description = "Time (in seconds) after instance comes into service before checking health."
  default     = 300
}
variable "health_check_type" {
  type        = string
  description = "EC2 or ELB, Controls how health checking is done."
  default     = "EC2"
}

variable "termination_policies" {
  type        = list(string)
  description = "A list of policies to decide how the instances in the auto scale group should be terminated"
  default     = ["NewestInstance", "Default"]
}

variable "suspended_processes" {
  type        = list(string)
  description = " A list of processes to suspend for the AutoScaling Group"
  default     = ["ReplaceUnhealthy", "HealthCheck"]
}

variable "placement_group" {
  type        = string
  description = "  The name of the placement group into which you'll launch your instances, if any"
  default     = null
}

variable "metrics_granularity" {
  type        = string
  description = "The granularity to associate with the metrics to collect"
  default     = "1Minute"
}

variable "enabled_metrics" {
  type        = list(string)
  description = " A list of metrics to collect"
  default     = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

variable "wait_for_capacity_timeout" {
  type        = number
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out."
  default     = 0
}

variable "additional_tags" {
  type = map(string)
  default = {
    "createdby" = "devops"
  }
}