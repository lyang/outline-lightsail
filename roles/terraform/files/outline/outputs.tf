resource "local_file" "private_key" {
  content         = aws_lightsail_key_pair.outline_key_pair.private_key
  filename        = "${path.module}/../generated/outline.key"
  file_permission = "0600"
}

locals {
  vars = {
    host        = aws_lightsail_static_ip.outline_static_ip.ip_address
    private_key = local_file.private_key.filename
  }
}

resource "local_file" "inventory" {
  content  = templatefile("${path.module}/templates/inventory.yml.tftpl", local.vars)
  filename = "${path.module}/../generated/inventory.yml"
}

