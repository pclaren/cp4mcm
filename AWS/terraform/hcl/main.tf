# Key pair for Ansible user
resource "tls_private_key" "keyPairForAnsibleUser" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name    = "${var.hostname}_ansible_ssh_key"
  public_key  = "${tls_private_key.keyPairForAnsibleUser.public_key_openssh}"
}

resource "aws_instance" "centos" {
  // CentOS 7
  ami = "ami-0b850cf02cc00fdc8"
  instance_type = "t2.micro"
  key_name = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.instance.id]

  tags = {
    Name = "${var.hostname}"
  }
}

resource "aws_security_group" "instance" {
  name = "${var.hostname}_instance"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // All all outgoing traffic
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
