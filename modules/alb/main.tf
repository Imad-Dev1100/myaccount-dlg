resource "aws_security_group" "alb" {
  name        = "gfdigital_${var.environment}_myaccount_alb_sg"
  description = "Security group for the ALB in ${var.environment}."
  vpc_id      = var.vpc_id

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

  tags = merge(var.default_tags, {
    Name = "gfdigital_${var.environment}_myaccount_alb_sg"
  })
}

resource "aws_lb" "alb" {
  name               = "gfdigital-${var.environment}-myaccount-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.subnet_ids

  tags = merge(var.default_tags, {
    Name = "gfdigital_${var.environment}_myaccount_alb"
  })
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy = "ELBSecurityPolicy-2016-08"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "OK"
      status_code  = "200"
    }
  }
}
