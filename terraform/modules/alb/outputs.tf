output "alb_sg_id" {
  value = aws_security_group.alb_security_group.id
}

output "alb_target_green" {
  description = "Green tg arn"
  value       = aws_lb_target_group.green.arn
}

output "alb_target_blue" {
  description = "Blue tg arn"
  value       = aws_lb_target_group.blue.arn
}

output "blue_https_listener" {
  description = "Blue listener"
  value = aws_lb_listener.alb_listener_https.arn
}

 output "green_listener_test" {
  description = "Allows testing of Green TG by sending real traffic"
  value = aws_lb_listener.alb_listener_test.arn
}

output "alb_hosted_zone_id" {
  value    = aws_lb.application_load_balancer.zone_id
}

output "alb_dns_name" {
  value    = aws_lb.application_load_balancer.dns_name
}


