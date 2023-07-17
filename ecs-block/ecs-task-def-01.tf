#Task definition creation
resource "aws_ecs_task_definition" "service" {
  count  = var.ecs-task-def.task_count
  family = var.ecs-task-def.task_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = var.ecs-task-def.task_nw_mode
  cpu                      = var.ecs-task-def.task_cpu
  memory                   = var.ecs-task-def.task_memory
  container_definitions = jsonencode([
    {
      name      = var.ecs-task-def.container_name
      image     = var.ecs-task-def.container_image
      cpu       = var.ecs-task-def.task_cpu
      memory    = var.ecs-task-def.task_memory
      essential = true
      portMappings = [
        {
          containerPort = var.ecs-task-def.container_port
          hostPort      = var.ecs-task-def.host_port
        }
      ]
    }
  ])
}