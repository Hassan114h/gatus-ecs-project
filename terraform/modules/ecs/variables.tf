variable "service_name" {
  type    = string
  default = "gatus_sv"
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "vpc_id" {
  description = "The id of the VPC"
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
  default = "913513914993.dkr.ecr.eu-west-1.amazonaws.com/memosapp-repo-e:9d0d245172b46ee4c7b4fd7f78fcbb4f9d47298d"
} 

variable "container_port" {
  type    = number
  default = 8080
}

variable "private_subnets" {
  description = "List of private subnet IDs where ECS tasks will be launched"
  type        = list(string)
}

