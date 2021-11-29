provider "aws" {

  version = "3.67.0"
  region = "us-east-1"
  profile = "acloud"
}

module "keypair" {
  source     = "../modules/keypair"
  key_name   = var.key_name
  public_key = var.public_key
  
}

module "securitygroup" {
  source     = "../modules/securitygroup"
  vpc_id   =  var.vpc_id
    
}

module "ec2node" {

    source = "../modules/ec2node"
    ec2node_count = var.ec2node_count
    application_ami = var.application_ami
    new_keypair_id = module.keypair.new_keypair_id 
    ec2node_instance_type = var.ec2node_instance_type
    sg_ec2node_id = module.securitygroup.sg_ec2node_id
    
  
}
