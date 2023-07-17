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