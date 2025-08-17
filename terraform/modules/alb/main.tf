resource "aws_lb" "application_load_balancer" {
  name               = "ecs-lb-tf"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = var.public_subnets 
}


resource "aws_security_group" "alb_security_group" {
  name = "alb_sg"
  description = "ALB Security Group"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = var.vpc_id
}
 
# Create ALB Target Group and then go BACK to ECS Module to define it there too 

resource "aws_lb_target_group" "memos_tg" {
  name     = "memos-tg"
  port     = 5230 #put into variable
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 6
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
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
}


resource "aws_lb_listener" "alb_listener_https" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.acm_cert_arn ## Create this cert

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.memos_tg.arn
  }
}
