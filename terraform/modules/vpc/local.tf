locals {
  vpc_cidr = "10.0.0.0/16"
  azs = ["eu-west-1a", "eu-west-1b"]
  public_subnets = ["10.0.0.0/19", "10.0.32.0/19"]
  private_subnets = ["10.0.64.0/19", "10.0.96.0/19"]
}