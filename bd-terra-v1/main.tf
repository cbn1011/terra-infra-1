provider "aws" {
    region = var.region
}
module "ecs-service" {
  source = "../bd-terra-modules/ecs-block"
}
module "alb" {
  source = "../bd-terra-modules/lb-block"
}