resource "aws_security_group" "create_kibana" {
  name = "create_kibana"
  description = "kibana traffic"

  # elasticsearch port
  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # kibana ports
  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

resource "aws_instance" "kibana-cluster" {
  ami           = "ami-xxxxxxx"
  instance_type = "t2.xxxxx"
  key_name      = "${var.key}"
  vpc_security_group_ids = [
    "${aws_security_group.create_elasticsearch.id}",
  ]

  provisioner "file" {
    content      = "files need to copy to new created resource"
    destination   = "copy file to destination"

    connection {
      type        = "ssh"
      user        = "dev"
      private_key = "${var.private_key}"
    }
  }

    
  provisioner "remote-exec" {
    script        = "${path}/setup-kabana.sh"
    
    connection {
      type        = "ssh"
      user        = "dev"
      private_key = "${var.private_key}"
    }
  }

  depends_on = ["aws_security_group.create_kibana"]
}
