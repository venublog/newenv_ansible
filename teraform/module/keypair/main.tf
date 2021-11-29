
resource "aws_key_pair" "site_key" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key)}"
}

output "new_keypair_id" {
  value = "${aws_key_pair.site_key.id}"
}
