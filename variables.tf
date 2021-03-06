######### For Launch Configuraions ##############
variable "enable_launch_configuration" {
  type        = bool
  description = "Do you want to enable launch_configuration"
  default     = false
}

variable "name" {
  type        = string
  description = "(Optional) The name of the launch configuration. If you leave this blank, Terraform will auto-generate a unique name."
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

variable "force_delete" {
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  type        = bool
  default     = false
}

variable "load_balancers" {
  description = "A list of elastic load balancer names to add to the autoscaling group names"
  type        = list(string)
  default     = []
}

variable "target_group_arns" {
  description = "A list of aws_alb_target_group ARNs, for use with Application Load Balancing"
  type        = list(string)
  default     = []
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default"
  type        = list(string)
  default     = ["Default"]
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

variable "enable_autoscaling_group" {
  type        = bool
  description = "Do you want to enable Auto scaling group"
  default     = false
}


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

variable "suspended_processes" {
  description = "A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly."
  type        = list(string)
  default     = []
}

variable "placement_group" {
  type        = string
  description = "The name of the placement group into which you'll launch your instances, if any"
  default     = null
}

variable "metrics_granularity" {
  description = "The granularity to associate with the metrics to collect. The only valid value is 1Minute"
  type        = string
  default     = "1Minute"
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
  type        = list(string)
  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  type        = string
  default     = "10m"
}

variable "tags" {
  description = "A map of tags and values in the same format as other resources accept. This will be converted into the non-standard format that the aws_autoscaling_group requires."
  type        = map(string)
  default     = {}
}


variable "min_elb_capacity" {
  description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes"
  type        = number
  default     = 0
}

variable "wait_for_elb_capacity" {
  description = "Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min_elb_capacity behavior."
  type        = number
  default     = null
}

variable "protect_from_scale_in" {
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events."
  type        = bool
  default     = false
}

variable "service_linked_role_arn" {
  description = "The ARN of the service-linked role that the ASG will use to call other AWS services."
  type        = string
  default     = ""
}

variable "max_instance_lifetime" {
  description = "The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 604800 and 31536000 seconds."
  type        = number
  default     = 0
}

variable "initial_lifecycle_hook" {
  type        = list(map(string))
  description = "(Optional) One or more Lifecycle Hooks to attach to the autoscaling group before instances are launched. The syntax is exactly the same as the separate aws_autoscaling_lifecycle_hook resource, without the autoscaling_group_name attribute. Please note that this will only work when creating a new autoscaling group. For all other use-cases, please use aws_autoscaling_lifecycle_hook resource."
  default = [
  ]
}

variable "vpc_id" {
  type        = string
  description = "(Optional, Forces new resource) The VPC ID."
  default     = ""
}

variable "ingress" {
  type        = any
  description = "(Optional) Can be specified multiple times for each ingress rule."
  default = [

  ]
}

variable "egress" {
  type        = any
  description = "(Optional, VPC only) Can be specified multiple times for each egress rule."
  default = [

  ]
}

############ Launch Templates #########

variable "enable_launch_template" {
  type        = bool
  description = "Do you want to enable launch_template"
  default     = true
}

variable "default_version" {
  type        = number
  description = "Default Version of the launch template."
  default     = null
}

variable "block_device_mappings" {
  type        = any
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"
  default     = []
}

variable "credit_specification" {
  type = object({
    cpu_credits = string
  })
  description = "Customize the credit specification of the instances"
  default     = null
}

variable "disable_api_termination" {
  type        = bool
  description = "If `true`, enables EC2 Instance Termination Protection"
  default     = false
}

variable "instance_initiated_shutdown_behavior" {
  type        = string
  description = "Shutdown behavior for the instances. Can be `stop` or `terminate`"
  default     = "terminate"
}

variable "metadata_options" {
  type        = list(map(string))
  description = "(Optional) Customize the metadata options for the instance."
  default = [
  ]
}

########### AutoScaling Scaling Policy resource ####

variable "enable_autoscaling_policy" {
  type        = bool
  description = "Do you want to enable ASG Policy"
  default     = false
}

variable "adjustment_type" {
  type        = string
  description = " (Optional) Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity."
  default     = "ExactCapacity"
}

variable "policy_type" {
  type        = string
  description = "(Optional) The policy type, either `SimpleScaling`, `StepScaling` or `TargetTrackingScaling`. If this value isn't provided, AWS will default to `SimpleScaling.`"
  default     = "SimpleScaling"
}

variable "estimated_instance_warmup" {
  type        = number
  description = " (Optional) The estimated time, in seconds, until a newly launched instance will contribute CloudWatch metrics. Without a value, AWS will default to the group's specified cooldown period."
  default     = 300
}

variable "cooldown" {
  type        = number
  description = " (Optional) The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start."
  default     = 300
}

variable "scaling_adjustment" {
  type        = number
  description = "(Optional) The number of instances by which to scale. adjustment_type determines the interpretation of this number (e.g., as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity."
  default     = 4
}


variable "min_adjustment_magnitude" {
  type        = string
  description = "(Optional) Minimum value to scale by when adjustment_type is set to PercentChangeInCapacity"
  default     = null
}

variable "target_tracking_configuration" {
  type        = any
  description = " (Optional) A target tracking policy."
  default = [

  ]
}
