variable "cluster-name" {
  type = string
  description = "Provide the Clustername"
  default     = "BestDoc-UAE-Cluster"
}
variable "ecs-task-def" {
type = object({
    task_count      = number
    task_family     = string
    task_nw_mode    = string
    task_cpu        = number
    task_memory     = number
    container_name  = string
    container_image = string
    container_port  = number
    host_port       = number
})
default = {
  task_nw_mode = "awsvpc"
  task_count = 1
  task_cpu = 1024
  task_memory = 2048
  task_family = "service"
  container_image = "first-service"
  container_name = "first"
  container_port = 80
  host_port = 80
}
}
variable "lb-tg" {
  type = string
  # default = "arn:aws:elasticloadbalancing:me-central-1:148889286790:targetgroup/TG-messaging/84289770e68e18d2"
}
data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  tags = {
    TIer = "Public"
  }
}
data "aws_subnet" "vpc_subnet" {
  for_each = toset(data.aws_subnets.vpc_subnets.ids)
  id       = each.value
}
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["Bestdoc-Uae-MyVPC."]
  }
}