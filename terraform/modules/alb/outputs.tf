output "alb_sg_id" {
  value = aws_security_group.alb_security_group.id
}

output "alb_target_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_lb_target_group.memos_tg.arn
}

output "alb_hosted_zone_id" {
  value    = aws_lb.application_load_balancer.zone_id
}

output "alb_dns_name" {
  value    = aws_lb.application_load_balancer.dns_name
}

output "lb_https_listener_arn" {
  value    = aws_lb_listener.alb_listener_https.arn
}

