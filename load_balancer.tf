#Creating a classic elastic application load balancer
resource "aws_elb" "my_application_elb" {
  name               = "my-application-elb"
  security_groups    = [aws_security_group.my_lb_sg.id]
  subnets            = [aws_subnet.my_public_subnet[0].id]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  # Adding ingress rule for port 81 for Frontend Jenkins
  listener {
    instance_port     = 81
    instance_protocol = "HTTP"
    lb_port           = 81
    lb_protocol       = "HTTP"
  }

  # Adding ingress rule for port 82 for Backend Jenkins
  listener {
    instance_port     = 82
    instance_protocol = "HTTP"
    lb_port           = 82
    lb_protocol       = "HTTP"
  }

  # Adding ingress rule for port 3000 for Metabase instance
  listener {
    instance_port     = 3000
    instance_protocol = "HTTP"
    lb_port           = 3000
    lb_protocol       = "HTTP"
  }

  # Adding ingress rule for port 4000 for Frontend instance
  listener {
    instance_port     = 4000
    instance_protocol = "HTTP"
    lb_port           = 4000
    lb_protocol       = "HTTP"
  }
  
  listener {
    instance_port     = 443
    instance_protocol = "HTTP"
    lb_port           = 443
    lb_protocol       = "HTTP"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  
  tags = {
    Name = "My Application ELB"
  }
}