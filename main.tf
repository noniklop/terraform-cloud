module "vpc" {
  source = "./modules/network"
}

module "network_security" {
  source = "./modules/network_security"
  vpc_id = module.vpc.vpc_id
}

module "application" {
  source = "./modules/application"
  ssh_sg = module.network_security.ssh_security_group_id
  public_http_sg = module.network_security.public_http_security_group_id
  private_http_sg = module.network_security.private_http_security_group_id
  subnet_a_id = module.vpc.subnet_a_id
  subnet_b_id = module.vpc.subnet_b_id
  subnet_c_id = module.vpc.subnet_c_id
  vpc_id = module.vpc.vpc_id
}
