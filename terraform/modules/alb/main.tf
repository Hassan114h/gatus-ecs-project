resource "aws_lb" "application_load_balancer" {
  name               = "ecs-lb-tf"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = var.public_subnets 

  tags = {
    Name = "ecs-lb-tf"
  }
}

resource "aws_security_group" "alb_security_group" {
  name        = "alb_sg"
  description = "ALB Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = var.vpc_id

  tags = {
    Name = "alb_sg"
  }
}


resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Name = "http_listener"
  }
}

# Blue listener
resource "aws_lb_listener" "alb_listener_https" {
   load_balancer_arn = aws_lb.application_load_balancer.arn
   port              = 443
   protocol          = "HTTPS"
   certificate_arn   = var.acm_cert_arn

   default_action {
     type             = "forward"
     target_group_arn = aws_lb_target_group.blue.arn
   }
 }

 # Test HTTPS listener (used by CodeDeploy for validation) # This sends real traffic after the health check is conducted
 resource "aws_lb_listener" "alb_listener_test" {
   load_balancer_arn = aws_lb.application_load_balancer.arn
   port              = 8443
   protocol          = "HTTPS"
   certificate_arn   = var.acm_cert_arn

   default_action {
     type             = "forward"
     target_group_arn = aws_lb_target_group.green.arn
   }

   tags = {
     Name = "https_listener_test"
   }
 }

resource "aws_lb_target_group" "blue" {
  name        = "alb-tgblue14"
  port        = var.container_port   
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip" 

  health_check {
    protocol            = "HTTP"
    path                = "/"
    interval            = 30
    timeout             = 6
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = {
    Name = "alb-tgblue14"
  }
}

 resource "aws_lb_target_group" "green" {
   name        = "alb-tggreen14"
   port        = var.container_port   
   protocol    = "HTTP"
   vpc_id      = var.vpc_id
   target_type = "ip" 

   health_check {
     protocol            = "HTTP"
     path                = "/healthz"
     interval            = 30
     timeout             = 6
     healthy_threshold   = 2
     unhealthy_threshold = 2
     matcher             = "200-399"
   }

   tags = {
     Name = "alb-tggreen14"
   }
}



## AWS WAF
resource "aws_wafv2_web_acl" "aws_common_rule" {
  name        = "aws_common_rule"
  description = "AWS COMMON RULE SET"
  scope       = "REGIONAL"

  # Default action, allow requests unless blocked by a rule
  default_action {
    allow {}
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 0

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "hassan114WAF"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "hassan114WAF_ACL"
    sampled_requests_enabled   = true
  }
}


 resource "aws_wafv2_web_acl_association" "alb" {
   resource_arn = aws_lb.application_load_balancer.arn 
   web_acl_arn  = aws_wafv2_web_acl.aws_common_rule.arn
 }

