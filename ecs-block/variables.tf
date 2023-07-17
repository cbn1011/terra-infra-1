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