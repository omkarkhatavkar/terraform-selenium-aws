    provider "aws" {

      access_key = "${var.aws_access_key}"
      secret_key = "${var.aws_secret_key}"
      region = "${var.aws_region}"

    }

    resource "aws_security_group" "selenium_hub_sg" {
      name = "selenium-grid-hub-sg"
      description = "This is selenium grid hub"

      # This is currently vpc from the account
      vpc_id = "${var.aws_vpc_id}"

      egress {
          from_port = 0
          to_port = 0
          protocol = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
    }

    resource "aws_security_group_rule" "ssh_ingress_access" {
      type = "ingress"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
      security_group_id = "${aws_security_group.selenium_hub_sg.id}"
    }

    resource "aws_security_group_rule" "hub_ingress_access" {
      type = "ingress"
      from_port = 0
      to_port = 65535
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
      security_group_id = "${aws_security_group.selenium_hub_sg.id}"
    }


    resource "aws_instance" "selenium_hub_instance" {
      instance_type = "${var.aws_instance_type}"
      vpc_security_group_ids = [ "${aws_security_group.selenium_hub_sg.id}" ]
      associate_public_ip_address = true
      tags {
        Name = "selenium_hub_instance"
      }
      key_name = "${aws_key_pair.admin_key.key_name}"
      ami = "${var.aws_ami}"
      user_data = "${file("./files/selenium_hub.sh")}"
      # This is currently vpc from the account
      subnet_id = "${var.aws_subnet_id}"


    }

    resource "aws_instance" "selenium_node_instance" {
      instance_type = "${var.aws_instance_type}"
      vpc_security_group_ids = [ "${aws_security_group.selenium_hub_sg.id}" ]
      associate_public_ip_address = true
      tags {
        Name = "selenium_node_instance"
      }

      key_name = "admin_key"
      ami = "${var.aws_ami}"
      # This is currently vpc from the account
      subnet_id = "${var.aws_subnet_id}"
      depends_on = ["aws_instance.selenium_hub_instance"]

      provisioner "file" {
        source = "files/selenium_node.sh"
        destination = "/tmp/selenium_node.sh"
      }

      provisioner "remote-exec" {
        inline = [
          "sleep 10",
          "echo ${aws_instance.selenium_hub_instance.public_ip}",
          "chmod +x /tmp/selenium_node.sh",
          "sudo sh /tmp/selenium_node.sh ${aws_instance.selenium_hub_instance.public_ip}" ,
        ]
      }

      provisioner "local-exec" {
        command = "echo -e '[selenium_hub]\nurl=${aws_instance.selenium_hub_instance.public_ip}' > test.ini"
      }

      connection {
          user        = "centos"
          private_key = "${file("${var.aws_ssh_private_key}")}"
      }

    }




