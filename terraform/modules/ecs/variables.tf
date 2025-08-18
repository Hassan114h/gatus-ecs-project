variable "service_name" {
  type    = string
  default = "memos"
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "vpc_id" {
  description = "The id of the VPC your working with"
  type        = string
}


variable "alb_sg" {
  description = "The security group ID of the ALB to allow ingress to ECS tasks"
  type        = string
}


variable "task_cpu" {
  type    = number
  default = 256
}

variable "task_memory" {
  type    = number
  default = 512
}

variable "alb_target_arn" {
  description = "The ARN of the ALB target group for ECS service"
  type        = string
}

variable "ecr_image_uri" {
  type    = string
  default = "913513914993.dkr.ecr.eu-west-1.amazonaws.com/memosapp-repo-e:66e2824ea092fd3f5f87ec37f349c7a086a51ffd"
}

variable "container_port" {
  type    = number
  default = 5230
}

variable "private_subnets" {
  description = "List of private subnet IDs where ECS tasks will be launched"
  type        = list(string)
}
