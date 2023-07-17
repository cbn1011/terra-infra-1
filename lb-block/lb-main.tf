#LoadBalancer Creation
resource "aws_alb" "BD-UAE-LB" {
  name               = var.lb-name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [for subnet in data.aws_subnet.vpc_subnet : subnet.id]
   
}
# data "aws_subnet" "vpc_subnet" {
#   for_each = toset(data.aws_subnets.vpc_subnets.ids)
#   id = each.value
# }
#Security group block
resource "aws_security_group" "alb" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

#Loadbalancer listener block
resource "aws_lb_listener" "forntend" {
  load_balancer_arn = aws_alb.BD-UAE-LB.arn
  port              = "80"
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
#Target group creation
resource "aws_lb_target_group" "target-group" {
  name        = var.tg_name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.selected.id
}
#Target group assigning to ALB
resource "aws_lb_listener_rule" "messaging_rule" {
  listener_arn = aws_lb_listener.forntend.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }

  condition {
    path_pattern {
      values = [var.tg-details.path]
    }
  }

  condition {
    host_header {
      values = [var.tg-details.domain]
    }
  }
  tags = {
    Name = "For Messaging"
  }
}
