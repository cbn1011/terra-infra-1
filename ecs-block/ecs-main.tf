resource "aws_ecs_cluster" "ecs-cluster" {
  name = var.cluster-name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "ecs-capacity" {
  cluster_name = var.cluster-name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
  depends_on = [ aws_ecs_cluster.ecs-cluster ]
}

#Task definition creation
# resource "aws_ecs_task_definition" "service" {
#   count  = var.ecs-task-def.task_count
#   family = var.ecs-task-def.task_family
#   requires_compatibilities = ["FARGATE"]
#   network_mode             = var.ecs-task-def.task_nw_mode
#   cpu                      = var.ecs-task-def.task_cpu
#   memory                   = var.ecs-task-def.task_memory
#   container_definitions = jsonencode([
#     {
#       name      = var.ecs-task-def.container_name
#       image     = var.ecs-task-def.container_image
#       cpu       = var.ecs-task-def.task_cpu
#       memory    = var.ecs-task-def.task_memory
#       essential = true
#       portMappings = [
#         {
#           containerPort = var.ecs-task-def.container_port
#           hostPort      = var.ecs-task-def.host_port
#         }
#       ]
#     }
    # {
    #   name      = "second"
    #   image     = "service-second"
    #   cpu       = 10
    #   memory    = 256
    #   essential = true
    #   portMappings = [
    #     {
    #       containerPort = 443
    #       hostPort      = 443
    #     }
    #   ]
    # }
  # ])

  # volume {
  #   name      = "service-storage"
  #   host_path = "/ecs/service-storage"
  # }

  # placement_constraints {
  #   type       = "memberOf"
  #   expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  # }
# }