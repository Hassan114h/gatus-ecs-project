resource "aws_iam_role" "codedeploy" {
  name = "codedeployrole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "CodeDeployRole"
  }
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
  role       = aws_iam_role.codedeploy.name
}

resource "aws_codedeploy_app" "gatus" {
  compute_platform = "ECS"
  name             = "gatus114codedeploy"
}

resource "aws_codedeploy_deployment_group" "blue_green_strategy" {
  app_name               = aws_codedeploy_app.gatus.name 
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name  = "bluegreen"
  service_role_arn       = aws_iam_role.codedeploy.arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = var.cluster_name
    service_name = var.service_name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.blue_https_listener] 
      }

    test_traffic_route {
      listener_arns = [var.green_listener_test] 
    }

      target_group {
        name = "alb-tgblue14"
      }

      target_group {
        name = "alb-tggreen14"
      }
    }
  }
}