# Added a new null_resource block for copying the script
resource "null_resource" "copy_script" {
  triggers = {
    copy_key = "${null_resource.name.id}"
  }

  provisioner "file" {
    source      = "jenkins-docker-script.sh"
    destination = "/tmp/jenkins-docker-script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/jenkins-docker-script.sh",
      "sh /tmp/jenkins-docker-script.sh",
    ]
  }

  depends_on = [aws_instance.ec2_instance]
}

# Updated comment style for consistency
# Declaring the AWS Provider
provider "aws" {
  region = "us-east-1"
}

data "tls_private_key" "generated_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.amzlinux2.id
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.ec2.id]
  user_data              = file("jenkins-docker-script.sh")

  tags = {
    Name = "jenkins_server"
  }

  key_name = "generated-key" # Use a new key generated by Terraform
}

resource "null_resource" "generate_key" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo "${data.tls_private_key.generated_key.private_key_pem}" > generated_key.pem
    EOT
  }
}

resource "null_resource" "name" {
  triggers = {
    key_generated = "${null_resource.generate_key.*.id}"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/generated_key.pem")
    host        = aws_instance.ec2_instance.public_ip
  }

  # Copy the jenkins-docker-script.sh file from your computer to the ec2 instance
  provisioner "file" {
    source      = "jenkins-docker-script.sh"
    destination = "/tmp/jenkins-docker-script.sh"
  }

  # Set permissions and run the install_jenkins.sh file
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/jenkins-docker-script.sh",
      "sh /tmp/jenkins-docker-script.sh",
    ]
  }

  # Wait for ec2 to be created
  depends_on = [aws_instance.ec2_instance]
}

# Print the URL of the jenkins server
output "website_url" {
  value = join("", ["http://", aws_instance.ec2_instance.public_dns, ":", "8080"])
}


  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/generated_key.pem")
    host        = aws_instance.ec2_instance.public_ip
  }
}
  # copy the jenkins-docker-script.sh file from your computer to the ec2 instance 
  provisioner "file" {
    source      = "jenkins-docker-script.sh"
    destination = "/tmp/jenkins-docker-script.sh"
  }

  # set permissions and run the install_jenkins.sh file
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/jenkins-docker-script.sh",
      "sh /tmp/jenkins-docker-script.sh",
    ]
  }

  # wait for ec2 to be created
  depends_on = [aws_instance.ec2_instance]
}


# print the url of the jenkins server
output "website_url" {
  value = join("", ["http://", aws_instance.ec2_instance.public_dns, ":", "8080"])
}
