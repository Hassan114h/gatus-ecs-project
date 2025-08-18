variable "region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "eu-west-1"
}

variable "task_security_group_id" {
  description = "Security group ID for ECS tasks that need access to VPC endpoints"
  type = string
}