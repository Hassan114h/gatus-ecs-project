resource "aws_security_group" "task_security" {
  name        = "ecs_sg"
  description = "ECS task security group"

  ingress {
    from_port       = var.container_port 
    to_port         = var.container_port 
    protocol        = "tcp"
    security_groups = [var.alb_sg] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = var.vpc_id

  tags = {
    Name = "ecs_sg"
  }
}


resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "ecs-task-role"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "gatusecs-task-service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = var.service_name
    image     = var.ecr_image_uri
    cpu       = var.task_cpu
    memory    = var.task_memory
    essential = true

    portMappings = [{
      containerPort = var.container_port
      hostPort      = var.container_port
      protocol      = "tcp"
    }]
  }])

  tags = {
    Name = "gatusecs-task-service"
  }
}


resource "aws_ecs_cluster" "main" {
  name = "gatus-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "gatus-cluster"
  }
}

resource "aws_ecs_service" "memos_service" {
  name             = var.service_name  
  cluster          = aws_ecs_cluster.main.id
  task_definition  = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count    = 2
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  deployment_controller {
    type = "CODE_DEPLOY"
  }
  
  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [aws_security_group.task_security.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.alb_target_arn 
    container_name   = var.service_name
    container_port   = var.container_port
  }

  tags = {
    Name = "gatus-service"
  }
}