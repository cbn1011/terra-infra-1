resource "aws_ecs_service" "this" {
  name            = "messaging-bd-uae-svc"              //cam be make it variable in future
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = element(aws_ecs_task_definition.service.*.arn, 0)
  desired_count   = 0
  launch_type     = "FARGATE"
  # iam_role        = aws_iam_role.this.arn
  # depends_on      = [aws_iam_role_policy.this]

  # ordered_placement_strategy {
  #   type  = "binpack"
  #   field = "cpu"
  # }
    network_configuration {
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = [for subnet in data.aws_subnet.vpc_subnet : subnet.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.lb-tg
    container_name   = "first"
    container_port   = 80
  }

#   placement_constraints {
#     type       = "memberOf"
#     expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
#   }
depends_on = [ aws_iam_role_policy_attachment.ecs-task, var.lb-tg ]
}