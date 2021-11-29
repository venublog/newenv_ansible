#----- EC2 instance for application-----

resource "aws_instance" "ec2node" {
  count                = var.ec2node_count
  ami                  = var.application_ami
  key_name             = var.keypair_id
  instance_type        = var.ec2node_instance_type

  vpc_security_group_ids = ["var.sg_ec2node_id"]
 
 
  lifecycle {
    create_before_destroy = true
    ignore_changes        = ["user_data"]
  }
 tags = {
    Name = "acloud_guru_application-${count.index+1}"
  }
}
