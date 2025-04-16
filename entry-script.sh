#!/bin/bash
  sudo yum update -y update && sudo yum install -y httpd
  sudo systemctl start httpd && sudo systemctl enable httpd
  sudo rm -f /etc/httpd/conf.d/welcome.conf
  sudo bash -c  'echo "<h1>Deployed via Terraform</h1>" > /var/www/html/index.html'
  sudo systemctl restart httpd

  sudo yum -y install docker
  sudo systemctl start docker
  sudo usermod -aG docker ec2-user
  sudo docker container run -d -p 8080:80 nginx