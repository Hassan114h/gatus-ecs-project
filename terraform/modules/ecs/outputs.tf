output "task_security_group_id" {
  description = "The ID of the ECS task security group"
  value       = aws_security_group.task_security.id
}

output "ecs_service_name" {
  value = aws_ecs_service.memos_service.name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}