variable "domain_name" {
  description = "The DNS name of the ALB"
  type        = string
  default = "hassan114.click"
}

variable "hosted_zone_id" {
  description = "The hosted zone ID of the ALB"
  type        = string
  default = "Z0952190E6PJC8Q98ZNX"
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB (output from ALB module)"
  type        = string
}

variable "alb_hosted_zone_id" {
  description = "The hosted zone ID of the ALB (output from ALB module)"
  type        = string
}