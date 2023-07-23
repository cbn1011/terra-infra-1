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
output "lb-tg" {
  value = aws_lb_target_group.target-group.arn
}