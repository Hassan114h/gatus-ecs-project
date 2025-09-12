variable "region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "eu-west-1"
}

variable "task_security_group_id" {
  description = "ECS Task Security Group"
  type        = string
}
