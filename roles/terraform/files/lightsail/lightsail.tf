resource "aws_lightsail_key_pair" "server_key_pair" {
  name = "server_key_pair"
}

resource "aws_lightsail_instance" "server" {
  name              = "outline-server"
  availability_zone = data.aws_availability_zones.available.names[0]
  blueprint_id      = "ubuntu_20_04"
  bundle_id         = "micro_2_0"
  key_pair_name     = aws_lightsail_key_pair.server_key_pair.id
}

resource "aws_lightsail_static_ip" "server_static_ip" {
  name = "server_ip"
}

resource "aws_lightsail_static_ip_attachment" "server_static_ip_attachment" {
  static_ip_name = aws_lightsail_static_ip.server_static_ip.id
  instance_name  = aws_lightsail_instance.server.id
}

resource "aws_lightsail_instance_public_ports" "server_public_ports" {
  instance_name = aws_lightsail_instance.server.id

  port_info {
    protocol  = "tcp"
    from_port = 0
    to_port   = 65535
  }

  port_info {
    protocol  = "udp"
    from_port = 0
    to_port   = 65535
  }
}

