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

