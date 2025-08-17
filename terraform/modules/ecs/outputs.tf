output "task_security_group_id" {
  description = "The ID of the ECS task security group"
  value       = aws_security_group.task_security.id
}
