# security group of the ecs tasks that has the ingress rules of the alb 

resource "aws_security_group" "task_security" {
    name = "ecs_sg"
    description = "ECS task security group"

    ingress {
        from_port = var.container_port 
        to_port = var.container_port 
        protocol = "tcp"
        security_groups = [var.alb_sg] 
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = var.vpc_id
}



# IAM Role for ECS Task Execution
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
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "memosecs-task-service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name  = var.service_name
    image = var.ecr_image_uri
    cpu    = var.task_cpu
    memory = var.task_memory
    essential = true

    portMappings = [{
      containerPort = var.container_port
      hostPort      = var.container_port
      protocol      = "tcp"
    }]

    environment = [
      { 
        name  = "MEMOS_DRIVER" 
        value = "postgres" 
      },
      { 
        name  = "MEMOS_DSN" 
        value = "postgres://${var.db_username}:${var.db_password}@${aws_db_instance.memos.address}:5432/memosdb?sslmode=disable" 
      }
    ]
  }])
}


resource "aws_ecs_cluster" "main" {
  name = "memos-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "memos_service" {
  name            = "memos-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  platform_version = "LATEST"
  
  network_configuration {
    subnets         = var.private_subnets
    security_groups = [aws_security_group.task_security.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.alb_target_arn 
    container_name   = var.service_name
    container_port   = var.container_port
  }
}


resource "aws_db_subnet_group" "memos" {
  name       = "memos-db-subnets"
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "memos" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "15.4"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.memos.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot  = true
}

resource "aws_security_group" "db_sg" {
  name   = "db-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.task_security.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
