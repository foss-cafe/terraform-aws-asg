# Terraform Module for AWS Auto Scaling Group

### Use as a Module
Go tot `examples` dir for more examples
```terrraform
module "asg_1" {
  source        = "../"
  name          = "example"
  image_id      = "ami-01fee56b22f308154"
  instance_type = "t2.micro"
  key_name      = "test"
  user_data     = file("${path.module}/install.sh")
  root_block_device = [
    {
      volume_size           = "25"
      volume_type           = "gp2"
      delete_on_termination = true
      encrypted             = true

    },
  ]

  vpc_id                    = var.vpc_id
  ingress                   = var.ingress
  egress                    = var.egress
  vpc_zone_identifier       = var.vpc_zone_identifier
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  service_linked_role_arn   = aws_iam_service_linked_role.autoscaling.arn
  tags = {
    extra_tag1 = "extra_value1"
    extra_tag2 = "extra_value2"
  }
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.7, < 0.14 |
| aws | >= 2.68, < 4.0 |
| null | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.68, < 4.0 |
| null | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| adjustment\_type | (Optional) Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity. | `string` | `"ExactCapacity"` | no |
| associate\_public\_ip\_address | Associate a public ip address with an instance in a VPC. | `bool` | `false` | no |
| block\_device\_mappings | Specify volumes to attach to the instance besides the volumes specified by the AMI | `any` | `[]` | no |
| cooldown | (Optional) The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start. | `number` | `300` | no |
| credit\_specification | Customize the credit specification of the instances | <pre>object({<br>    cpu_credits = string<br>  })</pre> | `null` | no |
| default\_cooldown | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start. | `number` | `30` | no |
| default\_version | Default Version of the launch template. | `number` | `null` | no |
| desired\_capacity | The number of Amazon EC2 instances that should be running in the group | `number` | `"1"` | no |
| disable\_api\_termination | If `true`, enables EC2 Instance Termination Protection | `bool` | `false` | no |
| ebs\_optimized | If true, the launched EC2 instance will be EBS-optimized | `bool` | `false` | no |
| egress | (Optional, VPC only) Can be specified multiple times for each egress rule. | `any` | `[]` | no |
| enable\_autoscaling\_group | Do you want to enable Auto scaling group | `bool` | `false` | no |
| enable\_autoscaling\_policy | Do you want to enable ASG Policy | `bool` | `false` | no |
| enable\_launch\_configuration | Do you want to enable launch\_configuration | `bool` | `false` | no |
| enable\_launch\_template | Do you want to enable launch\_template | `bool` | `true` | no |
| enable\_monitoring | Enables/disables detailed monitoring. This is enabled by default. | `bool` | `false` | no |
| enabled\_metrics | A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances | `list(string)` | <pre>[<br>  "GroupMinSize",<br>  "GroupMaxSize",<br>  "GroupDesiredCapacity",<br>  "GroupInServiceInstances",<br>  "GroupPendingInstances",<br>  "GroupStandbyInstances",<br>  "GroupTerminatingInstances",<br>  "GroupTotalInstances"<br>]</pre> | no |
| estimated\_instance\_warmup | (Optional) The estimated time, in seconds, until a newly launched instance will contribute CloudWatch metrics. Without a value, AWS will default to the group's specified cooldown period. | `number` | `300` | no |
| force\_delete | Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling | `bool` | `false` | no |
| health\_check\_grace\_period | Time (in seconds) after instance comes into service before checking health. | `number` | `300` | no |
| health\_check\_type | EC2 or ELB, Controls how health checking is done. | `string` | `"EC2"` | no |
| iam\_instance\_profile | The name attribute of the IAM instance profile to associate with launched instances. | `string` | `null` | no |
| image\_id | The EC2 image ID to launch | `string` | `null` | no |
| ingress | (Optional) Can be specified multiple times for each ingress rule. | `any` | `[]` | no |
| initial\_lifecycle\_hook | (Optional) One or more Lifecycle Hooks to attach to the autoscaling group before instances are launched. The syntax is exactly the same as the separate aws\_autoscaling\_lifecycle\_hook resource, without the autoscaling\_group\_name attribute. Please note that this will only work when creating a new autoscaling group. For all other use-cases, please use aws\_autoscaling\_lifecycle\_hook resource. | `list(map(string))` | `[]` | no |
| instance\_initiated\_shutdown\_behavior | Shutdown behavior for the instances. Can be `stop` or `terminate` | `string` | `"terminate"` | no |
| instance\_type | The size of instance to launch | `string` | `null` | no |
| key\_name | The key name that should be used for the instance | `string` | `null` | no |
| load\_balancers | A list of elastic load balancer names to add to the autoscaling group names | `list(string)` | `[]` | no |
| max\_instance\_lifetime | The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 604800 and 31536000 seconds. | `number` | `0` | no |
| max\_size | The maximum size of the auto scale group | `number` | `"3"` | no |
| metadata\_options | (Optional) Customize the metadata options for the instance. | `list(map(string))` | `[]` | no |
| metrics\_granularity | The granularity to associate with the metrics to collect. The only valid value is 1Minute | `string` | `"1Minute"` | no |
| min\_adjustment\_magnitude | (Optional) Minimum value to scale by when adjustment\_type is set to PercentChangeInCapacity | `string` | `null` | no |
| min\_elb\_capacity | Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes | `number` | `0` | no |
| min\_size | The minimum size of the auto scale group | `number` | `"1"` | no |
| name | (Optional) The name of the launch configuration. If you leave this blank, Terraform will auto-generate a unique name. | `string` | `null` | no |
| placement\_group | The name of the placement group into which you'll launch your instances, if any | `string` | `null` | no |
| placement\_tenancy | The tenancy of the instance. Valid values are default or dedicated | `string` | `"default"` | no |
| policy\_type | (Optional) The policy type, either `SimpleScaling`, `StepScaling` or `TargetTrackingScaling`. If this value isn't provided, AWS will default to `SimpleScaling.` | `string` | `"SimpleScaling"` | no |
| protect\_from\_scale\_in | Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events. | `bool` | `false` | no |
| root\_block\_device | Customize details about the root block device of the instance | `list(map(string))` | <pre>[<br>  {<br>    "volume_size": "20",<br>    "volume_type": "gp2"<br>  }<br>]</pre> | no |
| scaling\_adjustment | (Optional) The number of instances by which to scale. adjustment\_type determines the interpretation of this number (e.g., as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity. | `number` | `4` | no |
| security\_groups | A list of associated security group IDS. | `list` | `[]` | no |
| service\_linked\_role\_arn | The ARN of the service-linked role that the ASG will use to call other AWS services. | `string` | `""` | no |
| suspended\_processes | A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly. | `list(string)` | `[]` | no |
| tags | A map of tags and values in the same format as other resources accept. This will be converted into the non-standard format that the aws\_autoscaling\_group requires. | `map(string)` | `{}` | no |
| target\_group\_arns | A list of aws\_alb\_target\_group ARNs, for use with Application Load Balancing | `list(string)` | `[]` | no |
| target\_tracking\_configuration | (Optional) A target tracking policy. | `any` | `[]` | no |
| termination\_policies | A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default | `list(string)` | <pre>[<br>  "Default"<br>]</pre> | no |
| user\_data | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument | `string` | `null` | no |
| user\_data\_base64 | Can be used instead of user\_data to pass base64-encoded binary data directly | `string` | `null` | no |
| vpc\_id | (Optional, Forces new resource) The VPC ID. | `string` | `""` | no |
| vpc\_zone\_identifier | A list of subnet IDs to launch resources in | `list(string)` | `[]` | no |
| wait\_for\_capacity\_timeout | A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior. | `string` | `"10m"` | no |
| wait\_for\_elb\_capacity | Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min\_elb\_capacity behavior. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| asg\_arn | The ARN for this AutoScaling Group |
| asg\_id | The autoscaling group id |
| asg\_simple\_scaling\_policy | The scaling policy's type. |
| asg\_simple\_scaling\_policy\_adjustment\_type | The scaling policy's adjustment type. |
| asg\_simple\_scaling\_policy\_arn | The ARN assigned by AWS to the scaling policy. |
| asg\_simple\_scaling\_policy\_names | The scaling policy's name. |
| asg\_target\_tracking\_policy\_adjustment\_types | The scaling policy's adjustment type. |
| asg\_target\_tracking\_policy\_arns | The ARN assigned by AWS to the scaling policy. |
| asg\_target\_tracking\_policy\_names | The scaling policy's name. |
| asg\_target\_tracking\_policys | The scaling policy's type. |
| launch\_configuration\_arn | The name of the launch configuration |
| launch\_configuration\_id | The ID of the launch configuration |
| launch\_configuration\_name | The name of the launch configuration |
| sg\_arn | The ID of the security group |
| sg\_id | The ID of the security group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### ToDo

- [ ] Add Scheduled Actions
- [ ] Metadata V2 Issue with Checkov Scans
- [ ] mixed_instances_policy
- [ ] Support for `StepScaling`
