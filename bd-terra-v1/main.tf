provider "aws" {
    region = var.region
}
module "ecs-service" {
  source = "../ecs-block"
}
module "alb" {
  source = "../lb-block"
}