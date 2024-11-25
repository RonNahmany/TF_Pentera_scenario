provider "aws" {
  region = var.region
}

module "infra_networking" {
  source = "./modules/network"
  network_config = {
    cidr_block   = var.cidr_block
    dns_support  = var.dns_support
    dns_hostname = var.dns_hostname
    work_subnet  = var.work_subnet
  }
  global_provision_tag = var.Tag

}

module "instance_create" {
  depends_on      = [module.infra_networking]
  source          = "./modules/instance"
  vpc_id          = module.infra_networking.vpc_id
  nameTag         = var.Tag
  ingressrules    = var.ingressrules
  egressrules     = var.egressrules
  subnet_id       = module.infra_networking.subnet_id
  instance_config = var.instance_configs
}
