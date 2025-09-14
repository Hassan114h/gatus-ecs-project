module "tf-state" {
  source      = "./modules/tf-state"
  bucket_name = local.bucket_name
}

module "vpc" {
  source = "./modules/vpc"
  task_security_group_id = module.ecs.task_security_group_id
}

module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnet_ids
  acm_cert_arn   = module.route53.acm_certificate_arn
}

module "ecs" {
  source          = "./modules/ecs"
  vpc_id          = module.vpc.vpc_id
  alb_sg          = module.alb.alb_sg_id
  private_subnets = module.vpc.private_subnet_ids
  alb_target_arn  = module.alb.alb_target_blue
}

module "route53" {
  source = "./modules/route53"

  alb_dns_name       = module.alb.alb_dns_name
  alb_hosted_zone_id = module.alb.alb_hosted_zone_id
}

module "codedeploy" {
  source = "./modules/codedeploy"
  blue_https_listener = module.alb.blue_https_listener
  green_listener_test = module.alb.green_listener_test
  alb_target_blue = module.alb.alb_target_blue
  alb_target_green = module.alb.alb_target_green
  service_name = module.ecs.ecs_service_name
  cluster_name = module.ecs.ecs_cluster_name
}