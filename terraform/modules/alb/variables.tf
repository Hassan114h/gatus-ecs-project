variable "service_name" {
    type = string
    default = "sc-ecs-service" ###
}

variable "region" {
    type = string
    default = "eu-west-1"
}

variable "acm_cert_arn" {
    type = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}


#Define subnet 