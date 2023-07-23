terraform {
    source ="../../bd-terra-modules/ecs-block"
}

include "root" {
    path = find_in_parent_folders()
}
inputs = {
    lb-tg = dependency.lb.outputs.lb-tg
}
dependency "lb" {
  config_path = "../lb-b"
}